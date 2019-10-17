Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08428FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C312F20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPjUnpxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C312F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Gu-0006DV-92
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7OQ-0003Rk-6S
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7OP-0000bz-7D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:46 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL7ON-0000Zs-2N
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:08:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id j11so1273461plk.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WuWWW6xE1Pchpzf03ss/4tR08raHU2zu6kAU1PPJn+g=;
 b=IPjUnpxtPTMDKnE9JfNxoDQ9o/5ikDLdcubrExns+kUBCpxiPRVv3uDj/fV2IxYU+J
 8ULKFjJKrC19+cNOkzDlSgn2s+duW4PERXOeHer5fA0HshugTfbz0yu2WXosoxKCPrS6
 B/0J6aUK/gRoTweAeELj2YAfBM9DJ71pZ7Lb/TnqAlMqoUnhbcu9F8OYvAcLJShb5hfr
 Rd6ausN+sbvEj2jeJ0Bn1Gax0dVPziE6oQneGVaU4b/PfmRlWbk6XE06I8QNgyGYoKvy
 efeZPbewiNrFM3rK/Uw5HBPTA1ZQYmgrnCYlBOosHwhdxB++rQCPaf9/eySvJZcJiRgB
 yqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WuWWW6xE1Pchpzf03ss/4tR08raHU2zu6kAU1PPJn+g=;
 b=btViQW1JOjB1oO6TOF5EawEW0v/Dmcvh7WUM6/KQ6yY9H9K3gqLyfTh+tOR3QFZtri
 3Gr4ga09mnxh2JjAq9oUhu4/EERATo98SsSoFOyv1tzlf0yKz7sQWHpJ16ppE4zmi6Jy
 2QCPlFlzfHmgUSUi0D2Mgy0y6X8wLxzSMLMHEv/hE6qS7KQz8XAcDzFt76Y/R5iFLGks
 eHUW+L29G2CiJVMDw6BKUB48TzihHax6TdJ4/ekKR0nviIb4PMR/w9lLXzsadxg8HoBF
 yplgqMM5UqaAYR0hgYfbDsiAP7NdqF1WlHY/UlBn/ZthKwpc8nJ+DDB88j7b8YCvWbUm
 44Yg==
X-Gm-Message-State: APjAAAW8VrFiCmSZRqZo+sQJLUXmJPZkMoaDO6Zphz6wY5ezNnAYbEXU
 6ZWlJvaOqesuonH388V3S3Bbg7Ch2/M=
X-Google-Smtp-Source: APXvYqxp8Ipy0jNZCR4dwyWWJ0fHYPDfryf3zwG4XoVpM+QKJVYxyz1ar3Oq2MLUSp3Dj25f1SEnqg==
X-Received: by 2002:a17:902:bd06:: with SMTP id
 p6mr4227172pls.120.1571324921421; 
 Thu, 17 Oct 2019 08:08:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m13sm3426495pgi.22.2019.10.17.08.08.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:08:40 -0700 (PDT)
Subject: Re: [PATCH 8/8] hw/m68k/mcf5208.c: Switch to transaction-based ptimer
 API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a136af24-103d-8490-3f26-9093a684fca7@linaro.org>
Date: Thu, 17 Oct 2019 08:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
> Switch the mcf5208 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5208.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

