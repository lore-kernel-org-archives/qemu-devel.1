Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D55C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EB72072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwaIV3I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EB72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9UX0-0000k6-Bl
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVU-0007tu-8C
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9UVS-0003E1-Ji
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598106509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N1TvfeN9sguGH6fYWdtTuciXS7DxS//XoBqhXVC5YM=;
 b=DwaIV3I2xDJaUB+4N2CNn8Petdcg4LJbzBxLJoyc7tGZ7fZHLwrMzQfVX6FVIRv+itKR49
 mvL+Lf/abnXtTZeN8mQdT3q5nHRZAk1eHKDnPG9GNw3uJZ91lHqFw4RMkjQ/5SPOyQ37af
 eO4ntq/EiVFuVsAAAklpE9Qrm9EHILM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-cA3jFe3ZNOOEl6f0fC69sw-1; Sat, 22 Aug 2020 10:28:25 -0400
X-MC-Unique: cA3jFe3ZNOOEl6f0fC69sw-1
Received: by mail-wr1-f70.google.com with SMTP id m7so1751252wrb.20
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5N1TvfeN9sguGH6fYWdtTuciXS7DxS//XoBqhXVC5YM=;
 b=Ypv9p2yDrYFMYWtqox26Jf2iUUDAyaTk4Sa1MlpG/WU9J0o2zM7GUEmZr910j//CDJ
 bECqa8mcLdkDme484hMAIQ1i4gix1L2XcjtkiMyvawV9a/zTIAPG5Us6AjF2pq8l99a1
 fHBIsT4/LSkDHGKwvQlSNPklIPJdXnLVWE/7ydz0dwZ/9tc/Y6gKVqpYrvh/TYoZyWDl
 JqPKKTPI6QgEeXaCjSTjY5hrAHrv3ZY9oJnnZ1WozHQHo7KTGWV4S8IG1e2LfQwRs/k+
 TX340/pfyub2JJycmJpFUUcHElB4tcOdE83Q0AAO5d/yv6cWsLiErBa5TxMgBrJ6i+uy
 LcTg==
X-Gm-Message-State: AOAM5307vOvOkXK0gw8U2FHFerOCwFZrQv2SthzjTDC3OtM2UOvc2IOk
 DcqudQU/fHR0cRZRAVBh8b8JYjyKF+UuxvnvQr1+4QuJhAaB9Iu6HhLuYn2TzxDfH4Jzg2IlSIR
 s2reiPGARd84a7F8=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr8981653wmf.49.1598106504403; 
 Sat, 22 Aug 2020 07:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc6BPGcRPVr66IVWJ6fOki+xcWb8V8BjD9BRgqnRX+s3OxQFiw+8mncA00FT8qWqk806OZuA==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr8981637wmf.49.1598106504205; 
 Sat, 22 Aug 2020 07:28:24 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z203sm10504145wmc.31.2020.08.22.07.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 07:28:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/isa/superio: Set abstract TYPE_ISA_SUPERIO instance
 size
Date: Sat, 22 Aug 2020 16:28:15 +0200
Message-Id: <20200822142816.1318214-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822142816.1318214-1-philmd@redhat.com>
References: <20200822142816.1318214-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 10:28:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of setting the instance size on each implementations,
set it on the abstract parent, so we are sure no implementation
will forget to set it.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 1 -
 hw/isa/vt82c686.c          | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index e2e47d8fd99..83eb21ebb2a 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -182,6 +182,7 @@ static const TypeInfo isa_superio_type_info = {
     .name = TYPE_ISA_SUPERIO,
     .parent = TYPE_ISA_DEVICE,
     .abstract = true,
+    .instance_size = sizeof(ISASuperIODevice),
     .class_size = sizeof(ISASuperIOClass),
     .class_init = isa_superio_class_init,
 };
@@ -200,7 +201,6 @@ static void fdc37m81x_class_init(ObjectClass *klass, void *data)
 static const TypeInfo fdc37m81x_type_info = {
     .name          = TYPE_FDC37M81X_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_init    = fdc37m81x_class_init,
 };
 
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 18287741cb4..9e59dc16039 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -103,7 +103,6 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
 static const TypeInfo smc37c669_type_info = {
     .name          = TYPE_SMC37C669_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_size    = sizeof(ISASuperIOClass),
     .class_init    = smc37c669_class_init,
 };
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 18160ca445d..a4b84d405d0 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -533,7 +533,6 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
 static const TypeInfo via_superio_info = {
     .name          = TYPE_VT82C686B_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
     .class_size    = sizeof(ISASuperIOClass),
     .class_init    = vt82c686b_superio_class_init,
 };
-- 
2.26.2


