Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB03C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741012080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrBpwJFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741012080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsHs-0004jd-9g
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFr-0002to-Q4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFp-0004b1-3o
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQEk9XmgZVar258X+nzLlG/DpgykIhb38UjHzbs9aXs=;
 b=VrBpwJFuDLgZUt/cShhB0tfEJ0fMXt3Hz/6me+wzgH9v8uR0K3h8BRENPRw/gvAlXQMFJy
 AIGuOmLlDw+neGcDFeyLEMKDsvelDj6RtQd//WA1yYaldTflOO5/zeqa8R/wJK2ykr1XhI
 KiY0o61PokfR6IFcDbIAE+n4eio48Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-aO-DskZSMB2nc8qXZsX8Vw-1; Mon, 28 Sep 2020 08:27:34 -0400
X-MC-Unique: aO-DskZSMB2nc8qXZsX8Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4358B1084D65;
 Mon, 28 Sep 2020 12:27:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27EFE60C11;
 Mon, 28 Sep 2020 12:27:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] s390x/tcg: Implement ADD HALFWORD (AGH)
Date: Mon, 28 Sep 2020 14:27:10 +0200
Message-Id: <20200928122717.30586-3-david@redhat.com>
In-Reply-To: <20200928122717.30586-1-david@redhat.com>
References: <20200928122717.30586-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Easy, just like ADD HALFWORD IMMEDIATE (AGHI).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 target/s390x/translate.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d79ae9e3f1..8dbeaf8c49 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -52,6 +52,7 @@
 /* ADD HALFWORD */
     C(0x4a00, AH,      RX_a,  Z,   r1, m2_16s, new, r1_32, add, adds32)
     C(0xe37a, AHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, add, adds32)
+    C(0xe338, AGH,     RXY_a, MIE2,r1, m2_16s, r1, 0, add, adds64)
 /* ADD HALFWORD IMMEDIATE */
     C(0xa70a, AHI,     RI_a,  Z,   r1, i2, new, r1_32, add, adds32)
     C(0xa70b, AGHI,    RI_a,  Z,   r1, i2, r1, 0, add, adds64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a777343821..3b433caf46 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6098,6 +6098,7 @@ enum DisasInsnEnum {
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
 #define FAC_V           S390_FEAT_VECTOR /* vector facility */
 #define FAC_VE          S390_FEAT_VECTOR_ENH /* vector enhancements facility 1 */
+#define FAC_MIE2        S390_FEAT_MISC_INSTRUCTION_EXT2 /* miscellaneous-instruction-extensions facility 2 */
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.26.2


