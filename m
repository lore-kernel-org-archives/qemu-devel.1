Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D5C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7520A207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="UGhaCHTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7520A207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFoo-0006lK-7Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNFnq-0006Ej-SD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:36:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNFnl-0000u4-6E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:36:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so4524247pfg.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=NUQt2GxrfnAX1LvU7lRA62zC/GFRvsKlqpWe7g6L/WM=;
 b=UGhaCHTLOmigNUWoZIse9Z5LxETtCCL8Y0eFnip6BxujVH7zNDrSkFqu9OYcIsmHbj
 enMnMqSwJhRdMu1aR6yDIZ8j4rEuS3Kafddjz0bYoDsUB887cA93s7Ex7EHxy7PU2uXl
 x4zdxvt+sOrUSWwJB8NwrGcACP9gPda9QOTMk1oH7IvYyqpmHysFfh7jusn702H2EbuX
 dZ6TpKnqbTZjafXwrEmRKMGPT6j/FSU4VJsIcACr5f8F1PeUvCqtIU/yKk/qM/YYY3z2
 9eztXl+kGlIj86g25vzSjWCCIia0MDIMtoBCocB1LC/DqzZlzxBCluMxhvwmKlcYK212
 cyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=NUQt2GxrfnAX1LvU7lRA62zC/GFRvsKlqpWe7g6L/WM=;
 b=QC9UpCilBeZFRq7DHnrz7lNYJ4FhBZtu48fKKBy1oijCELU0AhisHbOaGqVtzZfOsH
 W9CXon5cu0F9OrOH+D84dyFTaMh0QnrUvU/Ddb/U+6v/NCbvBxQfIoPdcMHYXdbZLP0+
 GrCeD/ed5lcpXDdIH2x8NAOHlp/BqAofl4GE9XExwX1KFJjTkgsaO3Bz9pe5z5rY/ZQK
 aGjFOa4O4JEa0uwyhJ5ge17zmh3RzO7BlW5GS7g83VllCnBL8miXbrTU5FmEsbQJuMWn
 WJ65MZT6QkOR+RnsZ+/UfWe4ZEHXqH/cUnfyQnWKxSLErpEhO2+FRQIxTnE4H7MLwieh
 aQIQ==
X-Gm-Message-State: AOAM530J2cCIEg2OOSwbNbp5QYnlJXp2YPSsXHJPPtOrg3RuLnTVbl6x
 9NB8rspteIsOaJsysp5rnSYDyxqZEwbWMg==
X-Google-Smtp-Source: ABdhPJz9asHmN/jQmZcPEZRBPvSMJWdN/duCpjTOHiMXtBH3GpslpEL9HzLptPRCqweq6c2XnOxDlQ==
X-Received: by 2002:a17:902:bf4b:b029:d1:e5e7:bddd with SMTP id
 u11-20020a170902bf4bb02900d1e5e7bdddmr4530531pls.61.1601386575099; 
 Tue, 29 Sep 2020 06:36:15 -0700 (PDT)
Received: from [192.168.1.5] ([115.96.125.11])
 by smtp.gmail.com with ESMTPSA id h9sm4931264pfc.28.2020.09.29.06.36.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Sep 2020 06:36:14 -0700 (PDT)
Date: Tue, 29 Sep 2020 19:05:47 +0530
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Message-ID: <10a8e4db-82d0-40a5-b9aa-4b2de119b502@Spark>
In-Reply-To: <20200924090925.18915-1-ani@anisinha.ca>
References: <20200924090925.18915-1-ani@anisinha.ca>
Subject: Re: [PATCH v4] Add a comment in bios-tables-test.c to clarify
 the reason behind approach
X-Readdle-Message-ID: 10a8e4db-82d0-40a5-b9aa-4b2de119b502@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f733849_327b23c6_bd1"
Received-SPF: none client-ip=2607:f8b0:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f733849_327b23c6_bd1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Michael,

