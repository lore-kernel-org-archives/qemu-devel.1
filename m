Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C98C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B812080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6KupGjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B812080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihe2-00058j-It
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hihU9-0006hn-AX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hihU8-00040t-EZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hihU4-0003vb-Fy
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id u18so3413405wru.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W1e7HCR0URoLDFJvy8osbLidGSYj89/BzJDDHjzWy4g=;
 b=J6KupGjWP/v/dgaLc4CzuYoElYC9K+uVh+0BPrFUT+4t6itQ+tjoPnhNOa6p7O7wGS
 ff8u6YNIXeTMSOfEGvCmFplYyrt/WtEmquJvSyzGeQ40IQIS4fYznZT5xpIsGfoINjD9
 LJjvStIUoTNVWtVK/+FzJ5Zdaqpqh4pFaKm1tSnv2hNWtTKfCKQXo0sis8VmLJWUihRp
 Jfj2cyaXMfxA/52jYikkW0NCwvgsVRJvecAEr0ttg6zwhY6OC31LgXwr9Hj6UDNUtzh7
 blcyfj+PG4AvLmF69OXr7RwMO+5j52BAoHGER2gpoDkgzQIQepdC2X4lDozInDeVqRGx
 rvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W1e7HCR0URoLDFJvy8osbLidGSYj89/BzJDDHjzWy4g=;
 b=Q02GKZxTW8tDq94ndLONQIwHX7en/WxXm5kl0dL53Im5MpXkzRfJVCHMEZ/f0YpcUh
 6gZv7R6cn+hSOMvNjal5rUxSThVhcvPy/OV55r0Zp+RRZIyWakjohb+OxEG76o0JTSth
 B9kflwxCjv0qTWojVOTvZwf3kneOcUm9UmJjMWPvJ8bTqU45oz1x0eOZ8BubHZIhpLQE
 obez2ezhVxUjc44vzfvDbeKFNcOKmXPj5Sik14ELKH7xDJY3JcYtievycDkEooJenlj9
 MYb3UPBNgRvvVB85FguZiy2D7wGhOb/H2ifQDP8CQobP5hhPzXyEwVGKJNY7uGoMg8s2
 tkqg==
X-Gm-Message-State: APjAAAWJFGfC0+D3zaK+2ZGQySpdXnT4HSMzg9HMCVAm98fti4qauB7I
 z8nW92pdx+888G7GzDpHnfUapg==
X-Google-Smtp-Source: APXvYqw1/9I64DtBkDGcaujC9BOTNEjiK5P0hOwsqYz4kJtbSCyxFY16Vie5Wn8+cf+AygV+MHgrHg==
X-Received: by 2002:a5d:60c5:: with SMTP id x5mr16254482wrt.253.1562168865903; 
 Wed, 03 Jul 2019 08:47:45 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id c15sm1490350wrx.65.2019.07.03.08.47.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:47:45 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-4-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4e13bccc-9498-8514-b828-c8d79652bfd6@linaro.org>
Date: Wed, 3 Jul 2019 17:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-4-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 03/14] risugen_x86_emit: add
 module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> +sub parse_emitblock($$)
> +{
> +    my ($rec, $insn) = @_;
> +    my $insnname = $rec->{name};
> +    my $opcode = $insn->{opcode}{value};
> +
> +    $emit_opts = {};
> +
> +    my $emitblock = $rec->{blocks}{"emit"};
> +    if (defined $emitblock) {
> +        eval_with_fields($insnname, $opcode, $rec, "emit", $emitblock);
> +    }

And if !defined?  Silently discard?

Is this just weirdness higher in the risugen stack,
such that this might be called maybe_parse_emitblock?


r~

