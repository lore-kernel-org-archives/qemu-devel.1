Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83483C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539922086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539922086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=espressif.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubtE-0007bW-9p
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ivan@espressif.com>) id 1hubsT-0006iB-Lw
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ivan@espressif.com>) id 1hubsS-0004Ex-Ig
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:14:13 -0400
Received: from cnmail.espressif.com ([140.206.114.118]:15308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ivan@espressif.com>) id 1hubsR-00045v-VA
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:14:12 -0400
Received: from [192.168.0.145] ([195.122.199.236])
 by cnmail.espressif.com ((Espressif cloud mail system)) with ASMTP (SSL) id
 201908052015300999; Mon, 05 Aug 2019 20:15:30 +0800
From: Ivan Grokhotkov <ivan@espressif.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <B6797C6C-483E-4D08-92C8-BC109B149E50@espressif.com>
Date: Mon, 5 Aug 2019 14:14:00 +0200
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 140.206.114.118
Subject: [Qemu-devel] [PATCH v2] target/riscv: don't overwrite priv_version
 and resetvec when realizing
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
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU-specific init functions (riscv_*_cpu_init) configure members of
CPURISCVState, such as priv_version and resetvec. However
riscv_cpu_realize unconditionally overwrites these members. The
result is that some CPUs (such as CPU_SIFIVE_U34) are getting created
with incorrect priv_version.

Only set priv_version in riscv_cpu_realize if priv_spec property was
set. Don't set resetvec in riscv_cpu_realize, rely on the init
function to set it. Set default priv_version and resetvec in init
functions where this was missing.

Signed-off-by: Ivan Grokhotkov <ivan@espressif.com>
---
target/riscv/cpu.c | 12 +++++++-----
target/riscv/cpu.h |  1 +
2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20a..8f3cb0c6bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -110,7 +110,7 @@ static void riscv_any_cpu_init(Object *obj)
{
     CPURISCVState *env =3D &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-    set_priv_version(env, PRIV_VERSION_1_11_0);
+    set_priv_version(env, PRIV_VERSION_DEFAULT);
     set_resetvec(env, DEFAULT_RSTVEC);
}

@@ -119,6 +119,8 @@ static void riscv_any_cpu_init(Object *obj)
static void riscv_base32_cpu_init(Object *obj)
{
     CPURISCVState *env =3D &RISCV_CPU(obj)->env;
+    set_priv_version(env, PRIV_VERSION_DEFAULT);
+    set_resetvec(env, DEFAULT_RSTVEC);
     /* We set this in the realise function */
     set_misa(env, 0);
}
@@ -157,6 +159,8 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
static void riscv_base64_cpu_init(Object *obj)
{
     CPURISCVState *env =3D &RISCV_CPU(obj)->env;
+    set_priv_version(env, PRIV_VERSION_DEFAULT);
+    set_resetvec(env, DEFAULT_RSTVEC);
     /* We set this in the realise function */
     set_misa(env, 0);
}
@@ -316,7 +320,7 @@ static void riscv_cpu_realize(DeviceState *dev, =
Error **errp)
     RISCVCPU *cpu =3D RISCV_CPU(dev);
     CPURISCVState *env =3D &cpu->env;
     RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
-    int priv_version =3D PRIV_VERSION_1_11_0;
+    int priv_version =3D PRIV_VERSION_DEFAULT;
     target_ulong target_misa =3D 0;
     Error *local_err =3D NULL;

@@ -339,11 +343,9 @@ static void riscv_cpu_realize(DeviceState *dev, =
Error **errp)
                        cpu->cfg.priv_spec);
             return;
         }
+        set_priv_version(env, priv_version);
     }

-    set_priv_version(env, priv_version);
-    set_resetvec(env, DEFAULT_RSTVEC);
-
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..88a52a1c8c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@ enum {
#define PRIV_VERSION_1_09_1 0x00010901
#define PRIV_VERSION_1_10_0 0x00011000
#define PRIV_VERSION_1_11_0 0x00011100
+#define PRIV_VERSION_DEFAULT PRIV_VERSION_1_11_0

#define TRANSLATE_PMP_FAIL 2
#define TRANSLATE_FAIL 1
--=20
2.20.1 (Apple Git-117)



Re-sending with corrected indentation.

---
Best regards,
Ivan Grokhotkov




