Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE75C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BA6206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOWktmOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BA6206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfeE-0000bO-2t
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaQ-0004CJ-IY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaL-0006RZ-Pn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uD4ZZs3AdQVvdNh/+WO04nhUwpbLsvu+jH+EwquHgOI=;
 b=SOWktmOb4vFxo8lDZO6wlGTpPoYH+QLxwbVicZGHBF+82bWd39vYt5OBm1cxct7+x1aDmA
 kbLCv5zD2asdtsD/B6/+Rgl4G77enoNM/0+Sh/alHkq5PhdntABY706ollsf8FNRhztYiR
 9ycQ2t+hnTltBbimCbrVFQEBys9D49Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Ld3tGWz2Ol-yFFQ3OuCYWg-1; Tue, 22 Sep 2020 06:31:43 -0400
X-MC-Unique: Ld3tGWz2Ol-yFFQ3OuCYWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17F731868425;
 Tue, 22 Sep 2020 10:31:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF1719C4F;
 Tue, 22 Sep 2020 10:31:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/8] s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
Date: Tue, 22 Sep 2020 12:31:25 +0200
Message-Id: <20200922103129.12824-5-david@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

Just like MULTIPLY HALFWORD IMMEDIATE (MGHI), only the second operand
(signed 16 bit) comes from memory.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2b4ad1530d..455efe73da 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -666,6 +666,7 @@
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
     C(0xe37c, MHY,     RXY_a, GIE, r1_o, m2_16s, new, r1_32, mul, 0)
+    C(0xe33c, MGH,     RXY_a, MIE2,r1_o, m2_16s, r1, 0, mul, 0)
 /* MULTIPLY HALFWORD IMMEDIATE */
     C(0xa70c, MHI,     RI_a,  Z,   r1_o, i2, new, r1_32, mul, 0)
     C(0xa70d, MGHI,    RI_a,  Z,   r1_o, i2, r1, 0, mul, 0)
-- 
2.26.2


