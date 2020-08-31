Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EBD20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvnRRUTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EBD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCs2j-00008N-9O
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCs1s-0007kl-Gh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:11:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCs1p-0007fZ-NX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:11:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id k13so3889504plk.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PH2RCbNEIaLhQ86NxGfy7qBIeGRthZo3i/8Dmi3lax0=;
 b=KvnRRUTnd/5QvDOn6OMc5rfq5gF7hJSDAC4DssiiKpDawFgv/IjxYfzaPuueMJK1dw
 cRuaY+H1utJG+L/oyhWvZsyShv7WMEwK4lmKw8QJ9+W3hiMwbLyKYyDNNQr1yG1B5a3q
 7FNPxs88Eq0Glz9weNy0J+E5x+/YXFGQTPh8pNdqr3BIk+Ydtzvuv1+t1GDLpOVquovq
 +bSwMx8jTqfXHDZzbG/E5FCqsweQrUSLyGoD+GDpCyzDB0kQVlsM82yJdOwOa8Zly+Uq
 /TasIU9Q7OvkxqPUSW5e09fkeJOH/cysg9SH79ptf530yVeiuMnFRDfOztoGf5x9EVAj
 7fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PH2RCbNEIaLhQ86NxGfy7qBIeGRthZo3i/8Dmi3lax0=;
 b=TIZ9VjqB6YDKjNkI+wobI0lwg9jYmI2wQOWgzblXRjuDXcHcAZjYVYDL0v3KLdAbpS
 WDpN+CTSF6sXIffC+zeBzFAfyNmTI/T2ErG6UIn1gYTPusWvUQRuXv1AZ9Q6r7Fl5v96
 9yabLBoGniC2YQDWop5Zmxa/veVg0viDXJhuPuoiyAVziiXnW8jYUij57rDtTBB3eP2z
 GkqEvvTmltoYwzALLfHuwHg6HC3HH7rawwtLlQgDMJzdCi/XROlXyc6Px5/wNXh9AhpW
 68f+pwiCSCz5RCZzhi6UGbiPA55N9yuZvzGK2qQLW7lI+M7BmK4CLlz9aCcxypjFFbXn
 tv9A==
X-Gm-Message-State: AOAM5305+CUOZv4ZGdS5n6G7Xgs9EYgApuYbL0uUn8+pqAGmpPJoW/5s
 /quWPiLvm3rZkPYvQD4vCSlbwQ==
X-Google-Smtp-Source: ABdhPJyHeAhyq90Hw33BP93AMzx+wEo1MdvVb9FmV0StgvoewtulFfAzNG2O4KMOTxThoXtAhLT44g==
X-Received: by 2002:a17:902:6ac9:: with SMTP id
 i9mr2726606plt.128.1598911912064; 
 Mon, 31 Aug 2020 15:11:52 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 2sm590033pjg.32.2020.08.31.15.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 15:11:50 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] target: Push BQL on ->cpu_exec_interrupt down into
 per-arch implementation
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200819182856.4893-1-robert.foley@linaro.org>
 <20200819182856.4893-8-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42dc8454-9835-fc52-a7e2-73835672f3f9@linaro.org>
Date: Mon, 31 Aug 2020 15:11:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819182856.4893-8-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, pbonzini@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 11:28 AM, Robert Foley wrote:
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 499a8bdc5e..c4e54baa6f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -599,7 +599,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>             True when it is, and we should restart on a new TB,
>             and via longjmp via cpu_loop_exit.  */
>          else {
> -            qemu_mutex_lock_iothread();
>              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
>                  replay_interrupt();
>                  /*
> @@ -614,7 +613,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              /* The target hook may have updated the 'cpu->interrupt_request';
>               * reload the 'interrupt_request' value */
>              interrupt_request = cpu_interrupt_request(cpu);
> -            qemu_mutex_unlock_iothread();
>          }
>          if (interrupt_request & CPU_INTERRUPT_EXITTB) {
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);

I think you need a change to patch 5, because this patch reduces the scope
further, around cpu_interrupt_request, etc.

I think patch 5 should have

+    bool success;
+    qemu_mutex_lock_iothread();
+    success = cc->cpu_exec_interrupt(cpu, interrupt_request);
+    qemu_mutex_unlok_iothread();
+    if (success) {
-    if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {

That way this patch maintains the scope of the lock.


r~

