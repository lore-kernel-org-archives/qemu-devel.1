Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E021C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5DA20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3EcEpK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5DA20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisVt-0006HF-VA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKe-0007iG-6n
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKd-0008Fe-AK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/K+BMGp/Z1Mf6jaoeVGFnEXmqbuskYzi+ydMa9DJuV0=;
 b=S3EcEpK9sCGqjRqKKkRJFFAhSgzGPdYBETHo2+Szu2fIvXGj93lOtM9MgNS/gHcCLbNILm
 jXcB9rTUO4st0q5MO55GZKsBxx6UWC6Ixa70/ohXA1ZtSDR6jKslLmeXzGXSRMCU79Unnn
 ZxdgF7pDdW20eBVTJjc7cST9ueCbPZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-L0foAVNKM8Ol1JqKMLSrIA-1; Wed, 10 Jun 2020 00:27:16 -0400
X-MC-Unique: L0foAVNKM8Ol1JqKMLSrIA-1
Received: by mail-wr1-f69.google.com with SMTP id p10so498588wrn.19
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/K+BMGp/Z1Mf6jaoeVGFnEXmqbuskYzi+ydMa9DJuV0=;
 b=Cxd5Y/lgdlGujxLmEjnX8cBW/EriP3BuchzEGQyRgQbTiFzZ0szLslKu2IzwOFmBCQ
 JvDBk0etArHgma29jJsWV10k67zqzE60Lwq5w3cUqwEoiW7Foj3Sn4+Wj+Isn+IaE3Kc
 C+R789qjNPtLp/4Y98qU74vk4EckID17Ty/Zav7MvuLP/2OFhlw5kXO1AGStsqd+ccNN
 x8KwfXPW69GCf0ULGoKqgieVHnEouPNmPp6cjC/Kb8fFjNZCIUlEEzwe7SGGxZOBdhgo
 A3BzJLKDEDcNQZQwnsdrfIho8+c01MucSu/kSDJV8QVjtsifMksHIASUaJKj8fBgKglM
 hULw==
X-Gm-Message-State: AOAM53363W/9Cq1v7f+Xrvh+IlsD6r22VwkqXM1d7WooUelelCtfn6i+
 9FOsMwXOqsdJ5tm2dO9mFPcU5gebqs72QeZrt9KY3PSlq2bVGZekSNMiMXFUzY0HDke5VB2FVXT
 RWOmLCg8OmW0IAZA=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr649684wmh.98.1591763235165;
 Tue, 09 Jun 2020 21:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Owe4I/D2wtRAiUO1R5sOL7GAOh1j5G9+h8tvyDhJIlKWHMPftIbqSqnfJ/QoVVB27z4rhQ==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr649674wmh.98.1591763235000;
 Tue, 09 Jun 2020 21:27:15 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c81sm5385446wmd.42.2020.06.09.21.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:14 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/56] tests/acpi: Add void tables for Q35/TPM-TIS
 bios-tables-test
Message-ID: <20200610042613.1459309-19-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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


