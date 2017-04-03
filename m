Received: from eggs.gnu.org ([2001:4830:134:3::10]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cv3rC-00042E-2s
	for Qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cv3r8-0002ns-Ud
	for Qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:25:26 -0400
Date: Mon, 3 Apr 2017 17:24:43 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170403152443.GA20459@igalia.com>
References: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fddf65-e573-cf01-593d-6b02a3071721@redhat.com>
Subject: Re: [Qemu-devel] help debugging throttle crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On Mon, Apr 03, 2017 at 09:07:02AM -0500, Eric Blake wrote:

> At this point, it looks like no one is calling
> throttle_group_unregister_blk() as a result of the 'device_del',
> which leaves stale memory around

I see, I can also reproduce this very easily.

I wonder if it's not enough to simply disable I/O limits when a
BlockBackend is deleted?

--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -230,6 +230,9 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
+    if (blk->public.throttle_state) {
+        blk_io_limits_disable(blk);
+    }
     if (blk->root) {
         blk_remove_bs(blk);
     }

Berto
