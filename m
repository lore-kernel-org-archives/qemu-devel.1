Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE5C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 01:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8437B2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 01:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7ah8SRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8437B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcgFN-00051u-KO
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 21:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcgDq-0004VB-9W
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcgDp-0002Hv-EJ
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:14:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcgDp-0002HE-5B
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 21:14:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id s27so4805615pgl.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 18:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4srroAxJ4AboQFFDGMOsahm5ZIDsaet+2ZzAgzYCFcM=;
 b=j7ah8SRH4s5IU7FeoH/OJgg9Z0ezi+MQoQaOXNHsP92ozG4uUfQJtEJ+oTsVMzCAsa
 8564bYQrohiHvK2k11BjspF14e/mOR76lfOKtyQyP9uRWKz05UPmgW+4uZeALd/1wwVq
 nxIBaiveejsgYJlarj5EFG6eBpJYW/Nqn6/VC8Uj6R8RkX2cs3uzfIeKQfC7OAqyjFqj
 hXKoksok7AG3oeMMAmHxtchseK4onW+pL1L+V1xbq9oRF60nS44cY1okijAKrVIpdOVY
 N/eS+Z/VTSHRSyDHQHiUSzMVGoOYKCSdPnUoz2wqlE4FFZqvdPK5ESrVBcae2UbmbatK
 sArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4srroAxJ4AboQFFDGMOsahm5ZIDsaet+2ZzAgzYCFcM=;
 b=jPyAlKZHhQmYyrwEgvwh2jJ1qMEF+oYcTX5Zdn4C6ldUQBYKVF88T5xAxw0UTxRkPB
 66o4DvTzCZ8CHm6iHj2tXAXGrIt/QYH2AS5Ba70D5t+iN2piZFh8Y2pPJH961sHmGDWY
 pOxNowf2/nN9vRcRvLV41Sf3V+xgluLUQVvrjxpXbC6V6hUVW0PkHAOdv7ArpBl4mM/P
 lx9HFW9VXL/tX8cIqMmOWcP35bW6RHDR+yaujUU0nyu7Z+F3JlkqoEUxdZBYbTNe8yLV
 c+1Xu0M9FPhsjljbC0wJ+qELkGVK3dtnuEywf720G1LSKbkMup64QE2Sw/l+UDqdmGMv
 k15w==
X-Gm-Message-State: APjAAAX4sMxswCW4v14KMhnhNjiyp079eF8Wii8GBzGqRIXEgjdYBAqd
 +We42psHEG90VIcK+rvOiWp26A==
X-Google-Smtp-Source: APXvYqx6R0gz+nwWCidvSTr/bVjXGt6zWO8Ip0chH/NfHe6b++EcT2horqwtrUyfepflRARNzcqj/A==
X-Received: by 2002:a62:1ac8:: with SMTP id
 a191mr49545865pfa.164.1560734047423; 
 Sun, 16 Jun 2019 18:14:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 201sm13224484pfz.24.2019.06.16.18.14.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 18:14:06 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190616123751.781-1-mark.cave-ayland@ilande.co.uk>
 <20190616123751.781-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e0c81c84-fb4c-6e0a-9ce2-721c990a309c@linaro.org>
Date: Sun, 16 Jun 2019 18:14:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616123751.781-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 01/15] target/ppc: remove
 getVSR()/putVSR() from fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/19 5:37 AM, Mark Cave-Ayland wrote:
> Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
> registers are in host endian order" functions getVSR() and putVSR() which used
> to convert the VSR registers into host endian order are no longer required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c | 762 +++++++++++++++++++++++-------------------------
>  1 file changed, 366 insertions(+), 396 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

