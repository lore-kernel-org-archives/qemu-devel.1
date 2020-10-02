Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7995920665
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaflgcL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7995920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKBy-0003wa-Kn
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvP-0004pN-BJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvN-0003Wz-Gx
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5jeL73icdSoEitdtgj4079z9kZgec574FtVJbMWvcM=;
 b=CaflgcL0mx5Hj9WF11wdXHVkFmdu7OIxP9tOmqX0j5a+9j+omsmyld/+iBgxABQ0B0PzE9
 FyNpI8E8qz/dJYwduydaLj+dJrGCzNND7W81miX3RBiVtIFn2nuVZeW6ylXYlXyQ+WvCVW
 IlX1eec4D3+v8K0sXwvQLF8ONmIpEmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-GjkcAVbvM_-cMIYqXhhyhg-1; Fri, 02 Oct 2020 08:12:30 -0400
X-MC-Unique: GjkcAVbvM_-cMIYqXhhyhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8390A873119;
 Fri,  2 Oct 2020 12:12:29 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C865D9D5;
 Fri,  2 Oct 2020 12:12:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/19] s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
Date: Fri,  2 Oct 2020 14:11:15 +0200
Message-Id: <20201002121118.180315-17-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Just like BRANCH ON CONDITION - however the address is read from memory
(always 8 bytes are read), we have to wrap the address manually. The
address is read using current CPU DAT/address-space controls, just like
ordinary data.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200928122717.30586-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 2 ++
 target/s390x/translate.c   | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index bf18d8aaf43e..3322e5f2a504 100644
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
index 66a3693d128c..27fb7af8fb1c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5956,6 +5956,14 @@ static void in2_m2_64(DisasContext *s, DisasOps *o)
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
2.25.4


