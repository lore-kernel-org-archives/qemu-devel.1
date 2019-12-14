Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06FAC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708B720700
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBCztNKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708B720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig46o-0004a5-23
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig409-00052x-8n
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig407-00063T-Ke
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51684
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig407-00060V-DN
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDg+807iArEhZjenX1sVcxomXSGnTRm3h/+PwfZNwvs=;
 b=jBCztNKZZsNUkgCXjVpAhdJ9hbV3kJXwaJF/9TPXLMnaxcDv5KWoYm9UBxrC6i3PmP9mIZ
 Q8/VyTO2FSO6ZkEqvS1WvDvefvGqdToaBDn0Y+gOWBkMT75SA/vjkvJ7B5VmYa7i26gtWZ
 LYViCLOKMH11IkTrVmSqUBW/7o/Da/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-nhxaX_vzOkS_uQ2esEwvdA-1; Sat, 14 Dec 2019 04:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64AF107ACC4;
 Sat, 14 Dec 2019 09:46:03 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 668221000325;
 Sat, 14 Dec 2019 09:46:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 09/16] s390x: Fix cpu normal reset ri clearing
Date: Sat, 14 Dec 2019 10:45:19 +0100
Message-Id: <20191214094526.8698-10-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nhxaX_vzOkS_uQ2esEwvdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

As it turns out we need to clear the ri controls and PSW enablement
bit to be architecture compliant.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20191203132813.2734-4-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 7 ++++++-
 target/s390x/cpu.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index bd39cb54b7aa..99ea09085a30 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -100,7 +100,7 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type =
type)
     case S390_CPU_RESET_INITIAL:
         /* initial reset does not clear everything! */
         memset(&env->start_initial_reset_fields, 0,
-               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_normal_reset_fields) -
                offsetof(CPUS390XState, start_initial_reset_fields));
=20
         /* architectured initial value for Breaking-Event-Address register=
 */
@@ -123,6 +123,11 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type=
 type)
                                   &env->fpu_status);
        /* fall through */
     case S390_CPU_RESET_NORMAL:
+        env->psw.mask &=3D ~PSW_MASK_RI;
+        memset(&env->start_normal_reset_fields, 0,
+               offsetof(CPUS390XState, end_reset_fields) -
+               offsetof(CPUS390XState, start_normal_reset_fields));
+
         env->pfault_token =3D -1UL;
         env->bpbc =3D false;
         break;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d2af13b345cc..7e1c18d59696 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -58,7 +58,6 @@ struct CPUS390XState {
      */
     uint64_t vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
     uint32_t aregs[16];    /* access registers */
-    uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
     uint64_t etoken;       /* etoken */
     uint64_t etoken_extension; /* etoken extension */
@@ -114,6 +113,10 @@ struct CPUS390XState {
     uint64_t gbea;
     uint64_t pp;
=20
+    /* Fields up to this point are not cleared by normal CPU reset */
+    struct {} start_normal_reset_fields;
+    uint8_t riccb[64];     /* runtime instrumentation control */
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
=20
@@ -252,6 +255,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #undef PSW_SHIFT_ASC
 #undef PSW_MASK_CC
 #undef PSW_MASK_PM
+#undef PSW_MASK_RI
 #undef PSW_SHIFT_MASK_PM
 #undef PSW_MASK_64
 #undef PSW_MASK_32
@@ -273,6 +277,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_CC             0x0000300000000000ULL
 #define PSW_MASK_PM             0x00000F0000000000ULL
 #define PSW_SHIFT_MASK_PM       40
+#define PSW_MASK_RI             0x0000008000000000ULL
 #define PSW_MASK_64             0x0000000100000000ULL
 #define PSW_MASK_32             0x0000000080000000ULL
 #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
--=20
2.21.0


