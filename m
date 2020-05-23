Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4412BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13227207F7
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="w6DI2otC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13227207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcXwP-00012X-8C
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXvo-0000ad-FG
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:27:32 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:40135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jcXvn-00082a-PM
 for qemu-devel@nongnu.org; Sat, 23 May 2020 13:27:32 -0400
Received: by mail-qv1-xf43.google.com with SMTP id l3so6238123qvo.7
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3o4dXMdsZyXR91TvmsA5yqVpL3iWAx17rpaSWyqFt/E=;
 b=w6DI2otCG8VCDkzqWG2MXBWfSlg4zHmzcja+QF7TNyKxKwj7/kGpyDJ8YN/KNoLkij
 +hjcM+9NAbZNEAJJOui0IPjbXQMdHxuv72YUmm/L6HWbztiukILHKxf61ecmL3JakFn+
 swYk5eWBV6J7zMh+ugV3gcBO9RQO6FEzIUotGk3rwGmgRGdM2AGUFiWl5SbuqF0VUXwz
 p6YS/wqp+YcxBs99XmaLZFPCXEeEjxIThC44IV1wpSeXd/fGWsn2THzhxmaJ0wMeCaNs
 PJPtYf2BJTTzGdoULZRlftA7jBOBygjqS2fHum8g3vzlDaWqOYSoqs2VYy2Y7Fb5It/H
 y4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3o4dXMdsZyXR91TvmsA5yqVpL3iWAx17rpaSWyqFt/E=;
 b=WGtVCHjq3ZgMrr35NrSLO/7zbZHIm0Wm0N3GP9nMg4KQj7lukcCpDObCmvrfaMHQLi
 nlZFCBZT6lLQ463Hkb2AtD+IAqTW6Jy6eVJTCjrd59PA9QpSMhfqJtp5W4FITbDutMS0
 8637bP5psA1mROZ5Elew9A7TyHXluLg9HsIp5fRsmnngCLAqMQwTwQ74EKvcnM48uPlg
 L4Sp49ZE/8N9mziV8KtMB3E32fnlE9G+Nyik2sE0R8kmAKhxI9ZmmaoEX9CPpnCPLkpJ
 xZiQWFYRAsbafDp0zvWzAskgNoYy8dVE4XkoY/6joqDoD7TDtu8QbxyOpNPt3pwtOODS
 dMhg==
X-Gm-Message-State: AOAM530m8T4CmuXlsVg5tZvMFnzcM6K9DI8p/y9OXz9J6g74rW7wXlB2
 Jse6d9Xsobk4/jK30fVZlznZOw==
X-Google-Smtp-Source: ABdhPJwoKtvx+uZ7NTiMM4QavhRxmnrAmfD77RfrS8v0mwMm7tgMSdiFPe7cV/DMxowBOU05FTtFrQ==
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr8832852qvf.30.1590254850545; 
 Sat, 23 May 2020 10:27:30 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id w21sm11374751qtj.78.2020.05.23.10.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 10:27:29 -0700 (PDT)
Date: Sat, 23 May 2020 13:27:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 12/19] configure: added tsan support for blacklist.
Message-ID: <20200523172729.GD382220@sff>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-13-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160755.886-13-robert.foley@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::f43;
 envelope-from=cota@braap.org; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 12:07:48 -0400, Robert Foley wrote:
> Initially put several files into blacklist that were
> causing the most problems, namely bitops.c and bitmap.c.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  configure                 | 3 ++-
>  tests/tsan/blacklist.tsan | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tsan/blacklist.tsan
> 
> diff --git a/configure b/configure
> index c95c54fb48..8a86a0638d 100755
> --- a/configure
> +++ b/configure
> @@ -6306,7 +6306,8 @@ if test "$have_asan" = "yes"; then
>  fi
>  if test "$have_tsan" = "yes" ; then
>    if test "$have_tsan_iface_fiber" = "yes" ; then
> -    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
> +    QEMU_CFLAGS="-fsanitize=thread -fsanitize-blacklist="\
> +	        "\$(SRC_PATH)/tests/tsan/blacklist.tsan $QEMU_CFLAGS"

I presume the goal here is to fix these races later (my default assumption
is that warnings == races, since most warnings are indeed races). If so,
please consider making the suppression optional (via
"--extra-cflags=-fsanitize-blacklist=path-to-this-file"), since that
way the reports are likely to get more eyeballs.

Thanks,

		E.

