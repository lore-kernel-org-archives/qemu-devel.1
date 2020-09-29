Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443ADC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D297F2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdCX3e7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNADX-0000lg-Ve
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9y3-0004G7-Nv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xx-0001lb-72
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkUx6b1cSk9kEji0PxARO6FKoBMVB3jc1oddzWmGMC8=;
 b=GdCX3e7NaBilBiJ34LRLD8ECyO2cntX2XM88bnaUsKuf5uyFo0I/m22Z8VI0Fv/6s6afjP
 UhCgjmqoCCO9KWYmjra4pgWQBdT23EqKFUZ7D0gV7WXIgByOAbwtapG2bGXshi+rJrFk6y
 KsN+1atTyBp3EXgxfGwjzoj0OrM76/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-pnAh2eOhMFSNuhNiEvyhfQ-1; Tue, 29 Sep 2020 03:22:22 -0400
X-MC-Unique: pnAh2eOhMFSNuhNiEvyhfQ-1
Received: by mail-wm1-f71.google.com with SMTP id r83so1031184wma.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gkUx6b1cSk9kEji0PxARO6FKoBMVB3jc1oddzWmGMC8=;
 b=GTIDc8YeMBvZZR/0D9BJMt+BYEFKFIaL/5RogZeQ3mfHjWst5a4+im7xK5UIapFi87
 Oz6SF7na0iU6fvktYPi5/NbmWrU6PhkqmkrKcaNjESvUXKYqO/Xrjnp3Qpg+NGk+yaqe
 dzkoiwvU7eOTOTkI1+jrf+2Mt5NpsW+PyqIE7HrO/PGheWD9heBEv0ezMhw74QFSK8LR
 erYuMU/NqNRp6XwQ5fdJC5XhfmElR1GPc58ls6phq9ndzpb7vaPbsX7wuDkgSh56cJ5M
 EVI2RU+oBtTt4fJhX4zBOL4zrax8Jyy6ksSL2pYhaYICh2SyAY/qTgjGN7bmHtkcOvCE
 x4Ug==
X-Gm-Message-State: AOAM5334MO26MV8k1HVjg+s/bHc0P5LO7tBwYxfRGRS5G/6XHihTVg2R
 oShZALYd1C9fcm/YRYYN3BO520OMmCUU7P8JOcHr/aNlwhaGBCp3voTl+cDpdxtqMisdvFOqLP9
 Fqw+FRcxrPlme504=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr2617201wrv.156.1601364140757; 
 Tue, 29 Sep 2020 00:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwujlSBY2x3DesO5EzaeCJPnztN0ViQYzUQrwHLatJxkVVp0o40ICJF1ih0k3amh6t2q5hCrQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr2617182wrv.156.1601364140538; 
 Tue, 29 Sep 2020 00:22:20 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q13sm4920163wra.93.2020.09.29.00.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:19 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 32/48] hw/smbios: report error if table size is too large
Message-ID: <20200929071948.281157-33-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200923133804.2089190-3-berrange@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d993448087..8b30906e50 100644
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
MST


