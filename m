Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D7CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E11E206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XblnLDlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E11E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8Yj-0002Nz-Fe
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jE8Xi-0001SQ-RS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jE8Xh-0000ej-MZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:29:46 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:46714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jE8Xh-0000Zs-G0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:29:45 -0400
Received: by mail-ot1-x330.google.com with SMTP id 111so20847374oth.13
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lnOKmgu1sNl0XqBjfHs1rrPrWm0VhQNaLDMjjMjtNYo=;
 b=XblnLDluido2eTh/Bj6PFaoLC+eV4o2Tv0a77qwBBevbIOQ8B1L6sPYDAWw3Tk2epf
 L37p8GGYlaP3w8eqp1YymEwxJsb7EIvFv/089Vj7YNfZSEC8YcMTlsThqIGHaWc3Wycc
 MIbJUjXn5kQ3e8U80qPsZgig6BVakuSN4vlN/2AlJeeBfLubjAiXR+tX5ZTCkHDC6eKj
 ilhobqbCk/LciMfbS3lg+CxNcGwEgz7GGBTjKmhm8ripDkWSZ7stdRkN04dmoFXaRfsa
 beLVWpirwDWJeY97xqnA0J49JLFfA+RSymUvDurEx9OvbETZgDMoSbcggnIZ0C4N4PLU
 j57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lnOKmgu1sNl0XqBjfHs1rrPrWm0VhQNaLDMjjMjtNYo=;
 b=gvR8r0xIRAaF1fGYHQYrcIN4xy9DFJw4eyCHyDUkIwD8fOCSb3xDNhsEF+WRhOeoVF
 TrMasZGEfjooQJsBdWXXu5mYy3/oiJf34s59WqgdIOXUAyyyUdjJfSDLz0tTHAshR81l
 lDUjsleR3Qf4KsNGgWJmXzO6UJ1aaKMVhU6jmZk6AJEzwh/BQ9Z4caWMUd3Uuuf0KBLB
 H9+Fm9mClLdTl0g99xHvgH99f40hyLoFsAhUfYocKPjNyTwUp1HzZWczYzuGaIRHLIV7
 YzE9yM8xYUH6hHcEvRfnhlElNmFmCVbr0fjiC+Z/VfNx0PH4glFRuWKkefCEe/op3fq3
 naTw==
X-Gm-Message-State: ANhLgQ3GBURn0AqvPFNoJt/z2b+4rC4sbjlBu8g3s2ICgqC8Q5SqxEds
 6Xy2CvD90066rA7Ey6NNvFHm17rFN/gULk6eafMyMA==
X-Google-Smtp-Source: ADFU+vuU0uJIMlOE4mZElweW3lz41Sd0z+UeCpJGyWjwfYhPc2I5FuVqAmBg0sKf+5vufzgDfiVMgkrAHr7iyhI3zKo=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr2940204otk.232.1584437384344; 
 Tue, 17 Mar 2020 02:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
In-Reply-To: <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 09:29:32 +0000
Message-ID: <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 04:59, Cleber Rosa <crosa@redhat.com> wrote:
> Yes, that did the trick and I can now see the configuration.  What I can
> *not* see is any "Specific Runner" configured.  So maybe:
>
> 1) The documentation I included is not clear enough about the fact that
> setup steps need to be done on a machine so that it becomes a "Runner"
>
> 2) The (Ansible) playbooks (especially contrib/ci/orgs/qemu/gitlab-runner.yml)
> is not working as intended
>
> 3) Some expectations misalignment on machines that would be available to run
> those jobs
>
> In any case, none of those should be big problems.  Please let me know what
> you did/experienced/expected up to this point, and we can continue from there.

Ah, I see. My assumption was that this was all stuff that you were
working on, so that I would then be able to test that it worked correctly,
not that I would need to do configuration of the gitlab.com setup.
I thought all the stuff about "how to set up runners" was only for
people who wanted to set up some 3rd-party CI for non-official
forks or for when we wanted to add extra runners in future (eg for
architectures not yet covered). So the only thing I did was follow
your "just push to staging" instructions.

thanks
-- PMM

