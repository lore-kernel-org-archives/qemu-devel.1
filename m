Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3649B2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro7ILzaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3649B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1hg-0002sZ-E3
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <e.emanuelegiuseppe@gmail.com>) id 1iK1VU-0006lk-0g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <e.emanuelegiuseppe@gmail.com>) id 1iK1VS-0005iN-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:39:31 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1iK1VS-0005hc-H6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:39:30 -0400
Received: by mail-ed1-x541.google.com with SMTP id r16so14991058edq.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VY1YVo6YapHF0KXQfkYVfZV/ppvh2Q0nFPHmUukWvr4=;
 b=ro7ILzaVxepUHajGt7F0RJn/0uq8KWiquVR/kJwH+LLS5iSZPSYYu8fhIDL8xLBJ6X
 i+UK1Y9zf4z8PA5qfkceMdTHSNAqai/nEt3HY39SpCsdrW1g5D7LeDcrTSzW9YrVIdaT
 +pdewE3FM4jg9tglOdly7S1u9IFl4O9vAzq4QT1snF5kSQDRe9+yL9ob0F104Oo6XlrN
 HwTsRuFA3HtTs5yTaTRfTIEnUePox/U25pWUow73x9Qkz7ESvSqNQlEPBrMQ8+E6E70G
 E64ckeooZICyj119bFlSf7rvUkN6rqTlmT4SbQ84k49geFnWvBOQdFHX9Ai1sNL1kRHS
 5a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VY1YVo6YapHF0KXQfkYVfZV/ppvh2Q0nFPHmUukWvr4=;
 b=H0CQukkBYTI7nCAWfh2tPNOZ6aQt+T87xy40qxwWPYH3AvWrSzadmswfVAn+cUEbqZ
 pY1QBlNmJTr/TyxWQGDvOooSeIjSDmyCSNcIvN3YKz1gOfwAwQzolBRZvUWBpa6OXni3
 RXtz1hP/gCE9ImcOmsHyrIZ6ioBwIfNjJCgrHEmacbvH+sL2rEXb7jg9d6dG5HeIz8Sw
 5ECfazhxOWUi8CDlmmu7y/zG9o+kAAAerVCTAsHmJkG1KspkMR8grgDNdxwamkOz13oJ
 KFTEVHfWWlw0ItHKQFbXSITkS4FwlhwY9I6iyjvqFvWb49fIF8aTnn9utGFZBSrQGoud
 /2LQ==
X-Gm-Message-State: APjAAAUCAUnq7FSu7AMWaTLdAE20xYJOa5n1r9wWREL/gyh8ne+Usatq
 NiIiijlCarwD5TCVL0ypLIM=
X-Google-Smtp-Source: APXvYqwVC+I6G5uHRY2bQcfMElzTcjiK5of0zjUpe52Lj21gT+ReWTyN6wOeCWkWLJ1U7aZm29T6Vw==
X-Received: by 2002:a50:d083:: with SMTP id v3mr28117134edd.51.1571063968853; 
 Mon, 14 Oct 2019 07:39:28 -0700 (PDT)
Received: from [192.168.8.101] ([194.230.155.172])
 by smtp.gmail.com with ESMTPSA id 4sm2341229ejm.47.2019.10.14.07.39.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 07:39:28 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] contrib/gitdm: add more entries individuals and
 academics
To: qemu-devel@nongnu.org
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-2-alex.bennee@linaro.org>
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-ID: <a18c0078-dcb2-f55e-55eb-8328bc465bca@gmail.com>
Date: Mon, 14 Oct 2019 16:39:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014135905.24364-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Alex,

I confirm my email address, I worked on qemu during the 2018 Google 
Summer of Code.

Thanks,
Emanuele

On 14/10/2019 15:59, Alex Bennée wrote:
> Again this is guess work based on public websites. Please confirm.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: "Kővágó, Zoltán" <dirty.ice.hu@gmail.com>
> Cc: Li Qiang <liq3ea@gmail.com>
> Cc: Li Qiang <liq3ea@163.com>
> ---
>   contrib/gitdm/group-map-academics   | 3 +++
>   contrib/gitdm/group-map-individuals | 4 ++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
> index 08f9d81d13..5cbb9d84c8 100644
> --- a/contrib/gitdm/group-map-academics
> +++ b/contrib/gitdm/group-map-academics
> @@ -12,3 +12,6 @@ ispras.ru
>   # Columbia University
>   cs.columbia.edu
>   cota@braap.org
> +
> +# University of Paderborn
> +uni-paderborn.de
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
> index 1c84717438..301071b98b 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -14,3 +14,7 @@ noring@nocrew.org
>   samuel.thibault@ens-lyon.org
>   aurelien@aurel32.net
>   balaton@eik.bme.hu
> +e.emanuelegiuseppe@gmail.com
> +dirty.ice.hu@gmail.com
> +liq3ea@163.com
> +liq3ea@gmail.com

