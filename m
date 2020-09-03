Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DBC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D0D20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsbWCJFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D0D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtZf-0004nA-An
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYc-0003Qy-3Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYZ-0007PF-Co
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OztoC9v0fTAzGHm6210N9osEGvTH2M/XSh6+JQmJeOo=;
 b=KsbWCJFWhtl1VpyTRIxlL6nSMunWCEKadlAbJMrAbq8YPOKkNvvYflgUyjT50l8GYXgaX2
 smFUSuTtmgKJth5ci2QztA5n5919jqybatmgiKOUfEJWJ/UPi5mNhI75FbFpQmkBAVx7aB
 Mhdc3Cl4w3JWmEL5Ckz1se+ocSDvDRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-DeCP8G6mOMOVkILyOMQx8w-1; Thu, 03 Sep 2020 14:01:50 -0400
X-MC-Unique: DeCP8G6mOMOVkILyOMQx8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631378015A4;
 Thu,  3 Sep 2020 18:01:49 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7878A6198B;
 Thu,  3 Sep 2020 18:01:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 2/8] i8254: Rename PIT to ISA_PIT
Date: Thu,  3 Sep 2020 14:01:22 -0400
Message-Id: <20200903180128.1523959-3-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename type checking function to be consistent with the type name
constant (TYPE_ISA_PIT) and type name string ("isa-pit").

Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/timer/i8254.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 5666bcb4ef..3f63e7b936 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -38,7 +38,7 @@
 #define RW_STATE_WORD1 4
 
 typedef struct PITClass PITClass;
-DECLARE_CLASS_CHECKERS(PITClass, PIT,
+DECLARE_CLASS_CHECKERS(PITClass, ISA_PIT,
                        TYPE_ISA_PIT)
 
 struct PITClass {
@@ -334,7 +334,7 @@ static void pit_post_load(PITCommonState *s)
 static void pit_realizefn(DeviceState *dev, Error **errp)
 {
     PITCommonState *pit = PIT_COMMON(dev);
-    PITClass *pc = PIT_GET_CLASS(dev);
+    PITClass *pc = ISA_PIT_GET_CLASS(dev);
     PITChannelState *s;
 
     s = &pit->channels[0];
@@ -357,7 +357,7 @@ static Property pit_properties[] = {
 
 static void pit_class_initfn(ObjectClass *klass, void *data)
 {
-    PITClass *pc = PIT_CLASS(klass);
+    PITClass *pc = ISA_PIT_CLASS(klass);
     PITCommonClass *k = PIT_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-- 
2.26.2


