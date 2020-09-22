Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1EB206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQsi3VgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1EB206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfiF-0006Ht-T2
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaV-0004N7-7V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaS-0006T1-Iu
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woNXgy+g6diIx3edLt4lKkiGEuXFcC6Qn4PHaQTNE9g=;
 b=IQsi3VgDef5U0gX/1YOtDi9qtD/XlCxXi1hTZ0xbPsysEX0j7y0r1KZEfu9QI3AQekgUNL
 XWGev6WUtT6wm4Uq1531ae/JpyAgncPBVvUtqcZa/91oocTu0OW1wde8k2KeNBrJYdpGiP
 lyFcrmA/X0ddQKi12TM9HMyVdMdy9vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-hkJENZLJOM6Ut41kAIQmAg-1; Tue, 22 Sep 2020 06:31:49 -0400
X-MC-Unique: hkJENZLJOM6Ut41kAIQmAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A751005E61;
 Tue, 22 Sep 2020 10:31:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B6019C4F;
 Tue, 22 Sep 2020 10:31:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 8/8] s390x/tcg: Implement CIPHER MESSAGE WITH
 AUTHENTICATION (KMA)
Date: Tue, 22 Sep 2020 12:31:29 +0200
Message-Id: <20200922103129.12824-9-david@redhat.com>
In-Reply-To: <20200922103129.12824-1-david@redhat.com>
References: <20200922103129.12824-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As with the other crypto functions, we only implement subcode 0 (query)
and no actual encryption/decryption. We now implement S390_FEAT_MSA_EXT_8.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/gen-features.c | 1 +
 target/s390x/insn-data.def  | 1 +
 target/s390x/translate.c    | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 1736b85ab0..8de18f7f41 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -717,6 +717,7 @@ static uint16_t qemu_MAX[] = {
     /* features introduced after the z13 */
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_MSA_EXT_8,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index bcd424e9ae..1ffdc20d59 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -979,6 +979,7 @@
     D(0xb92d, KMCTR,   RRF_b, MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMCTR)
     D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
     D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
+    D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
     D(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO)
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index c90cb37aae..df549e59e9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2715,6 +2715,12 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     TCGv_i32 t_r1, t_r2, t_r3, type;
 
     switch (s->insn->data) {
+    case S390_FEAT_TYPE_KMA:
+        if (r3 == r1 || r3 == r2) {
+            gen_program_exception(s, PGM_SPECIFICATION);
+            return DISAS_NORETURN;
+        }
+        /* FALL THROUGH */
     case S390_FEAT_TYPE_KMCTR:
         if (r3 & 1 || !r3) {
             gen_program_exception(s, PGM_SPECIFICATION);
@@ -6130,6 +6136,7 @@ enum DisasInsnEnum {
 #define FAC_MSA3        S390_FEAT_MSA_EXT_3 /* msa-extension-3 facility */
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
+#define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.26.2


