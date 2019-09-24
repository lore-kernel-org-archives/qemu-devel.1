Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BBCC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5B3207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnJnUGn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtqt-0006A4-5Y
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtOn-0001L8-Rw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtOU-0007Xy-S1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:35:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtOT-0007Pl-NT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:34:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so2044890pgp.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Mx2Mt7lmIhcuMZ+VDzTlGiAmyVtHl6b8+s3UfB4B3KU=;
 b=nnJnUGn3j/n9QZKMDutUp/LmekKj07oe+1A3k172Gyc3c4ppqONJUjJ4tmjSAq1Rif
 VlEknfSlFwKIUma7XSm+GfRE7bQJ8L0YxBZULZaczjvZY5R+zm7AGeeBB2/4XALTPJCj
 qLNrAJ5L/AHu2jeu4E1wIYpNJIpxUBlyasr/yMsvy/KH39zfF9TnDZ004kI0KGnc1y8T
 lts7RqTNscGv/gZy+2/l2V7pu7FmWCtKOWEFiaqKGeu7ADg9xF06BYRGXCNhGHALha6g
 BpeNKYTcxxElalr4hOuVHeTKyUu/Y4qRbad5OqOMOCIxQ0iJclCMBvIn5e3J1+dkOrt1
 cqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mx2Mt7lmIhcuMZ+VDzTlGiAmyVtHl6b8+s3UfB4B3KU=;
 b=FdZaZ96GzSoD8Q/+PBfwvbxvlqgJCN0oec47/23ejmsCJva2IrH8YWVr6NGmi2nN1t
 +pkxfBrfGlWMhdZY91tltaznFibytoyicnDetttskjNe6Qhetd1HdMjJgK9NSXAsalJ3
 n4pu/mLFxLET3CSI6hEgOXlyAc8vDYUsUrPledtc1//CGAwebodJivfpRgMDHbVTlR5D
 MyzG2C1mlhwN1Kj5oocuJDpgYJi9kIjW8miwwAE8PLK7pdEQNFsIwwHUarTOA+xzQysX
 sb2W0W60HqRBPQgbriv67osdwmWUtAB70xHJk1dzIzQYy49p3s+z0+xA2V5KENLyv8aC
 awag==
X-Gm-Message-State: APjAAAUgF3fkmLoSjP4jWSkyB3ViM8tDnezU+osSvZ8ZeXXeaz3nerPd
 EY0jJGye2xoocrsPgMRnjF0ZDQ==
X-Google-Smtp-Source: APXvYqz1winCHrKmKJOKP6E4JnpYEY57xBHTEvJdwKPpBMTiYF04eXYBlX1RrzNqryGji+97NI7B5g==
X-Received: by 2002:a62:115:: with SMTP id 21mr5942476pfb.110.1569360441777;
 Tue, 24 Sep 2019 14:27:21 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id x20sm3360386pfp.120.2019.09.24.14.27.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:27:20 -0700 (PDT)
Subject: Re: [PATCH 2/7] target/ppc: introduce set_dfp{64,128}() helper
 functions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <86712310-a882-11f9-48f4-82730fe4220d@linaro.org>
Date: Tue, 24 Sep 2019 14:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> The existing functions (now incorrectly) assume that the MSB and LSB of DFP
> numbers are stored as consecutive 64-bit words in memory. Instead of accessing
> the DFP numbers directly, introduce set_dfp{64,128}() helper functions to ease
> the switch to the correct representation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 90 ++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 42 deletions(-)
> 
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index 354a4aa877..cb98780d20 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -47,6 +47,17 @@ static void get_dfp128(uint64_t *dst, uint64_t *dfp)
>      dst[1] = dfp[LO_IDX];
>  }
>  
> +static void set_dfp64(uint64_t *dfp, uint64_t *src)
> +{
> +    dfp[0] = src[0];
> +}
> +
> +static void set_dfp128(uint64_t *dfp, uint64_t *src)
> +{
> +    dfp[0] = src[HI_IDX];
> +    dfp[1] = src[LO_IDX];
> +}
...
>      decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.context);\
>      postprocs(&dfp);                   \
>      if (size == 64) {                  \
> -        t[0] = dfp.t64[0];             \
> +        set_dfp64(t, dfp.t64);         \
>      } else if (size == 128) {          \
> -        t[0] = dfp.t64[HI_IDX];        \
> -        t[1] = dfp.t64[LO_IDX];        \
> +        set_dfp128(t, dfp.t64);        \
>      }          

This is perhaps a bit harder to see than the get case, because POSTPROCS is in
the way.

However, we can guess, because postprocs has not been passed GETPC(), that it
cannot longjmp out, and therefore not interfere with writing back of the result
to the register file.  And, as it turns out from inspection, the set of
postprocs also does not modify dfp->t64; only looks at dfp->context.status.

Therefore, as a first step we can move postprocs down, then as a second step
combine the conversion from decNumber (dfp->t) to decimal128, and then into the
register file (t).


r~

