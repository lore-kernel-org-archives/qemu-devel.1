Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FBC76194
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB3222CBD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a85Vf/nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB3222CBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0Sh-0005eo-G3
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0SU-00052J-Q7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0ST-0003JH-LH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:40:30 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0ST-0003HJ-CT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:40:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id i70so14076028pgd.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ts3Mb/QRq2ILN8vtchm/lhkfGiLpQyRe8+PoTIb9dQ0=;
 b=a85Vf/nIUsI9sXXDJNG3tcL3bgG3JVY0pJXC1FEc1bRC+MULydSnILIbWvab2csDqO
 eKIDl3vf4E/nD5RaE8ga8DbSkfAxdDi9LpXjnMZDG/5jIHh9aygNhZcFyWRevR7JkLmB
 ZeYvwp0kbBX0htrw2xMKkFv4lJLmVWDXFDV6WaTUmYDntVTwCXfN47XlnmO62S0KOoV9
 K6Zh64/MYMtYwrDTcfBhN00l1dPCPNhu1l/x+uAl4h2GA8tn0qA2Hz7lNaibH3Yi518Y
 Z+bJjTc8BN2oLZduFcA6agwztsCKMX14br+u1f1ipzxM56aOdc1cvQBqeui/PPE7SYrW
 YkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ts3Mb/QRq2ILN8vtchm/lhkfGiLpQyRe8+PoTIb9dQ0=;
 b=UihoWSqHG48mBx1jQueAxC6EmUg7wWLJAvKOTeIFAWMHjU7qvq4A2BKu3b9FHcyve9
 gUoCSkTFu5jFoYwihAuhBj21p27mKM18fH3dnAkYunWRxNG/Y7EEw7BANaMnK/I2fUoT
 6Jp9cR0qOlu9jQKnWyIG4HTzIrvFrOzHQny3H9V9mFA4BmnBmOhRW7ct/5d25bsmk6o5
 paS/xte7gAd+A+S57BDjcrBa0DLjBdlhaUBtzVikr1Ihz8tKxwM919B5qPX2dTPuY3GN
 LqSR9C17t5sNYb/Fo2MiuQ4rIEwvsuItcNEMZmdPlFK3F2EZ3lGpazrTQ03xfqLEbr6i
 P3mA==
X-Gm-Message-State: APjAAAWLUlzz3PiuDHyYweIxI5HQ98OO4LIFpPG0/OL25Z+cAp9XfGl2
 +SrVA2QtL090IPSDy3SvVbr0oQ==
X-Google-Smtp-Source: APXvYqxta0GfTQcJk6xvqb5S/ZAHMt5AoSQnkVau+ys0gr/sc8Zl5dgGAWr1n1WOUtqRS6ScSB+wJw==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id
 n11mr59462892pjp.98.1564148428313; 
 Fri, 26 Jul 2019 06:40:28 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id j5sm64474991pfi.104.2019.07.26.06.40.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:40:27 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123462960.14205@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <164823e2-ae60-e729-84e0-6765b7175cc2@linaro.org>
Date: Fri, 26 Jul 2019 06:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123462960.14205@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v5 03/15] target/mips: Access MemoryRegion
 with MemOp
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

On 7/25/19 11:44 PM, tony.nguyen@bt.com wrote:
>          memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
> -                                    8, MEMTXATTRS_UNSPECIFIED);
> +                                    SIZE_MEMOP(8), MEMTXATTRS_UNSPECIFIED);

As an example of why I'm not especially keen on the temporary incorrect
implementation of size_memop, you'll need a second pass through these files to
replace this with the proper MO_64.

That said,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

