Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29FEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91D82078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+SZjVNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91D82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H7b-0002jT-Td
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3Z-0004wm-SS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3X-0008KW-U0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16/8u8u4aSNC+TBsbyq8DSkALSFB26Shm2nwb6CzfCw=;
 b=N+SZjVNFjLOduptYmZhiMKs0FiwWhiSn7ckZnJxmoOdLS7/Zznl0VCVsXNajNesG3TaKVO
 kVA3hybgNm5EbwgBShda1EsVNiza/Z8CkjzHI0UTYcHFD2tWoIeYImrQueCWdyBF9u+kp7
 np+aRjOHViuWsxzzhzVf1bwBMdHpw+I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-ViVMnpYKMze7NXrl_0xr7w-1; Thu, 13 Aug 2020 13:30:21 -0400
X-MC-Unique: ViVMnpYKMze7NXrl_0xr7w-1
Received: by mail-wr1-f72.google.com with SMTP id b18so2353213wrn.6
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=16/8u8u4aSNC+TBsbyq8DSkALSFB26Shm2nwb6CzfCw=;
 b=VcrOpNLwwnERuueL5SH4Sa43OVrcn2+XFX9SWneVDccWGDkl/7GCjf4k49Q6NSMiC4
 fAHIUZ9duJ/9dUnDNsHpyR/JJ39CoBenETJPx8+h5Nkf0u9xFSLrdpcqdE6ss5e0K71Z
 nE3/ZXDZsIIus70JdFahpKSWPqab10aF0bIxkh7G1TgmBguSxtXjYJgkN22/4lRgIIKC
 +1jS9iZVnAcmPjux9/egchd39siS/I98zvPyPYOvNHwJd6UX2qLa8mxYV+T3kpePNxbB
 dm3JjcljdV3FTPhalQaOQk77oFUG8gfd9S4HsOrkFPm4fR3UUTMJCFnHy3KEaQ775Ig2
 +nvQ==
X-Gm-Message-State: AOAM530vTFuWorY/FR7aKwNU9+63Viiv2vLDO78aDFhK31a6ocVWm0D2
 K8uugLXwVdRc0FSy3aWup/cdW+ssrJ+MqPD4J4rc/JBDR38QfSbZA9HgiW0v3OQjX90e0sRuS/A
 7iJShbejFy6Xwmec=
X-Received: by 2002:a5d:5445:: with SMTP id w5mr5353717wrv.342.1597339820069; 
 Thu, 13 Aug 2020 10:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRrxCEfbhfAfBTKj0hhPG4BuEkNr7WLE1FFC/mH8l7PD2jgyfu9yjALhTZjkMplOeO5fqGEw==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr5353700wrv.342.1597339819890; 
 Thu, 13 Aug 2020 10:30:19 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l18sm11106929wrm.52.2020.08.13.10.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 4/7] util/vfio-helpers: Check the device allow up to
 'irq_count' IRQs
Date: Thu, 13 Aug 2020 19:29:54 +0200
Message-Id: <20200813172957.8289-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813172957.8289-1-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:30:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As we want to use more than one single IRQ, add a check that
the device accept our request to use multiple IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 6 ++++++
 util/trace-events   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index bad60076f3..b81d4c70c2 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -335,6 +335,12 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    trace_qemu_vfio_init_pci(device_info.num_irqs);
+    if (device_info.num_irqs < irq_count) {
+        error_setg(errp, "Invalid device IRQ count");
+        ret = -EINVAL;
+        goto fail;
+    }
     s->irq_type = irq_type;
     s->irq_count = irq_count;
 
diff --git a/util/trace-events b/util/trace-events
index 0ce42822eb..2e85555be3 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -83,3 +83,4 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size %zu iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size %zu temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_init_pci(uint32_t count) "device interrupt count: %"PRIu32
-- 
2.21.3


