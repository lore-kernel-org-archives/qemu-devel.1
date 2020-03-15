Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AEB205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCJmfP0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AEB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDaR0-0004Fw-Ez
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDa9N-0007Bb-4w
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDa9L-0001V5-Td
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:46:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDa9L-0001TA-Ms
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 16:46:19 -0400
Received: by mail-pl1-x643.google.com with SMTP id f8so6963637plt.10
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iFXp4zNmSDqQKJwjNyZbD2cn17LZUGny+MQasX8s9wk=;
 b=XCJmfP0i1fvapM5nqotmFRwsScJCqgbVxhwrUww3l/xWsprL8DCsdbn41PFjOkeuCz
 FvdGWZqiNaC/dMIJOuRoaHuAIgPGO+sKeTVeQCjD0iBD1vVTT7PTfQdcbBYsiOOuiQDM
 Wd69FvdRlO2H234TD2sVWj6pfhsx89AAsaEJ6iysIsNaiJfY4VN8vkBEX4Jusd3bqQjF
 WsUgOVwjrrfyHE0+qsAi+mHbdolKsp/Yaa4uHDj/5G7YcCIlUCym8ofMrolmHltbFWKM
 dfTwxXqP4/j8E7p4VeGRUQvsT1cMBQyK5yAUtGF6rfo70zL+CCCAKZDQx8bMTGFsuTUt
 W/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iFXp4zNmSDqQKJwjNyZbD2cn17LZUGny+MQasX8s9wk=;
 b=FML17Lgx7V6dNCrCJZNVjo9hEDzI3/Kyd6pz3tigid3HpGwMiV/0pfH4Q3VXmKXPI1
 JFhiM6XyRK6PQSM2IwbDALE04SnIcy2tdjs3tkvrwCj/LgyyHy7ww5zVyNd6lowpOLzj
 1Nq0wrj/LQMuT3GPbpQ+JiYoAEGeG/Btk3wuvK7IWkIjt8UlA8bCFON6OVPMv3oNhM7i
 kpFCny7vdbDffHAnGmFJthzJST9vWdObM1cMNvLeiHvAALpCtWQN0SDHPAs37mN+a5em
 e7Owz4RyqyWjDUgFHjb77NXbiPq5ImQ0raTAlibzeEUkK8Z1jHmyexGrNNbi/05oCalg
 XQrA==
X-Gm-Message-State: ANhLgQ3Cg93IbG3UQXhpgQvR/auWYZm+W3rg/iNRpEOfN/qorj/ANIk1
 Xn1tbXez4+H8sH2TbMnUcMO56A==
X-Google-Smtp-Source: ADFU+vsPw+Ai2GQY8mcs8tJcvUx7H9FxQhMgeeUGIQwJfp1TKTa7gtiZGs139/XFZWCwXXpzH8yRNg==
X-Received: by 2002:a17:90a:d34b:: with SMTP id
 i11mr20522008pjx.180.1584305178521; 
 Sun, 15 Mar 2020 13:46:18 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o66sm51279474pfb.93.2020.03.15.13.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 13:46:17 -0700 (PDT)
Subject: Re: [PATCH 12/14] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-13-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75c44540-a833-4c35-d698-9e919c68c47c@linaro.org>
Date: Sun, 15 Mar 2020 13:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-13-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/i386/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


