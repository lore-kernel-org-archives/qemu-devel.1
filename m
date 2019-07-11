Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D04C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AC120872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeDPoR/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYqs-0004yc-NG
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYqD-0003y9-DL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYqC-0001CV-BT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:10:29 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYqC-00019p-5s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:10:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so5767403ota.8
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0d2rK15oafNwc5oRkzFFCwRcBXfWOvtrxAQhIFLY6y0=;
 b=HeDPoR/VGiCYnFu8C9jP9hAPFzENa7leJNjtq5EVLiS3QqE6UkJsMio3Sy6OmVBOIL
 m1NVa4anfMQE6InZWsUMOyaWQ+Q1HjBuND1vSRTmaHaSEcTBIq+7GKEPYj8zvXdkcB3G
 LqwzsUNS7kotukoo5U66X3phDaujjR79VB6q9uzONAe4464qLk0VX2DNlQlM2+o0fGuS
 iyQe/FI+8ZL84hKXgRICXDV9JK9UqDPsxZYmL2/+a1v4b+gUnfsftBK5Zf8KqSorIYlD
 IzWMy4wwPgG/drMak5dWA/KdkuIQ+/trXjZIra6LK2swOWn+gfl+NY7IeSS4jzxGDR+I
 Lq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0d2rK15oafNwc5oRkzFFCwRcBXfWOvtrxAQhIFLY6y0=;
 b=DmXNq7c77AJkgeK6ps8s6vojyzXeWMgtR5xVB+zLg+aZzLkpNtOB6kGXGBofW/RW8n
 GIT5/8etqwKi4Ae/t5mAy/0Zkrz7q87WqJHquKg0oUid1pwx5IsK1h+mmX0tTAnCS6PG
 gQdBDOCIYrWUdVNRkN3l+Evl5MQh/AfLmKdorhQ0YhEBvmttE3fAIF5gAJ6L+0d/Oe7L
 TE40AHxzTGLSuZ5by/XFE6L43fk+n+DHlCQLv2Y5qxCeDTXWZpWlCzYQrlq/0GZ0DoMY
 V3eFZv4L8LY1IWOloRIoYJNNWkHomdxxqGL6EX+Rgz/4aI9wDmZSdLUu0zbqcxBSpm4S
 dKbw==
X-Gm-Message-State: APjAAAWB/ynpwK8lFoT4oFv+3WUBaDSFc1OzVJO8BI+hqIPGLGzDKqVJ
 oSOpxWsSus8AuNFCnAIHTlYTFBijiS1+yhA+Fsc9Xg==
X-Google-Smtp-Source: APXvYqxqsFvNFI8kbyfm6sj1Cs0tdgz3YTGtjlyjAWb59VDMAnWkBQiI6RnfQtF8+ViwyuovW2sMwEO8op/jXs3CQnU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3162108otk.221.1562850627308; 
 Thu, 11 Jul 2019 06:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190711130759.27720-1-philmd@redhat.com>
In-Reply-To: <20190711130759.27720-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 14:10:16 +0100
Message-ID: <CAFEAcA9Qtobijxop21kj0x9ZMdC2et339xJpNsHLkPdZbAJxuQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH-for-4.1] hw/block/pflash_cfi02: Explicit
 switch fallthrough for ERASE commands
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 14:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Previous to commit ddb6f2254, the DQ2 bit was incorrectly set
> during PROGRAM command (0xA0). The commit reordered the switch
> cases to only set the DQ2 bit for the ERASE commands using a
> fallthrough, but did not explicit the fallthrough is intentional.
>
> Mark the switch fallthrough with a comment interpretable by C
> preprocessors and static analysis tools.
>
> Reported-by: Coverity (CID 1403012)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 83084b9d72..f68837a449 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -367,6 +367,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
>      case 0x30: /* Sector Erase */
>          /* Toggle bit 2 during erase, but not program. */
>          toggle_dq2(pfl);
> +        /* fall through */
>      case 0xA0: /* Program */
>          /* Toggle bit 6 */
>          toggle_dq6(pfl);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

