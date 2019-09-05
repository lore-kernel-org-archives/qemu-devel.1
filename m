Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3F42082E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQrR8fNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3F42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5uL5-0002rp-83
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5uJq-0001q9-Lo
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5uJp-0004xU-6d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:09:10 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5uJp-0004x9-06
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 12:09:09 -0400
Received: by mail-ot1-x330.google.com with SMTP id c7so2759991otp.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FabbdlZIJDQkTyx3szZfOr3MihX4kYVPPVSJGIuIf4I=;
 b=eQrR8fNz3m5s18Ff1PBvPTdQX98I6hZKsn+X0XSCn9PGV7l3GiHN+nkPRlUpEgsqQf
 z3N4TMi3yKozBsTSL6CdyIJNKRJdIR4p4TewDT6zEUyS32z3x1bvUxsmf5oCm9XYQBgT
 62Z/R9UOit/M+kwEVKmD1WxsXd0iKrubkG3QMaSLaLrQpuPm8lT4MYo33XB3K+ZzDV2P
 6myWDEYS+ICVHMCv0+eGexXqPEnEvgkt9A5iLz1CZ7VaRiCqnQcBQHDLTSiDmuB3PrR0
 s4tmjtVcKb1COXtDULw2P2HbsNwxpmxAWi7sSuWhoDffUXhcZr+S6rCC/T9XOh11Z6PL
 F0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FabbdlZIJDQkTyx3szZfOr3MihX4kYVPPVSJGIuIf4I=;
 b=nk8c58FELXEOWplNLJFUKnbg2iJmc31VVMkRndM8UdqfJhUJhNFFejQ5w57LeFHjyk
 NQzcpRZ0b70Ej60pGxH+ZGFe+DjWbexxmdpV4M9Au65FnQtAihgrkWZ4XcjQbgu53GcY
 YWngGkN5JKO1wWCOWMAjC1TusTjxnulzun9PcdyG/E7VH8YLZ407GfefMpImedAy8TEt
 jpCR2+DtPd68O6PLVo1STsVP+tpcAtYyrjWVBh+tNPz/THG+UCaaqnyWdLjRd85aK7eB
 Ys6xU6n+JH5ta1KPEyY26vmfXqgHpvziiDWE+aqna3Wak+rH/HCiABri1v7AcGVGJkkQ
 3GoQ==
X-Gm-Message-State: APjAAAWpJHS1YlrHIIdBdZ3XkKFuDacWQZHhrFADI1U+ep8r8E4PjkbP
 BdAuk6ilRJe4TECAvKoW/Om0dKYpP1jOMq6AZRORbA==
X-Google-Smtp-Source: APXvYqweCyZQ1K7nJe+Nsx1SP60kD0Kw5AUmpXbt+WERIeCopKZ+6rKgrzHlyXs0e+OW7+As71Ijv1Jcen20xa/g600=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr3368612oti.91.1567699747642; 
 Thu, 05 Sep 2019 09:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190905134526.32146-1-berrange@redhat.com>
In-Reply-To: <20190905134526.32146-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 17:08:55 +0100
Message-ID: <CAFEAcA9kMNCGT8KzR_ecaBnOWz+FDEyzex0JQP557hjZEb4hvw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/4] Docs patches
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 at 14:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7b6e4=
21:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' into=
 staging (2019-09-05 09:33:01 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/docs-pull-request
>
> for you to fetch changes up to 9f8efa74d3f1cb9ceeee957ee382c2b4feb2ae30:
>
>   docs: split the CODING_STYLE doc into distinct groups (2019-09-05 14:41=
:00 +0100)
>
> ----------------------------------------------------------------
>
> * Merges HACKING into CODING_STYLE
> * Converts README and CODING_STYLE docs into RST syntax
> * Documents use of auto cleanup functions
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

