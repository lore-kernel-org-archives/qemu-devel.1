Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D53121734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyDAzrhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D53121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufI5-0001Nb-57
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucsv-0007Ta-Rw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucst-0006az-QN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucst-0006Zz-Mu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5xgf8npNPdcgNy49WhRLDJw3NarywnPN43TdsMlJ2k=;
 b=FyDAzrhVfwAZH0BbrrSjy9k5HcMuQdQbXrAguG5znMQO9VUh9TqDvRA65izi4cmZT3Nq6e
 OqtC8EocYdjI/EMvJLvbyTv6/Rje9XHlciDAV4Za2C3JCyJcJAE9+3QHGSXCrp7HHWQl3L
 SsD1Fu9ujWXSPZm5HEhHMIeFIMMpkhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-nTAogNC9MkKY_gITRWicqw-1; Thu, 23 Jan 2020 08:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1DC02F2F;
 Thu, 23 Jan 2020 13:50:55 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE7A385780;
 Thu, 23 Jan 2020 13:50:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/59] cpu: Use cpu_class_set_parent_reset()
Date: Thu, 23 Jan 2020 14:49:52 +0100
Message-Id: <1579787449-27599-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nTAogNC9MkKY_gITRWicqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Convert all targets to use cpu_class_set_parent_reset() with the following
coccinelle script:

@@
type CPUParentClass;
CPUParentClass *pcc;
CPUClass *cc;
identifier parent_fn;
identifier child_fn;
@@
+cpu_class_set_parent_reset(cc, child_fn, &pcc->parent_fn);
-pcc->parent_fn =3D cc->reset;
...
-cc->reset =3D child_fn;

Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <157650847817.354886.7047137349018460524.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/cpu.c                | 3 +--
 target/cris/cpu.c               | 3 +--
 target/i386/cpu.c               | 3 +--
 target/lm32/cpu.c               | 3 +--
 target/m68k/cpu.c               | 3 +--
 target/microblaze/cpu.c         | 3 +--
 target/mips/cpu.c               | 3 +--
 target/moxie/cpu.c              | 3 +--
 target/nios2/cpu.c              | 3 +--
 target/openrisc/cpu.c           | 3 +--
 target/ppc/translate_init.inc.c | 3 +--
 target/riscv/cpu.c              | 3 +--
 target/s390x/cpu.c              | 3 +--
 target/sh4/cpu.c                | 3 +--
 target/sparc/cpu.c              | 3 +--
 target/tilegx/cpu.c             | 3 +--
 target/tricore/cpu.c            | 3 +--
 target/xtensa/cpu.c             | 3 +--
 18 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d62fd5f..411faaa 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2707,8 +2707,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void =
*data)
                                     &acc->parent_realize);
     dc->props =3D arm_cpu_properties;
=20
-    acc->parent_reset =3D cc->reset;
-    cc->reset =3D arm_cpu_reset;
+    cpu_class_set_parent_reset(cc, arm_cpu_reset, &acc->parent_reset);
=20
     cc->class_by_name =3D arm_cpu_class_by_name;
     cc->has_work =3D arm_cpu_has_work;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 6a857f5..17c6712 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -264,8 +264,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *=
data)
     device_class_set_parent_realize(dc, cris_cpu_realizefn,
                                     &ccc->parent_realize);
=20
-    ccc->parent_reset =3D cc->reset;
-    cc->reset =3D cris_cpu_reset;
+    cpu_class_set_parent_reset(cc, cris_cpu_reset, &ccc->parent_reset);
=20
     cc->class_by_name =3D cris_cpu_class_by_name;
     cc->has_work =3D cris_cpu_has_work;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 41f28ce..78bdb7c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7149,8 +7149,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
                                       &xcc->parent_unrealize);
     dc->props =3D x86_cpu_properties;
=20
-    xcc->parent_reset =3D cc->reset;
-    cc->reset =3D x86_cpu_reset;
+    cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
     cc->reset_dump_flags =3D CPU_DUMP_FPU | CPU_DUMP_CCOP;
=20
     cc->class_by_name =3D x86_cpu_class_by_name;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b35537d..687bf35 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -218,8 +218,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *=
data)
=20
     device_class_set_parent_realize(dc, lm32_cpu_realizefn,
                                     &lcc->parent_realize);
-    lcc->parent_reset =3D cc->reset;
-    cc->reset =3D lm32_cpu_reset;
+    cpu_class_set_parent_reset(cc, lm32_cpu_reset, &lcc->parent_reset);
=20
     cc->class_by_name =3D lm32_cpu_class_by_name;
     cc->has_work =3D lm32_cpu_has_work;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f276335..f0653cd 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -273,8 +273,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *d=
ata)
=20
     device_class_set_parent_realize(dc, m68k_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D m68k_cpu_reset;
+    cpu_class_set_parent_reset(cc, m68k_cpu_reset, &mcc->parent_reset);
=20
     cc->class_by_name =3D m68k_cpu_class_by_name;
     cc->has_work =3D m68k_cpu_has_work;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9cfd744..71d88f6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -292,8 +292,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *da=
ta)
=20
     device_class_set_parent_realize(dc, mb_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D mb_cpu_reset;
+    cpu_class_set_parent_reset(cc, mb_cpu_reset, &mcc->parent_reset);
=20
     cc->class_by_name =3D mb_cpu_class_by_name;
     cc->has_work =3D mb_cpu_has_work;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbcf7ca..6cd6b96 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -189,8 +189,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *d=
ata)
=20
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D mips_cpu_reset;
+    cpu_class_set_parent_reset(cc, mips_cpu_reset, &mcc->parent_reset);
=20
     cc->class_by_name =3D mips_cpu_class_by_name;
     cc->has_work =3D mips_cpu_has_work;
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 48996d0..cf47bc7 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -101,8 +101,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, void =
*data)
=20
     device_class_set_parent_realize(dc, moxie_cpu_realizefn,
                                     &mcc->parent_realize);
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D moxie_cpu_reset;
+    cpu_class_set_parent_reset(cc, moxie_cpu_reset, &mcc->parent_reset);
=20
     cc->class_by_name =3D moxie_cpu_class_by_name;
