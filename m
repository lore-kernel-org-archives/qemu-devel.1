Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9A8214F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="qsawdKI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9A8214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgcD-0002yj-Gf
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKgbR-0002Et-12
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:36:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kKgbO-00017d-VE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:36:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so16667076wrw.11
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kBXRQryOkIp539HNDGBAOhgtbbEt/lKfc3zoBDzm008=;
 b=qsawdKI16ORlAYQ8CLDrLvbRtowBYvkr3IBjL8SkpqXHeX0sXN1tOKus/L9rZNfbp9
 b8IylmzGJZdKP1Ewr+MImaLJPH1ZuSdOiT0OODJiCcnPYoOAloVVY9uTadBKcBgnc5f+
 5a67JXZoz35iirZbkkfpQRs6IQuaehNReyWAGtscnuWAx84J6vIalX4WsBQVZjMiAQHf
 cj55EpuO1C4+f8T4O9OZp8BQ9jDIlAITHayz2IcNWznQsk06WmMNsh3P+vk+LjQaAD5a
 OivtWlPco/M3rWooT9QUno+pUGLRE6aPuQhL53mXkVfNnOzRpqRncJYcpeFX+nylfZ9Y
 i9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kBXRQryOkIp539HNDGBAOhgtbbEt/lKfc3zoBDzm008=;
 b=W9VXIuycSJXIzvoG4DdpUU0lf4Wq+If8Iya9ixBZt9kGvyms5Lpirej7Vx/U61jzop
 +7ccbCHYojjxgfV/pKHqFl8LJhKyxV7jZJh8QNUSiz63dj4yYSz92DMZFx+Y4x1fZ4jd
 y5jSV/0GFiST0eBZxqftFikouUl/wCthrOu34/q7MbXiV+8eDsW9dLwWoZuib+D5mL5t
 VgVMv83Xu1PDY5bqsOW+/gJfCRTzekriBT2Q9ZhYXXwBfsiyHku0mTSgvEH6xmOUwLg5
 jIGCA3Yg9dFPgzCtXi1fwUNfg45F11P51GWx256xdjIJm41pM3TrKPGCZXxQeByN8CUF
 IF4Q==
X-Gm-Message-State: AOAM532AsToDOhrjL/i3fzRRwU6IZfLcHxIc6UKBohr9KAsjpsbPZFst
 NJFTLF276G/lMw2XgqOarRAxlcWXmjJrNKIFLEKFjw==
X-Google-Smtp-Source: ABdhPJymDp/mlHqNlfqE5qfM07vtWncndbttRf1F7SawmalmKV5K/4Z0VtqXM+XdXOPbgB6DSJzY08H9U6sjye8FtRY=
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr2474537wrn.212.1600774613344; 
 Tue, 22 Sep 2020 04:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200922100918.4200-1-ani@anisinha.ca>
 <20200922132744.2faf4eea@redhat.com>
In-Reply-To: <20200922132744.2faf4eea@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 22 Sep 2020 17:06:42 +0530
Message-ID: <CAARzgwxKJHAQr3SgzN7UHVxPjzu+sh14P7B22wBniJ0qcpJ-vQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 4:57 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 22 Sep 2020 15:39:18 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > A comment blob is added in bios-tables-test.c that explains the reasoning
> > behind the process of updating the ACPI table blobs when new tests are added
> > or old tests are modified or code is committed that affect tests. The
> > explanation would help future contributors follow the correct process when
> > making code changes that affect ACPI tables.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> My English is not good enough for writing documentation.
> Maybe Eric will have something to suggest.
>
> > ---
> >  tests/qtest/bios-tables-test.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > Changelog:
> > v2: cosmetic - commit log reworded.
> > v3: review feedback incorporared and actual comment in the code reworded.
> >
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index b514b70b62..1e8838c8c6 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  /*
> > - * How to add or update the tests:
> > + * How to add or update the tests or commit changes that affect ACPI tables:
> >   * Contributor:
> >   * 1. add empty files for new tables, if any, under tests/data/acpi
> >   * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -38,6 +38,17 @@
> >   *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> >   * 6. Now commit any changes to the expected binary, include diff from step 4
> >   *    in commit log.
> > + *    The reason why we follow the above process is described below:
> > + *    After every commit we make sure that the unit tests are not broken. To do
> > + *    that, we could have committed the table updates along with the patches.
> I'd drop upto here, it's obvious that that no patch should break build intentionally.

I prefer to make this explicit. Build breakage != unit test breakage
all the time :-)

>
> Writing docs is hard, try to minimize amount of not really needed
> information.
>
> > + *    However, expected binary updates needs to be a separate patch from the
> s/However,//
>
> > + *    code that introduces changes to ACPI tables. It lets maintainer to drop
> > + *    and regenerate binary updates in case of merge conflicts. Further, a code
> > + *    change is easily reviewable but a binary blob is not (without doing a
> > + *    diassemly).
>
> > + * Listing the modified table files additionally helps in
> > + *    bisection in case things are broken.
> > + *    Hence, we have a multi-step process and at each step unit tests continue
> > + *    to pass.
> I'd drop this part as well

Why?

>
> with above corrections, I'm more or less fine with text so on that condition
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> the rest is upto Michael.
>
> >   * 7. Before sending patches to the list (Contributor)
> >   *    or before doing a pull request (Maintainer), make sure
> >   *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
>

