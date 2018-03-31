Received: from eggs.gnu.org ([2001:4830:134:3::10]:50647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FYz-0003md-GZ
	for Qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f2FYw-0007Rw-Co
	for Qemu-devel@nongnu.org; Sat, 31 Mar 2018 08:24:53 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
Date: Sat, 31 Mar 2018 07:24:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] RFC: Tweak the NBD_OPT_SET_META_CONTEXT layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>

As mentioned in earlier email threads, I experimented with an 
alternative layout to the structs sent across the wire during 
NBD_OPT_{LIST,SET}_META_CONTEXT, on the grounds that having the 
namespace and leaf-name combined into one string that requires further 
parsing on each end is not as nice as having two separate fields.  I'm 
replying to this mail with two RFC patches, one for the NBD spec, and 
one for the qemu implementation.

If we like the idea, this has to go into qemu 2.12, so we have less than 
a week.  Or, we can ignore the RFC, keep qemu the way it is currently 
coded, and when it is released, it will be time to promote the NBD 
extension-blockstatus to current as there will be an existing 
implementation to be interoperable with.

Note that I intentionally changed the value of NBD_OPT_SET_META_CONTEXT 
so that the existing Virtuozzo of OPT 10 will not get confused by the 
new layout (both new server and old client, as well as old server and 
new client, will merely fail to negotiate block status, and then be 
unable to use NBD_CMD_BLOCK_STATUS).  I didn't bother changing 
NBD_OPT_LIST_META_CONTEXT, as it looks like the existing Virtuozzo 
implementation did not use that option as a client.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
