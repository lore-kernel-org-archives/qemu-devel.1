Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5DCC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4639721743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDqoTqpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639721743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkrB-0005N5-CK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hnkr1-0004yb-FO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hnkr0-00005P-I3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:24:23 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hnkr0-0008W9-7k
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:24:22 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so10925933pff.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rchX0GTC5iLpvxpy7WDPVay6hO/LLhvHka4wOV8cxxc=;
 b=EDqoTqplzVogaCcDa0i7UJyUTv5vso8qDJ7NsRTsEanc5RMvvhogurVbrlH0DeBO4j
 nMhivB4Iz4S+ncw0BDrk+FUUuE4tLPpc9pqd4Jeor+FJ8U8wpbFSdKsbtCXlB4nZzwnn
 KgI7NwKmDmzbuDZ5U3yc5hlqC/MgJ2kFCdSVPsME+IHE8vSTcV3N4jDFWunoOmz8nJE4
 Ss/m5hi2VgKmt0toIKLlwOreZMBFPGOPItHTujFembpqV18dJjV/1xEj2nrRI6TCY7xV
 omkdYhYjG4Idh3J6IO2Ax0VGH4pVPmEAWDoTYdRgseLuiocBiT8RW1mQUm0wyp9bHgJn
 Dm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rchX0GTC5iLpvxpy7WDPVay6hO/LLhvHka4wOV8cxxc=;
 b=cvXeiFIBFzUY2NTIKNtdtyTLx6HnO6shcSmFSUN1kZjcQFtVKzCpnMSVV8vMHOUMy+
 6xId4WYv68UTquJEP+HWZPnzVkGrGLAZ718YbPrGUBZTwtetyCXGbZqLZ2N3T3L5Qkf3
 D6isxRw4shVTRQM2EYt92cTtuyZIc4FQDdgWrTfOnE0rDn2m+kPfbLmWwSAR+Yf/8XDR
 CEZ38fL70A3TBGHzRM8rIFxtL6VEmJ1ftfUvL1BL3+2NjfRA4zcHT0aCwdAGXSkUvQCK
 yX7NVzyMWFOQ9/svQCYSGzBSD1+NjT26OYiXn+ger+FsubN4pgCcl2/gvWmfxTv/l0bC
 gO4g==
X-Gm-Message-State: APjAAAWdJic+l1luePtcasZbP6g/XKzFTwWMFi7NoEe7nI37XrrbGWr7
 LFtGJv9W5cNC1eZ+xyszxaE=
X-Google-Smtp-Source: APXvYqyUVm2AKgr6rcEvWCZV7DI/Ikp1YnyT9NVc/8O02dNy2nGTUUFFn6HEq3Hfish7ZVXaSH3U9Q==
X-Received: by 2002:a17:90a:9905:: with SMTP id
 b5mr45253473pjp.70.1563373460656; 
 Wed, 17 Jul 2019 07:24:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.googlemail.com with ESMTPSA id z19sm20719638pgv.35.2019.07.17.07.24.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 07:24:20 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
 <1563343596429.3033@bt.com>
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
Message-ID: <06dca0ee-a556-d09b-7f13-6938b5a1f74f@twiddle.net>
Date: Wed, 17 Jul 2019 07:24:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563343596429.3033@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 2/4] memory: Single byte swap along the I/O
 path
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

On 7/16/19 11:06 PM, tony.nguyen@bt.com wrote:
> +++ b/include/exec/poison.h
> @@ -38,7 +38,6 @@
>  #pragma GCC poison TARGET_HAS_BFLT
>  #pragma GCC poison TARGET_NAME
>  #pragma GCC poison TARGET_SUPPORTS_MTTCG
> -#pragma GCC poison TARGET_WORDS_BIGENDIAN

You can't do this.  This is here for a very good reason, to avoid letting
target-specific values creep into code that is compiled once, for all targets.

This means that you'll need to either move MO_TE out of memop.h or perhaps
conditionalize it upon NEED_CPU_H.

I would like to see this patch broken up into smaller bits.  Convert one
interface at a time, pushing the use of MemOp further down the stack.  At
present it's hard to review.


r~

