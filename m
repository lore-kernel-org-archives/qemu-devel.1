Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE25C432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 21:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E77215E5
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 21:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bcy2e/Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E77215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibX5f-00074z-Ix
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 16:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibX4h-0006YG-Kj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibX4g-0000Sp-4y
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:48:15 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibX4e-0000RH-GP
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:48:13 -0500
Received: by mail-pg1-x543.google.com with SMTP id b137so15022856pga.6
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 13:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z1YBpPGsXlTAyNWuYDZ+Qy6PHTfRyN2DEWkmpIOR4Ow=;
 b=Bcy2e/HiWT+2wqaXFfxxYYaVxBA2EmHY8jsQgPFmFL//XHLH9ThifwGEsITZ9BVUiG
 iu6czaR/HUBQutBFTL1euV86TNlRnHrXqiO4nrnbTARcxqjwbEPYtMwBf6P0TyDLgSRR
 9f0bGjCoJIVNya/W/zhGCnDeLuKSbv+LnKIKkEORaQinGbORVTjPG2nn7wp7plhJbkDN
 SLrE3OV8M54wYMjE4H5518yZVAN3e5egIpIEJE0s+/9B2VFI9aQvCs8viz3y1JsdYBV7
 Wet1QRs8f0Fy8qJMQqG121+ANJscNBsXqExB/SyEfCWySaTBFLXyAzn8Z1oLwiIlDXvD
 wT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z1YBpPGsXlTAyNWuYDZ+Qy6PHTfRyN2DEWkmpIOR4Ow=;
 b=VNW34o/pl9K03Bs/3QZBDxS9QkYgWt5DJjJ6QHF12viHQpZj8KkMgrGq+M5Ss/Pyqw
 IXtnMT0pFrkZr2AV62SU4+hxfV0/riMtCYJuBz/iNeo/sWNY20C0S+Xbnuz+mhbTLDaV
 YM9BCWkfIH0GpEBbnYbk2sWp3jh7v1RCf8O1+8bPNZHtQ8r+AA0pH0K3H0Y323jYvwue
 ADmNf63xVvK1U215KSgZ/hyZggIWT3baFYSthF2Vlpu32YW97l2F8RwoysD1HqGJPe83
 lPdW55ii7CYWpr4qqsBpPpO3n8zuW2u/IFKjZLdHvHrcemT4cBQ/YBGwZkP5HIjCFkkT
 3dLw==
X-Gm-Message-State: APjAAAXcEx9R3WBDgQSctrzT7IlvVMwWVDnzDumpk8RHs0MF47NT6+Bq
 d0lHeBqVi1mhDk1LG67d+hLCaQ==
X-Google-Smtp-Source: APXvYqwEC2Xkw7K5SrShv2yNWBnHa5b++VqvZqIE+bGbaeaxWubixqGxAJq8A1K//vqQfSWtuX9ykQ==
X-Received: by 2002:a63:c141:: with SMTP id p1mr2038249pgi.326.1575236891073; 
 Sun, 01 Dec 2019 13:48:11 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a6sm28507568pgg.25.2019.12.01.13.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 13:48:10 -0800 (PST)
Subject: Re: [PATCH] configure: Use lld --image-base for --disable-pie user
 mode binaries
To: Fangrui Song <i@maskray.me>, qemu-devel@nongnu.org
References: <20191116052815.nop3xkmd4umqsdsb@google.com>
 <20191120210200.hvwlfuzo2vy5d5n4@gmail.com>
 <20191127183631.n3kfz7k5szri27b3@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5bf2584-bae2-8dda-a2b2-8930ee17ea86@linaro.org>
Date: Sun, 1 Dec 2019 13:48:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127183631.n3kfz7k5szri27b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 6:36 PM, Fangrui Song wrote:
> On 2019-11-20, Fangrui Song wrote:
>> On 2019-11-15, Fangrui Song wrote:
>>> For lld, --image-base is the preferred way to set the base address.
>>> lld does not actually implement -Ttext-segment, but treats it as an alias for
>>> -Ttext. -Ttext-segment=0x60000000 combined with --no-rosegment can
>>> create a 1.6GB executable.
>>>
>>> Fix the problem by using --image-base for lld. GNU ld and gold will
>>> still get -Ttext-segment. Also delete the ld --verbose fallback introduced
>>> in 2013, which is no longer relevant or correct (the default linker
>>> script has changed).
>>>
>>> Signed-off-by: Fangrui Song <i@maskray.me>
>>> ---
>>> configure | 33 ++++++++++++---------------------
>>> 1 file changed, 12 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index 6099be1d84..2d45af0d09 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -6336,43 +6336,34 @@ fi
>>>
>>> # Probe for the need for relocating the user-only binary.
>>> if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ];
>>> then
>>> -  textseg_addr=
>>> +  image_base=
>>>   case "$cpu" in
>>>     arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
>>> -      # ??? Rationale for choosing this address
>>> -      textseg_addr=0x60000000
>>> +      # An arbitrary address that makes it unlikely to collide with user
>>> +      # programs.

Please don't replace this ??? with an arbitrary rationale, which clearly
doesn't apply to all of these hosts.

>>> +      image_base=0x60000000
>>>       ;;
>>>     mips)
>>>       # A 256M aligned address, high in the address space, with enough
>>>       # room for the code_gen_buffer above it before the stack.

This is the only one with a proper rationale.

That said, I'm not sure that the proper way to handle this issue with lld is to
drop this code entirely.

The best way to handle the underlying issue -- address conflict between
interpreter and guest binary -- is PIE, for which this code is skipped.

After that, we go to some pain to choose a guest_base address that allows the
guest binary to load around the interpreter's reserved addresses.

So what's left that this messing about with link addresses buys us?


r~

