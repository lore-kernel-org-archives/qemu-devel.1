Received: from eggs.gnu.org ([2001:4830:134:3::10]:44027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK3ng-0003MA-H8
	for Qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK3nf-0000Ce-Er
	for Qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:57:24 -0500
From: Eric Blake <eblake@redhat.com>
Message-ID: <15f2fce6-00f4-0c1d-4ebe-d4ed7c5e7596@redhat.com>
Date: Wed, 29 Nov 2017 08:57:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] RFC: Let NBD client request read-only mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nbd list <nbd@other.debian.org>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Right now, only the server can choose whether an export is read-only.  A 
client can always treat an export as read-only by not sending any 
writes, but a server has no guarantee that a client will behave that 
way, and must assume that an export where the server did not advertise 
NBD_FLAG_READ_ONLY will modify the export.  Therefore, if the server 
does not want to permit simultaneous modifications to the underlying 
data, it has the choice of either permitting only one client at a time, 
or supporting multiple connections but enforcing all subsequent 
connections to see the NBD_FLAG_READ_ONLY bit on the export that is 
already in use by the first connection (note that this is racy - whoever 
connects first is the only one that can get write permissions, even if 
the first connected client doesn't want to write).

However, at least qemu has a case where it would be nice to permit a 
parallel known-read-only client from the same server that is (or will 
be) handling a read-write client; and what's more, to make it so that 
the read-only client can win the race of being the first connection 
without penalizing the actual read-write connection (see 
https://bugzilla.redhat.com/show_bug.cgi?id=1518543).  I don't see any 
way to accomplish this with oldstyle negotiation (but that doesn't 
matter these days); but with newstyle negotiation, there are at least 
two possible implementations:

Idea 1: the server advertises a new global bit NBD_FLAG_NO_WRITE (ideas 
for a better name?) in its 16-bit handshake flags; if the client replies 
with the same bit set (documentation-wise, we'd name the client reply 
NBD_FLAG_C_NO_WRITE), then the server knows that the client promises to 
be a read-only connection.

Idea 2: we add a new option, NBD_OPT_READ_ONLY.  If the client sends 
this option, and the server replies with NBD_REP_ACK, then the server 
knows that the client promises to be a read-only connection.

With either idea, once the server knows the client's intent to be a 
read-only client, the server SHOULD set NBD_FLAG_READ_ONLY on all 
(further) information sent for any export (whether from 
NBD_OPT_EXPORT_NAME, NBD_OPT_INFO, or NBD_OPT_GO) and treat any export 
as read-only for the current client, even if that export is in parallel 
use by another read-write client, and the client MUST NOT send 
NBD_CMD_WRITE, NBD_CMD_TRIM, NBD_CMD_WRITE_ZEROES, or any other command 
that requires a writable connection (the NBD_CMD_RESIZE extension comes 
to mind).

A client that wants to be read-only, but which does not see server 
support (in idea 1, the server did not advertise the bit; in idea 2, the 
server replies with NBD_REP_ERR_UNSUP), does not have to do anything 
special (it is always possible to do just reads to a read-write 
connection, and the server may still set NBD_FLAG_READ_ONLY even without 
supporting the extension of permitting a client-side request).  But such 
a client may, if it wants to be nice to potential parallel writers on 
the same export, decide to disconnect quickly (with NBD_OPT_ABORT or 
NBD_CMD_DISC as appropriate) rather than tie up a read-write connection.

I don't know which idea is more palatable.  We have a finite set of only 
2^4 global handshake flags because it is a bitmask, where only 14 bits 
remain; whereas we have almost 2^32 potential NBD_OPT_ values.  On the 
other hand, using a global handshake flag means the server never shows 
any export as writable; while with the NBD_OPT_ solution, a guest can 
get different results for the sequence NBD_OPT_INFO, NBD_OPT_READ_ONLY, 
NBD_OPT_INFO.  There's also the question with option 2 of whether 
permitting NBD_OPT_READ_ONLY prior to NBD_OPT_STARTTLS would make sense 
(is there any case where the set of TLS authentication to be performed 
can involve looser requirements for a known-read-only client?), where 
using a global bit makes the sequence of required NBD_OPT_* a bit less 
stateful.

Does the idea sound reasonable enough to propose wording to add it to 
the NBD spec and an implementation in qemu?  Which of the two ideas is 
preferred for letting the client inform the server of its intent?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
