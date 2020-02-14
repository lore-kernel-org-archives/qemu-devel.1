Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D7BC352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C6820873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6BXlAnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C6820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2OfF-0002ni-4f
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2Oe3-00014T-6s
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2Oe2-0001Cz-7T
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:15:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2Odz-0001AC-TH; Thu, 13 Feb 2020 19:15:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id n10so6983431wrm.1;
 Thu, 13 Feb 2020 16:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yh4qq4z5B0JA7TX6kY9jLzrsvkYEtEYsr8zWc21zEow=;
 b=m6BXlAndPr3wTEXb1rIV7nNWwX6CNKZRoymgiNhPcOCHLbQ3uaj6nnKVE0eN3svlqA
 V4LYI6CshBsB6T14DPcFc9mdG3XQmQwieVXvtc5/O/SVPr9myhCYlcEwd+TKIq6lLxd4
 4qYYXVDhbEKrtCzAFZ2pqTAfbz+t04WZTle+x4oFMG/w/KAekC3mksBhBRNT8/JtcT5Q
 9bawSmCC3BuFxH8J1b+PjYe2/M7z0uhVjH0ddW+3HOcHsYN5/hFpdNXRSAFS7QAgq4kT
 ZWzD1b7sDHzVkq24HT0vhAw6dbpG/Bj/FAGEt511NH2Prf2P+X+b2MYeFS/nHWwd7OrY
 6pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yh4qq4z5B0JA7TX6kY9jLzrsvkYEtEYsr8zWc21zEow=;
 b=ZqRB1kyl6agd6hhjX4h+1fKxKWVqWq7C9+F44eTY0Gqo+wJE1OiUviXI78BleXIeS9
 fy2nZxo2sna/tadV0TFpR73glfyWtcxwO/giBIar7M4sX4CGicp3QxcbWvNAOJgrHqdE
 4xfKEnB7SI6pNh2iyxs3C73Cgq8OcJ4nikVIRvWB6PUxeWKOhYOVR7RWNEgROtY6qwSs
 MffJ8Q5XM0VFvT5QnJGagAS1FbnkhvA12VAifbUe4suhSrzJ2feJ93JsqyB+qolCFnj5
 b4c7XsWAEcrMQOCBPtjbAguf//hA+15m85BFAILfjnvFXWDzZp2lvScY7usdEVShO4Jr
 DHrQ==
X-Gm-Message-State: APjAAAVBz2u8S8VpRDTzrgs+0f0yvQ4V3+iQR5nqXPDDpK43cWElWkiM
 ssNxV4GxATkxiQP2azf/w8+kpxaZD/s=
X-Google-Smtp-Source: APXvYqw84aiahrpqFPGetNeWUmZz9Vttj1SsYE+nHTu7CqY2V2Pes6aLHid95hhE+WLamApffU4hcw==
X-Received: by 2002:a5d:61d1:: with SMTP id q17mr112192wrv.156.1581639342803; 
 Thu, 13 Feb 2020 16:15:42 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm4770706wrv.78.2020.02.13.16.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 16:15:41 -0800 (PST)
Subject: Re: [PATCH] target/ppc: Fix typo in comments
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20200214000143.6D67F747DCF@zero.eik.bme.hu>
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
Message-ID: <dff2a0eb-3dcf-eab9-ea6f-f8a6f3022ec5@amsat.org>
Date: Fri, 14 Feb 2020 01:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214000143.6D67F747DCF@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 12:57 AM, BALATON Zoltan wrote:
> "Deferred" was misspelled as "differed" in some comments, correct this
> typo,
> 

Fixes: 7c58044c
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/fpu_helper.c            | 2 +-
>  target/ppc/translate/fp-impl.inc.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index dc383242f7..5182764df3 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -293,7 +293,7 @@ static void float_invalid_op_vxvc(CPUPPCState *env, bool set_fpcc,
>          env->error_code = POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
>          /* Update the floating-point enabled exception summary */
>          env->fpscr |= FP_FEX;
> -        /* Exception is differed */
> +        /* Exception is deferred */
>      }
>  }
>  
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
> index d8e27bf4d5..9f7868ee28 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -781,7 +781,7 @@ static void gen_mtfsb1(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>  }
>  
> @@ -817,7 +817,7 @@ static void gen_mtfsf(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>      tcg_temp_free_i64(t1);
>  }
> @@ -850,7 +850,7 @@ static void gen_mtfsfi(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>  }
>  
> 

