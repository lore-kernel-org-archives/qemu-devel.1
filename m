Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684BDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3452120734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8EoEE18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3452120734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisc2-000055-AY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLI-0000sX-5W
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLH-0008Kx-5S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MPP6uVIK/72gmaaGLDDvftHafSRk3w6HEMlvs19A15A=;
 b=O8EoEE18eIiRoMAKuuArMGii/+43h7kBY9q80YrxRljguchpzMZAUH6VHoLqZv6heNNEmd
 D6J1H3uxabMu9ovMEtw5ClLGUsACJZUKaoXUttYKiznaJlfaDRLoxzqqwoDhCyK9c45Dyh
 +4YJNnc9SFQqG+Litu99XvEVajQ0UVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170--TEWLSjTPQiV0v5JBs-aOA-1; Wed, 10 Jun 2020 00:27:56 -0400
X-MC-Unique: -TEWLSjTPQiV0v5JBs-aOA-1
Received: by mail-wm1-f70.google.com with SMTP id c4so89310wmd.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MPP6uVIK/72gmaaGLDDvftHafSRk3w6HEMlvs19A15A=;
 b=dkFVlnwayr62zvQVH4ZNQ2/yPYgwnQx08Kcltw7uuP2By8UFd0xnWJhegujRxCk1JL
 HqL1PGH1m5ol666bzK/hdhQ011XHr5u3nqgoCt4YNIl4KXZYfqTFFxyB/VpIzGUGJkUi
 t+k4vH5im5Ij4PTv9HazfgHi1eOZQMxKdaUDbPto0Y78RnXyVSIymBV8GGYILle183Xx
 y5VxE8UiMUd8AIC0KA8Viko3Z12MzSnfunJD/zexDGUGx7eHasx6MyTTI+bzqmk2wr/f
 OEcLz0E3SVLYd5FMgI8xGiJz/YNG8Hyo5RQw5HJU31veLRM58jb9Jo6m2jY1zIpsDfz8
 1mkw==
X-Gm-Message-State: AOAM531ilW9zfgoHc3ueckhMk/GZkS3FcL1XonCIppeRMXzFapXCE6wl
 hAesIxzoV29VypNr+QF8GnC9qJLHHRBxv2KfCMM640HGCRgATgL0pwoq+j/Sp9sQoqNYWAFk3jy
 9MczJipktKP6Qtd4=
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr1157763wmk.77.1591763275070;
 Tue, 09 Jun 2020 21:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypcYA8eodf5m+YlI3N4wAqX3wCimLzryxQYTZMdDdu95iBB3Td0cXBS9D1YUmwJBYULy8OmQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr1157753wmk.77.1591763274876;
 Tue, 09 Jun 2020 21:27:54 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id a126sm5083019wme.28.2020.06.09.21.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:54 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/56] Add helper to populate vhost-user message regions
Message-ID: <20200610042613.1459309-37-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

When setting vhost-user memory tables, memory region descriptors must be
copied from the vhost_dev struct to the vhost-user message. To avoid
duplicating code in setting the memory tables, we should use a helper to
populate this field. This change adds this helper.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-2-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ec21e8fbe8..2e0552dd74 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,6 +407,15 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
+                                       struct vhost_memory_region *src)
+{
+    assert(src != NULL && dst != NULL);
+    dst->userspace_addr = src->userspace_addr;
+    dst->memory_size = src->memory_size;
+    dst->guest_phys_addr = src->guest_phys_addr;
+}
+
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                              struct vhost_dev *dev,
                                              VhostUserMsg *msg,
@@ -417,6 +426,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     ram_addr_t offset;
     MemoryRegion *mr;
     struct vhost_memory_region *reg;
+    VhostUserMemoryRegion region_buffer;
 
     msg->hdr.request = VHOST_USER_SET_MEM_TABLE;
 
@@ -441,12 +451,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                 error_report("Failed preparing vhost-user memory table msg");
                 return -1;
             }
-            msg->payload.memory.regions[*fd_num].userspace_addr =
-                reg->userspace_addr;
-            msg->payload.memory.regions[*fd_num].memory_size =
-                reg->memory_size;
-            msg->payload.memory.regions[*fd_num].guest_phys_addr =
-                reg->guest_phys_addr;
+            vhost_user_fill_msg_region(&region_buffer, reg);
+            msg->payload.memory.regions[*fd_num] = region_buffer;
             msg->payload.memory.regions[*fd_num].mmap_offset = offset;
             fds[(*fd_num)++] = fd;
         } else if (track_ramblocks) {
-- 
MST


