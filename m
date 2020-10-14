Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A611020848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egx1EQuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A611020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfSU-0000WO-Up
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLi-0000LG-OO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLh-0000Y3-3W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MF6CELc3HUdf4Q8Rj0ad0iLARqM18cYceZFctPs7+I=;
 b=Egx1EQuWwHdCcO0+hlGBF0aNW+V5+5e0s2ygn+NlyxN3E8pWs9o2iJJej3wX8iHywieI0z
 xIkMhjxHTWasPQ/cRkKcPrzuw3rOQZ+b9eC7ihmsT4ht2LxDsj2VDzOQ4Z/8pCdmy5p8Up
 A4nFwZKLCAjSlKjYbHanqSwBnin3mbU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-djBpbDBCOzeX2ze4sFUGRQ-1; Wed, 14 Oct 2020 07:53:36 -0400
X-MC-Unique: djBpbDBCOzeX2ze4sFUGRQ-1
Received: by mail-wm1-f70.google.com with SMTP id c204so530156wmd.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+MF6CELc3HUdf4Q8Rj0ad0iLARqM18cYceZFctPs7+I=;
 b=DphE+P3Inl3ZALy2Wi5rumqUTjxmvOZwF0eJS4JasgGKCut0utFH0wCQY4ApgA6GWp
 ftJ2wZ/lQezyYDHsjrULEjMz2qguxtgbS0EYqnmv0WpeNLb36ookYrbsl24nxHNTyBen
 qSGLMVI5csf2EEyqrvqzfotWWsNzCbOnfQRizVO1Icf0b0d2+B09UObojQAcGcnJv2Qz
 FGXbe19N2qLnHNF6tfdH21dLuT58xnDRAS39FVzw31vZSKUE56POa468IJB4MOtP3u+b
 BJqrj2iTDlGUfseKJeMZ3dVk2MEmuCrdrsz2iqtJmASTMW+EuaLB9cgQNwvKHZLT01PL
 KCFQ==
X-Gm-Message-State: AOAM531odHNLKl7f3rwcxa8CZ05l6SUQsvYmgh1wRok+E+Al1id8gBj0
 dvFeR/rraxEa3iIib26rCSxe2EdxhKeK4ATPT1CWadGtDSkYNupV5G2biZH7sJGob8VcJ8RIshJ
 IboH0196rwPNPScw=
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr5067244wrn.91.1602676415204; 
 Wed, 14 Oct 2020 04:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL2e9IVbFz59KuTP2nwDmqI5XVzLoDSQqKHOW3W0u3Sy/zE9IC6aSMNJOLvMUQa6Yu11m1mA==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr5067223wrn.91.1602676414996; 
 Wed, 14 Oct 2020 04:53:34 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z11sm4503433wrh.70.2020.10.14.04.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/9] util/vfio-helpers: Let qemu_vfio_do_mapping() propagate
 Error
Date: Wed, 14 Oct 2020 13:52:52 +0200
Message-Id: <20201014115253.25276-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass qemu_vfio_do_mapping() an Error* argument so it can propagate
any error to callers. Replace error_report() which only report
to the monitor by the more generic error_setg_errno().

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


