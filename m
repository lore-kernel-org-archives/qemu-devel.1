Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A538C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C074207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC5KEmzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C074207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWb5-0000cV-69
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kDWa7-0007xb-US
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:29:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kDWa5-0003v4-Pd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:29:59 -0400
Received: by mail-lf1-x142.google.com with SMTP id x77so266450lfa.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mfMVEnm/aU0KnjcFXAGITOcH1QJjm8sg1fO6Hab3Df8=;
 b=HC5KEmznAUZ7qRchoTKmYYgQYrwA54V4RSYEwgzYJxsFmyY3Rvn9FMIfpt7A1Myiuw
 Zd5uz2KF1ClR1ohslIfj8mmDSEWIYzLM+ZeZ09bQKpat4On00D/Ips3mIyMWjJJXiw6h
 fdPB/wOH1VF4DVpNe2zpSNeqjtAgDfTAMA9Jie4HMpP5iCluyMzuHW3prwVmBCd0Az1k
 PtJ/t3SNmaGGTrrjZbrLwlbwxg25ZPqmTY9C4RnBCFTHT/gs+KeBJDqCfiROR6PcwjUJ
 tLhdwguP1+knuDbM/pdyevmqyIfpSApze/t80ARQdQnFEnepbV7phnqMZhXytMaiAchQ
 vUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mfMVEnm/aU0KnjcFXAGITOcH1QJjm8sg1fO6Hab3Df8=;
 b=UV+lohqAm70bLU80kUGOs0T+X3+yjaR3lQHKSsJ94msnfT1Edq+Xnd3BFOOuON7Lkw
 FPARC41ZzAN8wqr96X4C/HRSyhZP9NTNI2ezmbxzPXqsrlZ4XBnWjuTT3aMP01WgCqKc
 v0+/MhLFLM6rPnhBhCHhF43cQdRfuS7I9g+6irNBXzHwnPHqEGOxrehKEGkBkMA+B3j3
 fc07kAU0LAbFlSAjWuoSDSa5wtoCLb3+KbUdiBdsMHc8O0YiIii70jTWRQfrGtBAw1Wx
 CeG5NXDFxAGQViXZlj+kvC7aXxHtgyOQzZA9N56RZ4KNgZnYtHY4v/3FfIds62RM7acw
 XyEQ==
X-Gm-Message-State: AOAM531paexEpe/q3WuQVkTgUELiGC3v+bMS+c9qJWTSfoVe2dt9/wYu
 g7qutoCjohqThlme3qUmCnR/oxnWud5vFa7FSus=
X-Google-Smtp-Source: ABdhPJzQczKUZYngmeAjx/BRrTpdOHKIVhDSzmatCIhUO4149upLbZm3P17XZQ/FCQg+LEKe8HsJwVI75UcK6TGJ+n4=
X-Received: by 2002:a19:df53:: with SMTP id q19mr3751325lfj.119.1599067795828; 
 Wed, 02 Sep 2020 10:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
 <87zh6848e2.fsf@linaro.org>
In-Reply-To: <87zh6848e2.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 2 Sep 2020 19:29:19 +0200
Message-ID: <CALTWKrUxs-76UeeR1HMXBstuOV2JKY1xNJt8dzLnfNKnqmWCAw@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests/performance: Add nightly tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Mr. Alex,

