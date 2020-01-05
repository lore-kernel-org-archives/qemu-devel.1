Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F3C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 20:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235B1207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5HtIB5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235B1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioCO8-0008Gx-9X
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 15:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ioCNS-0007lT-Mp
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 15:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ioCNR-0003E8-Fr
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 15:19:58 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ioCNR-0003CZ-8u
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 15:19:57 -0500
Received: by mail-pj1-x1043.google.com with SMTP id d5so6689239pjz.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yIYOnALLSF247BMbI+crSEdEd6wSywBi/gP5GdLOQjI=;
 b=V5HtIB5xh51u08ZTXrD9or5fcnURxMeZp4xCRYyysEKFPCR1sMusH3iO90lb8IL4Gw
 oO+PZYnRNPsWLBSs9yKRr0jNl+b4B0v3oWB4uqU7tbZnEcS/rkbOGO2WrjMk+g/S5yIG
 BLIVc5crzw/s2ICg7JTreEBMQoAPooqsnd1SkRRW3Cimhqfyq+xGwEe8RLFEarmVYZFS
 +A6bFRDZ6HEUVCZt2g0yluW2EP/eeZYyhEmcmkFNT4z5nxJqPeLrdLYCxWMqXhSjnN2Y
 xFpjlPZ3Q0DhvFBGXB5RDCza/xOd3jvQZB9xAkg4dqsUjxBku+dEam1IYq584SlN4/dW
 SeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yIYOnALLSF247BMbI+crSEdEd6wSywBi/gP5GdLOQjI=;
 b=OzdVJVQWMNILmrAgrpTEfdD9hC7E3CLCj+J87qjOn7wbg0p6ygi7AS0CWjMkActXAm
 MbRIO3NbfGEAa0uC1R1KF/zCWB5RxZU3929gz9IsTHJw5+6yg7e+J4GMWysnwMg6CF9x
 NuXQwobM/QiOfguDk7dc88+DDCwqYizZKuPng2PSzAyjylGaGXayOQPZifNSgS1T7I8h
 j6cIpzKYPXJD04k2hXS+kqpxFwXTcOkwuGTVybazT2oUILnlLD/de57Ubla+QGj5vj4l
 LYdhSs8pnk19qbKlacZV7MZwgmY/EQoSS4Q4hXftfGJ/jCwtYapznpqSdT/uIygKleVD
 Oj8Q==
X-Gm-Message-State: APjAAAVnYWSRAOw4j3kah/3IdAlclnPdPaVkNNO3bwthidF/Sok70mzg
 ZKaMoDCvuQ8VFads0bQloe60KD0fiATygA==
X-Google-Smtp-Source: APXvYqw478Mg3WWkz7/FC3tNCQjwSczCQ6ONmetXv32/2f7Zcxv+6/0Bq1TtSsrimKxR3yVcHAnTNA==
X-Received: by 2002:a17:902:7613:: with SMTP id
 k19mr28559140pll.7.1578255595292; 
 Sun, 05 Jan 2020 12:19:55 -0800 (PST)
Received: from ?IPv6:2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd?
 (2001-44b8-2176-c800-f1c3-9f9c-2e9f-1ebd.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd])
 by smtp.gmail.com with ESMTPSA id g11sm68730787pgd.26.2020.01.05.12.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2020 12:19:54 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <1b1826c3-50e4-2481-56a2-4ebb01e04498@c-sky.com>
 <fe1a210e-e4cf-f62a-a39f-2818358d53c9@linaro.org>
 <ea5d5926-48ba-e204-cad8-7e5260b2e2ee@c-sky.com>
 <9e1c5407-3704-9c34-92d7-fd59e48eb13a@linaro.org>
 <a363cee3-b691-6c6a-3ddf-b0b1773b491b@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bacf00f-d599-8e3e-e649-6e808f932b11@linaro.org>
Date: Mon, 6 Jan 2020 06:19:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a363cee3-b691-6c6a-3ddf-b0b1773b491b@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org,
 Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 6:11 PM, LIU Zhiwei wrote:
> 
> However It's not clear when use tcg_gen_gvec_*_ptr or tcg_gen_gvec_ool. I think
> the meaning of oprsz is the
> the bits of active elements.  Therefore , oprsz is  8 * env->vext.vl in RISC-V
> and it can't be fetched  from
> TB_FLAGS like SVE.
> 
> Probably oprsz field will be not be used in RISC-V vector extension.

Correct.  For those risc-v helpers that are called when VL != VLMAX, you would
ignore the oprsz field and fetch it from env.

It may still be handy to pass in vlmax as maxsz, even if you leave the oprsz
field 0.  You'll find that out as you do the coding, I suppose.


r~

