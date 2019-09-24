Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF1C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1E420872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDu09QHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1E420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtna-0003Mw-9z
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtUk-00066a-Q9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtUj-0004Vs-8h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:41:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtUj-0004RJ-26
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:41:17 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so8531034iom.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g7Na4rBIeHw6b5t4qsn+LNFp5Bu3PBqrLCGvea+qAa4=;
 b=VDu09QHf2d8yo5eaT/RgiB64tZIUzvVqmp2rx1b0WnDQ90xzdMrRSYEpJaGFkW1slr
 NYO5EjnqP9FAa2nrh0HGjp54lTyTJXnOGgLwVcxzr/HK1vBjBMkA3Nf2KXBK2jJc7qou
 kcymcJQZg3B9N+jsAF8A2Fsn0VhfKWl5yqLPGkvD0VpuLrd6Riyz5rmXzcC/DLLFRE7n
 Baq/Kw+gdY7EvZ7zjV90JZaFJTSK3/jzacAuLQdMxXUZ8pM8V70EK2GNtd2fedNqhbC+
 LcYTpB/cSRHBqRCrdm3caiKkkVLP5GSpaywsr08ZFH0FoWt5OT3kcqqz2siccTsMbNYb
 /eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g7Na4rBIeHw6b5t4qsn+LNFp5Bu3PBqrLCGvea+qAa4=;
 b=YBMDQoghpLv1v7Z6UVKCpHpI6qENY99exqd0RSu8Hxwt0M2PVp3bYwU+cweF955Y+E
 7iXk9dVnu5jhWHQunkViZWrTfYZJbzLtdL05/2oCQZ84hv364QvQnFvyH6d4ajE7IXVl
 ypSVqUpECMpQ3k5lvtOFYx0awVLB1Er0WUvYMH33aBbfkJkU8Uw1CxAPs29YR60LfPpu
 xNCW+F8m1XC72YiBEOH2Pap+YJPG7vo1ZClIxyuUuXVCmsrAj0+fohCNNOfnSeAyRfjO
 xzRGJNjhO2qW8g/ictF3ysfyH0fW80+BSz6h2owaOFDZeFo5of7aCSuH97LT99bVfdLr
 UHbA==
X-Gm-Message-State: APjAAAXHK5+FYE/jRbETg2qzWODGwPKkC1GM+45ZL+Cif86EyMai11sM
 k+8FdWKJ4O8DyT9Fd0sXoWXcUGlvZeM=
X-Google-Smtp-Source: APXvYqwYS3n7VI2orqYUbI+BhYcXfPh3XeZVkUVXWx0LHr2MlFucQnYQZHBllS5RlKHld22P96mqvg==
X-Received: by 2002:a63:ff4a:: with SMTP id s10mr5169995pgk.166.1569361661074; 
 Tue, 24 Sep 2019 14:47:41 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id j24sm3011917pff.71.2019.09.24.14.47.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:47:40 -0700 (PDT)
Subject: Re: [PATCH 4/7] target/ppc: introduce dfp_finalize_decimal{64, 128}()
 helper functions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <db3dba14-a49d-69d3-5908-dfde9afd8166@linaro.org>
Date: Tue, 24 Sep 2019 14:47:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.166.66
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

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> Most of the DFP helper functions call decimal{64,128}FromNumber() just before
> returning in order to convert the decNumber stored in dfp.t64 back to a
> Decimal{64,128} to write back to the FP registers.
> 
> Introduce new dfp_finalize_decimal{64,128}() helper functions which both enable
> the parameter list to be reduced considerably, and also help minimise the
> changes required in the next patch.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 42 ++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

