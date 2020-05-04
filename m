Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C542C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAF02078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwH1IfzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAF02078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcIN-0002lU-V1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6p-0006ca-Rr
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6o-0006cO-ER
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm0WQ9pqxtVALi8Njtzsdw3M2RP1aGt1m39O0TzxS68=;
 b=bwH1IfzKxkzninGGAyWlKBKGxRP4rpatujyXofANhSCh53e7h/JI6QNq3rYRdBsBKT2eei
 OpoGXk+SQndpZcJ0ofIFNNT2SF2g5yDAFQLmbniYddJu1ZFPCpCeSklvuTsfBOzxmfWJnv
 +3y32Hi3LjASFjjwNHwwtCZLDUBbZt0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ks6w_daLPAGLp26i6FpnVA-1; Mon, 04 May 2020 10:30:09 -0400
X-MC-Unique: ks6w_daLPAGLp26i6FpnVA-1
Received: by mail-wm1-f71.google.com with SMTP id d134so90287wmd.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vpBDMFw09qHmehha1zrdHcs0buJfEVnScVncHzFoem8=;
 b=Yhi94u2CT+tgXDcPFghKcyPBHF9TDVb2MGz0t66EphOXQakUXV2YGqhAW/kRKjI/wc
 QSuqXbp0Fkd5Fzs2DT5pRKtaE23xvcDzi6sQyGx7Rar6sjmxocW5mpg7d0soLyXVflew
 jm1SKi/CgRMXM1NWsw5c53akGhQ2fvwATpayx7CRWGElcaUhiEqRuXYd3wQ2lmCtOj/r
 NpaEeld/7Mo9AIV69iV6JwvBZNSEd2taeYV9dWt2iaPf8B10M+eyKdzZdrQ2O9GeT2IG
 UuvRz1POfmmoJqxi4nm1D0h21czw4SMMJ3eKpC6TkYnvDv6vw4TLqGkBszOORCYcdURB
 yhTQ==
X-Gm-Message-State: AGi0PuYBl8l6As7BvTwwtSGVuj1oLuVeOUwL+ezeCdaOPL8yjSMZW4QZ
 JVKWLeGZi5hfaj8NM9kgijggTJklNhiV9ri1zjzGtHRpk8132v2NY66C926wl6GTiAmKzf1bwKL
 CGuxxQM2Pq66DlLo=
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr9250571wrt.81.1588602608599; 
 Mon, 04 May 2020 07:30:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypL3jKRxaVoh14IRd2pN9VLgTCWo8AVuQ4HtqiJN71bCsUoHWZNz7D6NjxObY9yR7XQS8lpKmQ==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr9250535wrt.81.1588602608270; 
 Mon, 04 May 2020 07:30:08 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 k133sm15176962wma.0.2020.05.04.07.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:07 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] Refactor vhost_user_set_mem_table functions
Message-ID: <20200504142814.157589-23-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

vhost_user_set_mem_table() and vhost_user_set_mem_table_postcopy() have
gotten convoluted, and have some identical code.

This change moves the logic populating the VhostUserMemory struct and
fds array from vhost_user_set_mem_table() and
vhost_user_set_mem_table_postcopy() to a new function,
vhost_user_fill_set_mem_table_msg().

No functionality is impacted.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Message-Id: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 143 +++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 76 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 08e7e63790..ec21e8fbe8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,18 +407,79 @@ static int vhost_user_set_log_base(struct vhost_dev *=
dev, uint64_t base,
     return 0;
 }
