Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1702C21534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7Ijnuok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1702C21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpP3-0004Jf-0Q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUpMq-0002Yi-QR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUpMn-00064X-P9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603191583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=b8dt7Ngk6ivHozgFhpCN03VTvz2toPLe9gvyAeHfzlw=;
 b=L7Ijnuok6679WJmG49arGRnsBehrJfznbBnhKJcvReI9NCaQCD2ci2iu0WhS2I8zpxnJR4
 ukqKt+nE9MHxKq8yKV2ROGcxlR/cKfy1zqCsnMt+jD/ozhyZf48Wlk3cmz1mPQc44EaxRM
 /lRj/WHLY18WV7d094TTmSMGG+qxAKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-ZCzRoFVlPGKQkOnL5t2Krg-1; Tue, 20 Oct 2020 06:59:42 -0400
X-MC-Unique: ZCzRoFVlPGKQkOnL5t2Krg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD76064082;
 Tue, 20 Oct 2020 10:59:40 +0000 (UTC)
Received: from thuth.com (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD9485D9D2;
 Tue, 20 Oct 2020 10:59:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/highbank: Silence warnings about missing fallthrough
 statements
Date: Tue, 20 Oct 2020 12:59:38 +0200
Message-Id: <20201020105938.23209-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling with -Werror=implicit-fallthrough, gcc complains about
missing fallthrough annotations in this file. Looking at the code,
the fallthrough is very likely intended here, so add some comments
to silence the compiler warnings.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/highbank.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index da0510d7ce..f71087860d 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -92,10 +92,12 @@ static void hb_reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x30, 0,
                                    MEMTXATTRS_UNSPECIFIED, NULL);
+        /* fallthrough */
     case 3:
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x20, 0,
                                    MEMTXATTRS_UNSPECIFIED, NULL);
+        /* fallthrough */
     case 2:
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x10, 0,
-- 
2.18.2


