Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD412C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B72217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGplMXXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B72217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittly-0003rN-2z
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itshY-0003GX-HU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itshU-0004m3-Kl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60067)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itshU-0004lx-H4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGv6zNVxuKuym9ksnQl50L+mnvqmK9zVXfAcevoknPM=;
 b=bGplMXXNoDGLFLRXcy0ZoLbewGZoO+4v4fBG4+t8DnI0w3LqSKRq/vJu+a++jF+Sa7p7YR
 lXefQnkGEomv1reqw/tOD6Wr3hNFpT0B/EOMqbLuVRxTk7WNBNhhBVC+LHrStPJFRJi2vM
 5ln+CvwglLRF+b5AQ5MpZ3H5vkEfOBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-BZaoJiuVNWujq-HPcsW-sw-1; Tue, 21 Jan 2020 07:32:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDEA0107ACC9;
 Tue, 21 Jan 2020 12:32:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F0060BE0;
 Tue, 21 Jan 2020 12:32:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 092/109] libvhost-user: Fix some memtable remap cases
Date: Tue, 21 Jan 2020 12:24:16 +0000
Message-Id: <20200121122433.50803-93-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BZaoJiuVNWujq-HPcsW-sw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If a new setmemtable command comes in once the vhost threads are
running, it will remap the guests address space and the threads
will now be looking in the wrong place.

Fortunately we're running this command under lock, so we can
update the queue mappings so that threads will look in the new-right
place.

Note: This doesn't fix things that the threads might be doing
without a lock (e.g. a readv/writev!)  That's for another time.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 33 ++++++++++++++++++++-------
 contrib/libvhost-user/libvhost-user.h |  3 +++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index 63e41062a4..b89bf18501 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -564,6 +564,21 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
=20
+static bool
+map_ring(VuDev *dev, VuVirtq *vq)
+{
+    vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
+    vq->vring.used =3D qva_to_va(dev, vq->vra.used_user_addr);
+    vq->vring.avail =3D qva_to_va(dev, vq->vra.avail_user_addr);
+
+    DPRINT("Setting virtq addresses:\n");
+    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
+    DPRINT("    vring_used  at %p\n", vq->vring.used);
+    DPRINT("    vring_avail at %p\n", vq->vring.avail);
+
+    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -767,6 +782,14 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
         close(vmsg->fds[i]);
     }
=20
+    for (i =3D 0; i < dev->max_queues; i++) {
+        if (dev->vq[i].vring.desc) {
+            if (map_ring(dev, &dev->vq[i])) {
+                vu_panic(dev, "remaping queue %d during setmemtable", i);
+            }
+        }
+    }
+
     return false;
 }
=20
@@ -853,18 +876,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg=
)
     DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", vra->avail_user_add=
r);
     DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", vra->log_guest_addr=
);
=20
+    vq->vra =3D *vra;
     vq->vring.flags =3D vra->flags;
-    vq->vring.desc =3D qva_to_va(dev, vra->desc_user_addr);
-    vq->vring.used =3D qva_to_va(dev, vra->used_user_addr);
-    vq->vring.avail =3D qva_to_va(dev, vra->avail_user_addr);
     vq->vring.log_guest_addr =3D vra->log_guest_addr;
=20
-    DPRINT("Setting virtq addresses:\n");
-    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
-    DPRINT("    vring_used  at %p\n", vq->vring.used);
-    DPRINT("    vring_avail at %p\n", vq->vring.avail);
=20
-    if (!(vq->vring.desc && vq->vring.used && vq->vring.avail)) {
+    if (map_ring(dev, vq)) {
         vu_panic(dev, "Invalid vring_addr message");
         return false;
     }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h
index 1844b6f8d4..5cb7708559 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -327,6 +327,9 @@ typedef struct VuVirtq {
     int err_fd;
     unsigned int enable;
     bool started;
+
+    /* Guest addresses of our ring */
+    struct vhost_vring_addr vra;
 } VuVirtq;
=20
 enum VuWatchCondtion {
--=20
2.24.1


