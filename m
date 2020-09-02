Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD561C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881E9207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AY+xGheY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881E9207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSn6-0007fA-PQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDSmZ-0007Cw-Sk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:26:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDSmX-0002Kg-Mg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:26:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so5242917wrt.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/YeFWNRQbUCpqTQGdJxEI57fvZ7t0et7Vc8xyAd7HK0=;
 b=AY+xGheY/AIkWEaILuTWsi1u7OkiNzCz4h41bj2g+U0oNh3CZo17YTo8OmmDhVS5wY
 ToNd4zpIYKmmqDgcre6wP+btLNB3x9yoMhKvpmXjYgMponWlnARzi160QbJKGsNKkswj
 O7wJMbuqxYRMwOc100XKMrzIwlYCMVfuyxjXnAYkiY2yCI4+IhfCsZpWoDOpPO0Xq9pV
 81L0p9YvOiiiL8AzHGWhFcaKNPlRXLig1knp4GoTqTK9hn0BPBhiV4zGpDQf/9FNEbpC
 L8gpETsKHijb54gK0jOxjCijrroSVWcRgGiN79/PHDm2XHrlagQ8JkbeogXA7MnI4QhE
 bOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/YeFWNRQbUCpqTQGdJxEI57fvZ7t0et7Vc8xyAd7HK0=;
 b=C9rnQq2z/eMl58ElKB6vCd+5tCsSzQ9JPMTWQ0zQdFzgnP+XmGnAcHb4VdKZ0C49vE
 XKifGWw9RdlyIudulw1F1Dc1xtJvqs7nr1N1r0reQrlSrCOmbG91pmB7qykCQz0wPvxw
 xIdF37UvwGUq9f0LGlg1YrBavfF6yoYg1SpmVOC2Wfk+knV/GsvYnDwN+NIgQEuOsP3I
 GnmaAl0yjhXTqvNoYyl1Gu4Mmx6lhF8f7j/YrEJQDXQqah3cOukF8gdcwd1qLw+ZAiCi
 ZXowalDHrhrVpMSHR+Ev0utMzxRHXxLuDJj4HxZ0Yq7K8HrgIfVz3X0/Ubj0hVACDjqm
 +SJA==
X-Gm-Message-State: AOAM531oyQiNtD0bw8H3Jw9wpT8hRKHq7kf1BWe/Kleo8uM22ubAGEwM
 9Iii054j6u2M8pYyE3BEWYu21w==
X-Google-Smtp-Source: ABdhPJzGDrHNAYk8iE1+2iTMZZdsn43hjNDYVOHNstW1SwTVcGN0a9brz2SsfVY5iJq7Y5BVVXs0ww==
X-Received: by 2002:adf:c108:: with SMTP id r8mr7394003wre.350.1599053191368; 
 Wed, 02 Sep 2020 06:26:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t1sm6105065wmi.16.2020.09.02.06.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 06:26:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 582D31FF7E;
 Wed,  2 Sep 2020 14:26:29 +0100 (BST)
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [PATCH 7/9] tests/performance: Add nightly tests
In-reply-to: <20200828104102.4490-8-ahmedkhaledkaraman@gmail.com>
Date: Wed, 02 Sep 2020 14:26:29 +0100
Message-ID: <87zh6848e2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, philmd@redhat.com, aleksandar.qemu.devel@gmail.com,
 crosa@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> A nightly performance testing system to monitor any change in QEMU
