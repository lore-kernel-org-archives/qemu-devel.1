Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D0AC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6F12596E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6F12596E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60189 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXj5z-0005DL-Vt
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:17:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiwC-0004qi-76
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiw6-00032o-CU
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXiw6-00031L-4z; Mon, 03 Jun 2019 05:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D9AD2F8BDE;
	Mon,  3 Jun 2019 09:07:21 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7166261981;
	Mon,  3 Jun 2019 09:07:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:27 +0200
Message-Id: <20190603090635.10631-15-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 03 Jun 2019 09:07:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 14/22] s390x/tcg: Implement VECTOR LOAD
 ROUNDED
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
	Richard Henderson <richard.henderson@linaro.org>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can reuse some of the infrastructure introduced for
VECTOR FP CONVERT FROM FIXED 64-BIT and friends.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 43 +++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index cb25141ffe..7526f8e8c6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -280,6 +280,8 @@ DEF_HELPER_FLAGS_4(gvec_vfi64, TCG_CALL_NO_WG, void, =
ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfi64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vfll32, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vfll32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vflr64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5afdb36aec..f03914d528 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1232,6 +1232,8 @@
     F(0xe7c7, VFI,     VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR LOAD LENGTHENED */
     F(0xe7c4, VFLL,    VRR_a, V,   0, 0, 0, 0, vfll, 0, IF_VEC)
+/* VECTOR LOAD ROUNDED */
+    F(0xe7c5, VFLR,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index a25985e5c9..73e1b1062a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2672,6 +2672,9 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     case 0xc7:
         fn =3D se ? gen_helper_gvec_vfi64s : gen_helper_gvec_vfi64;
         break;
+    case 0xc5:
+        fn =3D se ? gen_helper_gvec_vflr64s : gen_helper_gvec_vflr64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index f5b7fdf871..764f7379da 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -444,3 +444,46 @@ void HELPER(gvec_vfll32s)(void *v1, const void *v2, =
CPUS390XState *env,
 {
     vfll32(v1, v2, env, true, GETPC());
 }
+
+static void vflr64(S390Vector *v1, const S390Vector *v2, CPUS390XState *=
env,
+                   bool s, bool XxC, uint8_t erm, uintptr_t retaddr)
+{
+    uint8_t vxc, vec_exc =3D 0;
+    S390Vector tmp =3D {};
+    int i, old_mode;
+
+    old_mode =3D s390_swap_bfp_rounding_mode(env, erm);
+    for (i =3D 0; i < 2; i++) {
+        float64 a =3D s390_vec_read_element64(v2, i);
+        uint32_t ret =3D float64_to_float32(a, &env->fpu_status);
+
+        /* place at even element */
+        s390_vec_write_element32(&tmp, i * 2, ret);
+        /* indicate the source element */
+        vxc =3D check_ieee_exc(env, i, XxC, &vec_exc);
+        if (s || vxc) {
+            break;
+        }
+    }
+    s390_restore_bfp_rounding_mode(env, old_mode);
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+    *v1 =3D tmp;
+}
+
+void HELPER(gvec_vflr64)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vflr64(v1, v2, env, false, XxC, erm, GETPC());
+}
+
+void HELPER(gvec_vflr64s)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vflr64(v1, v2, env, true, XxC, erm, GETPC());
+}
--=20
2.21.0


