Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BBC41514
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D7C22CDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8/u+UwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7C22CDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0WB-0004rZ-Bl
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Vq-0003Ud-L4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Vp-0007f3-FZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:58 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0Vp-0007e8-9U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:43:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id p184so24548775pfp.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VErsMOJrJsbZB59YG3aE240P/hZISZ5QmUyEKYzm9ZI=;
 b=e8/u+UwUoAmX3gBOogCXhZTz8MaHjeBjHb0fQCgiBYqHiy3Q+mMRJOFizS1dcZcr4E
 OYHx3yL3jm+F5+gf8SPd0DHCeU9ZxoG6h37ZkSxOy/KekcCQzu3igasGHvzoipIeupDm
 o0AELlmBw/r4197Y0+/kqBFOafcwDsUCoKBRzTOpmu/5MccRjoxwu7roYK4Z70u/aDTm
 u/ReskFJqsMoWNE4v5XDirCcwdUbUqw+wEZQoSoc0x6Il+qF8RhfZCDyVbZ7I+qVZxjJ
 SBvtIe4dkM8GKh7nZuTB4p5mWsXVmVAqWU7FpPG3xaxNpZV3oZtC+HgOwgow+9cju+lt
 /VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VErsMOJrJsbZB59YG3aE240P/hZISZ5QmUyEKYzm9ZI=;
 b=IBoghqmd6ZLv3zlMZuUxBv8qqvFLXN9ApmdWG146TUdz+C5nc89bPKF3ipaDxmKLyi
 XFQ7wxBjV+TjPXOo0B7MbHA2F+XI6jdghMCnY7akCCIFobJd9bkHE5wk9IeqQ8nau7SX
 CaAxA03fdzNg08DGdXXhEcy4m+84PGevvh44USWDxYxVB4ctJkG4kK0NEYFIMI2wOpeg
 RDHkcWmgUb6+2T86lLD9qepEIdk5HIVPsCzuVfKl/9OeLNMhWXTeTmPhHNLKm9IvxJu6
 0ISMIdfWsejAWYt8wWl9rHjmmAn28SSxvvEgnNyDaP65/nzy+CxBYrISZArlvJpQ+kGB
 weZw==
X-Gm-Message-State: APjAAAUZvBbLgKAfeLqtcD+5ZTomzh/dkM/jPbpFVS2mLmpKNxr89+L9
 wvBgJf/jZpECefnqjEi7Yt+PZw==
X-Google-Smtp-Source: APXvYqwB9jpneHQc5pVISeujqRuO8pTvs4lRDNaMfMuWBsuan09I9Z0V9KOFG5r7MMFhHZtiNiAnvw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr21799279pfn.98.1564148636344; 
 Fri, 26 Jul 2019 06:43:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id u134sm51392165pfc.19.2019.07.26.06.43.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:43:55 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123571442.48536@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <055d6faa-fd5d-482c-7356-e48ab40089d3@linaro.org>
Date: Fri, 26 Jul 2019 06:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123571442.48536@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v5 07/15] hw/vfio: Access MemoryRegion with
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
> ---
>  hw/vfio/pci-quirks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

