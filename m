Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AAC04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 06:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29E721019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 06:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYFYb5fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29E721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTh9p-0006RS-CF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 02:24:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTh90-00068m-8K
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTh8z-0002gA-7w
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:24:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTh8z-0002fL-0A
	for qemu-devel@nongnu.org; Thu, 23 May 2019 02:24:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so4816299wrs.5
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=cSM85018cDtKMLGjAp4Nc9LefdwvZOH/Cv5/WDrjvu8=;
	b=IYFYb5fEza955ZxZMLZMvmQKPRtHYLfPGIJqAYBeHtOlSe3f4vPA/tbGQMzzR7YsFG
	HMfMW14dDaKnejEHPlE1mfVzIpmDSH/HGb8k7lEkfHzB1J8WK94azoVmhRTdiz/cHFHD
	2WiDKy30oisUqk8hEr33vDKyytnEx54DP5G1uVswbcQsemanvM1F0KpuNzH/h5xaWmPR
	0Xovf66Zmkmg+hbvhHUttALzUUU4RjLsof/Cn2IPAqTgF628SDC6jyoMLRUdSnO3L3eP
	ML8JTuRV7ZSRMXchmN35JXsRnFztTlgTSqphEbwneg6TUZyiBnjwFGsJpMEWVwsV0L+o
	xZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=cSM85018cDtKMLGjAp4Nc9LefdwvZOH/Cv5/WDrjvu8=;
	b=GbK7rhtRLnkstj622PTz+b1YxBSTPoqZ3bMeVrFR8Y2ssj4YUIN08iIRymjmIeiEN5
	LH5SBaRXQl2X/9EOdqwXWFSQbJR7QQ4S9XUNxf7dfOr97Fu/oC79BlF0lUetQWJDzY/4
	2xMcHcCXsgd0lsPbofJIm55Eh08Z5yk0mHsGWbWqt43EIsz0blMzuEwwoKOjqc+emR+3
	nlRsrAxhNOjx8lirbNUU5AFCOVkvofRtgqrmRVPz/drC3Bwk0MitTbr+ilCwAt3a1maS
	G8FXDVvdpKTQJX1Mc35Qg01V3B7AXLYlJVZ8tbTO/wq1qKlFdywTxF/HQpNdzpODRfc3
	iNBg==
X-Gm-Message-State: APjAAAWqCUcXUuJtVNwcy7WIXsku3BoMrmJvJOCDBkBlZ91uGb23TPrL
	iJI9vhZnLoKjvf+TwRydvAZyiw==
X-Google-Smtp-Source: APXvYqwTK0LCYqf7rLzAMf1ME+/7Aveup1SULZx2g1D5I52mxVE8jyp7P3ZO2JgOpsFjZHXHdzx78Q==
X-Received: by 2002:adf:b456:: with SMTP id v22mr5693899wrd.55.1558592639558; 
	Wed, 22 May 2019 23:23:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id l18sm907129wrh.54.2019.05.22.23.23.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 23:23:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2BB981FF87;
	Thu, 23 May 2019 07:23:58 +0100 (BST)
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <20190523024229.1158-2-richard.henderson@linaro.org>
Date: Thu, 23 May 2019 07:23:58 +0100
Message-ID: <87o93t1yf5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Since v4.0, capstone.h has moved to <capstone/capstone.h>.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/disas/capstone.h | 4 ++++
>  configure                | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index e29068dd97..90631d84a9 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -3,7 +3,11 @@
>
>  #ifdef CONFIG_CAPSTONE
>
> +#ifdef CONFIG_CAPSTONE_CAPSTONE_H
> +#include <capstone/capstone.h>
> +#else
>  #include <capstone.h>
> +#endif
>
>  #else
>
> diff --git a/configure b/configure
> index d2fc346302..eec7f061c3 100755
> --- a/configure
> +++ b/configure
> @@ -5021,6 +5021,9 @@ case "$capstone" in
>    system)
>      QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"
>      LIBS=3D"$($pkg_config --libs capstone) $LIBS"
> +    if check_include capstone/capstone.h; then
> +      capstone_capstone_h=3Dyes
> +    fi
>      ;;
>
>    no)
> @@ -7197,6 +7200,9 @@ if test "$ivshmem" =3D "yes" ; then
>  fi
>  if test "$capstone" !=3D "no" ; then
>    echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
> +  if test "$capstone_capstone_h" !=3D "no" ; then
> +    echo "CONFIG_CAPSTONE_CAPSTONE_H=3Dy" >> $config_host_mak
> +  fi
>  fi
>  if test "$debug_mutex" =3D "yes" ; then
>    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak


--
Alex Benn=C3=A9e

