Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A04C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD04D270B9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD04D270B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXixS-0005nF-Lf
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:08:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivY-0004FL-CR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivW-00027Y-Bh
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXivV-00026L-Vk; Mon, 03 Jun 2019 05:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39144307D861;
	Mon,  3 Jun 2019 09:06:45 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6661861169;
	Mon,  3 Jun 2019 09:06:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:15 +0200
Message-Id: <20190603090635.10631-3-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 03 Jun 2019 09:06:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/22] s390x/tcg: Introduce
 tcg_s390_vector_exception()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling is similar to data exceptions, however we can always store the
VXC into the lowore and the FPC:

z14 PoP, 6-20, "Vector-Exception Code"
    When a vector-processing exception causes a pro-
    gram interruption, a vector-exception code (VXC) is
    stored at location 147, and zeros are stored at loca-
    tions 144-146. The VXC is also placed in the DXC
    field of the floating-point-control (FPC) register if bit
    45 of control register 0 is one. When bit 45 of control
    register 0 is zero and bit 46 of control register 0 is
    one, the DXC field of the FPC register and the con-
    tents of storage at location 147 are unpredictable.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  1 +
 target/s390x/excp_helper.c | 15 +++++++++++++++
 target/s390x/tcg_s390x.h   |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 317a1377e6..4fc08a2c88 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -215,6 +215,7 @@ extern const struct VMStateDescription vmstate_s390_c=
pu;
 #define PGM_SPECIAL_OP                  0x0013
 #define PGM_OPERAND                     0x0015
 #define PGM_TRACE_TABLE                 0x0016
+#define PGM_VECTOR_PROCESSING           0x001b
 #define PGM_SPACE_SWITCH                0x001c
 #define PGM_HFP_SQRT                    0x001d
 #define PGM_PC_TRANS_SPEC               0x001f
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 85223d00c0..f21bcf79ae 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -62,6 +62,21 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XSta=
te *env, uint32_t dxc,
     tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
 }
=20
+void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_=
t vxc,
+                                             uintptr_t ra)
+{
+    g_assert(vxc <=3D 0xff);
+#if !defined(CONFIG_USER_ONLY)
+    /* Always store the VXC into the lowcore, without AFP it is undefine=
d */
+    stl_phys(CPU(s390_env_get_cpu(env))->as,
+             env->psa + offsetof(LowCore, data_exc_code), vxc);
+#endif
+
+    /* Always store the VXC into the FPC, without AFP it is undefined */
+    env->fpc =3D deposit32(env->fpc, 8, 8, vxc);
+    tcg_s390_program_interrupt(env, PGM_VECTOR_PROCESSING, ILEN_AUTO, ra=
);
+}
+
 void HELPER(data_exception)(CPUS390XState *env, uint32_t dxc)
 {
     tcg_s390_data_exception(env, dxc, GETPC());
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index ab2c4ba703..2813f9d48e 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -18,5 +18,7 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XS=
tate *env, uint32_t code,
                                               int ilen, uintptr_t ra);
 void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t =
dxc,
                                            uintptr_t ra);
+void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_=
t vxc,
+                                             uintptr_t ra);
=20
 #endif /* TCG_S390X_H */
--=20
2.21.0


