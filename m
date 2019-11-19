Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58953C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7720885
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4YyO0Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7720885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9xp-0005BP-Ar
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9wm-0004iR-J3
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iX9wl-00041p-4L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:18:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iX9wk-00041E-Kt
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:17:58 -0500
Received: by mail-wr1-x444.google.com with SMTP id b18so24022269wrj.8
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tRgTt3M7KgEbSYxV2iufJan302+j32iRRzC/BJlLCIo=;
 b=a4YyO0JrmpZRAGFZG3MVTgZr2Ii1+H001l6d9aU7MgJaNyrrfu1aTcS3pasHzQAD5m
 hMx9xky5YaMUAWc3s0nzLZS09sWn0kCYAJpsqKMXSIoRr9JiHAyp2sXm85N2sM71akks
 tvGcrDqlTcWJh0x2YoIe5aYkMji11UJQlVU2S0Kw+gM5tu+fl5qDf58o3Ju/1r/tZEqr
 7sLgOutwN+AX83DmOA+6q4/AiqE9i0WT6JjxwBU69bpYc1ZisBlPkCtU2voZqpTr0hN8
 TKGhj18L6qyzK71ULY47X9YcfDL4MHHWTmWRwaLcZPpSGkL4Z27G1aZcTEDA5MgoCSl0
 Uo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tRgTt3M7KgEbSYxV2iufJan302+j32iRRzC/BJlLCIo=;
 b=l3gwBxVpUza74xI/SVIiPhguC+FDQrXzrXqIlkdYY2avEBp3NAtSc4q9CKpL9JXqYj
 keoI9wxbbTYvQQYCP2YGN5t7bNzBFYAx/APzwqpQaip1zTg5eb0imyRrGjd+pXIdOKcK
 qBmeXIucn8XSQrwlh3qv/JJheNbz99hu+3OUb5+JrcF6NNCv2W7ilqaTC34K8JecqVR3
 reKQQ9NVaSWMudPo7S6ffx0xwghl3pFwqjSlzuz00wScNFgDJ/yvNT/kiyZL+OtcNhwh
 MgRXsb2vxYGAtXNVZpeWiIgUG2cbElZbhPu7o0UMsvMZS2abqeGNkzYxBfiidubz/4ot
 qZ6Q==
X-Gm-Message-State: APjAAAU/+Lahrz+7nuqTBjdlYibvcRxlXcd0X8i8hX58ugLgbR+W206s
 JwNwJgdPKBKzO3waOadV+ZNlCw==
X-Google-Smtp-Source: APXvYqwfnCrXvWJIjIN0IzIkWP2aMJXTjHMKj+e/UJVVLpCDEFRfZQvqQbqLja2kdN+izGTQMqOe6Q==
X-Received: by 2002:adf:f048:: with SMTP id t8mr24719159wro.237.1574194677312; 
 Tue, 19 Nov 2019 12:17:57 -0800 (PST)
Received: from [192.168.8.102] (64.red-79-149-204.dynamicip.rima-tde.net.
 [79.149.204.64])
 by smtp.gmail.com with ESMTPSA id b8sm27668712wrt.39.2019.11.19.12.17.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 12:17:56 -0800 (PST)
Subject: Re: [PATCH] linux-user/strace: Add missing signal strings
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20191119185153.GA23003@ls3530.fritz.box>
 <48097cb5-bc47-e532-fcde-67ca65a2039e@linaro.org>
 <06aaa584-fc97-8097-ca52-00d97982e5be@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <21861bfc-f656-0f77-f29d-1dbaabfdaefc@linaro.org>
Date: Tue, 19 Nov 2019 21:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <06aaa584-fc97-8097-ca52-00d97982e5be@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 9:06 PM, Helge Deller wrote:
>>> +#ifdef SIGSTKFLT
>>> +    case TARGET_SIGSTKFLT: signal_name = "SIGSTKFLT"; break;
>>> +#endif
>>
>> Wrong ifdef.
> 
> Same here, see in linux-user/signal.c (line 50):
> #ifdef SIGSTKFLT
>     [SIGSTKFLT] = TARGET_SIGSTKFLT,
> #endif

But that one actually references SIGSTKFLT, but the case above does not.
You probably don't need the ifdef at all.


r~

