Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2FC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4BD2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8IogMer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4BD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1eY-0003lz-Tx
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1eD-0002FS-E7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr1eC-0007PS-93
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr1eC-0007NR-2H
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:56:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so24640707pfq.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pQDFBSwsYIydUY+TzvjuDb7i3I61Qwr/Ai6uGnN+5dc=;
 b=A8IogMerOKkjEb3ZeQgo0a3/blo1UmoiJ9biLr18rlvMOz737NJ1Dl/IYkEl1xRk8i
 3EHuW3XJ8M8kZgxT+Eiwbt2plfTLsSsf+VL/CA6cbUSLeIGWALdB5AqhJfaOJAfsRjRM
 bdlakpf8wtDXOTvAOXkjtBxMqN+q6kKmqtOpDb5YuUlDoxHmKgrJqOlWrbTqNf1mCNV+
 swIHAjrFhIOIXze2joj0AdtsI8pnaQq3WhXtht/NZK0mIzdcTvUg4rMGuS+h3jBwQJS/
 vkV3iJv7zD3LtbYRkahX+aeifzHCEAvN26C68rpDnUx50uUjpIiBb7rv2X2NOjwJLHMu
 3Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pQDFBSwsYIydUY+TzvjuDb7i3I61Qwr/Ai6uGnN+5dc=;
 b=DkJoblDFPeGAAqLfF1W8FBn2DgR512vvtxN+eXvm3ARZjpaU+hDd0nPxGbAjM7PT+O
 /2lpENGvWEb1QhkFYoJd/vh09rPN/sI+99lw66Xl5OUF8BuQpMoDZi6jrhCacCV+KfuC
 8KGsNSnMXEqj1nU1WS8hBnQOCELwwXRUdZ3uZZz6bjPYnknqIG7kLlzN2FuVDHfYSKSO
 cUFj/i2H8Sza4VR09qwutX8URKgUuBTZQ1ClI6Y9tD0lVdudFeP/DI6TgFGKxHvsB+aF
 /WS8/YKCL6GEHiDV9cDNQL873k0QhS3+F4eg9DYgtiZYTrEeKxLkx2BD5hSWmVhOYPAY
 BRWA==
X-Gm-Message-State: APjAAAUx1TCJbUoWuy4qyPLHlERSOOvksa4rlx7DcJRwQx1b1DSWjjqs
 pbnskmM56RDLA4JXC8+SeiM9nQ==
X-Google-Smtp-Source: APXvYqzwI4dmhyNaKeyCpPYbAalf+lDGTOtqgmfWZCLn1dwG8XS2UvGVZ9DLiv0YnNdX7CARxJSExg==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr23132118pfd.48.1564152999052; 
 Fri, 26 Jul 2019 07:56:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id u1sm50177390pgi.28.2019.07.26.07.56.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 07:56:38 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123758372.45776@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7ab88ef1-55cd-fbe0-e25a-7449b8a3ffc3@linaro.org>
Date: Fri, 26 Jul 2019 07:56:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123758372.45776@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v5 15/15] target/sparc: sun4u Invert Endian
 TTE bit
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

On 7/25/19 11:49 PM, tony.nguyen@bt.com wrote:
> This bit configures endianness of PCI MMIO devices. It is used by
> Solaris and OpenBSD sunhme drivers.
> 
> Tested working on OpenBSD.
> 
> Unfortunately Solaris 10 had a unrelated keyboard issue blocking
> testing... another inch towards Solaris 10 on SPARC64 =)
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  target/sparc/cpu.h        | 2 ++
>  target/sparc/mmu_helper.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

