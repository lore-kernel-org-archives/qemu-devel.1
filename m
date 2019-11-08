Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F3C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CEF2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcS19dMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CEF2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4Ab-000763-R3
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iT47D-0005WD-OU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iT47B-0005ro-9p
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iT478-0005mF-K9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id q130so6205288wme.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 05:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jwbQ3SYWggzpE6CpWE5l1YZF0hptKFDwW7jW4K6jgYo=;
 b=JcS19dMwYQPq2n8XfOxnRfzwhMMD0wrsduojUPUmGNRQZxDJeNhQDHt4nFPFlIKAnw
 t+mNlcLdKplVnslOeFYe8hIoW4vOLls267e5Mlj8Y2moJy/d5uDG+9f10dgMVK4W4aFK
 0BPz5OyYwALy/IItQqzztm7Q6r3YGnp7/TMWSney8tKqd2/n9LFsaoOrCYNYhXh6tAS/
 Q5AUryGK3eUoQjEnlkrGcfiIQ3bu9+GCUWYzoR5zxlylpq8O3USVtNHvzF2rWDPnXVcI
 NO+WnT3yr9spB47/63x3wasunqQVntiMTp6aaVHT98rGZFzKhkqz3NZXoYgb7gl2S5DW
 1MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jwbQ3SYWggzpE6CpWE5l1YZF0hptKFDwW7jW4K6jgYo=;
 b=bdtoP/xfuJwZkiBETIQSwikBu1MkQLelRroxK3QVaKGIGtyZG6u6W3847BsjlU6A9J
 irHiMEiAXlORnbpxFa8ne3CmnOOj2WWB3mUV3Le+Wavr780TX8V3IsGx6zPpcH8RaGt/
 22Soc4o83B0AODLldhPTJTzIXvu9xwgtvxWJQMrmVhzrwAZPs0x1GN5Uf2jYQnR5HpBT
 FCbmBoej9/J1hg2OTjQ42GREEZ8cPJhUtpMtHVb2l4V24g14vtpYp2sDJwE0jfXbYp82
 Oz24KFU2ZQ+8kMlHDRjYrJ9aN4XE8CYn7BxucV028++WmCNf9ukwT+O2kojpuJTEkhW9
 3GVA==
X-Gm-Message-State: APjAAAU7WxIGKU4naaqUb4kLPPxdG5IqR0ZENeRzVZ5SeUZh2ZgQW55U
 CqDkqmbOgOeBSrTYbolCMeX/mQ==
X-Google-Smtp-Source: APXvYqyxGm7ochCIgBKtVNxuL+MoJMCyqVQ/sfHm2EdesdwVybSEJdZHnn+b+HVUMsCa9jqTS2ngDg==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr8103523wmh.67.1573218943140; 
 Fri, 08 Nov 2019 05:15:43 -0800 (PST)
Received: from [192.168.8.102] (212.red-213-99-162.dynamicip.rima-tde.net.
 [213.99.162.212])
 by smtp.gmail.com with ESMTPSA id n22sm4849332wmk.19.2019.11.08.05.15.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Nov 2019 05:15:42 -0800 (PST)
Subject: Re: [PATCH v2 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191108124219.31348-1-edgar.iglesias@gmail.com>
 <20191108124219.31348-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9673b4b4-b8c2-fbaf-5071-bd72a0cd04e9@linaro.org>
Date: Fri, 8 Nov 2019 14:15:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108124219.31348-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 1:42 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Simplify endian reversion of address also plugging TCG temp
> leaks for loads/stores.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 46 +++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

