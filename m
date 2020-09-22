Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B14C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D92206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd29PWPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D92206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfgF-00030W-5R
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaP-0004An-CJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaN-0006S5-Nn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UDYOUobIS4HPyMO0LM18wbJhIIlX5pigEtZUvhEekE=;
 b=Yd29PWPW2TH4+83gR39JhRq+ixE/CZCUqngxinRqpPOb+fUl+/CFohHNgCqBCwFUFYCIOF
 YVV/bauLnXrETtPHc3qF+dUYYs2S9mKkdZh7WmNBsC2SYnO0QmZDNrhE/XX+FADua2yUwZ
 g60PQwCnOpOWU+ws8Sg3L3IBP+Z5NtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-MLWwZYn8PzC1XIHVb-3qHA-1; Tue, 22 Sep 2020 06:31:44 -0400
X-MC-Unique: MLWwZYn8PzC1XIHVb-3qHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1151868434;
 Tue, 22 Sep 2020 10:31:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6542B19C4F;
 Tue, 22 Sep 2020 10:31:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/8] s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
Date: Tue, 22 Sep 2020 12:31:26 +0200
Message-Id: <20200922103129.12824-6-david@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Just like BRANCH ON CONDITION - however the address is read from memory
(always 8 bytes are read), we have to wrap the address manually. The
address is read using current CPU DAT/address-space controls, just like
ordinary data.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 455efe73da..dfb0ec067b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -115,6 +115,8 @@
 /* BRANCH RELATIVE AND SAVE */
     C(0xa705, BRAS,    RI_b,  Z,   0, 0, r1, 0, basi, 0)
     C(0xc005, BRASL,   RIL_b, Z,   0, 0, r1, 0, basi, 0)
+/* BRANCH INDIRECT ON CONDITION */
+    C(0xe347, BIC,     RXY_b, MIE2,0, m2_64, 0, 0, bc, 0)
 /* BRANCH ON CONDITION */
     C(0x0700, BCR,     RR_b,  Z,   0, r2_nz, 0, 0, bc, 0)
     C(0x4700, BC,      RX_b,  Z,   0, a2, 0, 0, bc, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b536491892..383edf7419 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1626,6 +1626,11 @@ static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
         return DISAS_NEXT;
     }
 
+    /* For BIC the address came from memory, we need to wrap it again. */
+    if (s->fields.op2 == 0x47) {
+        gen_addi_and_wrap_i64(s, o->in2, o->in2, 0);
+    }
+
     disas_jcc(s, &c, m1);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
-- 
2.26.2