> performance across seventeen different targets.
>
> The system includes eight different benchmarks to provide a variety
> of testing workloads.
>
> dijkstra_double:
> Find the shortest path between the source node and all other nodes
> using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all =
nxn
> distances are double values. The value of n can be specified using
> the -n flag. The default value is 2000.
>
> dijkstra_int32:
> Find the shortest path between the source node and all other nodes
> using Dijkstra=E2=80=99s algorithm. The graph contains n nodes where all =
nxn
> distances are int32 values. The value of n can be specified using
> the -n flag. The default value is 2000.
>
> matmult_double:
> Standard matrix multiplication of an n*n matrix of randomly generated
> double numbers from 0 to 100. The value of n is passed as an argument
> with the -n flag. The default value is 200.
>
> matmult_int32:
> Standard matrix multiplication of an n*n matrix of randomly generated
> integer numbers from 0 to 100. The value of n is passed as an
> argument with the -n flag. The default value is 200.
>
> qsort_double:
> Quick sort of an array of n randomly generated double numbers from 0
> to 1000. The value of n is passed as an argument with the -n flag.
> The default value is 300000.
>
> qsort_int32:
> Quick sort of an array of n randomly generated integer numbers from 0
> to 50000000. The value of n is passed as an argument with the -n
> flag.The default value is 300000.
>
> qsort_string:
> Quick sort of an array of 10000 randomly generated strings of size 8
> (including null terminating character). The sort process is repeated
> n number of times. The value of n is passed as an argument with the
> -n flag. The default value is 20.
>
> search_string:
> Search for the occurrence of a small string in a much larger random
> string (=E2=80=9Cneedle in a hay=E2=80=9D). The search process is repeate=
d n number
> of times and each time, a different large random string (=E2=80=9Chay=E2=
=80=9D) is
> generated. The value of n can be specified using the -n flag. The
> default value is 20.
>
> Syntax:
>     nightly_tests_core.py [-h] [-r REF]
>     Optional arguments:
>         -h, --help            Show this help message and exit
>         -r REF, --reference REF
>                         Reference QEMU version - Default is v5.1.0
>     Example of usage:
>         nightly_tests_core.py -r v5.1.0 2>log.txt
>
> The following report includes detailed setup and execution details
> of the system:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nightly-Perf=
ormance-Tests/
>
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  tests/performance/nightly-tests/README.md     | 243 +++++
>  .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
>  .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
>  .../source/matmult_double/matmult_double.c    | 123 +++
>  .../source/matmult_int32/matmult_int32.c      | 121 +++
>  .../source/qsort_double/qsort_double.c        | 104 ++
>  .../source/qsort_int32/qsort_int32.c          | 103 ++
>  .../source/qsort_string/qsort_string.c        | 122 +++
>  .../source/search_string/search_string.c      | 110 +++
>  .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
>  .../scripts/run_nightly_tests.py              | 135 +++
>  .../nightly-tests/scripts/send_email.py       |  56 ++
>  12 files changed, 2423 insertions(+)
>  create mode 100644 tests/performance/nightly-tests/README.md
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/dij=
kstra_double/dijkstra_double.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/dij=
kstra_int32/dijkstra_int32.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/mat=
mult_double/matmult_double.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/mat=
mult_int32/matmult_int32.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/qso=
rt_double/qsort_double.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/qso=
rt_int32/qsort_int32.c
>  create mode 100644 tests/performance/nightly-tests/benchmarks/source/qso=
rt_string/qsort_string.c
>  create mode 100644
> tests/performance/nightly-tests/benchmarks/source/search_string/search_st=
ring.c

Perhaps we could compress these paths down to:

  tests/tcg/benchmarks/foo.c
  tests/tcg/benchmarks/bar.c

and then we can also ensure they are built using the existing TCG tests
cross compile framework.

>  create mode 100755 tests/performance/nightly-tests/scripts/nightly_tests=
_core.py
>  create mode 100755 tests/performance/nightly-tests/scripts/run_nightly_t=
ests.py
>  create mode 100644 tests/performance/nightly-tests/scripts/send_email.py
>
> diff --git a/tests/performance/nightly-tests/README.md b/tests/performanc=
e/nightly-tests/README.md
> new file mode 100644
> index 0000000000..6db3b351b3
> --- /dev/null
> +++ b/tests/performance/nightly-tests/README.md
> @@ -0,0 +1,243 @@
> +### QEMU Nightly Tests
> +
> +**Required settings:**
> +
> +Update the `GMAIL_USER` object in `send_email.py` with your credentials.
> +
> +For more details on how the system works, please check the [eighth
> report](https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-Nigh=
tly-Performance-Tests/)
> of the "TCG Continuos Benchmarking" series.

As external URLs are potentially unstable I think we want to distil the
details into a rst do in docs/devel/

<snip>

--=20
Alex Benn=C3=A9e

