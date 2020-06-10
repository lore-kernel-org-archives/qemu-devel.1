Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75098C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9312072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKH8uIgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9312072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisnX-00010j-Do
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOJ-0004hX-7M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisOG-0000gc-6D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WoW/5GHRqsRNTQHlFF254BVJ0vB+TltSYwqwpwCDlQ=;
 b=jKH8uIgzxN2p8YM8H778txDCYwbs/Hb4Mym0rFiqgPPqtyV3tw1QZBYYB4e+8dIou3u9P2
 7rv1GkP3x+M9q0gb6fvCwfbwdmdH65T8CopU0dXBomjzm8glnC7A4sm/9NFYELABrZ+Rpk
 7QehzmLLXBbQbKlS8EOlQ+KAXrAU7ic=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-KA5-9qTlOgSECpsxJhi-0g-1; Wed, 10 Jun 2020 00:27:58 -0400
X-MC-Unique: KA5-9qTlOgSECpsxJhi-0g-1
Received: by mail-wr1-f70.google.com with SMTP id n6so512493wrv.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3WoW/5GHRqsRNTQHlFF254BVJ0vB+TltSYwqwpwCDlQ=;
 b=AU4/fuk1CBoncCtzhywq6x2ZjyY+aVfJIQQxlP8Kq8EsOxmxFzTmcytlqlsBDHf7b7
 uCm8L/dMv49tI2BlJQ+qPPXrefPLslNacIxfoi25f0YleLp5kv42Tmgs4fvPSsaP1fcp
 VsZb4MADmzn3ftl6oYpA+G69erEeLtfmfZBI/iRm/KPvUSTTsp8FVkoBOrioKCC8j156
 monn9He9SmDAyS4d8uCVLw909blqUOUJ9zsL58Be0yw/fsjWFTqIY0U4uEFkfAi7z7oL
 9OmkylbOgGk+oJZLvg+LKltF3XAL+XIHzrid5ikzKrkpqaV6deAxEnANUdaH/NeTJvvr
 Mf8A==
X-Gm-Message-State: AOAM532xH7RGFZtMGZm04JuM9C2SmhKy49FmKsd4cHUiCamuvxr7C0N+
 qrprcAAkVmShUxT0uMHEvnHV9EzSO5dd3lE7nuRUZ7xBi1Eofho+oO6VMZjO3Vghy6o0QAgq8O0
 c7IrkNET1yKYAO0s=
X-Received: by 2002:a1c:451:: with SMTP id 78mr1226647wme.83.1591763277129;
 Tue, 09 Jun 2020 21:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPuBjUXDgDwuLREEmAFd/vLAchiY3NYbiW8NbR0+KhZUfziMA7bvz42IzhyDScNxU74rQlkA==
X-Received: by 2002:a1c:451:: with SMTP id 78mr1226634wme.83.1591763276917;
 Tue, 09 Jun 2020 21:27:56 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id l204sm5443241wmf.19.2020.06.09.21.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:56 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/56] Add vhost-user helper to get MemoryRegion data
Message-ID: <20200610042613.1459309-38-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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

When setting the memory tables, qemu uses a memory region's userspace
address to look up the region's MemoryRegion struct. Among other things,
the MemoryRegion contains the region's offset and associated file
descriptor, all of which need to be sent to the backend.

With VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, this logic will be
needed in multiple places, so before feature support is added it
should be moved to a helper function.

This helper is also used to simplify the vhost_user_can_merge()
function.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-3-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2e0552dd74..442b0d650a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -407,6 +407,18 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
+                                            int *fd)
+{
+    MemoryRegion *mr;
+
+    assert((uintptr_t)addr == addr);
+    mr = memory_region_from_host((void *)(uintptr_t)addr, offset);
+    *fd = memory_region_get_fd(mr);
+
+    return mr;
+}
+
 static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
                                        struct vhost_memory_region *src)
 {
@@ -433,10 +445,7 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
     for (i = 0; i < dev->mem->nregions; ++i) {
         reg = dev->mem->regions + i;
 
-        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
-        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
-                                     &offset);
-        fd = memory_region_get_fd(mr);
+        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
         if (fd > 0) {
             if (track_ramblocks) {
                 assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
@@ -1551,13 +1560,9 @@ static bool vhost_user_can_merge(struct vhost_dev *dev,
 {
     ram_addr_t offset;
     int mfd, rfd;
-    MemoryRegion *mr;
 
-    mr = memory_region_from_host((void *)(uintptr_t)start1, &offset);
-    mfd = memory_region_get_fd(mr);
-
-    mr = memory_region_from_host((void *)(uintptr_t)start2, &offset);
-    rfd = memory_region_get_fd(mr);
+    (void)vhost_user_get_mr_data(start1, &offset, &mfd);
+    (void)vhost_user_get_mr_data(start2, &offset, &rfd);
 
     return mfd == rfd;
 }
-- 
MST


