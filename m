Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2302320872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qi6l7BHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8EH-00032t-Jo
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7I9-0003MD-HP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7I8-0005vn-DZ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:02:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL7I7-0005uA-2H
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:02:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id p1so1521881pgi.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RINHsJYbGLEwlxGpIQSujqVVrNT804DXVsVXLS2jLAQ=;
 b=qi6l7BHOCY1j3MgGh3yRLY6kCxfEgeFon5p+sti6UL0EDL6FPrrBsazmdbyAuJ5UCd
 EsOICLhe4cW3CxglY4IT/66jm94sSve+dWEnvDio31O1SzJhJPuRgX/Fed1KF+jsn/o4
 NfPe0Kwroyfwdlu/qX6ZhGpa5FEQSx2VpaECgExKAyE19GBC88I1Du0ifx5z/KSk1INX
 bktW6du1w5Mgcry3fFRsEiPehZqMvA1HHhTakueyC0S442bywPWl/NC0CwKDAewjrVkF
 GvPj1Te9b7ywMESnI8k+KcJvx6v7xpt5aYBRoT66mRp/WZX7rqovW+bDVb9aWGxj0Kzv
 d0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RINHsJYbGLEwlxGpIQSujqVVrNT804DXVsVXLS2jLAQ=;
 b=KgnvGSv6kAMTEZVWwX+//VV2CgMs9tPHEQ06Pv3JJ8bWa/dccXn4RugGA7uOlOLqoe
 JtaQpplRQIs9UEiHAywFBbPWE5Fgwixr09UZ0LALK496gD9WjC6ERrzF39MZwqiZwoNX
 g2dttXGuj0XNxJwbOSrUAu3YJcgtF9lCkwx+rD5hhJHDEv+PAfPv77wXwJO1JBZpFcbr
 e5NeBnE7q7vCtmSpBhYb47r+ZTCJmleHNcZrxILrB1EmRYe7AG269HivMgQxjFu0dQK5
 iVkG0ljSbvBUmEpO0BJbPo6xD8aPZgUSfCEPo1RaFeyP/dlV+mo7jQiJIYuw8SmxEkzJ
 idsA==
X-Gm-Message-State: APjAAAWA0i+S6igYT6DquPTVZWRkVRFoBvqrpmOlOeSfjL+Fcayp8wHN
 DJHnO/TIwXUQggFBfXXS68XLCw==
X-Google-Smtp-Source: APXvYqzDVIQ4BitS602AklZ9Xx3nFG+mM5teGVFpwGUqMIWMZxgeDMWdSAjemqRg016HaFqmZdj2AA==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr673777pfr.161.1571324533442; 
 Thu, 17 Oct 2019 08:02:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p66sm3881501pfg.127.2019.10.17.08.02.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:02:12 -0700 (PDT)
Subject: Re: [PATCH 5/8] hw/timer/altera_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef78e5f6-53fc-74d1-afe5-08330a9ac045@linaro.org>
Date: Thu, 17 Oct 2019 08:02:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:29 AM, Peter Maydell wrote:
> Switch the altera_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/altera_timer.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

