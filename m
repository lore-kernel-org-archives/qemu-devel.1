Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E162C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E9420840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAdVQNBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWdM-0007JV-OF
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWck-0006jK-Rd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWck-0001pN-0d
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:14:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWcj-0001nH-QD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:14:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id b16so11004632wrq.9
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BMjgdhiumIy5rKVUS4Xqbw6o0DyVoKuYtZA+uv3TzQs=;
 b=AAdVQNBJh7KsWYz9t07Mgqn8+3p/N6AGgTqGf1Uxbe0F2Pa95EYX0iqcLSto2v9Ew9
 MZKbvCzFi2ycrg1dhjgOnCo1qOAjjdQCcxt6XZOSBmGMVtrFBZf3yi8uWBKwAXQq/9go
 5VQI1VOcrVK+lUgVdgXm8oO03nbrE5EqbBToSB13OKpgIEVCYb52F6XZy4at3mNtHb9+
 BjGWb4H5u7scj/dqBpt67UiqBFZ8VGq2iylZzBQEGa1heqvc5o19yS/g+dMHYSLNls6F
 DimjWqCPYM5foLhyefKG5XXd36Zo79T3mOgdndWgm4KH0Yd167inL3Eni+eDvRUfvaES
 LzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BMjgdhiumIy5rKVUS4Xqbw6o0DyVoKuYtZA+uv3TzQs=;
 b=ri2P2K9pVkIRBUYjB4+SfRoyEj2zEprRM/WuJX0K7zq6eQlO/qtlfBEA+pclnBcmSL
 8AWlklV4luz01QQjri3UijIx/JWBHjACFTngsX2u7B2s4W+IuSmbwru+B+CDjzg1vv4N
 KNekXQoMcrx0QKXvRiu/V424I6S4oXsQeNANOp4navZgZtyG135DFog3zW9JrC//Zj74
 NKwVimD5SgIBavcpi+ygDIRHzuYdtmWlxLlSfcBbx83q2USaBSmYWtQUcwf1UBj6O1r7
 AuwZpeWcF6Gp5fZk/cFhdTVt02Mrd86CLmH23COLfFG33qE7XlljYApgStP7ECC5GaXv
 YRJw==
X-Gm-Message-State: APjAAAWxP5Z/T+YLH+nnqP55wZNBrbok/kMHhaFldkogF3cuAei7HBuF
 T2Wo63I6n5cdVW5TReFnF2AOfw==
X-Google-Smtp-Source: APXvYqxyGdhLrSG3pxHj6G1J5NSi/1al4c6KDDkMRLrf3lih9Lz4mATt5A5jfmwiXcK4CSqrozfu3w==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr45823936wrv.247.1565702040119; 
 Tue, 13 Aug 2019 06:14:00 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id f70sm2083721wme.22.2019.08.13.06.13.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:13:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1dc41b2f-50a4-3d16-f714-5d90eca2d3a5@linaro.org>
Date: Tue, 13 Aug 2019 14:13:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 04/13] fpu: use min/max values from
 stdint.h for integral overflow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> Remove some more use of LIT64 while making the meaning more clear. We
> also avoid the need of casts as the results by definition fit into the
> return type.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


