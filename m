Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54EFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72238208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I09GxQa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72238208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0Lm-0001TQ-Q6
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0Iy-0006Ju-Bi
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0Ix-0006Cl-BD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:40:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0Iw-0005vn-HK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:40:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id v11so6551407pgl.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B2PNLaJMrFX7voo1xwOjbBnoq88bz+0TAGOVJxJO9L4=;
 b=I09GxQa5XJ8j2A4LJFXS+bo6DmCsKlVtRHFxWtlB5FGCFCK3X9Mlrtd1s0+JLQ4Ebp
 qKv/9/eM/VGH+vq10WdRpYUdOuQ9GgK7VWFYlLzSLtnViBoyANCvZG5fDWL6a3mcR/TH
 NNmVJc8K1rN0FYt/n8vIdWLjms07szgdpV+oPXcdQs0KCoG59q2pa1hYvVuitDktUwCk
 WpKMxYEynao7Fn4u85oZ04BDjNOl3g45CXut2wSxKfr1Xg4vPYEdbD+zeKfRPwxPXFCC
 jKhP+RYv7vb3r2AlxOCBmATsYLOm+qZoIPnmf5H/GCLQqVnsfzZ2ErH/vCTswN7KHUMq
 6BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2PNLaJMrFX7voo1xwOjbBnoq88bz+0TAGOVJxJO9L4=;
 b=GDZbjum7+ZX/xvGQGVeWUXQe8wgvROys5PZbVBDjIGHmzJSJFiYPDmZSZtRs6yz2hI
 GPYbdKaHnokL+wFrPkSgfpKvcpxmxJLboSedoiY3iAg0mzgoPuIRclmu1uMtVLGvWfaV
 oc0IjQ8w0nZ5zbKxgpq7bUws7xbaIdQReYgzT3HHwvj6U9Zn0e1aBP6MnHaD9gMN3aYz
 UJQ33AR2utFs8WxyULKsvw4zVtJPSEQUwKf5M0kNATYvfJbz2F0w7aFJiBNcMBC7NR3b
 +ZBDfdp1uzrNi3NzR85a4CWeyhbk8/kRE0drVz+hsU8nIUvLwbxrCTJuOnTS3+8C6MCX
 9syw==
X-Gm-Message-State: APjAAAWexyrORyoOuApe83oy8eaamRIlyLrSQ7x9jBqAfe8YBIJa0uMk
 wNuDTD3rYl2mnQa5DGEjWUnhSw==
X-Google-Smtp-Source: APXvYqwNQmU3+dD5PqtzgvK8Va9ry29OzoIPs0l9wSFiNOJEigg+TET5GbbgrRXecA4kZx4cr4CPsg==
X-Received: by 2002:a17:90a:fa12:: with SMTP id
 cm18mr1471056pjb.137.1560811230647; 
 Mon, 17 Jun 2019 15:40:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id h6sm452919pjs.2.2019.06.17.15.40.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:40:29 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-35-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c2320b93-8622-d835-e03c-5c9fcefe27f7@linaro.org>
Date: Mon, 17 Jun 2019 15:39:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-35-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 34/50] target/sparc: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sparc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


