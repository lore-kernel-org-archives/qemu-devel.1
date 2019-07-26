Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC4C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A8722CC2
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWTsu+jV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A8722CC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0Un-0007QC-0E
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Ub-0006q1-GK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Ua-0006HH-GH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:42:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0Ua-0006Gv-8c
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:42:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so24818886pgl.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zh2aZm5p0BwjIlcTt9PEUjKiq7QQhQfo9/KW4Xdq0VI=;
 b=CWTsu+jVC9jhSW3punasuRaYvEWV5lviiNiVkHgtRd+7WgB5IaQexbNa+NViBhtPxb
 Acsc+PcQ2BLmzPk1WgaDWF4V8AVRAx3tzvxBVWXbvM132I/wMawq3rrV9PM8HZ5aRDBv
 FwXvLxIpDo0GkF43PSm32NNHAA31b+6mBV0x/ALB42Z44qHHFy+tSI4Yn3v1AN86KQC2
 BzKcJJBPcP/XNB90yRclsbtAfmjH1L0/zAkf6YVyLg7Wxw1H4r3FVhWaCP7ndUSnzTwf
 hFQ80fJTb/fhr2D2wIrQ4cSGL9tLihVRMEnKb4VUFQtDIruzZAluvhbi4eVuxgGzOLqu
 PLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zh2aZm5p0BwjIlcTt9PEUjKiq7QQhQfo9/KW4Xdq0VI=;
 b=Gz/jgVjo6l11HtNzr3jWBkfm2oQV6Pb/euBnYlnWRf/f/x5+8qL9WHCeq6OgsGVmBg
 jzBiCfX/Xn9EIdgNcYcr8kp7/QRkMHup35UgnfqhGRBkKRPXdMKX/36BKQZkvaNAIcHu
 d9Y4GfeiEah8VTCz6EbTIvbE1qdP7wclWkyPTnTquaoWogZs8ZCQptd/o0L0eVbIWgM/
 62UI7YGrdsizwmOoCtwSJgYLnhTvxOLDiHNez3t+/3hy4QzPwTZIpV8zxqTN/CyLvHzh
 J83HQMwOXXO/1xb44Cmez50f7seZoor/Q7kXO/Rc2BGvlqq6VEozLrIiP0XDQ5UASvgD
 p2Gw==
X-Gm-Message-State: APjAAAV+AA+OrZP9d5BYyg5QHRkxCshASIIRv+x0HyO8c5UsjYBsbf/k
 yGYuTAnhjj9oaboaYR3No6+Msw==
X-Google-Smtp-Source: APXvYqyqOGVKu9/PuyrTlY21Panci4AfsFPa6xYIzWCdXjrhprr3q9aF+5DwdBN4FLgvofuV9DU4SQ==
X-Received: by 2002:a62:e20b:: with SMTP id a11mr22576753pfi.0.1564148559329; 
 Fri, 26 Jul 2019 06:42:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id q21sm37248736pgb.48.2019.07.26.06.42.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:42:38 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123494194.79744@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fb4ede1d-fded-6d36-3b88-af3aa32647d4@linaro.org>
Date: Fri, 26 Jul 2019 06:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123494194.79744@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v5 04/15] hw/s390x: Access MemoryRegion
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
> No-op SIZE_MEMOP macro allows us to later easily convert
> memory_region_dispatch_{read|write} paramter "unsigned size" into a
> size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/s390x/s390-pci-inst.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>      for (i = 0; i < len / 8; i++) {
>          result = memory_region_dispatch_write(mr, offset + i * 8,
> -                                              ldq_p(buffer + i * 8), 8,
> +                                              ldq_p(buffer + i * 8),
> +                                              SIZE_MEMOP(8),

MO_64, eventually.


r~