=20
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index ca9c7a6..bbdbc0c 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -188,8 +188,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void =
*data)
     device_class_set_parent_realize(dc, nios2_cpu_realizefn,
                                     &ncc->parent_realize);
     dc->props =3D nios2_properties;
-    ncc->parent_reset =3D cc->reset;
-    cc->reset =3D nios2_cpu_reset;
+    cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
=20
     cc->class_by_name =3D nios2_cpu_class_by_name;
     cc->has_work =3D nios2_cpu_has_work;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 506aec6..5cd04da 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -150,8 +150,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, vo=
id *data)
=20
     device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
                                     &occ->parent_realize);
-    occ->parent_reset =3D cc->reset;
-    cc->reset =3D openrisc_cpu_reset;
+    cpu_class_set_parent_reset(cc, openrisc_cpu_reset, &occ->parent_reset)=
;
=20
     cc->class_by_name =3D openrisc_cpu_class_by_name;
     cc->has_work =3D openrisc_cpu_has_work;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c
index d33d65d..5ffd07c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10873,8 +10873,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, voi=
d *data)
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_always;
     dc->props =3D ppc_cpu_properties;
=20
-    pcc->parent_reset =3D cc->reset;
-    cc->reset =3D ppc_cpu_reset;
+    cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
=20
     cc->class_by_name =3D ppc_cpu_class_by_name;
     pcc->parent_parse_features =3D cc->parse_features;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d37861a..d6f1872 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -462,8 +462,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *=
data)
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
=20
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D riscv_cpu_reset;
+    cpu_class_set_parent_reset(cc, riscv_cpu_reset, &mcc->parent_reset);
=20
     cc->class_by_name =3D riscv_cpu_class_by_name;
     cc->has_work =3D riscv_cpu_has_work;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 625daee..ca487f5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -456,12 +456,11 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
     dc->props =3D s390x_cpu_properties;
     dc->user_creatable =3D true;
=20
-    scc->parent_reset =3D cc->reset;
+    cpu_class_set_parent_reset(cc, s390_cpu_reset_full, &scc->parent_reset=
);
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal =3D s390_cpu_load_normal;
 #endif
     scc->reset =3D s390_cpu_reset;
-    cc->reset =3D s390_cpu_reset_full;
     cc->class_by_name =3D s390_cpu_class_by_name,
     cc->has_work =3D s390_cpu_has_work;
 #ifdef CONFIG_TCG
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index d0a7707..70c8d81 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -214,8 +214,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void=
 *data)
     device_class_set_parent_realize(dc, superh_cpu_realizefn,
                                     &scc->parent_realize);
=20
-    scc->parent_reset =3D cc->reset;
-    cc->reset =3D superh_cpu_reset;
+    cpu_class_set_parent_reset(cc, superh_cpu_reset, &scc->parent_reset);
=20
     cc->class_by_name =3D superh_cpu_class_by_name;
     cc->has_work =3D superh_cpu_has_work;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bc65929..9c306e5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -859,8 +859,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void =
*data)
                                     &scc->parent_realize);
     dc->props =3D sparc_cpu_properties;
=20
-    scc->parent_reset =3D cc->reset;
-    cc->reset =3D sparc_cpu_reset;
+    cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
=20
     cc->class_by_name =3D sparc_cpu_class_by_name;
     cc->parse_features =3D sparc_cpu_parse_features;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 2b2a7cc..cd422a0 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -142,8 +142,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void=
 *data)
     device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
                                     &tcc->parent_realize);
=20
-    tcc->parent_reset =3D cc->reset;
-    cc->reset =3D tilegx_cpu_reset;
+    cpu_class_set_parent_reset(cc, tilegx_cpu_reset, &tcc->parent_reset);
=20
     cc->class_by_name =3D tilegx_cpu_class_by_name;
     cc->has_work =3D tilegx_cpu_has_work;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index df807c1..85bc9f0 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -153,8 +153,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void=
 *data)
     device_class_set_parent_realize(dc, tricore_cpu_realizefn,
                                     &mcc->parent_realize);
=20
-    mcc->parent_reset =3D cc->reset;
-    cc->reset =3D tricore_cpu_reset;
+    cpu_class_set_parent_reset(cc, tricore_cpu_reset, &mcc->parent_reset);
     cc->class_by_name =3D tricore_cpu_class_by_name;
     cc->has_work =3D tricore_cpu_has_work;
=20
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c65dcf9..4856aee 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -184,8 +184,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void=
 *data)
     device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
                                     &xcc->parent_realize);
=20
-    xcc->parent_reset =3D cc->reset;
-    cc->reset =3D xtensa_cpu_reset;
+    cpu_class_set_parent_reset(cc, xtensa_cpu_reset, &xcc->parent_reset);
=20
     cc->class_by_name =3D xtensa_cpu_class_by_name;
     cc->has_work =3D xtensa_cpu_has_work;
--=20
1.8.3.1



