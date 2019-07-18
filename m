Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE4C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88C020873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 14:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5GFIBwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88C020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7W8-0005bl-W6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1ho7Vz-0005Ch-3q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1ho7Vy-0006mC-3m
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:36:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ho7Vx-0006kY-Q6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 10:36:10 -0400
Received: by mail-pg1-x541.google.com with SMTP id f25so12982713pgv.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pazBJgjXtzPJWC58vHDwmasr6Z9pw0bM09rBWrt7Rws=;
 b=D5GFIBwz+oamJ4yXCaJIQ7fEokw3RVFTDzgREILiPp47DDa+A0EYSHFXB/Bzg8AJML
 CEWdV3H/qaZGJMV5AlsjB7ZJsgKNJhR8GoguJPjGj1ZNvgqnaYXs8km7/lM5adHGcTyi
 umJlP/9Q5Sr2kfdoamjB0YpmjDNFVtaXr67QnH/m56CChMtlG01m/uxd33hyhyPxrnzH
 0kixavyo0Rx6E9P0JALULtLbDaXs2NSfKrzbVU0zj6cvJlB9a/gR2ZNLTBTilUDFMGDS
 qZHmW9ZGBXN/k3ZkzglTZUQ+OVrl5tQVohdI7cLdk86Ec48HVbDthN/xe0lhpvbysMu4
 nvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pazBJgjXtzPJWC58vHDwmasr6Z9pw0bM09rBWrt7Rws=;
 b=kZ7DIlN+nxDUSFFPmzedAJPvV4SmGvDgyXzeAar1uH0VD+6js3LxzEVKVXcKc56+Bv
 6ey5iFi892EEui1aGYrzXAxZ2HH7eNZrzGPCLZZ1xeG7pzLJUQGicG3euTieCGOrfLRa
 QVAY4eH9p8m6icieQ9MKjG/T2IZ/XJvTewxLuJ5cdBsmFXUBi6EGqJktZGfCYWnxmN2X
 2MPg4jGPsl4gK/grZH31wkjqcO3YcqxYq8FG1AYmr34fgKd5gUeSJepnjkU2pzvNT4Ey
 o9ZlC3Vb/MMgSHUcAFh5Lr/sZofncl8UIodrORKo/BhLGRjZd6txiDc6VR1KCcc4LWdD
 Gl1g==
X-Gm-Message-State: APjAAAUL1H44VKi7yJ6XkLGZykTvw0qaIw7ZmaBL/rXE1MBDa7qNiBW5
 iZ6LtHHBsJUbZqyEhySVO4Y=
X-Google-Smtp-Source: APXvYqx/5VrQUxvr238FKdbztIoL+eU+2HObm/EMuwWXdd7NisWPqm1nv2MZ+tSGsLfJ4x6+wGqzyg==
X-Received: by 2002:a17:90a:ab0b:: with SMTP id
 m11mr52970329pjq.73.1563460567795; 
 Thu, 18 Jul 2019 07:36:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.googlemail.com with ESMTPSA id t10sm28539635pjr.13.2019.07.18.07.36.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 07:36:07 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
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
Message-ID: <a94b8d32-db37-da72-e7cd-0df267c636d1@twiddle.net>
Date: Thu, 18 Jul 2019 07:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] configure: Define target access alignment
 in configure
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 11:01 PM, tony.nguyen@bt.com wrote:
> This patch moves the define of target access alignment earlier from
> target/foo/cpu.h to configure.
> 
> Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp is now
> accelerator independent MemOp"
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  configure             | 12 ++++++++++--
>  include/exec/poison.h |  1 +
>  include/qom/cpu.h     |  2 +-
>  target/alpha/cpu.h    |  2 --
>  target/hppa/cpu.h     |  1 -
>  target/mips/cpu.h     |  2 --
>  target/sh4/cpu.h      |  2 --
>  target/sparc/cpu.h    |  2 --
>  target/xtensa/cpu.h   |  2 --
>  tcg/tcg.c             |  2 +-
>  tcg/tcg.h             |  8 +++++---
>  11 files changed, 18 insertions(+), 18 deletions(-)

Thanks for this.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

