Received: from eggs.gnu.org ([209.51.188.92]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfag-0006Fc-Kx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfT3-00059e-RS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfT3-00057y-NS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id b8so128292qtj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:25 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-3-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/25] contrib/libvhost-user: switch to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongji Xie <xieyongji@baidu.com>, Peter Xu <peterx@redhat.com>

contrib/libvhost-user is now using __u64 which is
a long long. New linux headers will use uint64_t.

These need to be printed differently: llx versus PRIx64.

For now cast to uint64_t for portability so the change
does not break the build.

Casts will go away in the future.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index a6b46cdc03..c28ec84a11 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -790,10 +790,10 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
     DPRINT("    flags:  %d\n", vra->flags);
-    DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
-    DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
-    DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
-    DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
+    DPRINT("    desc_user_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->desc_user_addr);
+    DPRINT("    used_user_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->used_user_addr);
+    DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
+    DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
 
     vq->vring.flags = vra->flags;
     vq->vring.desc = qva_to_va(dev, vra->desc_user_addr);
-- 
MST
