Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B3C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B3F2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDQq+9CT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B3F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcyfx-0000cH-AR
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42441)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyea-0007iL-0x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyeX-0006gY-C6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:54:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcyeS-0006dO-70
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:54:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id 83so6425720pgg.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TB3oUZP79tpk7tB0rSwVIolQ3XXM45leQSjd4333jKA=;
 b=CDQq+9CTzXz1piOC2oInrkNyfOrh/G3Rq8rswZ3LYtiVsagSzOHzVbzZ+J5e+fTtdk
 Y/upE6S5Fg0m+keMsWs3brtGbO9LbjNXz/3SW3Xpw0FqS6mefUsZcI+nkN9AAqkUaSRH
 RNlAcpNRAooTYsjUBbs6RtnGJEZ2Ii3a+CLaF7l+ElFJUi2tdA4WCLa5PJfn/I4Pahdq
 tjELmy69L5iUXQzkU8NeOytnTdVM37IbkkPCO8KM4zfsctU8EV6Ew5cvvJZPYpyRfv9l
 lNGX1X7bLpw0qoUMM/IENAgDlHy+i3wDhEuBU4xsKIMgjp7qCbo6vvIWLkeW3MeThlql
 MdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TB3oUZP79tpk7tB0rSwVIolQ3XXM45leQSjd4333jKA=;
 b=mGOVuLkrLhmf188hyUJwm2RGO3n/a+QL4NrqRC2E6SVZOWjDmwDNbfEM7MOu+xGw/b
 Q9Eme824s8S87k+sSOvjOl3ikj3pHDBT72k7+byaOc6HpRgHoIfivoxlq8aPWvQKqXz4
 UdR1qhqUk0WgQiqVSTb2jfsjo2nI5ivqS1rsu9bXQOLoWBZzC3VkFKDO6vm8CclxNe08
 7YqvXRqmceCyrb45eQDnVqXNd6apY0utVFu3ne2AkJxaB2JjPSArWNZGSSEKzZG03U5X
 6lRmaLkLODb+fY2MVDJHvF2T1YNmOBiWKJlEA4jNt9sQPzrrH9mVK6+mAqmI36n7JcD/
 IfbQ==
X-Gm-Message-State: APjAAAUuhLKrmvEpttOWRw0pr/crLDOKwZ/NfXWWvHHQ1Seah+/hMpjn
 v564G5UeMx5HB+4bB8pml3ddGuvhXIE=
X-Google-Smtp-Source: APXvYqwj8sr96mjjuigImQ9A4E7RFVK3C9O/ECJzp25iGiLZOlDaWd7CyAqiituhw+cGoGqYQgBF2w==
X-Received: by 2002:a62:3103:: with SMTP id x3mr34335535pfx.107.1560804889485; 
 Mon, 17 Jun 2019 13:54:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id 128sm13399500pfd.66.2019.06.17.13.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:54:48 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <89dca5c7-1a8d-5bcc-7958-4a5ebb99e507@linaro.org>
Date: Mon, 17 Jun 2019 13:54:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v3 21/50] *-user: notify plugin of exit
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
Cc: Riku Voipio <riku.voipio@iki.fi>, "Emilio G. Cota" <cota@braap.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  bsd-user/syscall.c | 3 +++
>  linux-user/exit.c  | 1 +
>  2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

