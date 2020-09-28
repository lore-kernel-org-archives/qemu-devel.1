Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22425C47420
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA8521531
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzmx3vIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA8521531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsPb-000482-Ls
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsGU-0003Zn-G0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsGT-0004eR-1X
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:28:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVocPT0chyJCn5Dv/9OWEIkEEsuls05up+nlpt9cTEc=;
 b=gzmx3vIF3pPp8Nm65tdu6+r265ax4Dm1Zie1dv0S2sQ2NpdzxE0L7qXXwzGt6qWF4coQt3
 jD2jpWUOGwyQ1ft8Ibwi1jv+MZVioL8VeB90wjfXxj0EvY+lbKQlPXbtjMLbD1apK3bKKR
 AwmYuAJrEIVpjH8sz9llDyOIq4pP6kI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-egPlxi8DNluChxY2eu3zYA-1; Mon, 28 Sep 2020 08:28:15 -0400
X-MC-Unique: egPlxi8DNluChxY2eu3zYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A580186DD24;
 Mon, 28 Sep 2020 12:28:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BCB860C11;
 Mon, 28 Sep 2020 12:28:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
Date: Mon, 28 Sep 2020 14:27:14 +0200
Message-Id: <20200928122717.30586-7-david@redhat.com>
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

Just like BRANCH ON CONDITION - however the address is read from memory
(always 8 bytes are read), we have to wrap the address manually. The
address is read using current CPU DAT/address-space controls, just like
ordinary data.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 455efe73da..cb40aea9a3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -115,6 +115,8 @@
 /* BRANCH RELATIVE AND SAVE */
     C(0xa705, BRAS,    RI_b,  Z,   0, 0, r1, 0, basi, 0)
     C(0xc005, BRASL,   RIL_b, Z,   0, 0, r1, 0, basi, 0)
+/* BRANCH INDIRECT ON CONDITION */
+    C(0xe347, BIC,     RXY_b, MIE2,0, m2_64w, 0, 0, bc, 0)
 /* BRANCH ON CONDITION */
     C(0x0700, BCR,     RR_b,  Z,   0, r2_nz, 0, 0, bc, 0)
     C(0x4700, BC,      RX_b,  Z,   0, a2, 0, 0, bc, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f20ebd7c6a..893b1f54a8 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5935,6 +5935,14 @@ static void in2_m2_64(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_m2_64 0
 
+static void in2_m2_64w(DisasContext *s, DisasOps *o)
+{
+    in2_a2(s, o);
+    tcg_gen_qemu_ld64(o->in2, o->in2, get_mem_index(s));
+    gen_addi_and_wrap_i64(s, o->in2, o->in2, 0);
+}
+#define SPEC_in2_m2_64w 0
+
 #ifndef CONFIG_USER_ONLY
 static void in2_m2_64a(DisasContext *s, DisasOps *o)
 {
-- 
2.26.2


