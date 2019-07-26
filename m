Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C8C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE4022CE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGsCJKMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE4022CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0ZC-00077I-GF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Yq-0006SL-C7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Yp-00026I-A8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:47:04 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0Yo-00024Z-Vj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:47:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id a93so24749287pla.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Wl2fd8LNoOtVLHHwm3Cw6JvAU+/r1OMbSAET3sQlpg=;
 b=JGsCJKMYLFoMirpfC2sTloOeN3k0TG4QTGL7ol0QHNYkF0DEEMtu/fC0upIceTKK6m
 eEfeHwwZwb9BH8YMqz0vvOQth57xKRuDVTdk6cR/EvwrK+Ni2FgfnliUPF/RA5ZhX02q
 mH/GcbLO9EzjqXun+rHwkKw0+Tz746owORQNl8py3QKfbh5nLKJems7uopiLNf1L5ku6
 pc6MnY2Q5qTsW5p/jRdZDeAkConPGel5aC6+RxEDVsrnVX6T7G/AuQShw3URh3fRGtQ7
 lf6YaRb6dQzB2iC5zx7hIaqG9vUj98dDkrU2zCHPmy2RPhMG9YilisATodsUydOyLZAW
 kUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Wl2fd8LNoOtVLHHwm3Cw6JvAU+/r1OMbSAET3sQlpg=;
 b=ArrzIh/cRayCmcNHa2/eNpxbelI+UxJDnKBZp7awlDndmMyOao+U8B1WuKMHs+TJjj
 77Lw9vNvVmYnQBV2BZAPmn+99GbHxYwO3aqi65tKZR1BI10P5FjLCfCL9O4Wj6WjEAlF
 SOAKjiErHeey5/mC70tGZHlvmf/EvxczGPh8X1puwxihjMxwmAFZ+1nUjI/jyMkkAMai
 fyalwRk+3GyQorROr5mrC13UHI0Z6h4qrWvJKHOz/souZxDHcDMtIPn1qQEGTRRfMuEa
 7KmAMjXcuzWi0/zH+dGh4Iq3NOuknkUS9hF7ececTSi8KQLJ5Juwq9pdtGgSftVoCLPT
 wuOw==
X-Gm-Message-State: APjAAAVdfa/Xv5IBXEatj2capawMi2tdSUh7ETaRNHmlaNi4WAzveN5E
 OhxTOpXDPkNWi34oL91cBDvLRw==
X-Google-Smtp-Source: APXvYqyVFMI4IvnFQ5f9RQocCniS99cmGbQTPGhkEo6WzaLH/QMMMhm6dDgs+5z32F0+M461dyFIGA==
X-Received: by 2002:a17:902:8a8a:: with SMTP id
 p10mr98334346plo.88.1564148821743; 
 Fri, 26 Jul 2019 06:47:01 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id x26sm68868804pfq.69.2019.07.26.06.47.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:47:01 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123592639.10426@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1016f328-46bb-f2fd-c7de-964945199b9c@linaro.org>
Date: Fri, 26 Jul 2019 06:46:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123592639.10426@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v5 08/15] exec: Access MemoryRegion with
 MemOp
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

On 7/25/19 11:46 PM, tony.nguyen@bt.com wrote:
> No-op SIZE_MEMOP macro allows us to later easily convert
> memory_region_dispatch_{read|write} paramter "unsigned size" into a
> size+sign+endianness encoded "MemOp op".
> 
> Being a no-op macro, this patch does not introduce any logical change.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  exec.c            |  6 ++++--
>  memory_ldst.inc.c | 18 +++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>          /* I/O case */
> -        r = memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(4), attrs);

MO_32, eventually, as well as

> -        r = memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(8), attrs);

MO_64

> -        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(1), attrs);

MO_8

> -        r = memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
> +        r = memory_region_dispatch_read(mr, addr1, &val, SIZE_MEMOP(2), attrs);

MO_16, and so on.


r~

