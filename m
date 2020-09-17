Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03463C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8961D2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="CnZW9gPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8961D2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIooX-0005Pm-DC
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeQ-0008HK-WC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeP-0004pp-7c
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id c3so692858plz.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=CnZW9gPaandkGGDrH1VaeFv8EdTC1OZzBrUh7btE8LaPtNwkTgKqxUV4gfR9tZBpha
 wwC+GB7mD3r34ZjuWkeLhomnherAljvwdbrEdGdZRMcM667t5CaOa0AgieVtaSqpkVBW
 z/Fh2fh9y7S+NOzJnfOx+l8FpNPQci+TBbsBrMgtgojOo/I8mvV8WKBVBR5Jl60zRG3l
 jy93znM85HZIPcH17L6hjdaI5wiGvXz6yy1/D9qqybegcOhPup2c/2H2nKME6DwEgY8e
 gpkkBsLq2xI11JMc1kIvPL1a51TqUa5RaXyviLoYOsMvOesoE1Ib3k7izuSPYDi1v5s2
 uXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=gGiH6PF69u7wtULCl8cIUBJEJR13Q5wz91UiLUQBCLzgIH4xDW7orAlqWBJ9Fs0V+L
 ZslTc8W9l+Pe1jGh8dI8qPyg74mtqUGgq12hUNBuSDz+4iZni7VgNCEs1O6mPMYeeqm1
 Uzlx8eH/KOLtwwOEOvnIcUBZEbEKwRtJU7PK73/dMdU2faWIkFzKQJlSCXNHZo3/ijI6
 DZ2NqU7CgD5+X8KRB6DGO9RTJFOKknxYMsqM6WVTli8vYnqVq6p9UZEITEx8B4LVnZn2
 zxWlvi059dR7ZnsOxumZjob+X7SYkdTzfiG5OQUyEtumrMrkoxEPwRst4LqCsBhcLc9W
 27GA==
X-Gm-Message-State: AOAM532S7CkqpnccCBCSCOBhjAlwVLzQOLBrvp9aX1SfhtRtvcI16by8
 Fbjc/T3MWNcX9pK1oPTBzITdQ70yCGFFlEn9
X-Google-Smtp-Source: ABdhPJxC+AmZ85kVK/Uy5septNaREyxM4oZ0GUBljgDH3oRsUF0OIVX5fUbALEIDDI+8evSvWTihug==
X-Received: by 2002:a17:90a:d789:: with SMTP id
 z9mr7472093pju.226.1600328895659; 
 Thu, 17 Sep 2020 00:48:15 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:14 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/12] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Thu, 17 Sep 2020 13:17:26 +0530
Message-Id: <20200917074733.13612-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file
for testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under
i440fx. This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.17.1


