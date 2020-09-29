Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F379C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADDA20936
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HW+OaA2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADDA20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAIW-0008Ul-ML
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yL-0004W5-Al
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yH-0001oU-Tn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sT3VHlOl/asIQ54Q0m4hicvdMpT5tXuTSbVGleHo81k=;
 b=HW+OaA2amoaiU/oIg1ByPYMXeeRKuo3Sg4eRQUXH+1R155e2oSLnHf7oAawXEqQYyJdIe5
 KyLvVam1a4hcMXBLndjz14um1TlWrmDCK07pz+JRbBP74BRgTFGdrehP7MLLP0LzdAxMfF
 0W/wQ2PjsC+o7nQt9kfq76www4zKgXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-605dvUxeODyN8ymKIgNViQ-1; Tue, 29 Sep 2020 03:22:43 -0400
X-MC-Unique: 605dvUxeODyN8ymKIgNViQ-1
Received: by mail-wm1-f69.google.com with SMTP id r83so1031506wma.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sT3VHlOl/asIQ54Q0m4hicvdMpT5tXuTSbVGleHo81k=;
 b=dw2WZ4/ZBoxrtGJrY6DAZszTTnmuC9RCZRXntyU9jljrZ6RQnNIh24eCxHeY6tg0vB
 0widE751TRDDBKehYQQL7qnbpOl9acF+9rROZottLv0sLijwp7yQLaiQKDEQ+2meGSZM
 ioxj29w9WsBEhzprtV7uuHM5i/qx6/3bvKipFzaisVv/A5cB3IGihHBGokk8NpgYbqLB
 YLBeVfnLN7AYP9qcp4WX/Yyc8AyNscolryvVtSJdoX8Ws1dg/e8MhTBZe1TJpp5WG+u5
 j1VMtsqHo8xo0IR89rr7a0o75JHay94j2Q3M5NRAjqmDgWxQ3HxGtyqsgQ1wka6aU6ek
 7Ztg==
X-Gm-Message-State: AOAM530oiVNj8YGS7wy1tEWBrW2FMtanQtgIfJDK8C8e0HrAULgM6nvf
 ABdNyF4oYCI1SPhBlE+gH6mHzLHXy2XGM/pBo0Erv5+n0zoCMjPYsqhYhrPWydDmjH8DIWn3H4/
 uwFZou2K6/TAGyvw=
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr2916829wma.162.1601364161477; 
 Tue, 29 Sep 2020 00:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwivMZft1I8uhaZQHorjOaw5HFHEJlpTLIFluA3e6YofDmlrEPfobgQKeEh4LQK31MIRT8tXQ==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr2916812wma.162.1601364161328; 
 Tue, 29 Sep 2020 00:22:41 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v9sm4959247wrv.35.2020.09.29.00.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:40 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 40/48] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Message-ID: <20200929071948.281157-41-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: Ani Sinha <ani@anisinha.ca>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file
for testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under
i440fx. This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-7-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..96a9237355 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbridge",
-- 
MST


