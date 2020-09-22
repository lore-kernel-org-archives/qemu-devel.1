Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62166239A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUky9F8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62166239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfdC-0007pO-E5
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaL-00042y-LX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaJ-0006Qz-SN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U944P9G+m879NAeS9xgfrL2agGNL/VREm8Rnvr0AK6I=;
 b=NUky9F8OLFSzYEMkgXBtbi7TDss+VKJNM3qsHKAfp2fN63nUtkUb/SDBF4rBzxY3qzw9mH
 idr6NU/yOWfMKaWQviu8fwg4ZpI6HPyoepslEFqG3opYxP1tiR3OJHtlDaTkKGYsOZsGm9
 v7l4EbVZL0y0YFxH/urywahDDKlaOBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-Wm5jHawZMvywpw6_r_SPmw-1; Tue, 22 Sep 2020 06:31:39 -0400
X-MC-Unique: Wm5jHawZMvywpw6_r_SPmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A28185A0FE;
 Tue, 22 Sep 2020 10:31:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2344F27BD1;
 Tue, 22 Sep 2020 10:31:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/8] s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
Date: Tue, 22 Sep 2020 12:31:23 +0200
Message-Id: <20200922103129.12824-3-david@redhat.com>
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

Easy to wire up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8dbeaf8c49..e851e9df5e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -883,6 +883,7 @@
 /* SUBTRACT HALFWORD */
     C(0x4b00, SH,      RX_a,  Z,   r1, m2_16s, new, r1_32, sub, subs32)
     C(0xe37b, SHY,     RXY_a, LD,  r1, m2_16s, new, r1_32, sub, subs32)
+    C(0xe339, SGH,     RXY_a, MIE2,r1, m2_16s, r1, 0, sub, subs64)
 /* SUBTRACT HIGH */
     C(0xb9c9, SHHHR,   RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, sub, subs32)
     C(0xb9d9, SHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, sub, subs32)
-- 
2.26.2


