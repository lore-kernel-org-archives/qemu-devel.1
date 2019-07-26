Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC7C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E589222ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GYG7xBhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E589222ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr0Ox-0002vE-5R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37846)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Ok-0002Il-Jq
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr0Oj-0006Ve-Ju
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:36:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr0Oj-0006V3-B2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:36:37 -0400
Received: by mail-pf1-x443.google.com with SMTP id i189so24549248pfg.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=inCfA/W1i3z3z5tOp8rEtDeZ1u+OtDpBt/sTzcc9ZUU=;
 b=GYG7xBhG/I4RR2zG42MXpywdoDx53ynyqL1JtuDsAOvcYsFjW0ciCGc/8HNtxdKHJc
 MvFTv29/LFw7CgRF3/CdkwoFyU2LW4z9jKMcZBag0BAidLEToiMSeX3ZhkPyWufJEnYi
 0f3dUEPwmQdZvLpZe6gsOYYZ997MxDjFt5RR/UgOv6htqm5TBaBcifS+5A5rpi8o+IBM
 dDSYVBBnjYmzNH+acf1LXBQid3TwLc3PwjCUjOux4kwdW7rAsG3G/CQWWYNUY0i4wYKf
 uvxi4Rrl6SEr2usQq0JdK7Ph9/q18pvpaR6MyntolCf7CzmkSgrw+L1bCmyVcmi1B/yZ
 +QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=inCfA/W1i3z3z5tOp8rEtDeZ1u+OtDpBt/sTzcc9ZUU=;
 b=uQQID17bgQE5mNPH0NJnq82neMO6H9tj5pzhg90P1gbwdc/3XoJq4KwVHbHsIBRZS8
 Sb/yE1m7l/CZWbNUAy4T0FGiPYQXIYpodQ4DUFIEHpBF+4YFGlN3slxiItsd1iIrZWb9
 BNYwFHeHwx/MJmvIZb8s+Yy2bUul4gLquQ25Bm4G+T23Jq3KiFv1TM79EMYGrAtB4TM0
 48M9F2qDLygwu9IMs61o6hqEq7Y9hM/qoPcdLTuk7Xyf9TaiqVVJFk+lofndkbSxOEKD
 c63WT04zjhDUeOjgeXNx04lYIdw5kZrTteQQuW4iyqmQ+HfCNZXDR81W1vsoHFjmuPWe
 noKA==
X-Gm-Message-State: APjAAAXdp7TL/ovJpwTCGmNpQZyIyDFcXcmxFSGeSVCfV1cY5uMoFyh9
 KINoI5MWABIhR4dToXyEZJ2CvA==
X-Google-Smtp-Source: APXvYqz2pQfwyUk/V+w0QASq2Z9FQnnKrTTfkiYqUte7wYSGpdOmnUHjsDgR3Hx7Iw88KqSNStpYNQ==
X-Received: by 2002:a63:5459:: with SMTP id e25mr26268824pgm.366.1564148196060; 
 Fri, 26 Jul 2019 06:36:36 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id 67sm14849813pfd.177.2019.07.26.06.36.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 06:36:34 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123434793.89101@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2e89740b-58e7-ed7b-834a-f94fa76f3cd3@linaro.org>
Date: Fri, 26 Jul 2019 06:36:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123434793.89101@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v5 02/15] memory: Access MemoryRegion with
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

On 7/25/19 11:43 PM, tony.nguyen@bt.com wrote:
>  } MemOp;
> 
> +/* No-op while memory_region_dispatch_[read|write] is converted to MemOp */
> +#define MEMOP_SIZE(op)  (op)    /* MemOp to size.  */
> +#define SIZE_MEMOP(ul)  (ul)    /* Size to MemOp.  */
> +

This doesn't thrill me, because for 9 patches these macros don't do what they
say on the tin, but I'll accept it.

I would prefer lower-case and that the real implementation in patch 10 be
inline functions with proper types instead of typeless macros.  In particular,
"unsigned" not "unsigned long" as you imply from "ul" here, since that's what
was used ...

>  MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
>                                          hwaddr addr,
>                                          uint64_t *pval,
> -                                        unsigned size,
> +                                        MemOp op,
>                                          MemTxAttrs attrs);

... here.

With the name case change,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

