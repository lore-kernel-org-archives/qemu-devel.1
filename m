Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D451C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8D320884
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEUGXKQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8D320884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxIL-0002hm-BE
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx6M-00078O-Qd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx6A-00012n-1M
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ButK3prZ+cWQ+tqdqRhbbnFa20a91mKSRG/nTX+kx68=;
 b=YEUGXKQUm4b8QSnfbIFRE0pdv0VGXBTQgMXPfiWO+NpByLxGRBxjim1CokKsJi3KRpImcR
 +2P1By0/PU2PMEq+UJJdVcbQlc61lGDqll2ncN9sxz9zfBD9BN6N82/blfdvJ2CUfyV8ET
 ll3LVxcMTQSY/pMJbBCI0JVIMdDk7qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-WsHgd7weN1u2brAc4nriiQ-1; Thu, 02 Jul 2020 07:09:39 -0400
X-MC-Unique: WsHgd7weN1u2brAc4nriiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD8B8015F6;
 Thu,  2 Jul 2020 11:09:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E87360CD3;
 Thu,  2 Jul 2020 11:09:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C6621138481; Thu,  2 Jul 2020 13:09:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/28] mips/cps: Fix mips_cps_realize() error API violations
Date: Thu,  2 Jul 2020 13:09:24 +0200
Message-Id: <20200702110931.2953148-22-armbru@redhat.com>
In-Reply-To: <20200702110931.2953148-1-armbru@redhat.com>
References: <20200702110931.2953148-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

mips_cps_realize() is wrong that way: it passes &err to multiple
object_property_set_FOO() without checking for failure, and then to
sysbus_realize().  Harmless, because the object_property_set_FOO()
can't actually fail here.

Fix by passing &error_abort instead.

Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200630090351.1247703-20-armbru@redhat.com>
---
 hw/mips/cps.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 5382bc86f7..0d7f3cf673 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -100,10 +100,12 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Inter-Thread Communication Unit */
     if (itu_present) {
         object_initialize_child(OBJECT(dev), "itu", &s->itu, TYPE_MIPS_ITU);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
+        object_property_set_int(OBJECT(&s->itu), 16, "num-fifo",
+                                &error_abort);
+        object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores",
+                                &error_abort);
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
-                                 &err);
+                                 &error_abort);
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
@@ -119,8 +121,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Cluster Power Controller */
     object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_MIPS_CPC);
-    object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err);
+    object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running",
+                            &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -132,8 +136,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Global Interrupt Controller */
     object_initialize_child(OBJECT(dev), "gic", &s->gic, TYPE_MIPS_GIC);
-    object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->gic), 128, "num-irq", &err);
+    object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gic), 128, "num-irq",
+                            &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -147,9 +153,12 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     gcr_base = env->CP0_CMGCRBase << 4;
 
     object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
-    object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
-    object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err);
+    object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base",
+                            &error_abort);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic",
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc",
-- 
2.26.2


