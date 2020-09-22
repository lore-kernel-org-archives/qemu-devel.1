Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1113221E7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTNklds9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1113221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqqG-0008JS-0l
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjo-0000Dq-9I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjh-0006Lq-MW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fh7e7Rjmi72oO8UNU1nk0X5y6rGjwRA2sLHT6riiTZs=;
 b=aTNklds96ZfDxROTs5hOU/4CQlKzQpwVon8Za2RKuAQp7jCOtBSUI+GdKvBb8sxcPWhKwj
 uV2fr8foJ60eIRtxv2RIq3k+YgDW7hPdoM7G9xQFXfH/XZFW8knHGF/9dfPM1ymdu2SX21
 8j9EuAvTZDF+Wwit7FvWsXqp4U0Ckko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-ZyrXXXnVN2SbGkR_x0nugA-1; Tue, 22 Sep 2020 18:26:05 -0400
X-MC-Unique: ZyrXXXnVN2SbGkR_x0nugA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C321D801FDD;
 Tue, 22 Sep 2020 22:26:04 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6525DD99;
 Tue, 22 Sep 2020 22:26:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/11] sifive_u: Register "start-in-flash" as class property
Date: Tue, 22 Sep 2020 18:25:42 -0400
Message-Id: <20200922222542.2354748-12-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
References: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:33:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200921221045.699690-25-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/riscv/sifive_u.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a97637fb333..6ad975d6923 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -568,14 +568,6 @@ static void sifive_u_machine_instance_init(Object *obj)
     SiFiveUState *s = RISCV_U_MACHINE(obj);
 
     s->start_in_flash = false;
-    object_property_add_bool(obj, "start-in-flash",
-                             sifive_u_machine_get_start_in_flash,
-                             sifive_u_machine_set_start_in_flash);
-    object_property_set_description(obj, "start-in-flash",
-                                    "Set on to tell QEMU's ROM to jump to "
-                                    "flash. Otherwise QEMU will jump to DRAM "
-                                    "or L2LIM depending on the msel value");
-
     s->msel = 0;
     object_property_add(obj, "msel", "uint32",
                         sifive_u_machine_get_uint32_prop,
@@ -599,6 +591,14 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
+
+    object_class_property_add_bool(oc, "start-in-flash",
+                                   sifive_u_machine_get_start_in_flash,
+                                   sifive_u_machine_set_start_in_flash);
+    object_class_property_set_description(oc, "start-in-flash",
+                                          "Set on to tell QEMU's ROM to jump to "
+                                          "flash. Otherwise QEMU will jump to DRAM "
+                                          "or L2LIM depending on the msel value");
 }
 
 static const TypeInfo sifive_u_machine_typeinfo = {
-- 
2.26.2


