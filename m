Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA271C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EC7206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H70OHFsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EC7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilOnc-0002kd-LE
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 21:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOmf-0001qr-7O
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOme-0000io-5a
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:58:25 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilOme-0000gm-0G
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:58:24 -0500
Received: by mail-pj1-x1044.google.com with SMTP id l35so6702399pje.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sKTtw6iLCBEzEWlSLDwQfYCTUbvbbN6mdX1NAs6ay7c=;
 b=H70OHFsrftMWCZ+UDyLDurr+aPNwErsai9BBFaX7OZuBVJHeCw+YhsseNa5qig4qul
 My0e593G5MjbbDkLwwQloDRfWc+3JiehgSohGtCNBR2nWZnWxWEaUvecQko5aMs3Yexv
 z2e2Vt4EdGebmCa0BH6ctK9zDDOjbatoG4DD2BLPjhRwauYxM1kr248IeiYMKIyQbObN
 9X4/tP2/XwqCX/a5Ymz65w8CnV4FSGPEXN90wnIsVmf+Bk5b8p/nfazfoMp3Jy41KuwL
 HF2N0pfvX3C0rwWaMZ+/3+37gmORQ1FmcUJRat1GvYV7t+YFh60Yvwdt1aGGTCTj+B43
 MO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sKTtw6iLCBEzEWlSLDwQfYCTUbvbbN6mdX1NAs6ay7c=;
 b=jz9Q6U4SGum798HufFVdAL7YcbIwFmI+7GyJG0k2fsOMp7RER8aXAqw+ZxAY5l1yj5
 GzsEimK+do1M4r+3G7f4M22aCJvGlNYRlVnzOxfi2X6nz1vmHY3tx01FK+I4LjRRKk8s
 RnMeco51P7wxYgEeAOIlp4M/aLauBVmc3aOHp36mjd7Ph1X3y5hEDZdEy9r6uU/D4+Kh
 R+jLYhXphBqxPAZxeVkJTYH2RvUqnWQgLafPpKjJcm65UlMP4mioqYa2etMVVym6f2Fn
 x/UqW9eu9syirxB4TBMmFe2x7z3sifsSwv4pHg8zmvbMUZf29L4j2tzRYOkk6b8tV9qV
 fffQ==
X-Gm-Message-State: APjAAAUlWGyltq8Xx1x7WU461afq7nlvwjUmW/Tfpn56KtcTC06tBA4r
 /ty2mez4KPPUZhinE5saAwsnFA==
X-Google-Smtp-Source: APXvYqwZX7YM1CM5Aw6RCoQfQjKAHAnIC3xDHjYOmV0bqMLkst+9ANruVM+de+7AdO65vBs5ufcyyg==
X-Received: by 2002:a17:90a:aa84:: with SMTP id
 l4mr36952343pjq.143.1577588303071; 
 Sat, 28 Dec 2019 18:58:23 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id x11sm44613813pfn.53.2019.12.28.18.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 18:58:22 -0800 (PST)
Subject: Re: [PATCH v2 3/5] semihosting: add qemu_semihosting_console_inc for
 SYS_READC
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191220132246.6759-1-alex.bennee@linaro.org>
 <20191220132246.6759-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2332616-1bef-fd80-817a-0c9c75f89162@linaro.org>
Date: Sun, 29 Dec 2019 13:58:15 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220132246.6759-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 12:22 AM, Alex Bennée wrote:
> From: Keith Packard <keithp@keithp.com>
> 
> Provides a blocking call to read a character from the console using
> semihosting.chardev, if specified. This takes some careful command
> line options to use stdio successfully as the serial ports, monitor
> and semihost all want to use stdio. Here's a sample set of command
> line options which share stdio between semihost, monitor and serial
> ports:
> 
> 	qemu \
> 	-chardev stdio,mux=on,id=stdio0 \
> 	-serial chardev:stdio0 \
> 	-semihosting-config enable=on,chardev=stdio0 \
> 	-mon chardev=stdio0,mode=readline
> 
> This creates a chardev hooked to stdio and then connects all of the
> subsystems to it. A shorter mechanism would be good to hear about.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> Message-Id: <20191104204230.12249-1-keithp@keithp.com>
> [AJB: fixed up deadlock, minor commit title reword]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Keith Packard <keithp@keithp.com>
> Tested-by: Keith Packard <keithp@keithp.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

