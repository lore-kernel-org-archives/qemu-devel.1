Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1ACC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EF6214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdUpkGON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EF6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJjJ-0007uw-9U
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJiA-0006ve-06
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJi7-0004Bx-VO
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJi7-0004Ao-QA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id a24so2579520pgj.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/k2GsCZzQ/HLGSjagfqlhv8CknJlrxTwfPKVn4jreNI=;
 b=MdUpkGONoAy6d/GUXkktKHW0Nb4EhvVTaV3X8B1jNPWerMRv52SfpWVJgbzapaGD78
 nN4HNMJWP47jiwMEHeBQjMhKtGYl9UcaYrMMQAkpinFRUiJkkNMN8ln3FAc9KKWfGTrk
 kfQVSynOEeyylp4TUd2r7Swg0lCT6AHQ0HYC3aOr84pd8uROJA3cvwgcltJ2gGbYF6jE
 4ui54R3x3xOoSyyv/OByinZGTuhNEMQGHrolVy62S58GA1BUGIvPrNhUhEi/Y/3J8001
 CfkCMla+FUUht5l21LAgqEcI/SynhbRCvSlwE9kz50vF6VATmWVJ/atcuHeVvs+cLV6l
 vpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/k2GsCZzQ/HLGSjagfqlhv8CknJlrxTwfPKVn4jreNI=;
 b=MxeCzYIfWXCvi7giDR70pj9i/ZamBLrIuj3TYUNYsgPDYLHCNginrgzqlXM5Qy6fNL
 qZHMG8Z7u4qhGpbk8SdtasG/i3s+Y1haFPzwj+VjBJJ+42YFPC2pQyyRqYdukePpW/XY
 Tm/CWMVuLN8fp+OQUP8iqZJ7I1Immx7Q8XgO2RCT1PW27Y2i3wSDVrjrohpRSwle2ERO
 3iGUAyyq772dUOy5zHuK8TgsXCyc8+F7vlFGQVNGF6NCpbTVi5t3KFfuRYng4pP5Vrhj
 pW/9bsHA07nX7Rcufhr4j20YmY1aGKbxl0sTCLms29cRoz02BMQfalfrPDmnwG0EGtos
 94/A==
X-Gm-Message-State: APjAAAWhwwPciWrA8WTgzJC0z8gCAA4cLikM9NvQfGyer3on04hcYHqX
 LVD5AZO7oV6t6Jbs8q8QlrbWvQ==
X-Google-Smtp-Source: APXvYqwZcH0sggXzNROoEfg/gjpNgQM4ktvc98KpfcqfrPW66jPZw4eswnETj4IvxRK75P+64wzPkg==
X-Received: by 2002:a63:124a:: with SMTP id 10mr590924pgs.254.1568750665250;
 Tue, 17 Sep 2019 13:04:25 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t11sm2952524pgp.62.2019.09.17.13.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:04:24 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c2f95f42-e58e-287f-6e81-aa8de59a920d@linaro.org>
Date: Tue, 17 Sep 2019 13:04:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v3 12/29] s390x/tcg: MVCS/MVCP: Properly
 wrap the length
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 9:57 AM, David Hildenbrand wrote:
> ... and don't perform any move in case the length is zero.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

