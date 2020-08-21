Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7DC20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYIUpMEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7DC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B1l-0004lb-Jj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9B01-00034K-DX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:38:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9Azy-0002SW-Lo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598031521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QQoARLZDJ9kJvgGBNB/TMfNiWwlKNFqv3ZziP5ASBD0=;
 b=dYIUpMEOxUHm3+9VumHFOAh9auBdAXGxPwAdvEmB8zB2eaJqKWYh9oxH65qBG0xYd99WuP
 vTWnrdAfVb43jt807uNPFn2ftgYK2CjDIjlhNRusCoESkSz19Vzh15L8AwXSWIWOWLeW7L
 mHjXsAJ8NQN3WAADVgPmevVgCS2/YoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-VllLD-jnM6yWiiSvbFF3yA-1; Fri, 21 Aug 2020 13:38:35 -0400
X-MC-Unique: VllLD-jnM6yWiiSvbFF3yA-1
Received: by mail-wr1-f72.google.com with SMTP id r11so632633wrj.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QQoARLZDJ9kJvgGBNB/TMfNiWwlKNFqv3ZziP5ASBD0=;
 b=XLHsYN5ENibMgiQi84+ZcOYkObd9ibxwhZIjG4zV3Bak0JJA5IIbsoxjpXmGOKwc9Q
 JI5uXx1B8N0ohBybTOgs1PSW+9tJHN7FQgQn8UR0G1UJXhacuSPtDq+AET2Nj3az+zAr
 B41yBWk12IjJeIyQef5LIrjdL9HWBe15qFNSl4gyHKTutbqgv5w5/AgUI2KM/iIzU0px
 +QHcLFbumP7NLlKH6tN9g2K71HKMf92J7kCkd99rbtehhJa0eHhUNdvsnzTkBtkWaj3o
 MRIEzj3ilKmZBqaabuJrFLE7w4ek1EqUEhG5PNEIHKfOZwt/ecRX/ojXtyrP6B/bt5+b
 dqZw==
X-Gm-Message-State: AOAM531/UKU/h4XCmNigXWxsH+NJhUqRzqr0yY3v+oNNO3Ig2+Za/CV8
 yWWGpGgxC928WKDD5wsRtl85SuEXtDfhzUDh0DZVuKq8iMHFJSUs1uPgWF9hxJW/7AlJOy3vNfT
 TRMj9Pvka82ely+4=
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr3948661wru.170.1598031514382; 
 Fri, 21 Aug 2020 10:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyG3EuRNn1WklIbg5C5hbBPkL9HJiaEObcqBUHm2hvxiZ8sP2LqlmHhZTeyC7CY5NnVDRtGw==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr3948630wru.170.1598031514130; 
 Fri, 21 Aug 2020 10:38:34 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c10sm5922687wro.84.2020.08.21.10.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/isa/isa-superio: Set abstract TYPE_ISA_SUPERIO instance
 size
Date: Fri, 21 Aug 2020 19:38:31 +0200
Message-Id: <20200821173831.1262979-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg731954.html
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


