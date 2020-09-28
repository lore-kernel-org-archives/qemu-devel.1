Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610CEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AEF207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSqzKIFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AEF207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsHn-0004Vn-Ms
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFp-0002oy-Av
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFh-0004ZE-0e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/gU+gWuVNX3xC7lNdnW/dVZVhD7aBiSN/1PsgG/0kE=;
 b=jSqzKIFsUr7fgDl+G1H1jqO28qEtLlqy1KZ2I9nVeGbmX2UAq4FnpXs0M8LEc0janFC3l/
 eHE26RTvAfBg7EamjJPPIs3XijLOqMzjny7+f4GiKNh6+xHgD+/wNMfxNKxI4wEx/JdZxO
 4NcQLZOoOUfdxLlFkvi/muayjl/lZF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-_WZzcoLmOeCXjdVmokHrzw-1; Mon, 28 Sep 2020 08:27:29 -0400
X-MC-Unique: _WZzcoLmOeCXjdVmokHrzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27209802B77;
 Mon, 28 Sep 2020 12:27:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C7DE60C11;
 Mon, 28 Sep 2020 12:27:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] s390x/cpu_model: S390_FEAT_MISC_INSTRUCTION_EXT ->
 S390_FEAT_MISC_INSTRUCTION_EXT2
Date: Mon, 28 Sep 2020 14:27:09 +0200
Message-Id: <20200928122717.30586-2-david@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's avoid confusion with the "Miscellaneous-Instruction-Extensions
Facility 1"

Suggested-by: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 2 +-
 target/s390x/gen-features.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 5942f81f16..6cc776e121 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -72,7 +72,7 @@ DEF_FEAT(INTERLOCKED_ACCESS_2, "iacc2", STFL, 52, "Interlocked-access facility 2
 DEF_FEAT(STFLE_53, "stfle53", STFL, 53, "Various facilities introduced with z13")
 DEF_FEAT(ENTROPY_ENC_COMP, "eec", STFL, 54, "Entropy encoding compression facility")
 DEF_FEAT(MSA_EXT_5, "msa5-base", STFL, 57, "Message-security-assist-extension-5 facility (excluding subfunctions)")
-DEF_FEAT(MISC_INSTRUCTION_EXT, "minste2", STFL, 58, "Miscellaneous-instruction-extensions facility 2")
+DEF_FEAT(MISC_INSTRUCTION_EXT2, "minste2", STFL, 58, "Miscellaneous-instruction-extensions facility 2")
 DEF_FEAT(SEMAPHORE_ASSIST, "sema", STFL, 59, "Semaphore-assist facility")
 DEF_FEAT(TIME_SLICE_INSTRUMENTATION, "tsi", STFL, 60, "Time-slice Instrumentation facility")
 DEF_FEAT(MISC_INSTRUCTION_EXT3, "minste3", STFL, 61, "Miscellaneous-Instruction-Extensions Facility 3")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8ddeebc544..210cee65f3 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -412,7 +412,7 @@ static uint16_t base_GEN13_GA1[] = {
 
 static uint16_t base_GEN14_GA1[] = {
     S390_FEAT_ENTROPY_ENC_COMP,
-    S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_MISC_INSTRUCTION_EXT2,
     S390_FEAT_SEMAPHORE_ASSIST,
     S390_FEAT_TIME_SLICE_INSTRUMENTATION,
     S390_FEAT_ORDER_PRESERVING_COMPRESSION,
-- 
2.26.2


