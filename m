Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A2C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6371F2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0Yrwrij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6371F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1dS-0000Fd-JC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1dF-00082T-Tm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1dE-0005lC-R6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:55:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr1dE-0005jb-GB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:55:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id y15so24648993pfn.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Odfgxg7vIXjw/Iv/5NARPcAT/tZ6lO+gPqDya16oOQ4=;
 b=u0YrwrijpB6FA7Cga6XnQQeIHcroFf8ygXeNB02hz9a1VnnMQubvQGMPjObIS7biyN
 69KtH1dqHycTjA4dTcAD8FEy0b5dhVrSLpD29wZ7qB0XyaITpokk2vBEjKV7ePuGPWbw
 wAf9nsZmgH5yhmfZU5K04mkYGJip/ubasv1FPBu6t4ClVTXfE03oNEP6tO/8KPMKunuC
 RZJhT7lwi2b6ogDl+oenX3kKnJakbObLGejqnF5GSaNpFm8G5CVUK2TDX9RR4UVG7sa/
 rv5XaHgyQEcAT/QA5aNkOkmX1eKruqwHyj0Q9LHlEaX5/TcpsGyrjsgmXGtN3ZGwSErk
 cWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Odfgxg7vIXjw/Iv/5NARPcAT/tZ6lO+gPqDya16oOQ4=;
 b=TKkGx9N25xWLrbg5v2oBkAby66R706d/vFg6knKXCdtHDHh8o319G7elk60/ec5Tza
 1sxlDyAdU333egYXaxXBqHopC9+h/823ZlUf1ZKluX/Wj8HPwAQLoBCCCP8pyIANQtcH
 gh8pxlaF+2bvtoQwrFMJ11s7ZuS1VhzNpq8tt+BqDt2kf/4KTFEjoYQMxFdUk/5cZeRo
 TsGQRJhnID/AYRc/3lwotTqI2jnguMJn1Iaq1TVfC8Vb+NZNcCellceCKxD0tp3yaA5h
 eLIHeW90P/6qW+UB/yv9aNa32M24WdjksRkNtvgJFqWqfAeJ066w2loeLty6rC7j7pJK
 KjkA==
X-Gm-Message-State: APjAAAUxaCLguiBHjEZI1P7Ja4TjOJS3n1thKgYhr5Psm+BkVXLs4g0K
 Mr0OJhiiEhsuBzXhMZ7W74j5JA==
X-Google-Smtp-Source: APXvYqxHP3A+az/tb3/Ex2/ugET3pE/toCX8uSZ0qv7LoYoPMUw15icDo/Fh8Ra+2FoGKjMLkB6zHQ==
X-Received: by 2002:a17:90a:9f08:: with SMTP id
 n8mr99311338pjp.102.1564152939279; 
 Fri, 26 Jul 2019 07:55:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id b68sm68532990pfb.149.2019.07.26.07.55.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 07:55:38 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123735589.34363@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1d9a2b2b-625c-f7d6-cf3c-97b5b40d366a@linaro.org>
Date: Fri, 26 Jul 2019 07:55:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123735589.34363@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v5 14/15] target/sparc: Add TLB entry with
 attributes
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 laurent@vivier.eu, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:48 PM, tony.nguyen@bt.com wrote:
> Append MemTxAttrs to interfaces so we can pass along up coming Invert
> Endian TTE bit on SPARC64.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  target/sparc/mmu_helper.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