Please queue this one for the next pull as well.
On Sep 24, 2020, 14:39 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> A comment is added in bios-tables-test.c that explains the reasoning
> behind the process of updating the ACPI table blobs when new tests are added
> or old tests are modified or code is committed that affect tests. The
> explanation would help future contributors follow the correct process when
> making code changes that affect ACPI tables.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
> tests/qtest/bios-tables-test.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
> Changelog:
> v2: cosmetic - commit log reworded.
> v3: review feedback incorporared and actual comment in the code reworded.
> v4: more updates as per Igor's suggestion. Dropped some comment lines. added
> ack'd by line.
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index b514b70b62..34e2e1c55b 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -11,7 +11,7 @@
> */
>
> /*
> - * How to add or update the tests:
> + * How to add or update the tests or commit changes that affect ACPI tables:
> * Contributor:
> * 1. add empty files for new tables, if any, under tests/data/acpi
> * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
> @@ -38,6 +38,11 @@
> * $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> * 6. Now commit any changes to the expected binary, include diff from step 4
> * in commit log.
> + * Expected binary updates needs to be a separate patch from the code that
> + * introduces changes to ACPI tables. It lets maintainer to drop
> + * and regenerate binary updates in case of merge conflicts. Further, a code
> + * change is easily reviewable but a binary blob is not (without doing a
> + * diassemly).
> * 7. Before sending patches to the list (Contributor)
> * or before doing a pull request (Maintainer), make sure
> * tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
> --
> 2.17.1
>

--5f733849_327b23c6_bd1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Michael,<br />
<br />
Please queue this one for the next pull as well.</div>
</div>
<div name=3D=22messageReplySection=22>On Sep 24, 2020, 14:39 +0530, Ani S=
inha &lt;ani=40anisinha.ca&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>A comment is added in bios-tables-test.c that explains the reas=
oning<br />
behind the process of updating the ACPI table blobs when new tests are ad=
ded<br />
or old tests are modified or code is committed that affect tests. The<br =
/>
explanation would help future contributors follow the correct process whe=
n<br />
making code changes that affect ACPI tables.<br />
<br />
Signed-off-by: Ani Sinha &lt;ani=40anisinha.ca&gt;<br />
Acked-by: Igor Mammedov &lt;imammedo=40redhat.com&gt;<br />
---<br />
tests/qtest/bios-tables-test.c =7C 7 ++++++-<br />
1 file changed, 6 insertions(+), 1 deletion(-)<br />
<br />
Changelog:<br />
v2: cosmetic - commit log reworded.<br />
v3: review feedback incorporared and actual comment in the code reworded.=
<br />
v4: more updates as per Igor's suggestion. Dropped some comment lines. ad=
ded<br />
ack'd by line.<br />
<br />
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c<br />
index b514b70b62..34e2e1c55b 100644<br />
--- a/tests/qtest/bios-tables-test.c<br />
+++ b/tests/qtest/bios-tables-test.c<br />
=40=40 -11,7 +11,7 =40=40<br />
*/<br />
<br />
/*<br />
- * How to add or update the tests:<br />
+ * How to add or update the tests or commit changes that affect ACPI tab=
les:<br />
* Contributor:<br />
* 1. add empty files for new tables, if any, under tests/data/acpi<br />
* 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.=
h<br />
=40=40 -38,6 +38,11 =40=40<br />
* =24(SRC=5FPATH)/tests/data/acpi/rebuild-expected-aml.sh<br />
* 6. Now commit any changes to the expected binary, include diff from ste=
p 4<br />
* in commit log.<br />
+ * Expected binary updates needs to be a separate patch from the code th=
at<br />
+ * introduces changes to ACPI tables. It lets maintainer to drop<br />
+ * and regenerate binary updates in case of merge conflicts. =46urther, =
a code<br />
+ * change is easily reviewable but a binary blob is not (without doing a=
<br />
+ * diassemly).<br />
* 7. Before sending patches to the list (Contributor)<br />
* or before doing a pull request (Maintainer), make sure<br />
* tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure=
<br />
--<br />
2.17.1<br />
<br /></blockquote>
</div>
</body>
</html>

--5f733849_327b23c6_bd1--


