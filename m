Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A455C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035DF27E70
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035DF27E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXj0E-0000Ce-6J
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:11:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivc-0004Hr-3T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiva-0002Cp-32
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXivZ-0002Am-EJ; Mon, 03 Jun 2019 05:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D2963082E91;
	Mon,  3 Jun 2019 09:06:48 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82CFE61981;
	Mon,  3 Jun 2019 09:06:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:16 +0200
Message-Id: <20190603090635.10631-4-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 03 Jun 2019 09:06:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 03/22] s390x/tcg: Export float_comp_to_cc()
 and float(32|64|128)_dcmask()
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

Vector floating-point instructions will require these functions, so
allow to use them from other files.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 4 ++--
 target/s390x/internal.h   | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 1be68bafea..d2c17ed942 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -112,7 +112,7 @@ static void handle_exceptions(CPUS390XState *env, boo=
l XxC, uintptr_t retaddr)
     }
 }
=20
-static inline int float_comp_to_cc(CPUS390XState *env, int float_compare=
)
+int float_comp_to_cc(CPUS390XState *env, int float_compare)
 {
     S390CPU *cpu =3D s390_env_get_cpu(env);
=20
@@ -746,7 +746,7 @@ static inline uint16_t dcmask(int bit, bool neg)
 }
=20
 #define DEF_FLOAT_DCMASK(_TYPE) \
-static uint16_t _TYPE##_dcmask(CPUS390XState *env, _TYPE f1)       \
+uint16_t _TYPE##_dcmask(CPUS390XState *env, _TYPE f1)              \
 {                                                                  \
     const bool neg =3D _TYPE##_is_neg(f1);                           \
                                                                    \
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 9893fc094b..c243fa725b 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -285,6 +285,10 @@ uint32_t set_cc_nz_f128(float128 v);
 uint8_t s390_softfloat_exc_to_ieee(unsigned int exc);
 int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3);
 void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode);
+int float_comp_to_cc(CPUS390XState *env, int float_compare);
+uint16_t float32_dcmask(CPUS390XState *env, float32 f1);
+uint16_t float64_dcmask(CPUS390XState *env, float64 f1);
+uint16_t float128_dcmask(CPUS390XState *env, float128 f1);
=20
=20
 /* gdbstub.c */
--=20
2.21.0


