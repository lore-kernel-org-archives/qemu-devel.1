Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3C1C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D772D2063F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 04:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewtpesXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D772D2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxOlD-0005zk-6N
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 00:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOke-0005O9-6e
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxOkc-0002w2-8S
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:49:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxOka-0002uO-7T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 00:49:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id r1so7393919wrl.7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jp1iDXrcUH/g9mTVCnJ5hMhmo0MRClKrMatiX5J4pNI=;
 b=ewtpesXYdzKn77hB+kjC+OoxM9/LHqxUbVHkwF91TuZkLVko4pEUbb3RHLheQRoXTB
 68DbWUqMIxBikuos+2t4CS2uRNOp34ipbxeUQe0Eglo81r3GgAo4P2W/aKtQdPir38qT
 p1RSToi1xCw2NqavAmya+EzNEzA6cZrJqsJ3ds5FI9HkkyLMwfRDIpgnxJvdSHZXuJ+R
 W1hUbO9OExHuZH7V4NwUzqWGWfdywzfLWRFyfzliqUMZTa/w+ZIGsksSXJ0rIEKWAOpO
 J5hQTkCBahUpxjT6dJOgURXNsFIcL+w2Oq6Fx8TZpHU4hxookJSC1zciQEdzM0DF3DX6
 8DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jp1iDXrcUH/g9mTVCnJ5hMhmo0MRClKrMatiX5J4pNI=;
 b=BBcf7KW2ZWLwPaPAPopPJM/wRRUbzEbQqQuwWKG7UH2VyEC1InA5XZwpgo8/GLJK+x
 Odd5VMG5fqVuBnEBlorvS9l1vpwiJ+FOhSsOYSZO8fI5CH6P8b7l9PL5DeBaRJd2uxV7
 7iCQ+2eA26qojCrmP9qZsTlo2zHA3uejdARHxXLUlbminzELOoNgWur4iCBRd7HIaj1V
 Mq/FuupHheEuxm3BYaTbfCOKfFReO48hwfeLJYefFWwaeR0hgx8fyazWhpgjLPrLt2bf
 hct5/uHJPRp5nzrfYXPVRutwU59zdPZ11D2s6iDbeLnVxNt4hpPsl32UtWM/fnVqArwG
 Ofcw==
X-Gm-Message-State: APjAAAVGNw83Qa8bxH+PK4RAVmejJOo2rhwumce5P/bxvdgYvGv5rzd7
 NNJpc7MQxj2mKZZfX4w9AxpumQ==
X-Google-Smtp-Source: APXvYqyyHBnv98a/uI+PGQyJqB5vpAaxj8rRwDBEMg19wIa/GVX+KuF/O+fIbddXYEmfXzqPxNR0hw==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr24337600wrs.56.1565671773882; 
 Mon, 12 Aug 2019 21:49:33 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id e10sm30791648wrn.33.2019.08.12.21.49.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 21:49:33 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-9-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b3d9ff75-f468-df2b-199c-f1b25855a901@linaro.org>
Date: Tue, 13 Aug 2019 05:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-9-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/39] target/i386: make variable b1
 const
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> The variable b1 does not change value once assigned. Make this fact
> explicit by marking it const.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/translate.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


