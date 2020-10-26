Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD91C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884CF2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGgWPvez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884CF2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Mf-00050b-K8
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Ac-000868-RO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Ab-0008Rj-04
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drjwmQSo3TPMr2yqHnKgPcr0+zGutJeRfAQssJrVzdY=;
 b=jGgWPvezLWxa0MXv7qRaRIUfyYXAUK3W2W1+xANL06ytiA+Jt1CYHMI0AXVZpyCgglTcOS
 LRvJk8lNdfZT3Du7dtOsMzgnUzciqFWUnmjmSKiEclrs06CvhsVRYOd0fXdTCnb9LVcdv3
 qqCFkgzHwVasc8S8EYDUsxg0d3Fxsb8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-jU2GC6TyOcWMmDYnQQzkfQ-1; Mon, 26 Oct 2020 06:56:06 -0400
X-MC-Unique: jU2GC6TyOcWMmDYnQQzkfQ-1
Received: by mail-wr1-f69.google.com with SMTP id j15so8203172wrd.16
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=drjwmQSo3TPMr2yqHnKgPcr0+zGutJeRfAQssJrVzdY=;
 b=gcujwz/5VM0Dx9tGnvVjiSJAFqbWVVXdR+UMA00SEvDDjfi6Fp7rhTk9Ov94EokaJ9
 z4aCUAfAxt9VQyMU7B2Cjux3NJK1sldoEbkFDK3piWUGfAb6cRWRTecxdVEmXqn7PDmG
 ahkJSWMwc3Gc4xjkeAeH8i+ZwlOt1tAcv3+5GH2GI5PonWbxWX3eiyEoaO9E2i8bNOjM
 U5pvvgSK2nAySRweNXtP2hW3cAfcr7IZifiKEA2fVRPeZC2t+bFbvZFOpfj6cbPySj62
 beHa4qzsyQqcPT5YWSimM2M2KqMvj8KBwX9bWo4xzovLlsNxrVw/PsoKhcnbuQxVUrd7
 M8tg==
X-Gm-Message-State: AOAM533XdEyfENX65u+rA1FRXHdOIpajFFeI5jVHEmIBd6fcgTsnsBgj
 97w1pQKmBVm7l+dkRFR7+a27AQmTuwkqf9k52+0VE93wa0eA4cgaabDDYd/VOdG1H/BF7Qp1lgq
 V+iQDDHw27H9DL8g=
X-Received: by 2002:adf:fe89:: with SMTP id l9mr17280969wrr.264.1603709765030; 
 Mon, 26 Oct 2020 03:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHRe3awfpH73MG7A/5OOqXAxovuCJFl1y6Y0demSgVXpYmRrwIMyFpa1uHINWPVbZ8vXezFA==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr17280941wrr.264.1603709764820; 
 Mon, 26 Oct 2020 03:56:04 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e11sm22193488wrj.75.2020.10.26.03.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/19] util/vfio-helpers: Let qemu_vfio_do_mapping()
 propagate Error
Date: Mon, 26 Oct 2020 11:54:57 +0100
Message-Id: <20201026105504.4023620-13-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass qemu_vfio_do_mapping() an Error* argument so it can propagate
any error to callers. Replace error_report() which only report
to the monitor by the more generic error_setg_errno().

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index c03fe0b7156..2c4598d7faa 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -609,7 +609,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
 
 /* Do the DMA mapping with VFIO. */
 static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
-                                uint64_t iova)
+                                uint64_t iova, Error **errp)
 {
     struct vfio_iommu_type1_dma_map dma_map = {
         .argsz = sizeof(dma_map),
@@ -621,7 +621,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
     trace_qemu_vfio_do_mapping(s, host, iova, size);
 
     if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
-        error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
+        error_setg_errno(errp, errno, "VFIO_MAP_DMA failed");
         return -errno;
     }
     return 0;
@@ -757,7 +757,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                 goto out;
             }
             assert(qemu_vfio_verify_mappings(s));
-            ret = qemu_vfio_do_mapping(s, host, size, iova0);
+            ret = qemu_vfio_do_mapping(s, host, size, iova0, errp);
             if (ret) {
                 qemu_vfio_undo_mapping(s, mapping, NULL);
                 goto out;
@@ -768,7 +768,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                 ret = -ENOMEM;
                 goto out;
             }
-            ret = qemu_vfio_do_mapping(s, host, size, iova0);
+            ret = qemu_vfio_do_mapping(s, host, size, iova0, errp);
             if (ret) {
                 goto out;
             }
-- 
2.26.2


