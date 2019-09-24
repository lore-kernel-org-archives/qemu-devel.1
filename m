Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30895C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0033921841
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjiyck8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0033921841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnuI-0004pA-Ad
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn2J-0007nR-N9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCn2H-00032l-JZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCn2H-00031y-4c
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:47:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id q17so2509909wrx.10
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IRtcHPd8XxGP9F+gG+P5IzGuGOdTl9ePtKc5A0vVr/s=;
 b=vjiyck8TAiFKAwFeA2l2FFLKW1wljDSb5eHdoTbBQFQQc7D7Ljbuldap2yTbuuayi3
 DtemhvK7HT1yNh5MsY5L+uTDVqeLjk3kwlat3sMZ/b++eNbuTRkeW39Q+H44iAflDq8w
 GAYzamBrE4r9SczrLIUDAkSJLJcUS99j8gLhiUANkLSQxON+RaQr3rf2BOPPUWbALsqo
 LW0Qkc53pBwnfUXNz/nudVGP/YWDAJ5Cl7uLGYytwxR8aScSEBqcbpoZRVOZjxqkSmhy
 oPgu7QRaTEC56eLw4tDgRSP4mOq3rKj+1SvWubFM3saPJW5X4nI9kmOJ4O3QKj416lIO
 MCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IRtcHPd8XxGP9F+gG+P5IzGuGOdTl9ePtKc5A0vVr/s=;
 b=MLBhd++IHxHPzHtI6hVZVRTRUkiP2loA37sts/1sg0rpjIowsCCl29Ib4UpZgtyyb3
 lAjibZbUdkPLDd4y4DQGHKFaS9jp6P4sqN4H/lOXJR373UgK9Tmw6IVVw2G66cnBXE7t
 FF8NIGb3/rOe9vX3hYBD5QnsCwI3EtaKv1JMvsxCy1W/nWZe8Q7v9pTsl4EGvyWgdnUR
 y5pxbpFpJ7314Ugrku2hrUNvrSxn+8a6WuQZSG2KU9RhJwAbdJxd5nFzyDT3ySrNsQDI
 UKqaBCdGaQ7acj1+j0b6BOw3w6TxcNRpw6Hx2EUsjs4nDFGae7oieWBKfnm3B+NMzw3o
 z6dQ==
X-Gm-Message-State: APjAAAXfWIzcFq8KOc7l6YMO+5CLKtQ8rWhVkf3MXwBOB0alYwJINwsU
 m1Jc2IkXyfLccrpCxu4EfQWQMA==
X-Google-Smtp-Source: APXvYqwOcwPzTYr7LDbJYQEKSn2G64TtoENhIVlQgVIZSlokoyzQFnZbZxdZqTbC+PPocSCGRLQNIg==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr3240963wrn.16.1569340047826; 
 Tue, 24 Sep 2019 08:47:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm3579636wra.79.2019.09.24.08.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:47:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3AC41FF87;
 Tue, 24 Sep 2019 16:47:26 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 04/16] cputlb: Use optimize_away in load/store_helpers
In-reply-to: <20190923230004.9231-5-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 16:47:26 +0100
Message-ID: <8736glbss1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Increase the current runtime assert to a compile-time assert.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 2222b87764..e529af6d09 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1396,7 +1396,7 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>          res =3D ldq_le_p(haddr);
>          break;
>      default:
> -        g_assert_not_reached();
> +        optimize_away();
>      }
>
>      return res;
> @@ -1680,8 +1680,7 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>          stq_le_p(haddr, val);
>          break;
>      default:
> -        g_assert_not_reached();
> -        break;
> +        optimize_away();
>      }
>  }


--
Alex Benn=C3=A9e

