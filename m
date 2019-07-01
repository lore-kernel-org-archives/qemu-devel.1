Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE86C06511
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A837520881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A837520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58241 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvXX-00081Q-Ti
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhvTO-00067B-Je
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhvTM-0002y5-Na
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhvT9-0002hC-A9; Mon, 01 Jul 2019 08:31:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D61FE5D5E6;
 Mon,  1 Jul 2019 12:31:31 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78F5117CC0;
 Mon,  1 Jul 2019 12:31:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 14:31:04 +0200
Message-Id: <20190701123108.12493-3-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-1-philmd@redhat.com>
References: <20190701123108.12493-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 01 Jul 2019 12:31:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] hw/arm: Use object_initialize_child for
 correct reference counting
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As explained in commit aff39be0ed97:

  Both functions, object_initialize() and object_property_add_child()
  increase the reference counter of the new object, so one of the
  references has to be dropped afterwards to get the reference
  counting right. Otherwise the child object will not be properly
  cleaned up when the parent gets destroyed.
  Thus let's use now object_initialize_child() instead to get the
  reference counting here right.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/mcimx7d-sabre.c |  9 ++++-----
 hw/arm/mps2-tz.c       | 15 +++++++--------
 hw/arm/musca.c         |  9 +++++----
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index d6b190d85d..8e211aa8df 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -29,7 +29,6 @@ static void mcimx7d_sabre_init(MachineState *machine)
 {
     static struct arm_boot_info boot_info;
     MCIMX7Sabre *s =3D g_new0(MCIMX7Sabre, 1);
-    Object *soc;
     int i;
=20
     if (machine->ram_size > FSL_IMX7_MMDC_SIZE) {
@@ -48,10 +47,10 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .nb_cpus =3D smp_cpus,
     };
=20
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX7);
-    soc =3D OBJECT(&s->soc);
-    object_property_add_child(OBJECT(machine), "soc", soc, &error_fatal)=
;
-    object_property_set_bool(soc, true, "realized", &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc",
+                            &s->soc, sizeof(s->soc),
+                            TYPE_FSL_IMX7, &error_fatal, NULL);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_f=
atal);
=20
     memory_region_allocate_system_memory(&s->ram, NULL, "mcimx7d-sabre.r=
am",
                                          machine->ram_size);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d85dc2c4bd..6b24aaacde 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -427,10 +427,10 @@ static void mps2tz_common_init(MachineState *machin=
e)
     /* The sec_resp_cfg output from the IoTKit must be split into multip=
le
      * lines, one for each of the PPCs we create here, plus one per MSC.
      */
-    object_initialize(&mms->sec_resp_splitter, sizeof(mms->sec_resp_spli=
tter),
-                      TYPE_SPLIT_IRQ);
-    object_property_add_child(OBJECT(machine), "sec-resp-splitter",
-                              OBJECT(&mms->sec_resp_splitter), &error_ab=
ort);
+    object_initialize_child(OBJECT(machine), "sec-resp-splitter",
+                            &mms->sec_resp_splitter,
+                            sizeof(mms->sec_resp_splitter),
+                            TYPE_SPLIT_IRQ, &error_abort, NULL);
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc) + ARRAY_SIZE(mms->msc),
                             "num-lines", &error_fatal);
@@ -465,10 +465,9 @@ static void mps2tz_common_init(MachineState *machine=
)
      * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
      * Create the OR gate for this.
      */
-    object_initialize(&mms->uart_irq_orgate, sizeof(mms->uart_irq_orgate=
),
-                      TYPE_OR_IRQ);
-    object_property_add_child(OBJECT(mms), "uart-irq-orgate",
-                              OBJECT(&mms->uart_irq_orgate), &error_abor=
t);
+    object_initialize_child(OBJECT(mms), "uart-irq-orgate",
+                            &mms->uart_irq_orgate, sizeof(mms->uart_irq_=
orgate),
+                            TYPE_OR_IRQ, &error_abort, NULL);
     object_property_set_int(OBJECT(&mms->uart_irq_orgate), 10, "num-line=
s",
                             &error_fatal);
     object_property_set_bool(OBJECT(&mms->uart_irq_orgate), true,
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index ddd8842732..68db4b5b38 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -424,10 +424,11 @@ static void musca_init(MachineState *machine)
      * The sec_resp_cfg output from the SSE-200 must be split into multi=
ple
      * lines, one for each of the PPCs we create here.
      */
-    object_initialize(&mms->sec_resp_splitter, sizeof(mms->sec_resp_spli=
tter),
-                      TYPE_SPLIT_IRQ);
-    object_property_add_child(OBJECT(machine), "sec-resp-splitter",
-                              OBJECT(&mms->sec_resp_splitter), &error_fa=
tal);
+    object_initialize_child(OBJECT(machine), "sec-resp-splitter",
+                            &mms->sec_resp_splitter,
+                            sizeof(mms->sec_resp_splitter),
+                            TYPE_SPLIT_IRQ, &error_fatal, NULL);
+
     object_property_set_int(OBJECT(&mms->sec_resp_splitter),
                             ARRAY_SIZE(mms->ppc), "num-lines", &error_fa=
tal);
     object_property_set_bool(OBJECT(&mms->sec_resp_splitter), true,
--=20
2.20.1


