Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BCC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91EF2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="yrgi/N4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91EF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIr03-00022B-Lh
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqs4-0000Tk-Ut
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:32 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqrw-0003Ty-Dc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id d19so891461pld.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=yrgi/N4llbWe/e9afG7Qh+0rXRbqeLjcrU/yaM16fphOo1616AZYNkMmVwHRFEyRnb
 hSZsoWGAL8n5m+O0NlzD1MVh6fd1FQTrpOtCwOd9+nix3/YIq1KVQjcGbGGC33efaZYi
 sX7bx6FvQvfQV75fO45zy4HdyMQ+gFAJtKai8p4GtB5I3Jk4Vablo32p47/vyETeettX
 CejUDoa4lpcRuptpaU8/iPOcAA/4O7vRE1s37FSeAKRoIPhdFQK3/Dv/6Ywt/I1LS13h
 AccOShv+WREUT58ujtHcWkbxv5kMFFR4o3HY1Xp8b1GX3Q1U0Q1w2EDw+xujSjFK1NYA
 93nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=NSY05qHpvQ/SJXFc+Ik314fH4oh6laza5+m0ucQ10ZROttWvqw7iSx+ceW+uB+gEWN
 wZbf90LPnSn289SHJHGNeezuG3etKbkE2TgOf+BhcvNI6RmU2sY3M64r5gIKWya9F3N5
 zi7qWgSMWyQM6cfLvoRjlezDfDFm3Lhtd20KsuZya1Mj0ndG8P2buwozzqnrMijBG6Nb
 GYr+Vi51xc2hXoCWmYVBbU5HFF0YGUKZogVaRPiZzv8YXgVWAAA9Oc3TSJrEzvUzAP7c
 yBPsi7fbU7fR7jE3I3GdTZzAkt+HMux0FpHSBOwhNXDQxZBjr2xr7/E0A+RmnRi7I5e5
 6jBA==
X-Gm-Message-State: AOAM533Yylak9y4Ao95ONlbVYXW88TO7OUBSyKxezS3919anHGiaPaWR
 3nretIIOqLPe6cZ7MHrCaAqqLP6fNvhCy8JZ
X-Google-Smtp-Source: ABdhPJzI8DwN9yviWxsWzIEuQL3ibwXq/fgz8fnb5fb4c65lKf7sPLfKCdeO9sIKPdX6D4rkXu6XRA==
X-Received: by 2002:a17:902:bb84:b029:d1:e5e7:bdd4 with SMTP id
 m4-20020a170902bb84b02900d1e5e7bdd4mr10486643pls.52.1600337422128; 
 Thu, 17 Sep 2020 03:10:22 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id d20sm5241559pjv.39.2020.09.17.03.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:10:21 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/12] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Thu, 17 Sep 2020 15:39:41 +0530
Message-Id: <20200917100947.21106-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917100947.21106-1-ani@anisinha.ca>
References: <20200917100947.21106-1-ani@anisinha.ca>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
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


