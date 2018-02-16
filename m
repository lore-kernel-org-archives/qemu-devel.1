Received: from eggs.gnu.org ([2001:4830:134:3::10]:45696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emibN-0002l0-UR
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emibJ-00013O-79
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:11:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emibJ-00013G-18
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:11:05 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
	<1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1e7c1c5-622c-ff78-4aec-ce62b0273d24@redhat.com>
Date: Fri, 16 Feb 2018 10:10:59 -0600
MIME-Version: 1.0
In-Reply-To: <1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd list <nbd@other.debian.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 02/16/2018 07:53 AM, Vladimir Sementsov-Ogievskiy wrote:

> 
> Good idea. But it would be tricky thing to maintain backward 
> compatibility with published versions of virtuozzo product. And finally 
> our implementation would be more complex because of this simplification.
> 

> 
> Hm. Finally, you suggested several changes (including already merged 
> 56c77720 :( ). Suggestions are logical. But if they will be accepted, we 
> (Virtuozzo) will have to invent tricky hard-to-maintain code, to 
> distinguish by third factors our already published versions. So, I 
> suggest to add some negotiation flag (BLOCK_STATUS_FIXED ?), to 
> negotiate your changes (including 56c77720). In upstream we can skip 
> supporting BLOCK_STATUS without that special flag, but it will help us 
> to distinguish our previous versions reliably.

So if I understand correctly, you already have an implementation of NBD 
servers in the wild that support a preliminary version of 
NBD_OPT_SET_META_CONTEXT, but which do not necessarily obey the 
semantics in the current extension branch (and which may not be the 
final semantics by the time we promote the extension branch into the NBD 
spec overall).

Also, the Virtuozzo product hasn't been mentioned on the NBD list, and 
while you are preparing patches to the public qemu based on the 
Virtuozzo product, I'm not sure if there is a public repository for the 
existing Virtuozzo product out in the wild.  Is your product using 
NBD_OPT_LIST_META_CONTEXT, or _just_ NBD_OPT_SET_META_CONTEXT?

Now, let's assess the ramifications for changing the current NBD 
proposal, before finalizing it into mainline.  Once it is in mainline, 
all other implementations have to obey the spec; but we want to leave 
ourselves the freedom to tweak the extension prior to that point 
according to things learned while implementing it.  With that said, what 
combinations are you hoping to still support?  And how long do you 
expect to have mismatched versions in the field, or is it something 
where it is relatively easy to upgrade both client and server within a 
short timeframe?

Here's what things look like if we do nothing, and the NBD_OPT side of 
the handshake stays compatible (as I understand it, your complaint about 
commit 56c77720 is that it affects only the transmission side; leaving 
aside for the moment that I have opened the door for even more changes 
that may affect the handshake side).

old client, old server (what is in the field now): The Virtuozzo client 
is able to request status from the Virtuozzo server, no other NBD client 
or server cares because they pre-date block status

new client, old server: Any new client that implements block_status, as 
currently documented, but talks to an existing Virtuozzo server, will 
get garbage replies to NBD_CMD_BLOCK_STATUS (status 5 instead of 
expected status 3).  Virtuozzo's client could be taught to special-case 
things and accept BOTH values for status replies (as long as nothing 
else changes between the old implementation and when NBD finally accepts 
the extension into mainline)

old client, new server: The Virtuozzo client talking to a non-Virtuozzo 
server that understands block_status as currently documented will get 
garbage replies to NBD_CMD_BLOCK_STATUS (status 3 instead of expected 
status 5). The Virtuozzo server cannot be patched to work around this, 
because it has no way to detect a Virtuozzo client differently from any 
other client.

new client, new server: Because everyone follows the same documentation, 
it should be interoperable.


It's ALWAYS risky to put an experimental item into production use; some 
precautions such as using intentionally higher numbers than normal may 
make it easier to identify the experimental versions (that is, if the 
proposal is to implement item '10', the experimental code implements 
item '10010'; then, any changes to what actually gets finalized into the 
semantics for item '10' will not affect continued use of the '10010' 
semantics).  But since you didn't do that, my immediate reaction is that 
adding a 'BLOCK_STATUS_FIXED' to the NBD protocol sounds crazy (fixed 
compared to what? An unpublished early implementation?).  But what we 
CAN do is specify that NBD_OPT_ value 10 is reserved for a (withdrawn) 
experimental extension (similar to how NBD_OPT_ value 4 for PEEK_EXPORT 
is skipped), and make NBD_OPT_SET_META_CONTEXT be 11.  Then you have:

old client, old server: client sends NBD_OPT 10, Virtuozzo server 
replies, and both sides use whatever you implemented even if it differs 
from the final NBD spec

new client, old server: any compliant client sends NBD_OPT 11, Virtuozzo 
server doesn't recognize it, and you lose the ability to query block 
status. Additionally, you can teach the Virtuozzo client to try 11 
first, and if it fails, fall back to trying 10 - the client then has to 
understand both old and new flavors, but can now talk to any version of 
the Virtuozzo server.

old client, new server: the Virtuozzo client sends NBD_OPT 10, a 
compliant server doesn't recognize it, and you don't get to query block 
status, but you are no worse off than for any other server that doesn't 
understand block status.  Additionally, you can teach the Virtuozzo 
server to accept opt 10 in addition to 11; the server now has to 
understand both old and new flavors, but can now talk to any version of 
the Virtuozzo client.

new client, new server: the client sends NBD_OPT 11, the server replies, 
and they communicate according to the spec

Or, we can revert the change in commit 56c77720, and keep 
NBD_REPLY_TYPE_BLOCK_STATUS at 5 (it leaves a hole in the NBD_REPLY_TYPE 
numbering, where 3 and 4 might be filled in by other future extensions, 
or permanently skipped).  This works IF there are no OTHER incompatible 
changes made to the rest of the block status extension as part of 
promoting it to current (where we still haven't finished that debate, 
given my question on whether 32-bit lengths and colon-separated 
namespace:leaf in a single string is the best representation).

So, I'd like some feedback from Alex or Wouter on which alternatives 
seem nicest at this point.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
