Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DE32075A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7WwTWYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DE32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFguL-0007n5-L7
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtb-0006dE-VJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtZ-00048T-Ft
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599584100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Crh3iw0bD87S4zWLCtdBOPh17sv2ir+oVFB/4hdOyc=;
 b=I7WwTWYVES1MuSBCJriU6Cg2eLjU0iPmkUKq9WO2wA7imtpOJnqyEVOb4n8Qb3ooI2xWm9
 GRaDPOcL8aN8t0Kzt0KuHcGmgArakbmipxmJFq4sgsJY8mKomHUf00D92aC8P/e00uhwC0
 M0ndolKHNCqHI7UMEvgSeVlFvNwnRrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-TCV6RZn4NHC0LMCVc8EKsw-1; Tue, 08 Sep 2020 12:54:58 -0400
X-MC-Unique: TCV6RZn4NHC0LMCVc8EKsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 827B98D5640;
 Tue,  8 Sep 2020 16:54:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98BA660C0F;
 Tue,  8 Sep 2020 16:54:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/smbios: report error if table size is too large
Date: Tue,  8 Sep 2020 17:54:35 +0100
Message-Id: <20200908165438.1008942-3-berrange@redhat.com>
In-Reply-To: <20200908165438.1008942-1-berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SMBIOS 2.1 entry point uses a uint16 data type for reporting the
total length of the tables. If the user passes -smbios configuration to
QEMU that causes the table size to exceed this limit then various bad
behaviours result, including

 - firmware hangs in an infinite loop
 - firmware triggers a KVM crash on bad memory access
 - firmware silently discards user's SMBIOS data replacing it with
   a generic data set.

Limiting the size to 0xffff in QEMU avoids triggering most of these
problems. There is a remaining bug in SeaBIOS which tries to prepend its
own data for table 0, and does not check whether there is sufficient
space before attempting this.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/smbios/smbios.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8450fad285..3c87be6c91 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -365,6 +365,13 @@ static void smbios_register_config(void)
 
 opts_init(smbios_register_config);
 
+/*
+ * The SMBIOS 2.1 "structure table length" field in the
+ * entry point uses a 16-bit integer, so we're limited
+ * in total table size
+ */
+#define SMBIOS_21_MAX_TABLES_LEN 0xffff
+
 static void smbios_validate_table(MachineState *ms)
 {
     uint32_t expect_t4_count = smbios_legacy ?
@@ -375,6 +382,13 @@ static void smbios_validate_table(MachineState *ms)
                      expect_t4_count, smbios_type4_count);
         exit(1);
     }
+
+    if (smbios_ep_type == SMBIOS_ENTRY_POINT_21 &&
+        smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
+        error_report("SMBIOS 2.1 table length %zu exceeds %d",
+                     smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
+        exit(1);
+    }
 }
 
 
-- 
2.26.2


