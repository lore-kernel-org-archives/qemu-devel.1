Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A2C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E99D218AC
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqMdNEjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilM35-0007PI-E9
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 19:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM2O-0006tl-A4
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM2N-0004ES-9Q
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:02:28 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilM2N-0004AD-2c
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:02:27 -0500
Received: by mail-pl1-x644.google.com with SMTP id x17so13240791pln.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pxNl67Qpqm5vxb3VetFUsObLMqeu5f6wpAPaVrE1TH8=;
 b=mqMdNEjoP+0Anhz0qlmHEV/Qs9qBxYOAIfGrywtG616KdBMh8gtkebKuj/xSX3emUW
 PUE1VJ5xN1VgvfuwbOpshDqkmQgkBOE3rO7MZ+YuBhlDgnGlUCxG4emUJT4tkH3pTLr/
 RT3ZFYsiOukmAZ876aNtPlOmBGrb6u6z+eXqmLUvladAsO0JtkIgdDwcSDJuIN+B1rSL
 rUOHK0q9jOkgzo0PgrflopP0vjLmu2r6/ukn4NimRlxFq2mLH8GMN9tCZbqRjN6tOqlW
 3sV5+o53uGwqkTKCqtaiAfkIpDqy3S1DRjA+kV5gRzWfAYfaoe5I0udv7jW6UyfFHwLc
 R/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pxNl67Qpqm5vxb3VetFUsObLMqeu5f6wpAPaVrE1TH8=;
 b=WI+tuTyuSi4ehUwI4J8+JtTontg5unh5p4oxOY4U8vCVbg2D9APfmz+CJsXS7AIjoe
 NnOg2hl6tMUU4uT838z6hRtSMN24olmenQdAH1tbROtuZZLL3GiH6C7imxjZZ6kfB9bW
 xw/Y5w6FTCKI3m78pKh38ojcm6ZFn1p4ZZogSmvpoYmA4CeP30q74E6XAJZj9YWoyGvN
 +LvSMUhxUYQxTYLNC7UGtu41Qj80uh9b8r+B4Lfnw9lnmczRYXYxivabJzduVz8/eJkp
 WicXyeZhrQqqJw/wOhLvJoNMHGMgHrhL0KkZyLP81S3o9ieGkh2cftsXvL89tOdJ8S60
 17jw==
X-Gm-Message-State: APjAAAVjoGg6wY1I0T6eCQfgvNK4UfgB9+qJPpzFIIQYFNih4n1LCQEh
 Wqi7w3osu/5HmEFpzVsL3HGPXA==
X-Google-Smtp-Source: APXvYqysNW4kPwsFCzcOInsJ6c97atadezUOAi7C26wkzFhiukXsv23O34xXZ5iDfInNlJPkF87KYw==
X-Received: by 2002:a17:902:8d83:: with SMTP id
 v3mr56753344plo.282.1577577746106; 
 Sat, 28 Dec 2019 16:02:26 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id t63sm46123379pfb.70.2019.12.28.16.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 16:02:25 -0800 (PST)
Subject: Re: [PATCH v6 09/11] docs/devel/reset.rst: add doc about Resettable
 interface
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-10-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5dd2b5f-e298-603b-76e9-e4c1570249c5@linaro.org>
Date: Sun, 29 Dec 2019 11:02:18 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-10-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/index.rst |   1 +
>  docs/devel/reset.rst | 289 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 290 insertions(+)
>  create mode 100644 docs/devel/reset.rst

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

