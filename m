Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FCC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E892087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E892087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaNu-0004p2-A1
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:46:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa6Y-0006uA-7Q
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa1T-0004xi-Ma
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:23:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hRa1T-0004xS-HA; Fri, 17 May 2019 06:23:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C912D3004419;
	Fri, 17 May 2019 10:23:30 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9AC34913;
	Fri, 17 May 2019 10:23:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 12:21:22 +0200
Message-Id: <20190517102145.21812-18-david@redhat.com>
In-Reply-To: <20190517102145.21812-1-david@redhat.com>
References: <20190517102145.21812-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 17 May 2019 10:23:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 17/40] s390x/tcg: Implement
 VECTOR (MAXIMUM|MINIMUM) (LOGICAL)
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Luckily, we already have gvec helpers for all four cases.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  8 ++++++++
 target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fc8886ff42..b22d9f0f6a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1098,6 +1098,14 @@
     F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
 /* VECTOR LOAD POSITIVE */
     F(0xe7df, VLP,     VRR_a, V,   0, 0, 0, 0, vlp, 0, IF_VEC)
+/* VECTOR MAXIMUM */
+    F(0xe7ff, VMX,     VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MAXIMUM LOGICAL */
+    F(0xe7fd, VMXL,    VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MINIMUM */
+    F(0xe7fe, VMN,     VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MINIMUM LOGICAL */
+    F(0xe7fc, VMNL,    VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 566a7df6df..bb27cad4d8 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1550,3 +1550,34 @@ static DisasJumpType op_vlp(DisasContext *s, Disas=
Ops *o)
     gen_gvec_fn_2(abs, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vmx(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v2 =3D get_field(s->fields, v2);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+    const uint8_t es =3D get_field(s->fields, m4);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xff:
+        gen_gvec_fn_3(smax, es, v1, v2, v3);
+        break;
+    case 0xfd:
+        gen_gvec_fn_3(umax, es, v1, v2, v3);
+        break;
+    case 0xfe:
+        gen_gvec_fn_3(smin, es, v1, v2, v3);
+        break;
+    case 0xfc:
+        gen_gvec_fn_3(umin, es, v1, v2, v3);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return DISAS_NEXT;
+}
--=20
2.20.1


