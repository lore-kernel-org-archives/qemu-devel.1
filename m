Received: from eggs.gnu.org ([2001:4830:134:3::10]:36291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHv7k-0004Sj-23
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHv7j-000390-61
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:17:16 -0500
References: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
	<1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
	<3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6fed6fa-8aee-c18e-4fc2-97cbc946a7e2@redhat.com>
Date: Thu, 23 Nov 2017 18:17:04 +0100
MIME-Version: 1.0
In-Reply-To: <3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deepa Srinivasan <deepa.srinivasan@oracle.com>, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mark.kanda@oracle.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On 23/11/2017 18:05, Deepa Srinivasan wrote:
> blk_aio_prwv() now takes a void pointer and the coroutine functions
> have been modified to cast it into QEMUIOVector if needed. It does
> not use an union in BlkRwCo since this leads to code - blk_aio_prwv()
> would have to write to the void pointer member, but coroutines would
> sometimes read the QEMUIOVector member. Paolo also suggested not
> using a union.
> 
> Note that a similar issue exists in
> blk_ioctl()/blk_ioctl_entry()/blk_prw() where blk_prw() always
> creates the QEMUIOVector even if blk_ioctl()/blk_ioctl_entry() does
> not need a QEMUIOVector. This will need to be fixed separately to
> keep it consistent with the AIO path.

For that it's probably simplest to inline blk_prw into blk_ioctl and
remove all the cruft:

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101be3..ceab3166bc 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1404,12 +1404,28 @@ static void blk_ioctl_entry(void *opaque)
 {
     BlkRwCo *rwco = opaque;
     rwco->ret = blk_co_ioctl(rwco->blk, rwco->offset,
-                             rwco->qiov->iov[0].iov_base);
+                             rwco->iobuf);
 }

 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 {
-    return blk_prw(blk, req, buf, 0, blk_ioctl_entry, 0);
+    BlkRwCo rwco = (BlkRwCo) {
+        .blk    = blk,
+        .iobuf  = buf,
+        .offset = req,
+        .ret    = NOT_DONE,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        blk_ioctl_entry(&rwco);
+    } else {
+        Coroutine *co = qemu_coroutine_create(blk_ioctl_entry, &rwco);
+        bdrv_coroutine_enter(blk_bs(blk), co);
+        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
+    }
+
+    return rwco.ret;
 }

 static void blk_aio_ioctl_entry(void *opaque)

Thanks,

Paolo
