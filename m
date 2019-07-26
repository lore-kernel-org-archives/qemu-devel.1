Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F736C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D180722CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXcheX8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D180722CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0VK-0000vN-Rt
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0V6-0000MA-Ky
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0V5-0006vi-LO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0V5-0006uD-8b
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so24819501pgl.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AmS7UDuS3zEcCE4IUO/TDmWCbBzA+qKCEdMP7YkyQYw=;
 b=cXcheX8CHjDS73QfCxqveu+PZaEoxZziSuO7L8ZSY+BUBL9HL+0e8rEixQ2/gaS6H+
 UAVhuzF1bOLgX6fKEl2c3ae3yLXbZWoDIkvKX367vLmjhRq7AboyK2uuEFMzDQfgaWcq
 I5PnWijEVMM/Dh9TKmziKmtXN92X+T8i/nGfh8K8GCXpllbZD4PVykSBXzIzJ9eSTlfm
 ZfCt79n9I7G0Eq55f/TOnSujCiBUhul1/fyHTCYeoNTJB4jf+ph1MsOFW6+Cj9qBlKR1
 vlU/GhNRnpd2NUqQRXcQuEUMxiICXVXxA/Ca9YjtPzb9d+SJ+clmVVj2mT30uacHSuZQ
 jnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AmS7UDuS3zEcCE4IUO/TDmWCbBzA+qKCEdMP7YkyQYw=;
 b=YT95dfkfrClqZ3brSsfiCSw7hx71UwF2xzjb1RmhR8mCllxL4sPi+In8vCMrnQpPbZ
 y8V/OwMfWwVm4AtXH7hsRoXeOCYOtIa4mR9uREaIAzNv1vnYiXodpHhNgWC+D0xjwbea
 /3fw7ygxVIXAlwxJZsvY5hgXq4hEyFRFS8S9bvfSrBrWoY1nbUtE3ZtnrC/HNXKQCoIc
 MTG7YL45dfCO4TOX1bamIFadpAhP98yV/C+xJvNdlmUEgzfC7ChoXRONvNMb4id7lE7E
 ZocZxeAiydkscLncDEpCns9GF+XZL+3TmfGd0pd4IPwu8XwxkWB8yFJFc+xwxR8FkifJ
 vTnw==
X-Gm-Message-State: APjAAAVfq9k0oa9ihzp8yPFiuCsesI/BL1JRYKVwkpId6YcfRVAAsW5k
 4i0VjZHd9aN+d6t5QUO8bAjPWA==
X-Google-Smtp-Source: APXvYqztq+3CG1P5MAxWuPcr8bGAHZPxxab8VSMoYbRu1vN3hBlc2Q5mmd6fTBjrGJj70xR0Y2t9vA==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr48696434pgr.62.1564148590262; 
 Fri, 26 Jul 2019 06:43:10 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id v184sm49410033pgd.34.2019.07.26.06.43.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:43:09 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123519581.61197@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5105ad51-98c5-ec01-b869-c32f69ec0e6f@linaro.org>
Date: Fri, 26 Jul 2019 06:43:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123519581.61197@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v5 05/15] hw/intc/armv7m_nic: Access
 MemoryRegion with MemOp
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

On 7/25/19 11:45 PM, tony.nguyen@bt.com wrote:
> No-op SIZE_MEMOP macro allows us to later easily convert
> memory_region_dispatch_{read|write} paramter "unsigned size" into a
> size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/intc/armv7m_nvic.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

