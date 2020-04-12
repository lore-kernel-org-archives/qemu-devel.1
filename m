Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3121DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 17:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12CC20644
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4yXuxvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12CC20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNgNK-0002U5-27
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 13:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgM9-0001eB-OK
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 13:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgM7-00059y-Ov
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 13:25:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNgM6-00050X-2C
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 13:25:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so7984903wrm.13
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65PbtvtOpV4tzzQsX+AdYODpZANfsP11YbPhiTj711M=;
 b=e4yXuxvu1FqMxzmFaUp7JmCqlqqedXwq019fGkOeN3hxE2rdPVYCd7j7P/HstlfLC8
 5L3CZ6fwgSBhoXU/ELrDM/AkSVf2WdOeJlBMA4WdZOpoRZ6cPaxjztHI8Ft3j1qEGen8
 XO/xGE2KDvfv82ZINbTJx2Zm5pw1PyFVAIv6hmoJZAKKJNlQuwWFbifh9CeByt9bZViQ
 S3RUtAynEJOgFmr9p41G+V1xXNLnt+T+FA/LE5lQk8WHmfW4OAYyX5HD4BWnkCW7jLfg
 Ep5JazyBOp4wWeOHFk2eqgLl0HoOR8iD3FDXYt+woTDqavTWSYd0167mlMkWb0doRiip
 Lkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=65PbtvtOpV4tzzQsX+AdYODpZANfsP11YbPhiTj711M=;
 b=PqBlfGPLQVub26LmgOw7llZMo24zljGI33131ONkR/5HfP20v1z7r0Tc9yghcbap+2
 /LkR1ljmrQZzrF8Gy6w5PFwAvjzdsYQtpdwtbKkSjNQqFKlAU6RN7oe3yHMFD+64Jrx8
 HasejZ9JzFzq8DG92hVD+uxbeHBOBE5wtAMDKCWjFxHkuYeqGd4kSBFyyHqkEqHJszd5
 W2LvEuKRY2Sk9H0JEY84geDgxTmFgMQSkM/0F12aK2FrB7ZBSYn1RGxuXc4/3pptJw3B
 dgx9o6FCx6QSGf8l/zOLBERKixyfsfPr7OhIbLdYjD0Kx+wpq5raAq74YncoiVSbpwhh
 ecdQ==
X-Gm-Message-State: AGi0PuZ87B9zXN7ZPQlVO5gqkrKG7gptHp5KzSxAxBEmMZbhEJSl7X6M
 7XkajF4zzWCR38C0evqNx4Y=
X-Google-Smtp-Source: APiQypKeKwLDb77onxFMO4lnWngOTPlzgMl1hK+Y4r/jRSWMEaQNKuk7LVO09SV1/ahijBBXS24AgA==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr14396429wrs.13.1586712310375; 
 Sun, 12 Apr 2020 10:25:10 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v19sm5799665wra.57.2020.04.12.10.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 10:25:09 -0700 (PDT)
Subject: Re: [PATCH] tcg/mips: mips sync* encode error
To: lixinyu <precinct@mail.ustc.edu.cn>, qemu-devel@nongnu.org
References: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <228a589e-437d-0b6a-3e4b-ab654851d233@amsat.org>
Date: Sun, 12 Apr 2020 19:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: arikalo@wavecomp.com, Pranith Kumar <bobby.prani@gmail.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/11/20 2:46 PM, lixinyu wrote:
> OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and
> OPC_SYNC_RMB have wrong encode. According to the mips manual,
> their encode should be 'OPC_SYNC | 0x?? << 6' rather than
> 'OPC_SYNC | 0x?? << 5'. Wrong encode can lead illegal instruction
> errors. These instructions often appear with multi-threaded
> simulation.
> 

Fixes: 6f0b99104a3

> Signed-off-by: lixinyu <precinct@mail.ustc.edu.cn>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/mips/tcg-target.inc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 1da663ce84..4d32ebc1df 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -404,11 +404,11 @@ typedef enum {
>  
>      /* MIPS r6 introduced names for weaker variants of SYNC.  These are
>         backward compatible to previous architecture revisions.  */
> -    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 5,
> -    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 5,
> -    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 5,
> -    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 5,
> -    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 5,
> +    OPC_SYNC_WMB     = OPC_SYNC | 0x04 << 6,
> +    OPC_SYNC_MB      = OPC_SYNC | 0x10 << 6,
> +    OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 6,
> +    OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 6,
> +    OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 6,
>  
>      /* Aliases for convenience.  */
>      ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
> 

