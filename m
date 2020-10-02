Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E879EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938B2206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka1yE2kU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938B2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKFu-0007cs-Pg
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvl-00050Z-Tj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvj-0003YH-0v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p15fEnU2x5Cdrh43KCW+kcJvwkIB+VO7T2snwCcFnoo=;
 b=Ka1yE2kUrIgZX0xpMZRpBu2S5twJvr3uHD/gOCekIw4CNq7ZIdbK2LD9e88RXnJxqIdzir
 p4+DigxInMDrIvA2EBC5JznM0QgLWnLKgiU5M5xpGNzQCkYF575FGiWSzif6JN49wGzzFU
 d+Nh1ZJlLooJ72pqPe0k21efhep1vQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-ok6c72I1P2aNL-eOavot9g-1; Fri, 02 Oct 2020 08:12:46 -0400
X-MC-Unique: ok6c72I1P2aNL-eOavot9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A7151084C8F;
 Fri,  2 Oct 2020 12:12:45 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9FE15C1D7;
 Fri,  2 Oct 2020 12:12:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/19] s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION
 (KMA)
Date: Fri,  2 Oct 2020 14:11:18 +0200
Message-Id: <20201002121118.180315-20-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

As with the other crypto functions, we only implement subcode 0 (query)
and no actual encryption/decryption. We now implement S390_FEAT_MSA_EXT_8.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200928122717.30586-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/gen-features.c | 1 +
 target/s390x/insn-data.def  | 1 +
 target/s390x/translate.c    | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 02ec0a673517..a6ec918e901e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -719,6 +719,7 @@ static uint16_t qemu_MAX[] = {
     /* features introduced after the z13 */
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_MISC_INSTRUCTION_EXT2,
+    S390_FEAT_MSA_EXT_8,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fc83a6ec32a4..d3bcdfd67b3c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -982,6 +982,7 @@
     D(0xb92d, KMCTR,   RRF_b, MSA4, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMCTR)
     D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
     D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
+    D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
     D(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO)
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index bcc65893e4ff..ac10f42f1045 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2710,6 +2710,12 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
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
@@ -6154,6 +6160,7 @@ enum DisasInsnEnum {
 #define FAC_MSA3        S390_FEAT_MSA_EXT_3 /* msa-extension-3 facility */
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
+#define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.25.4


