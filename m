Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F072076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ahM3ChV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F072076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyUl-0006ol-Ff
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRyU1-0006NK-CG
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:07:25 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRyTy-0003Qt-Vn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:07:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id x16so14376942pgj.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=QKGMKM9HyYc1eVD4XveDOx+OrGTCjt83H9U0dkUB2Ko=;
 b=ahM3ChV+GSEplzOZPSOpiTQzn5h2pgdVAyhpZ5jA8YlWbk4Hma6nJ7iQvb8oHpO/8p
 X/L4OLMZM/zeM/wLh0EnA04d+o5MTPZ4K5+BORqu40zznG5Q2o0dcT0eyDDYSJqG0C65
 qHzbO9y0zkEZsDwK8OhJ5FLjP7MrZoomXBC+ZeL3g5e8Cmne7UeND0T8xknTBhk/DAj2
 +QPiF1H8LzUV3UJexo8W8x2oVfTHfQECN3Q40xgfm2MgG0lC8eotzoCbLR0i8oAu/a52
 qx1eepBbQA7r7ytPMkq4O5ibGEngiIFwWYP2MtSYzlVGwYo6urGj3euojO+YROPjeHt0
 6iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=QKGMKM9HyYc1eVD4XveDOx+OrGTCjt83H9U0dkUB2Ko=;
 b=BGJSGtBJM7vw4wC/GgTkTwL5JdvX2/YPueYCryN5cRE8onKS9Fc8e56phtk7nDF0Xd
 3MjN1ePN89fkaKUpovjJ8BUJKEbQX9RDmVmmWtCaaTyTpXp4+UsfxATexqTjEcDWYo0/
 gLj2X+Ck4q45sSS3AF89jBfKiH9F/CdK3VoWm3hgUqQtSzzQKM2DR5aZl+yNlJ3UYuKm
 82o9rQCFLCLYnv3DpqzblqqXZSBPnbTguQgqK/NetfA+rw/V4tuTglyt9jJ07YiAl7V3
 ojRnVXxXG3x57mio77RcHCRMItxa7s82yF5im1PcGl8dJy0U9+cp6eys/zWhakBo4qLL
 IoQA==
X-Gm-Message-State: AOAM530162A/ouuf9OT2gg7rwbVXRZglKhVNFlRj70G8IR2qpYuXY3mA
 4/9pQI9ZdVLWMBpUky666sfqSg==
X-Google-Smtp-Source: ABdhPJyQl6VZ8/UlsLaajW5OYKUjiK6pt6rRFgmhjnZ+nZQeK31vyUIF/KY9SJCUptyTOvRmffvYxQ==
X-Received: by 2002:a62:7cd4:0:b029:152:b3e8:c59f with SMTP id
 x203-20020a627cd40000b0290152b3e8c59fmr23026737pfc.2.1602511639301; 
 Mon, 12 Oct 2020 07:07:19 -0700 (PDT)
Received: from [192.168.1.4] ([203.163.234.171])
 by smtp.gmail.com with ESMTPSA id u27sm19510774pgm.60.2020.10.12.07.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 07:07:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ani Sinha <ani@anisinha.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
Date: Mon, 12 Oct 2020 19:37:14 +0530
Message-Id: <105B94CB-1345-49FB-B296-F5236E448BC3@anisinha.ca>
References: <20200929142501.1057-1-ani@anisinha.ca>
In-Reply-To: <20200929142501.1057-1-ani@anisinha.ca>
To: mst@redhat.com, qemu-devel@nongnu.org
X-Mailer: iPad Mail (18A393)
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x544.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Request to queue this patch with the next pull.=20

> On Sep 29, 2020, at 7:55 PM, Ani Sinha <ani@anisinha.ca> wrote:
>=20
> =EF=BB=BFA comment is added in bios-tables-test.c that explains the reason=
ing
> behind the process of updating the ACPI table blobs when new tests are add=
ed
> or old tests are modified or code is committed that affect tests. The
> explanation would help future contributors follow the correct process when=

> making code changes that affect ACPI tables.
>=20
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
> tests/qtest/bios-tables-test.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> changelog:
> v5: incorporated suggestion from eric.
> v4: more updates as per Igor's suggestion. Dropped some comment lines. add=
ed
>    ack'd by line.
> v3: review feedback incorporared and actual comment in the code reworded.
> v2: cosmetic - commit log reworded.
>=20
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test=
.c
> index 3c09b844f9..fc7aaaf82c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -11,7 +11,7 @@
>  */
>=20
> /*
> - * How to add or update the tests:
> + * How to add or update the tests or commit changes that affect ACPI tabl=
es:
>  * Contributor:
>  * 1. add empty files for new tables, if any, under tests/data/acpi
>  * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.=
h
> @@ -38,6 +38,11 @@
>  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
>  * 6. Now commit any changes to the expected binary, include diff from ste=
p 4
>  *    in commit log.
> + *    Expected binary updates needs to be a separate patch from the code t=
hat
> + *    introduces changes to ACPI tables. It lets the maintainer drop
> + *    and regenerate binary updates in case of merge conflicts. Further, a=
 code
> + *    change is easily reviewable but a binary blob is not (without doing=
 a
> + *    disassembly).
>  * 7. Before sending patches to the list (Contributor)
>  *    or before doing a pull request (Maintainer), make sure
>  *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ens=
ure
> --=20
> 2.17.1
>=20

