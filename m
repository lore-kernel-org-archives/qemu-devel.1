Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF25C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3142089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ww6Jo+d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3142089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNYp-0002hI-Ct
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCNNa-0003Qa-4v
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCNNY-00038q-Tu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:23:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCNNY-00038X-Ob
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:23:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id 21so11847927otj.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=urlOqGf19tZHHy0Qjq++AtBU+IqZo0KLvFBHIIF6J1M=;
 b=ww6Jo+d+HaFs0E53DrX65hMsfsxxeMvu45lb7/WdioG1RY4Fi4JJ7YdVCKPYb3aKpZ
 xR1g7cuF3Q+4R7vtQVX9N7fXii6XPFm5K77vM0FZrbktoYxoc+DyoJauYWmE3FaIm6eP
 +e5icFtXRzKhkGJl7HP8JU2oAyxZE/aiy9aZcBj6y5JXxSLvMYnL0qaJ12MXyM7+TLFQ
 +ffno8B4JLIXQ4hS0PUGcuNv56+4sBwbqUtpDtHf5llsPufZEd7zMwMejur0cxAIr1Bh
 WFxNiMwE7Y8vPurTUzCn1T1iMYWgS8Fuhl8wR7AmRrljTBFx3jwwjNdgx8sgKCYgT6su
 F0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=urlOqGf19tZHHy0Qjq++AtBU+IqZo0KLvFBHIIF6J1M=;
 b=lA6rNaktxMbYC7EYI3mKO1LBY1PmPL6d04HeOBQWatL4XSYCfHlSn80SgckW7kPHmU
 9yCI9Y2O3EXtfIiMxTXLNkfKj96X7moryrOMWpVxVfwQ81ANR5cGuszKZQtsfoLdVZ5k
 3ZqyUPHOorszSZbcZSn7ZifyRwYTpOObGEM9+FSChHDitq7cCxsOo8Ty0zzopkz60vCc
 86RCC25S5uAJdavdhwU+Tiy1Co1NLvt9q//hw9dDQXUA3H5s2f6GUiqeG5A3V+BtT2R0
 jAA1iDSnZl9H6/73NDGwqsbxoqNme5NacxB/rCqqZaghJeqd9rXnRPjuzPondA1Tyesl
 Hs1A==
X-Gm-Message-State: APjAAAX4yztrKq+vIvWKCCfvp6REKxiEp2GIG29Kyj7630/9HmdCeIsA
 WNBOB8yRGkxtzqfJa3OTKPrfckONJUuSq5zNd7EEyF2bPXg=
X-Google-Smtp-Source: APXvYqy15j0sB6LR4FvCLmdIUl2D7xFMEPhKFgJUkq+p/AVyN8DQ0BNVivV1Y0LHo8MmHLP6BkVWVCyMyCm8FfKpFW8=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr3755656otq.91.1569241423967; 
 Mon, 23 Sep 2019 05:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190923121712.22971-1-thuth@redhat.com>
In-Reply-To: <20190923121712.22971-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 13:23:33 +0100
Message-ID: <CAFEAcA9jOD_mFOeVaAo5qsoj-Q0-U5qF8c85Am4ObgSn3b6irg@mail.gmail.com>
Subject: Re: [PATCH] Disallow colons in the parameter of "-accel"
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 13:21, Thomas Huth <thuth@redhat.com> wrote:
>
> Everybody who used something like "-machine accel=kvm:tcg" in the past
> might be tempted to specify a similar list with the -accel parameter,
> too, for example "-accel kvm:tcg". However, this is not how this
> options is thought to be used, since each "-accel" should only take care
> of one specific accelerator.
>
> In the long run, we really should rework the "-accel" code completely,
> so that it does not set "-machine accel=..." anymore internally, but
> is completely independent from "-machine". For the short run, let's
> make sure that users cannot use "-accel xyz:tcg", so that we avoid
> that we have to deal with such cases in the wild later.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..68f47a9c25 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3554,6 +3554,11 @@ int main(int argc, char **argv, char **envp)
>                      g_slist_free(accel_list);
>                      exit(0);
>                  }
> +                if (optarg && strchr(optarg, ':')) {
> +                    error_report("Don't use ':' with -accel, "
> +                                 "use -M accel=... in this case instead");
> +                    exit(1);
> +                }

This seems pretty ugly. If -accel is the way we're recommending
users configure the accelerator then it should support syntax
for specifying everything we could do with the old -machine...
option. If it can't do that yet, we shouldn't switch over to it
until it can.

thanks
-- PMM