=20
+static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
+                                             struct vhost_dev *dev,
+                                             VhostUserMsg *msg,
+                                             int *fds, size_t *fd_num,
+                                             bool track_ramblocks)
+{
+    int i, fd;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    struct vhost_memory_region *reg;
+
+    msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
+
+    for (i =3D 0; i < dev->mem->nregions; ++i) {
+        reg =3D dev->mem->regions + i;
+
+        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr);
+        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace_a=
ddr,
+                                     &offset);
+        fd =3D memory_region_get_fd(mr);
+        if (fd > 0) {
+            if (track_ramblocks) {
+                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
+                trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
+                                                      reg->memory_size,
+                                                      reg->guest_phys_addr=
,
+                                                      reg->userspace_addr,
+                                                      offset);
+                u->region_rb_offset[i] =3D offset;
+                u->region_rb[i] =3D mr->ram_block;
+            } else if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
+                error_report("Failed preparing vhost-user memory table msg=
");
+                return -1;
+            }
+            msg->payload.memory.regions[*fd_num].userspace_addr =3D
+                reg->userspace_addr;
+            msg->payload.memory.regions[*fd_num].memory_size =3D
+                reg->memory_size;
+            msg->payload.memory.regions[*fd_num].guest_phys_addr =3D
+                reg->guest_phys_addr;
+            msg->payload.memory.regions[*fd_num].mmap_offset =3D offset;
+            fds[(*fd_num)++] =3D fd;
+        } else if (track_ramblocks) {
+            u->region_rb_offset[i] =3D 0;
+            u->region_rb[i] =3D NULL;
+        }
+    }
+
+    msg->payload.memory.nregions =3D *fd_num;
+
+    if (!*fd_num) {
+        error_report("Failed initializing vhost-user memory map, "
+                     "consider using -object memory-backend-file share=3Do=
n");
+        return -1;
+    }
+
+    msg->hdr.size =3D sizeof(msg->payload.memory.nregions);
+    msg->hdr.size +=3D sizeof(msg->payload.memory.padding);
+    msg->hdr.size +=3D *fd_num * sizeof(VhostUserMemoryRegion);
+
+    return 1;
+}
+
 static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              struct vhost_memory *mem)
 {
     struct vhost_user *u =3D dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
     size_t fd_num =3D 0;
     VhostUserMsg msg_reply;
     int region_i, msg_i;
=20
     VhostUserMsg msg =3D {
-        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
         .hdr.flags =3D VHOST_USER_VERSION,
     };
=20
@@ -433,48 +494,11 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
         u->region_rb_len =3D dev->mem->nregions;
     }
=20
-    for (i =3D 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg =3D dev->mem->regions + i;
-        ram_addr_t offset;
-        MemoryRegion *mr;
-
-        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr);
-        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace_a=
ddr,
-                                     &offset);
-        fd =3D memory_region_get_fd(mr);
-        if (fd > 0) {
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
-            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
-                                                  reg->memory_size,
-                                                  reg->guest_phys_addr,
-                                                  reg->userspace_addr, off=
set);
-            u->region_rb_offset[i] =3D offset;
-            u->region_rb[i] =3D mr->ram_block;
-            msg.payload.memory.regions[fd_num].userspace_addr =3D
-                reg->userspace_addr;
-            msg.payload.memory.regions[fd_num].memory_size  =3D reg->memor=
y_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
-                reg->guest_phys_addr;
-            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
-            fds[fd_num++] =3D fd;
-        } else {
-            u->region_rb_offset[i] =3D 0;
-            u->region_rb[i] =3D NULL;
-        }
-    }
-
-    msg.payload.memory.nregions =3D fd_num;
-
-    if (!fd_num) {
-        error_report("Failed initializing vhost-user memory map, "
-                     "consider using -object memory-backend-file share=3Do=
n");
+    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                          true) < 0) {
         return -1;
     }
=20
-    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
-    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
-    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
-
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
         return -1;
     }
@@ -545,7 +569,6 @@ static int vhost_user_set_mem_table(struct vhost_dev *d=
ev,
 {
     struct vhost_user *u =3D dev->opaque;
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
     size_t fd_num =3D 0;
     bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
@@ -559,7 +582,6 @@ static int vhost_user_set_mem_table(struct vhost_dev *d=
ev,
     }
=20
     VhostUserMsg msg =3D {
-        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
         .hdr.flags =3D VHOST_USER_VERSION,
     };
=20
@@ -567,42 +589,11 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
         msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
     }
=20
-    for (i =3D 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg =3D dev->mem->regions + i;
-        ram_addr_t offset;
-        MemoryRegion *mr;
-
-        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr);
-        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace_a=
ddr,
-                                     &offset);
-        fd =3D memory_region_get_fd(mr);
-        if (fd > 0) {
-            if (fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
-                error_report("Failed preparing vhost-user memory table msg=
");
-                return -1;
-            }
-            msg.payload.memory.regions[fd_num].userspace_addr =3D
-                reg->userspace_addr;
-            msg.payload.memory.regions[fd_num].memory_size  =3D reg->memor=
y_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
-                reg->guest_phys_addr;
-            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
-            fds[fd_num++] =3D fd;
-        }
-    }
-
-    msg.payload.memory.nregions =3D fd_num;
-
-    if (!fd_num) {
-        error_report("Failed initializing vhost-user memory map, "
-                     "consider using -object memory-backend-file share=3Do=
n");
+    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
+                                          false) < 0) {
         return -1;
     }
=20
-    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
-    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
-    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
-
     if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
         return -1;
     }
--=20
MST


