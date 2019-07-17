Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B39C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D37B2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4T1bnCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D37B2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkXt-0004BG-I0
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hnkXg-0003dO-8Q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hnkXf-0004MY-8p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:04:24 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hnkXf-0004Ld-1m
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:04:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id 4so5069262pld.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OL5ngl/Sv6DdhHBujaTDK24WU3xlyry3KhV2DP43ni4=;
 b=N4T1bnCrppnsi7nAWMTjlfCCXzebf7XPteiCGMkifWa2O5t5v+5fp2nQJU/rXOSxfh
 wr/MeEDDTp+Sjvr4cTN494y6jxQYP+x1PrQH+Oy7BnhLerz5oDpgZkhd/nVGBCyZxaTv
 eWWCk9DmdnfB1j0u4l+ZRxzWeT3BgOxJhEpV/1qWT5uR9Xb1TNKJNNcFAy4XZfYnWJsJ
 HLGoyj4KybdjFX3cmnRAN0Q97btOIOYS6qaZB7YjcsGMfuTCj2bmusjHl2eYCAMMZRjO
 gNd163I/m4fBdh937OlfW7eqUqqp00u6BU/Td6HsIl5GN7YuzRJX6k2uX6lSCFc4X0Wf
 yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OL5ngl/Sv6DdhHBujaTDK24WU3xlyry3KhV2DP43ni4=;
 b=Trck6pmH0oHcnv6X4FD6hP80Ie4han/Tqq5wiq91dxlbfp4VylkSfUTOptqYRctGov
 22t2BUCEzuplKWoXToxF1uCXtp+oBwPCJFSG/xJkaHsKc3VfukfXOLuYUejU6R5Hw9F3
 bTmNIj3aInf6DfU7g2Q85++k4S8u5dHiMdDTPJ/QohdYjCCZiq/vuCIrrAS77zBqd/zT
 wRlTBKcD2RzTH/YdcGuYYLuTQvdtmARaaLpIloHB/NL6WLZtipdEfM3+sZwHkYtPhlF4
 wj5fh2Qr8gCaeiPuCybblhq/ggqbGFheRcMwxsWIM/bpC7BYR4tnPYKqQ/g/xoJtVqcm
 36Tw==
X-Gm-Message-State: APjAAAUNFhj/oSoni4uj1t3b/M4c17NEa/yOoNnvFkxtcC40XDL4HPUN
 zoCyDCh4qp2X2J8Cv8NpkTU=
X-Google-Smtp-Source: APXvYqzatpkRZNv6roaPtSr73L8JXKV7MkSDhjOV3bxuHBy/IPiHzc+GhotjbrKhP3iHTIf+24uYGw==
X-Received: by 2002:a17:902:124:: with SMTP id
 33mr44289240plb.145.1563372260938; 
 Wed, 17 Jul 2019 07:04:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.googlemail.com with ESMTPSA id a15sm18723314pgw.3.2019.07.17.07.04.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 07:04:19 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
 <1563343465306.78816@bt.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <090594bd-9970-3c07-c859-75e43133dee1@twiddle.net>
Date: Wed, 17 Jul 2019 07:04:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563343465306.78816@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 1/4] tcg: TCGMemOp is now accelerator
 independent MemOp
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 11:04 PM, tony.nguyen@bt.com wrote:
> +    MO_ASHIFT = 4,
> +    MO_AMASK = 7 << MO_ASHIFT,
> +#ifdef ALIGNED_ONLY
> +    MO_ALIGN = 0,
> +    MO_UNALN = MO_AMASK,
> +#else
> +    MO_ALIGN = MO_AMASK,
> +    MO_UNALN = 0,
> +#endif

I'm not sure you can move this portion as-is.

I think ALIGNED_ONLY needs to be moved out of target/foo/cpu.h into configure,
as we do with TARGET_WORDS_BIGENDIAN, so that it's always defined early.  Also,
poison the symbol in include/exec/poison.h.


r~

