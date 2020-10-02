Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4BA20719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWwYlHh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4BA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOK6K-0006Mp-6J
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJvD-0004LL-Dv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kOJv9-0003U6-T3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601640739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHBD8OAxwN2Hc4y4W0/2DnSeC8GEqaSX4FvJUa6OKqg=;
 b=GWwYlHh9M8yVq1dmTKSiSzcwCvBCOxLdkUX09Fjk75IuR+4I80WExPSS5+IVChsslzwcEA
 dv7+WkjdxJQFJUvgcLERMwrOekaSXBtts6jGcXzuZe1z+mbkQ2mVYa4ozHkkRC0m60g5dE
 6K1P5+aQ047hcUercLAaaO4+Zwwnp2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-py4E2dTyOFKei0MD3kD-Yw-1; Fri, 02 Oct 2020 08:12:17 -0400
X-MC-Unique: py4E2dTyOFKei0MD3kD-Yw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF6D480EDAE;
 Fri,  2 Oct 2020 12:12:14 +0000 (UTC)
Received: from localhost (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7609019C66;
 Fri,  2 Oct 2020 12:12:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/19] s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
Date: Fri,  2 Oct 2020 14:11:12 +0200
Message-Id: <20201002121118.180315-14-cohuck@redhat.com>
In-Reply-To: <20201002121118.180315-1-cohuck@redhat.com>
References: <20201002121118.180315-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Easy to wire up.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200928122717.30586-4-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dbcdb4c387fa..e994d32d96bd 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -886,6 +886,7 @@
 /* SUBTRACT HALFWORD */
     C(0x4b00, SH,      RX_a,  Z,   r1, m2_16s, new, r1_32, sub, subs32)
     C(0xe37b, SHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, sub, subs32)
+    C(0xe339, SGH,     RXY_a, MIE2,r1, m2_16s, r1, 0, sub, subs64)
 /* SUBTRACT HIGH */
     C(0xb9c9, SHHHR,   RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, sub, subs32)
     C(0xb9d9, SHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, sub, subs32)
-- 
2.25.4


