Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E3C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CB92082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8Pv9jLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIZT-0005yt-4V
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1izIVO-0008S3-4M
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1izIVM-00061U-Pd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1izIVM-0005yc-L6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e3sZqixUTB6l4ZXXTVziX6Kdsz82alFvsnQ/+T1eNL0=;
 b=A8Pv9jLRbAmjdLS9aUKwEs/3Ssfew+kHtu+NccAGhMKBNCGDVQ2YMswXkXr2lG8J51QJN9
 w2ZvRrP97N4f4Y72jxAVjngTy/TMzEfwnEAx13mJmke+xz79zuS2sh0zPO4K7G7EAgrEBC
 w7VOimqbRHWqA0mvierpZ24bisSvW/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-0LMMxv78OiOYiA_Axh2k4g-1; Wed, 05 Feb 2020 06:05:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 920DB1835A03;
 Wed,  5 Feb 2020 11:05:57 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-31.bne.redhat.com
 [10.64.54.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4743790C0;
 Wed,  5 Feb 2020 11:05:54 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError interrupt
Date: Wed,  5 Feb 2020 22:05:40 +1100
Message-Id: <20200205110541.37811-2-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0LMMxv78OiOYiA_Axh2k4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 aik@ozlabs.ru, maz@kernel.org, eric.auger@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to inject SError interrupt, which will be used on receiving
QMP/HMP "nmi" command in next patch.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/cpu.c    | 11 +++++++++++
 target/arm/cpu.h    | 12 +++++++++---
 target/arm/helper.c |  4 ++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f86e71a260..24fd77437b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -461,6 +461,17 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
         }
     }
=20
+    if (interrupt_request & CPU_INTERRUPT_SERROR) {
+        excp_idx =3D EXCP_SERROR;
+        target_el =3D arm_phys_excp_target_el(cs, excp_idx, cur_el, secure=
);
+        if (arm_excp_unmasked(cs, excp_idx, target_el)) {
+            cs->exception_index =3D excp_idx;
+            env->exception.target_el =3D target_el;
+            cc->do_interrupt(cs);
+            ret =3D true;
+        }
+    }
+
     return ret;
 }
=20
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 608fcbd0b7..0bbc46ff6d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -49,6 +49,7 @@
 #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
 #define EXCP_LSERR          21   /* v8M LSERR SecureFault */
 #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
+#define EXCP_SERROR         23   /* SError Interrupt */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
=20
 #define ARMV7M_EXCP_RESET   1
@@ -79,9 +80,10 @@ enum {
 };
=20
 /* ARM-specific interrupt pending bits.  */
-#define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
-#define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
-#define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_FIQ    CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_VIRQ   CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_VFIQ   CPU_INTERRUPT_TGT_EXT_3
+#define CPU_INTERRUPT_SERROR CPU_INTERRUPT_TGT_EXT_4
=20
 /* The usual mapping for an AArch64 system register to its AArch32
  * counterpart is for the 32 bit world to have access to the lower
@@ -2731,6 +2733,10 @@ static inline bool arm_excp_unmasked(CPUState *cs, u=
nsigned int excp_idx,
         pstate_unmasked =3D !(env->daif & PSTATE_I);
         break;
=20
+    case EXCP_SERROR:
+       pstate_unmasked =3D !(env->daif & PSTATE_A);
+       break;
+
     case EXCP_VFIQ:
         if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
             /* VFIQs are only taken when hypervized and non-secure.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da..622a1d8796 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7980,6 +7980,7 @@ void arm_log_exception(int idx)
             [EXCP_LAZYFP] =3D "v7M exception during lazy FP stacking",
             [EXCP_LSERR] =3D "v8M LSERR UsageFault",
             [EXCP_UNALIGNED] =3D "v7M UNALIGNED UsageFault",
+            [EXCP_SERROR] =3D "SError Interrupt",
         };
=20
         if (idx >=3D 0 && idx < ARRAY_SIZE(excnames)) {
@@ -8566,6 +8567,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs=
)
     case EXCP_VFIQ:
         addr +=3D 0x100;
         break;
+    case EXCP_SERROR:
+        addr +=3D 0x180;
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
--=20
2.23.0


