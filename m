Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A704720692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCTIJC8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMXuE-0003SH-Ta
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jMXtc-0002jG-AC
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jMXtb-00065S-Az
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jMXtb-00064y-5e
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:11:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so12123255wrl.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7kbUcMwdULW/E1x4D6HcmHiKt3/9mxxS3vMZPmXveDk=;
 b=gCTIJC8DYeDQa5Eg8V3e12wTBkaYYqWJyh/8kkQreYumjq0tlkiWkdhFKCP7c1V1td
 arEeTc9RDFO4R5Vtlf0UkgwmU+w1UD18Jx3+3La4BggmTC1tM41mVJVHc5/e9nMzVKW+
 rzyJKpW6kXJb5wn81hKcfjiqQNUnVl/pTzg/7xhyiLz9OXpHKmtT8qDvoLE1vs9eXZeI
 k80HUf6nZ0SObrWkl/sqUGAQzG5CV4zUZWuYxsIPXLZEpgkPfEGu2SSFD3pNgC6MetYi
 Ln6+p9Jk5NrdRj/znw39cLPHxbSz90uzuBcB+fB1gj98nu19ujpmRPsDY6P3jdVcEvlc
 EsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7kbUcMwdULW/E1x4D6HcmHiKt3/9mxxS3vMZPmXveDk=;
 b=YUH1JlUCc6WZ5UkZvlvMf5M5NdUAJ9yna1sbfkuMCygZ4QtuyWjYqN6OXA068DybJw
 6Jrap0QpT5k+kCrkUGZr6jnIte7M0GJpDwPbE4AvkDw6hr0KouTqkmP64DauwXjIzsxq
 a2t/P0ixYmF+D2cUcv103+hTYywGl3n71EVAry1kZF9Aa4iWGQShbncjLzDKhQfLJ70q
 paYK+txJS9ldYzW6YONvkaLDv+AoTsOX1ZF1srtVT7TqNq3ww18ocsAliLKczb6t/Ups
 WLg3TgL142cntQJZzzvQRFpIZvfInlu469aW07NyRXsBNNKWUO29a6O4nZF7nXs+s64L
 6sOw==
X-Gm-Message-State: AGi0PuYp8fJ2lWnrFdnip+qasx+Ghz3ApoCT7R8jXX/3ATn/3U0gB2a5
 qpqJyxjeu63VpwL2TUhg8NGdE1ea396jdv1sdVk=
X-Google-Smtp-Source: APiQypLK69XI46ayW2qrt0LgnEqMLx+S3CHi0Sn+iZnBJfRlsDXGeIb9jsuSEK4uV6GASLpFY11P+by4umyJIHeVqGc=
X-Received: by 2002:a05:6000:187:: with SMTP id
 p7mr14122102wrx.196.1586441465791; 
 Thu, 09 Apr 2020 07:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200409134133.11339-1-imammedo@redhat.com>
In-Reply-To: <20200409134133.11339-1-imammedo@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Apr 2020 16:10:53 +0200
Message-ID: <CAJ+F1C+kHYng295fWdKEgqUJ4Zn_ywa8srf3hZGSp+rpDFpFYQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0] vl.c: error out if -mem-path is used together
 with -M memory-backend
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 9, 2020 at 3:41 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> the former is not actually used by explicit backend, so instead of
> silently ignoring the option in non valid context, exit with error.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  softmmu/vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 58a40bcfc1..32c0047889 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4315,6 +4315,11 @@ void qemu_init(int argc, char **argv, char **envp)
>                               "explicitly specified 'memory-backend' prop=
erty");
>                  exit(EXIT_FAILURE);
>          }
> +        if (mem_path) {
> +            error_report("'-mem-path' can't be used together with"
> +                         "'-machine memory-backend'");
> +            exit(EXIT_FAILURE);
> +        }
>          ram_size =3D backend_size;
>      }
>
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

