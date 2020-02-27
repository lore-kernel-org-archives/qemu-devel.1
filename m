Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98023C52D5D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664DD24656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4V2R98F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664DD24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jh1-0007p8-KQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Jg2-0007MO-Oq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Jg1-0006uP-RV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:58:10 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Jg1-0006tn-LU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:58:09 -0500
Received: by mail-pf1-x443.google.com with SMTP id y5so1679793pfb.11
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6bTgmZs4+0yKu7QhFYSn6OguxtaGnMvy0J2gOiPho4U=;
 b=b4V2R98FHSfZ75vpAlyYlJkPxQc02Zj+Zr+V/cYNAyVfB4O/OTGZtoewTgtIRE27qU
 0R6e1myGUy4FBsakGqO5G+pwZh2gBVi55zuZvMtaqml9eKDqG07oGmtZJ/yWsLJdmfv7
 1YGfkFCLCRszxn0KbVvqXna151NaqTS43ibaFFRn1gSzJpqFMKJ8CUD+nFVETuY4ag9N
 Mk4zzTX9xR5AxI94Lf9pv8ioMeHhZHMsFx39AJOmHDTdqcxO+cDeobwX8PTp22tgpNjY
 jYVAlPAHj0EsJDu+1Tk4dAEp1akF5YGdjA7wZsS5b2bKZwj7NJmislkZF6RtDrroDd91
 JqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6bTgmZs4+0yKu7QhFYSn6OguxtaGnMvy0J2gOiPho4U=;
 b=LJczcLQ2vbem62pniv7HDCQ4YrlNt3P76+VgSmGE6UrdkbzdQdZgHa53Yv2qT6FeFO
 MmRkc2VaIgjnUphZD7ibSrmVb+d/uq2W8845AIF2byY5g4KmLTVVj0uDp78E/AEvfu9S
 IVeIZPDrHwym5+GQUsADi7ba5UHzKdT3Av/i9vOgTxlOENtFvoL5K12/AvA133GCLdK5
 OratUlcX7LRehk7tkmLUWxXbQePrmltxZZq5n0bUy7WZChIUV6OAahCNx7ooybqOZPgV
 L7bRT5FUaeR3oWORiSVOF55GduwkisA3SnLbrvCK/QWa6z8UClK4DnDMASJLkPAo1VNa
 y/qA==
X-Gm-Message-State: APjAAAXzrBJas3iblPu2Hm97DOtstKP20snWZgn9prcaTqdbufODPUQE
 z7qawQ6ci0iVbS/RNOmbu3nOTQ==
X-Google-Smtp-Source: APXvYqw8Rd6WoSWSFkWThr5h+tTSFPfVFWeBonJVNCILKjV4gc+fZ1GVfwYI7fW6gnz8VVMQk0E4tA==
X-Received: by 2002:a62:e414:: with SMTP id r20mr4180654pfh.154.1582811888536; 
 Thu, 27 Feb 2020 05:58:08 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p94sm2687327pjp.15.2020.02.27.05.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:58:07 -0800 (PST)
Subject: Re: [PATCH v3 03/12] tests/qapi/doc-good.json: Clean up markup
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225140437.20609-1-peter.maydell@linaro.org>
 <20200225140437.20609-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28ce6039-71c1-5098-9037-c1637f47d275@linaro.org>
Date: Thu, 27 Feb 2020 05:58:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140437.20609-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:04 AM, Peter Maydell wrote:
> doc-good.json tests some oddities of markup that we don't want to
> accept.  Make them match the more restrictive rST syntax:
> 
>  * in a single list the bullet types must all match
>  * lists must have leading and following blank lines
>  * indentation is important
>  * the '|' example syntax is going to go away entirely, so stop
>    testing it
> 
> This will avoid the tests spuriously breaking when we tighten up the
> parser code in the following commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New patch in v2
> ---
>  tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
>  tests/qapi-schema/doc-good.out  | 12 ++++++------
>  tests/qapi-schema/doc-good.texi | 12 +++---------
>  3 files changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

