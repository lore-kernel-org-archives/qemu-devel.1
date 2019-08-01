Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5DBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE6D206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmyMxO23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE6D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDoZ-0006lW-5m
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htDkl-0004UW-NP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htDkh-0002fY-Qm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:31 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htDkf-0002dd-V8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:16:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id r22so6868573pgk.10
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cSGojvIRJKy60Im8iDZpSTv9EYn/C0UZDgxUZxDS/ow=;
 b=JmyMxO23JexT7jjw4cxHXcbwWJ9gEZe4fyrSnEphFoG8ikLZav28jLvu7gRYwovMVw
 wmyZc/Ke581b17bOj/8vlgpHJP/ktKDptNbz5AkPM2ZIaPf8/hpju86WxohuaFId4Chl
 qFUrzNRbLWrY68tsxgUSC46M7FqdZHlOR2Er7fQPI0ngpfdXj3KNEP2PMOLA89oV64B8
 810NxdNt0DJjUWC3kyXrWqp9pOamGvjxXCO7J9/bv2W288XIXCmCMjnjmo3S+iloEUSh
 /unwFBa2EoWAiY1TKSi6upZwsVVWpWFLFqRB3cYPzL/3KpevTPRF6N/eKIydpXrcHfoO
 DAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cSGojvIRJKy60Im8iDZpSTv9EYn/C0UZDgxUZxDS/ow=;
 b=N5iDvR6y+nALBDP99ItJnSKBEQitqdTd/f9RFq/p/LdiaM85wlJyEjCn1utjm1zg3U
 m5VKhbSUBICh0nLlA9qzH8xXe7HYzAheROONyNg+lmg+qLWX/RUm8evgF69zr7SOdw6G
 QVgAsW96hQfRZy8r6crNe6NffIdKVrWUilLsxtkBCu53bHaxOAX+3CuVo5Ji+fp2FORQ
 F8T6WwobU9Aa5AglxJfo+v0vPNxroym1nrMIwyucWloxh30oag1v4bt4kXFR6bPqD2eg
 aUE277mVPdyXkZ4K9hzGP8QB5jkuRjQCd9bGTcly/COfhOJjC8MBnI42iMMxhF7bSnoq
 ALpg==
X-Gm-Message-State: APjAAAVW1KHIfUkaYLW2B1KGFC4IVG2r/FNzQ7WqgJmDdADOXJUyU77f
 rWkRtWSbYl5jgu6xV+Uymh479g==
X-Google-Smtp-Source: APXvYqzGqh8oQwy4aq7oPs83+PjjJA1cEkzX+XTtSjrRD2YlqWceZ4bne/s4qAomoj+UeVVQINVDVw==
X-Received: by 2002:a62:e910:: with SMTP id j16mr55885333pfh.123.1564676182901; 
 Thu, 01 Aug 2019 09:16:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm7964281pjb.0.2019.08.01.09.16.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 09:16:22 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <74566ced-83f0-73e8-9a24-582b485c1457@linaro.org>
Date: Thu, 1 Aug 2019 09:16:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v4 16/54] queue: add QTAILQ_REMOVE_SEVERAL
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> This is faster than removing elements one by one.
> 
> Will gain a user soon.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/queue.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

