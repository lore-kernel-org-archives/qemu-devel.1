Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B7C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D91521D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Ld3ZYOxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D91521D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC8c-0005nX-7f
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBy4-0002Re-8S
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:09 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBy2-0007tV-Gh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:42:07 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b17so2659567pji.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a5N2FhUSOabJ48UmpjSQFcSaviMRIjtZ+S0ajhOGTF8=;
 b=Ld3ZYOxcoBkyza5hwGFRf4jGKSHT9GBZOpmpQTnAHvw+/NrD5li0lqfTqx6FKG7aQL
 Qdf6xQM8lnSkUz2UpsQUxYES/LoolUiw+/c2SD4Q6qMYg/u3xw1sqXxNjiVjREEKE/Zn
 76s3D9IWbU2VUc1PjEQF4jfniDVwmj5IiaWauAO/Hh1HBb++tcfxINec3Hl1vPXXb89A
 jy75fSxP3mbmWlIWmvQOrB3Q4tcZwN7XxruYV1ExeR8rhrk2W06DHoDm7+FTgLlNgttm
 IK2dEF/1sGx3kKxYm2SJ5ANOVsHx6N64ns80HUxRAqBbG8kDRh0zMlvVZX81YsWd+1KF
 F9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a5N2FhUSOabJ48UmpjSQFcSaviMRIjtZ+S0ajhOGTF8=;
 b=br+rorbH8SdoDANpa9aOIx5/hW1Mdc4niv5U6uiL/AsR1R4NHpOm0J6CWHdU0n2X/0
 yv1UcG+Fu13o5xEAJ6z9YfaRF0+1anSHys/top3vcafg1ZUcQOW0LqjD7+kEEavjUnMY
 ZA5Z+yExtzUVfD12SI7CU2OJH75fneD/czldK1uYf1kagFpcP8CZnPsOfxWcP9jqMfLY
 /b9XeVlEST6z0Y8dDOxvlkBk8bTdnud9WW8WUu/hzZUdmKem4v/fhpkvLdaIG8ZBn2xj
 q/U6D47kVu98IVUg4uLQEzYjltsJIGrcSRBbd2Z5qlyWZbsRTK7sZ3H7xKDggQ+EtHGP
 ZOFQ==
X-Gm-Message-State: AOAM532JH0rrb9Xy2LYwbOhOTvwnCSNS1N4Q+GKbrRlghppbjUfCWUMF
 sAgzf1+O/cpJp8xcEdWk3ViEgw==
X-Google-Smtp-Source: ABdhPJyFMztpJh05i+0rvJV0vHSfAnLc5N9hjzo7vjZlCiMjhR8PPaixrmKi8pvZ0l37K3rN2/GMAg==
X-Received: by 2002:a17:90a:f486:: with SMTP id
 bx6mr11766822pjb.130.1600418525290; 
 Fri, 18 Sep 2020 01:42:05 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:42:04 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 09/13] Add ACPI DSDT tables for q35 that are being updated
 by the next patch
Date: Fri, 18 Sep 2020 14:11:07 +0530
Message-Id: <20200918084111.15339-10-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following patch 7b7d8ff077 ("piix4: don't reserve hw resources when
hotplug is off globally") modifies certain ACPI tables for q35 machines.
This patch adds those table names to tests/qtest/bios-tables-test-allowed-diff.h
so that unit tests continues to pass and bisection is not broken.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..631703142c 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,11 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.tis",
-- 
2.17.1


