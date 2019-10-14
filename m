Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38120C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0742420854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ealIZ/4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0742420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4BR-0005Hc-UM
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK310-0002wm-Ni
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK30z-0005jm-Mh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK30z-0005jD-GD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:16:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id x127so10658120pfb.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zYdTrapY58oqqXGuUkVy8+IBTHTaOyRrrJOUgmzQnoA=;
 b=ealIZ/4EcOPEtR8Ji56B7oKsTZ7weMBfEkTbkVFTyRISwlay8dEqB/JGjiPu/t5sqi
 MqicKcmeAEZKxKATd//SqnSBRfYjK5RQpFSk6dWsVqiQ3KDSvQ8jyGNyDR02xhMp9UNB
 EHJflzCOqygL9HtpOpUdpKT3CUxqgJczeOARNKvo7w8QGBQ0q9P4cGKL5VuAVphsFpVK
 oaRMozu2v/z4MsECp3rOcKLk8ceaCHjs3tjoFQOqiDmVeJmD74VEXBZO/UEZ8oazZ+cn
 oGkxXHj0jELDOM3CPpL1pwjkTazRK7HES7or22MM+ig9IjMmtYxaIdFA2n6xdM/RWDvt
 y/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zYdTrapY58oqqXGuUkVy8+IBTHTaOyRrrJOUgmzQnoA=;
 b=JmcTVnff8TBUKLpHrU6Ay83OdUOVfB55rgHPdfSZCLwozObQFN0XjEZvLGya/j8qBN
 V+3Wup8Obd23Z+fs8r5q3td9o52Zso8Tn7xWbfBeAsBz6Xqg3Vkm86S3nIq9nP6I8PEe
 3G58qs6BWqTWaxZOQ7MlJmCr+vEN9+le9s++5WXXdY3NVGiGt0Sz69py41hqDpF9S97b
 G6oRoietQWiBSr8arVL42ieAPu81Bud4tnuFuAnuYuiACmiP+EhGNh6b3KMvUiqZtD9y
 m6C0qQ//XfCki/VAYAnhNC0YwagvRIbUr1eLsyvV+FpbtHidTVffxAOmb7e6MUckZfV1
 S8hg==
X-Gm-Message-State: APjAAAXmhbNSx4hUcA4wjt9sYvj/IHDM5lfRCZHhe3Kqd2zU9NVU0nUu
 GjYgidWjYSdn+3bgbXW0Eo5j+w==
X-Google-Smtp-Source: APXvYqxAoIAdBixKQ0AVSqZ2GINpiSuMTab4/7dMMSvrf4yVXlXzy9Mo5U74zduIMhoV639yzxpzGw==
X-Received: by 2002:a62:6411:: with SMTP id y17mr33928537pfb.24.1571069768239; 
 Mon, 14 Oct 2019 09:16:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f62sm22380976pfg.74.2019.10.14.09.16.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:16:07 -0700 (PDT)
Subject: Re: [PATCH v5 41/55] tests/tcg: set QEMU_OPTS for all cris runs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-42-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aeb5b80f-3345-a8f6-b4e7-a2c58d2ab777@linaro.org>
Date: Mon, 14 Oct 2019 09:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-42-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, robert.foley@futurewei.com,
 cota@braap.org, aaron@os.amperecomputing.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> This will important for ensuring the plugin test variants will also
> work.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/cris/Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


