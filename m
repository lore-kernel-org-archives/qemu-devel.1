Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EAC20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVxZbbhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EAC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCiXu-0001Tc-VA
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCiWw-0000bL-IJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCiWv-0002sr-6b
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCiWu-0002pA-S0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:31:04 -0400
Received: by mail-ot1-x344.google.com with SMTP id a6so9651477otb.10
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=if/r4vhAG7a4GtEP5IdX/8TjTnZVSBtb22Vph6IFxds=;
 b=RVxZbbhXqIb/UUD71GKEx0l4ixmcZhVCjXZs9f6Z8Nloai3TcaSitIBzOWGALDXAqV
 Q5ccBG3l6h2/LwLLVNAy0bANYqLrWvM2xD7nrioBAQf0qwD2eEt26P10Muj+eMdjkddV
 31xzu88veHngwrPj08T9MdcihS2RXq6GHRzYzt0y7/8dXzAISxPiYozoA9CIGApleMJY
 vll82BAhe2scJJoG0NbWIvZLpsdthe+bki7TAtF7V3w5x/E4T1UKuJERcfBPrpSDjOa9
 UE5mAIVDw1KxkaMwKB9kOmyPQc4ew3Zs66CEVM5rqstf0Hwv0KS6TPmSd05L39qneuEX
 PRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=if/r4vhAG7a4GtEP5IdX/8TjTnZVSBtb22Vph6IFxds=;
 b=mmKEFCYUgOiL59W56814VrkDF9JVWVj7WRIQnxNk10hsm4yIzH2bp2brcjdZ4j0zGs
 lZL0mWAY79F1i1lvJdwA0T4lvJk0L0uUyZldm+ipVl177BfVDB3rf7l8TNexglwiVCO4
 /pnMJp1sJcampdCW7C1LBh3u935CPOUuL9AHznwKieqEOzP3u7ss2kZpnI0nY+9vAe+Z
 cqvz2XwhQjZx5LTZ+AGeyyGQjy5bzGseTdFBbiUm5nD2pXcNwFofteFxm5+1QvxxPFSD
 +MOBazxHmcYg+4dVdL/N9A/jiusexEYxa5y+/BaDWd+bEt0TfV8s0ulBDhPlB7513TpD
 Yoow==
X-Gm-Message-State: ANhLgQ01GcbjXK/IWSrvQIuqf5RuOw++ojr2lt7DMwcYDr5+Ne+9DJgY
 9yxfFEJFFc93XmlcMMAglS38VXTGTAA0PIkGgfk6NQ==
X-Google-Smtp-Source: ADFU+vu5/FKfSmmbkyhf0WACghwf/J7mf02Wjz4MdB/8YCHIakVrrTagmUpmP6kU+R/3XHbQzNwcls/sF+E1rP1g2UI=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr1574284otm.91.1584099062575; 
 Fri, 13 Mar 2020 04:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313032327.7008-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200313032327.7008-1-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 11:30:51 +0000
Message-ID: <CAFEAcA9mOppVAYgP4LJeuSBgiaYN16H+JHbKr7OTFvjbvD-3wA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 03:23, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> The current code causes clang static code analyzer generate warning:
> hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x0000000f;
>         ^       ~~~~~~~~~~~~~~~~~~
> hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x000000fd;
>         ^       ~~~~~~~~~~~~~~~~~~
>
> According to the definition of the function, the two =E2=80=9Cvalue=E2=80=
=9D assignments
>  should be written to registers.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
>
> v1->v2:
>   The register 'ENET_TGSR' write-1-to-clear timer flag.
>   The register 'ENET_TCSRn' 7bit(TF) write-1-to-clear timer flag.
>
> v2->v3:
>   Optimize code style, based on discussions with Peter.
> ---
>  hw/net/imx_fec.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 6a124a154a..3547975710 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -854,14 +854,17 @@ static void imx_enet_write(IMXFECState *s, uint32_t=
 index, uint32_t value)
>          s->regs[index] =3D value & 0x00007f7f;
>          break;
>      case ENET_TGSR:
> -        /* implement clear timer flag */
> -        value =3D value & 0x0000000f;
> +        /* implement clear timer flag, 0-3 bits W1C, reserved bits write=
 zero */
> +        s->regs[index] &=3D ~(value & 0x0000000f) & 0x0000000f;

I think I must have misunderstood what you were
suggesting in your previous question.
The final & with 0x0000000f here is unnecessary, because
those bits are always 0 in s->regs[index] anyway.

>          break;
>      case ENET_TCSR0:
>      case ENET_TCSR1:
>      case ENET_TCSR2:
>      case ENET_TCSR3:
> -        value =3D value & 0x000000fd;
> +        /* 7 bits W1C, reserved bits write zero */
> +        s->regs[index] &=3D ~(value & 0x00000080) & 0x000000ff;

Similarly here.

> +        s->regs[index] &=3D ~0x0000007d; /* writable fields */
> +        s->regs[index] |=3D (value & 0x0000007d);
>          break;
>      case ENET_TCCR0:
>      case ENET_TCCR1:

Short answer: my recommendation is to use the expressions
I recommended that you use...

thanks
-- PMM

