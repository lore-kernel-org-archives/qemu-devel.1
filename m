Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B16720672
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzm0Xa7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B16720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBf3-00067K-SN
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iYBcs-0004vH-Oi
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iYBcr-0000MW-J4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:17:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iYBcr-0000JN-A7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:17:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id s5so9316439wrw.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WvkgKLfCm3oyyF/6eWVRcAnvU9WJaNPwvddjPCT4la4=;
 b=vzm0Xa7cydf1lIrU+ou6NsJG/bGBAd8Y3sEQ60d5ixwboPDsgg5kklZhCKgTZRr+ld
 7EVGt/Fkar8DS3iDUAcSAO7N3+Fkjj5eJuWXWE1lcfvB7uKgCwCFim7apMb11PrfZLTC
 qAtcbTVkD38JHcM7Fc8JNOmSqqk12Mk21aGvTfkPFqYZMNTIY9EDfpXtpzbdsXtFpiPq
 3Wy80+m+UP0BdLxYCRIJlC3vG0IkFrV19FZ5Bn5ylkieqllxOFqrvmNPvn+v8tIBpIpF
 q3McRLoywWDkL/7WPwdozAWVRR4uHw5gFC9U+wJCCY/+A6nL+oe3TuuT2VNHXm/7ICZ9
 CLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WvkgKLfCm3oyyF/6eWVRcAnvU9WJaNPwvddjPCT4la4=;
 b=briJ5Xt3Yddzwdw512QXD7aQzn0r9ykLJ8cZNW0ZQUTTz8/ufu6ZODBp7aRPz1tKzM
 AwLFl4bu61T5KoKj4ISB3GqUwy/L0pMUmGURVUZfHSQzDxZ63/rIqsZDAoMbZbswSrhq
 9pwi6htPNJOwAqCAPQXWGG/iLRbEQTiv0RPFo9prOzDzSpMnyT6G7wMWNhSOClmFOm+b
 teIcjslPyaYmEqb0/3M6kuvQStH/0KlRD+s1CAFrk528KoDhA73xr9uag8TmA2lzgdBz
 XaymjTwxdxZ2PoV0WkMp9a76PMOat0xxeG/KSY4CqoJqQmxl8lkgfWC9q1yCsAZRZVJq
 gHlg==
X-Gm-Message-State: APjAAAUsV6ISie21nck4ilQdk7tCIAK7FgD9wMjnvuAcCEEHifhe+z1/
 VuUVxGFy0//s1jISy1MbAhW7ag==
X-Google-Smtp-Source: APXvYqzVHEhABmyalNc3HjsbmGT64hEKZ5wiz27rJOdJmb7xqQ5juGNVQRnlwH+yk1zabw2N5pDqGg==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr17999585wrw.383.1574439459334; 
 Fri, 22 Nov 2019 08:17:39 -0800 (PST)
Received: from [10.0.0.120] (host-87-242-235-70.ppp.onetel.net.uk.
 [87.242.235.70])
 by smtp.gmail.com with ESMTPSA id d13sm179633wrv.88.2019.11.22.08.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 08:17:38 -0800 (PST)
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
To: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20191122135833.28953-1-maz@kernel.org>
 <CAFEAcA-aRwc9bogn-QbT-q5FzkqieYmQOZMr6H=kK5ixMGANMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <12a72593-6634-37a8-366b-56d48cfed9d1@linaro.org>
Date: Fri, 22 Nov 2019 16:17:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aRwc9bogn-QbT-q5FzkqieYmQOZMr6H=kK5ixMGANMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 2:16 PM, Peter Maydell wrote:
> RTH: vaguely wondering if this might be related to the
> bug you ran into trying to test your VHE emulation
> patchset...

Thanks for the thought.  It might be related, but it isn't the final cause:
the inner guest does not yet succeed including this patch.


r~


