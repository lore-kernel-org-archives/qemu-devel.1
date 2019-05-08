Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958EC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CA7216F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPrJOOwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CA7216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQNU-0000fo-0s
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:29:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQK6-00063Z-42
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQK5-00071h-89
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:43847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQK3-0006yh-NL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:41 -0400
Received: by mail-pf1-x431.google.com with SMTP id c6so5629013pfa.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lv0AIM3tGAmzdKchW+ct2T/vx/rrAbqEBy8JF2WCCdY=;
	b=qPrJOOwT9FSd3sTxESyNq9HtBn/T9OoYl9eg+1FxCpLfN6pTEFYnTkmxFkC4+gKy+V
	xCufnRYIIp9dYddsrUbJNQWJT0wsKle66O2rIQ3fqgbKwjsfCVtryp8+UM1yswlKc9Aj
	JfHrjS/pM0LkigHEU1LuvhU+tFIKI2xGlZ9VQELo2w3VYLHuoVmwdOE2UHSiMNJGbWQ3
	zudw8ecAOpoXRXDkl3QCx6Kw2uTOZLK7zMSfcBFfzRX/VDczffHscUZCFXztOiQ2zOQZ
	V50FB2gXw76JP1J1wVtJWuYkLDW88uhYmA1kEUrxkQpBzDeLjxhrgxSF+tM/a7V0GE7S
	cwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lv0AIM3tGAmzdKchW+ct2T/vx/rrAbqEBy8JF2WCCdY=;
	b=IPER0jGLliSprDz7GED8Si5zuB3GL/cadGEXt6J7eaKp3+0WaNcb6lJEOsJTYfvgvF
	3AzO7+SYZAzwOEYW/loEzEYRdRFQxJq4xXlPlHeY79rn0mnoc9CK13he3D7emslgIZ5R
	Z9zUDC85EwYC3CZlNX/XazGbIKpGmzO4GVXn0YdHwoA+0wDgd4YyZG58o62VZ3YeWKQE
	Pvuo3QMYFnuBjcYaLcMQzdUn7o6IznRf3ydnUBNorcnJas7DvwvThlmRnNYxBm1dHARk
	RLwkC8c9L9dvNfUBX/SVDBJv0Rc1lLqcSnV5XPIUjisDc6M8sC6uV3mJPZ/3FrqfQxlS
	n85g==
X-Gm-Message-State: APjAAAXh+whohbtQDyWtZBGgG3mUAQlK5IiPf3ys2xFKEN9CV/lRbrDs
	8EgnrOsQxIuGiSZwZz1MvzQ09A==
X-Google-Smtp-Source: APXvYqxWuTyco0IgCNZ5OLRKH71zXY+Dq9gizy/E9JtdnXoVOSaVAENw50hDpnW58yUrmHeWHoYvOg==
X-Received: by 2002:a62:fb0f:: with SMTP id x15mr51097171pfm.30.1557336337012; 
	Wed, 08 May 2019 10:25:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	f64sm10359518pfc.62.2019.05.08.10.25.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:25:36 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-5-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <abbe9609-6166-8934-e42c-760b3b1be994@linaro.org>
Date: Wed, 8 May 2019 10:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-5-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: Re: [Qemu-devel] [PATCH v10 04/13] target/rx: RX disassembler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/disas/dis-asm.h |    5 +
>  target/rx/disas.c       | 1480 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1485 insertions(+)
>  create mode 100644 target/rx/disas.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


