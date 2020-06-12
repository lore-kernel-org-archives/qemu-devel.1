Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2704C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA463206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3m1zRuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA463206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlUq-0003RF-UW
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5I-0004eQ-Mr
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl5D-00020w-Fx
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/K+BMGp/Z1Mf6jaoeVGFnEXmqbuskYzi+ydMa9DJuV0=;
 b=P3m1zRuqsX3CMTZpWRu8biragqinceCzNWZKJF0EFXmFN2zlTAAO8ZVvRUY7T0d+9o1mG2
 wFer3e4zr0yW0MJOdCOX830tJOKiS6c89+Uaq+ogqbKZbJxFvol757e8/0D3/rpDAEiHlL
 r58SFMr2wO2S3Zitwe9DfHqtNW8swQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-ZFTMeIxGNTSWS03sAW8ftA-1; Fri, 12 Jun 2020 10:51:45 -0400
X-MC-Unique: ZFTMeIxGNTSWS03sAW8ftA-1
Received: by mail-wm1-f69.google.com with SMTP id j128so2546124wmj.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/K+BMGp/Z1Mf6jaoeVGFnEXmqbuskYzi+ydMa9DJuV0=;
 b=tu5JFRgnX2Ds0CZbLIMitI+hXoiBVgaCMYBKKg0JZ/nYetGaV4CpnoGmOfz6r2Lhnv
 aayrmA0GeMCQfDtkNt6See/WZA61sX0lmP8YKpNyoiN4y1m9puTqhaxu66wQezRGkdXa
 /m8xjPZoR+KpbQa7ICDOHZBTq0I6xvdAQrScugGvSdagAzEjvO71EFAwvnnbAHGkVhjJ
 Hy3+vZHgfxIxTN/YOEOGYU4CqjKRUSVyyMDC7TszdJeORueQOpYRK5sR94pssIAY1cSs
 XIdRJtlxhPUIXVi0o+ILKkmqezuQqjtOm0ntnDS7tszf4Oh/0HlDOEbH95Z5UhMsDEvW
 Vz0A==
X-Gm-Message-State: AOAM532F0UCHdeGN2avefJccuQ21tBlilexz2HI9FEBwWHvQu4XBVPMY
 a8Gicy7r8ekpx4xI8gAxPu7R/Lh7IQEBZIkugn7j88eKPcHH+c4V3wNxoM1DrXLKybhHpImbjJm
 VhP3yDf/kpWKujrE=
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr15035364wrv.74.1591973503830; 
 Fri, 12 Jun 2020 07:51:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7pp74lkH56Ds7sode03UAtMq11m8YKrtc5MkzNWuHu7qWDgs5qCKoyQ0P7V5jDThZnoiVkA==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr15035345wrv.74.1591973503624; 
 Fri, 12 Jun 2020 07:51:43 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b201sm9004424wmb.36.2020.06.12.07.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:43 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/58] tests/acpi: Add void tables for Q35/TPM-TIS
 bios-tables-test
Message-ID: <20200612141917.9446-19-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Add placeholders for TPM and DSDT reference tables for
Q35 TPM-TIS tests and ignore them for the time being.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Message-Id: <20200609125409.24179-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 tests/data/acpi/q35/DSDT.tis                | 0
 tests/data/acpi/q35/TPM2.tis                | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/q35/DSDT.tis
 create mode 100644 tests/data/acpi/q35/TPM2.tis

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a2a45d1d31 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.tis",
+"tests/data/acpi/q35/TPM2.tis",
diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/TPM2.tis b/tests/data/acpi/q35/TPM2.tis
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


