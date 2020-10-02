Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E96C47425
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A4221D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idzGolBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A4221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK7C-0007Io-8d
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvI-0004Xg-Bl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvG-0003VG-QG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EnuCjQbCLv9CGuzTKtouRRl6nvSX6AetpA8WsY25AI=;
 b=idzGolBPCPZQIzfMjSxYBB8+ap8XI/V+6sT6Tui8Nuk4iHHsCCdhRPX/vTOPhuIqD/srM3
 rl9V53et8ImRYF/6reH8REaItjDRByZuQYeUMyZ40lHviIas/FvtzpzGMlS7zRkhLjh9N7
 m1cwGJptYzseA1Q32BAJMkpGNc6BeHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-wAi_pKl2OKeclVl_r-7amQ-1; Fri, 02 Oct 2020 08:12:22 -0400
X-MC-Unique: wAi_pKl2OKeclVl_r-7amQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81E61084C93;
 Fri,  2 Oct 2020 12:12:19 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A1979981;
 Fri,  2 Oct 2020 12:12:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/19] s390x/tcg: Implement MULTIPLY (MG, MGRK)
Date: Fri,  2 Oct 2020 14:11:13 +0200
Message-Id: <20201002121118.180315-15-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Multiply two signed 64bit values and store the 128bit result in r1 (0-63)
and r1 + 1 (64-127).

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200928122717.30586-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def |  2 ++
 target/s390x/translate.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e994d32d96bd..13c4ffdaf5b3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -653,8 +653,10 @@
 
 /* MULTIPLY */
     C(0x1c00, MR,      RR_a,  Z,   r1p1_32s, r2_32s, new, r1_D32, mul, 0)
+    C(0xb9ec, MGRK,    RRF_a, MIE2,r3_o, r2_o, r1_P, 0, muls128, 0)
     C(0x5c00, M,       RX_a,  Z,   r1p1_32s, m2_32s, new, r1_D32, mul, 0)
     C(0xe35c, MFY,     RXY_a, GIE, r1p1_32s, m2_32s, new, r1_D32, mul, 0)
+    C(0xe384, MG,      RXY_a, MIE2,r1p1_o, m2_64, r1_P, 0, muls128, 0)
     F(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0, IF_BFP)
     F(0xb31c, MDBR,    RRE,   Z,   f1, f2, new, f1, mdb, 0, IF_BFP)
     F(0xb34c, MXBR,    RRE,   Z,   x2h, x2l, x1, x1, mxb, 0, IF_BFP)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7ea666b9a7fb..66a3693d128c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3539,6 +3539,12 @@ static DisasJumpType op_mul128(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_muls128(DisasContext *s, DisasOps *o)
+{
+    tcg_gen_muls2_i64(o->out2, o->out, o->in1, o->in2);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_meeb(DisasContext *s, DisasOps *o)
 {
     gen_helper_meeb(o->out, cpu_env, o->in1, o->in2);
@@ -5563,6 +5569,13 @@ static void in1_r1p1(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in1_r1p1 SPEC_r1_even
 
+static void in1_r1p1_o(DisasContext *s, DisasOps *o)
+{
+    o->in1 = regs[get_field(s, r1) + 1];
+    o->g_in1 = true;
+}
+#define SPEC_in1_r1p1_o SPEC_r1_even
+
 static void in1_r1p1_32s(DisasContext *s, DisasOps *o)
 {
     o->in1 = tcg_temp_new_i64();
-- 
2.25.4


