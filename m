Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD563C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CEB2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN0rsd+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CEB2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvSL-0004xJ-3R
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOB-00078y-On
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvO9-00087d-S9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LYaPDykygFtAxF5+J+IEj33yA5rBInQCpCJf3vg5O0=;
 b=JN0rsd+DGjdM4R+PKKL0+R4Q9qSM1dcPbUgI/vPe51rDi4MiUCL6JH16xP9H1UjLnFw2I1
 auRZygSf+2JXcx/qNpXM2RqtDTO7fRowhQ36JdfIWL9BsnYJcqHQ0Nliz0hQNvcFgAcQDR
 eSrTNL7VyjuCi/eQXzstrAHLSaz7DjE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-jOij0cnGOU-VtARh4vFRDg-1; Tue, 20 Oct 2020 13:25:28 -0400
X-MC-Unique: jOij0cnGOU-VtARh4vFRDg-1
Received: by mail-wr1-f71.google.com with SMTP id t3so1090608wrq.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7LYaPDykygFtAxF5+J+IEj33yA5rBInQCpCJf3vg5O0=;
 b=G+PH8Cu2y+J377xwUMj/fTge2xNMCYZMz+UwOjFxVJZX+Rh16Q20y/4ZvydBus6rEo
 PFrToBlKxnBOT1sGqbUIiw6SoxxxfkcZqu09yfzazHC0L/lFcT6XHs4c3pI96uaMjYka
 i/nK3jSJEGlD1k4VK62QVS3B7KGIFYpGKNxsM4A83df9uzM0/qlfZwKRNRq5y2UYgaUF
 jbwVTfkA8mpF/kodY7RAsfBopRH9MqYJXg5m5xlIQwT8C+jQI9YzcVgAmgKlYv5bJDRQ
 uBd3hcaj9ilvTKfFC9sObb7/h+QJJMa688djsP5l4MAt/vf9o/HCBhdcFlM+xissC0cs
 5enw==
X-Gm-Message-State: AOAM530rhj4hhwL05QSHP02J21CL3I91bl+PAid5efryzJHrNLUUFGbD
 DwL6PqYq3cQKBM3huBH9TBpFfQq8nxSlKDhZiJRP8trpaUL+4evrJ6OLjcf7n0Y3awqggjllgGp
 NW8vwOjT/HoCsSgo=
X-Received: by 2002:adf:fd49:: with SMTP id h9mr4977129wrs.115.1603214726913; 
 Tue, 20 Oct 2020 10:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8bH8yADkwParrzpk3HEb+VNDg6I537fQ5Ih2TTJxKFYwGhLQLS70gFcu/Hh5/9p+PagnMuA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr4977099wrs.115.1603214726693; 
 Tue, 20 Oct 2020 10:25:26 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c130sm3589568wma.17.2020.10.20.10.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] util/vfio-helpers: Let qemu_vfio_do_mapping() propagate
 Error
Date: Tue, 20 Oct 2020 19:24:23 +0200
Message-Id: <20201020172428.2220726-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 8c075d9aae7..fb180becc4f 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -639,7 +639,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
 
 /* Do the DMA mapping with VFIO. */
 static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
-                                uint64_t iova)
+                                uint64_t iova, Error **errp)
 {
     struct vfio_iommu_type1_dma_map dma_map = {
         .argsz = sizeof(dma_map),
@@ -651,7 +651,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
     trace_qemu_vfio_do_mapping(s, host, iova, size);
 
     if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
-        error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
+        error_setg_errno(errp, errno, "VFIO_MAP_DMA failed");
         return -errno;
     }
     return 0;
@@ -787,7 +787,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                 goto out;
             }
             assert(qemu_vfio_verify_mappings(s));
-            ret = qemu_vfio_do_mapping(s, host, size, iova0);
+            ret = qemu_vfio_do_mapping(s, host, size, iova0, errp);
             if (ret) {
                 qemu_vfio_undo_mapping(s, mapping, NULL);
                 goto out;
@@ -798,7 +798,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
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