On Wed, Sep 2, 2020 at 3:26 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > A nightly performance testing system to monitor any change in QEMU
> > performance across seventeen different targets.
> >
> > The system includes eight different benchmarks to provide a variety
> > of testing workloads.
> >
> > dijkstra_double:
> > Find the shortest path between the source node and all other nodes
> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where al=
l nxn
> > distances are double values. The value of n can be specified using
> > the -n flag. The default value is 2000.
> >
> > dijkstra_int32:
> > Find the shortest path between the source node and all other nodes
> > using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where al=
l nxn
> > distances are int32 values. The value of n can be specified using
> > the -n flag. The default value is 2000.
> >
> > matmult_double:
> > Standard matrix multiplication of an n*n matrix of randomly generated
> > double numbers from 0 to 100. The value of n is passed as an argument
> > with the -n flag. The default value is 200.
> >
> > matmult_int32:
> > Standard matrix multiplication of an n*n matrix of randomly generated
> > integer numbers from 0 to 100. The value of n is passed as an
> > argument with the -n flag. The default value is 200.
> >
> > qsort_double:
> > Quick sort of an array of n randomly generated double numbers from 0
> > to 1000. The value of n is passed as an argument with the -n flag.
> > The default value is 300000.
> >
> > qsort_int32:
> > Quick sort of an array of n randomly generated integer numbers from 0
> > to 50000000. The value of n is passed as an argument with the -n
> > flag.The default value is 300000.
> >
> > qsort_string:
> > Quick sort of an array of 10000 randomly generated strings of size 8
> > (including null terminating character). The sort process is repeated
> > n number of times. The value of n is passed as an argument with the
> > -n flag. The default value is 20.
> >
> > search_string:
> > Search for the occurrence of a small string in a much larger random
> > string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repea=
ted n number
> > of times and each time, a different large random string (=E2=80=9Chay=
=E2=80=9D) is
> > generated. The value of n can be specified using the -n flag. The
> > default value is 20.
> >
> > Syntax:
> >     nightly_tests_core.py [-h] [-r REF]
> >     Optional arguments:
> >         -h, --help            Show this help message and exit
> >         -r REF, --reference REF
> >                         Reference QEMU version - Default is v5.1.0
> >     Example of usage:
> >         nightly_tests_core.py -r v5.1.0 2>log.txt
> >
> > The following report includes detailed setup and execution details
> > of the system:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Pe=
rformance-Tests/
> >
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > ---
> >  tests/performance/nightly-tests/README.md     | 243 +++++
> >  .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
> >  .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
> >  .../source/matmult_double/matmult_double.c    | 123 +++
> >  .../source/matmult_int32/matmult_int32.c      | 121 +++
> >  .../source/qsort_double/qsort_double.c        | 104 ++
> >  .../source/qsort_int32/qsort_int32.c          | 103 ++
> >  .../source/qsort_string/qsort_string.c        | 122 +++
> >  .../source/search_string/search_string.c      | 110 +++
> >  .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
> >  .../scripts/run_nightly_tests.py              | 135 +++
> >  .../nightly-tests/scripts/send_email.py       |  56 ++
> >  12 files changed, 2423 insertions(+)
> >  create mode 100644 tests/performance/nightly-tests/README.md
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/d=
ijkstra_double/dijkstra_double.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/d=
ijkstra_int32/dijkstra_int32.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/m=
atmult_double/matmult_double.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/m=
atmult_int32/matmult_int32.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/q=
sort_double/qsort_double.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/q=
sort_int32/qsort_int32.c
> >  create mode 100644 tests/performance/nightly-tests/benchmarks/source/q=
sort_string/qsort_string.c
> >  create mode 100644
> > tests/performance/nightly-tests/benchmarks/source/search_string/search_=
string.c
>

> Perhaps we could compress these paths down to:
>
>   tests/tcg/benchmarks/foo.c
>   tests/tcg/benchmarks/bar.c
>
> and then we can also ensure they are built using the existing TCG tests
> cross compile framework.
>

Can you provide the commands for compiling the benchmarks for the 17 target=
s?

> >  create mode 100755 tests/performance/nightly-tests/scripts/nightly_tes=
ts_core.py
> >  create mode 100755 tests/performance/nightly-tests/scripts/run_nightly=
_tests.py
> >  create mode 100644 tests/performance/nightly-tests/scripts/send_email.=
py
> >
> > diff --git a/tests/performance/nightly-tests/README.md b/tests/performa=
nce/nightly-tests/README.md
> > new file mode 100644
> > index 0000000000..6db3b351b3
> > --- /dev/null
> > +++ b/tests/performance/nightly-tests/README.md
> > @@ -0,0 +1,243 @@
> > +### QEMU Nightly Tests
> > +
> > +**Required settings:**
> > +
> > +Update the `GMAIL_USER` object in `send_email.py` with your credential=
s.
> > +
> > +For more details on how the system works, please check the [eighth
> > report](https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Ni=
ghtly-Performance-Tests/)
> > of the "TCG Continuos Benchmarking" series.
>
> As external URLs are potentially unstable I think we want to distil the
> details into a rst do in docs/devel/

Any advice on converting markdown to rst? Are there any specific rules
that should be followed to write rst documentation for QEMU.

>
> <snip>
>
> --
> Alex Benn=C3=A9e

Best regards,
Ahmed Karaman

