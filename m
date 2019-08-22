Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8639E233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOMdGUAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8639E233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qIW-00087D-Pv
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qH1-0006ik-Fh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0qGu-0005ln-GG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:49:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0qGk-0005aT-OR
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:49:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id b1so6082959otp.6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ne8nOakEzqsAcuexH1JzcTQja3WJVZmL2Sdyx0ScGoo=;
 b=vOMdGUAOGFJ0efbnxRporcfzIs9Xr2hf21Q4iQXUxA6jXzQbyaDqTTq3wiNpsntk22
 F8WbReKex4VLSHCp6gJS6fjafCQbvbcJ39ogV1hcPA7YpuVHwHkZROPguWg6r2cA6vpE
 WUJXe6V4o/4Bazf6OqdjPOBGGPr8a/Nbn5d5qzLQxTwZ44/Z8Kv5+b1OWGOWRenvfIft
 /eKUo3ge4H1KtynO62kjYro0K4NoAphnDkKPzdMJXoUrkjY58r3DBZKo8tH4XtZqhO4C
 MydVuPMlxmyilvNOjhMdPThk861LVUg+6lB5hIkhpIBNEUy7MhrwgV9Wag1Z/l8/GRWb
 MXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ne8nOakEzqsAcuexH1JzcTQja3WJVZmL2Sdyx0ScGoo=;
 b=j+IGvljAibuxZezPbYLo8RHpQpTd7LtFq1vkLgiKiqZGz0plbfNS/068OnMPHUGfmU
 w3V+n6C4q8Z7aPdk664KuBStifv5TFZFl9IEto22xww0XEzAqhBSjqDsc+bg2hIsW16r
 9UNXygxosfy7u0ufIHIKXkUcPqFcooqWO5X+TwtC3daL8kKDS7ukNt3jaOjXV5QnDQNr
 6WUqGu9XdH1ylnz+aOsCD7BU6nJPeavJKcvRH1hpg7ehPDuQb/1wOuY2d3WowRiSJlBu
 QYJ5ngow2Qh5nIzqNHrzh/8Yl/b4JEs8Jaobe4/GjVa7XsHsIcbnUhumjhP/ucpoWE5B
 y+OQ==
X-Gm-Message-State: APjAAAVwYDm8mAuFRROqPGS09p92FkwP+Pq6eXApsouSzvjbD7o7Zv+X
 /Lv0FREGw/pyuyo+hTJhkmECuhkgiByqVGZfsrR0+A==
X-Google-Smtp-Source: APXvYqy8O9GCk/gRleEYtu1t8nFAm75fuo6bJ6Gs3GdkE1VU65MBDMTzFAXqLSxHH0xgey5haInZNsgUGQaIwyf49PU=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr458227oti.91.1566492537665;
 Thu, 22 Aug 2019 09:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181109150710.31085-1-crosa@redhat.com>
 <20181109150710.31085-2-crosa@redhat.com>
In-Reply-To: <20181109150710.31085-2-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 17:48:46 +0100
Message-ID: <CAFEAcA86JT-3jLV=+aqLntoe1jJr77VYvg1dWn9OBVGA6cPZmQ@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
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
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Caio Carrara <ccarrara@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Nov 2018 at 15:09, Cleber Rosa <crosa@redhat.com> wrote:
>
> Some functionality is dependent on the Python version
> detected/configured on configure.  While it's possible to run the
> Python version later and check for the version, doing it once is
> preferable.  Also, it's a relevant information to keep in build logs,
> as the overall behavior of the build can be affected by it.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 74e313a810..67fff0290d 100755
> --- a/configure
> +++ b/configure
> @@ -1740,6 +1740,9 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
>        "Use --python=/path/to/python to specify a supported Python."
>  fi
>
> +# Preserve python version since some functionality is dependent on it
> +python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
> +

Hi. Somebody on IRC has just fallen over a problem where
their python's "-V" output prints multiple lines, which
means that "$python_version" here is multiple lines, which
means that the eventual config-host.mak has invalid syntax
because we assume here:

> @@ -6823,6 +6826,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
>  echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
>  echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
>  echo "PYTHON=$python" >> $config_host_mak
> +echo "PYTHON_VERSION=$python_version" >> $config_host_mak
>  echo "CC=$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
>    echo "IASL=$iasl" >> $config_host_mak

that it's only one line, and will generate bogus makefile
syntax if it's got an embedded newline. (Problem system
seems to be Fedora 29.)

I've reread this thread, where there seems to have been
some discussion about just running Python itself to
get the sys.version value (which is how we check for
"is this python too old" earlier in the configure script).
But I'm not really clear why trying to parse -V output is better:
it's definitely less reliable, as demonstrated by this bug.

Given that the only thing as far as I can tell that we
do with PYTHON_VERSION is use it in tests/Makefile.inc
to suppress a bit of test functionality if we don't have
Python 3, could we stop trying to parse -V output and run
python to print sys.version_info instead, and/or just
have the makefile variable track "is this python 2",
since that's what we really care about and would mean we
don't have to then search the string for "v2"  ?

thanks
-- PMM

