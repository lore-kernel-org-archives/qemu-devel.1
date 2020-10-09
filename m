Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E316B22276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmitRWhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316B22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsHR-0005lY-Vn
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQsFz-0004sU-R5; Fri, 09 Oct 2020 09:16:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQsFu-0006JL-63; Fri, 09 Oct 2020 09:16:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id n18so10265476wrs.5;
 Fri, 09 Oct 2020 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BCBRkd7SY1UGBTvNjwTUZiHdR4k7LgdAwwkOsNr4HZc=;
 b=HmitRWhVocYgSOtXwuynB0laV7+779gNP5WyPmGsnLmV0Wdr1AOxYCB//YgqMJMDYd
 YBKnylVN4WkCwNelgHbEV0ebCkrI4XV2V6qVA1iEmFf2dE3vhgwdOveSaiobqsO+R5NC
 VXd0gSG+GKjQjVGg+EvTNUr9Tis8ujquK8ViJdScF0zugPQTebioMi8Q09ppaVSkbw03
 LQc4e225Z7w+F4gttVuZK86R5HKKr+ItjBISoKaBRr6xz3OelbTe1lYrv5Sv0R3b1C0c
 0R7Hz/qGEH9RHiabNj8CKw0j+nYV9dV7/VEBrw2oUihRIJr91BeBjAKMDoaiuEDgqWOk
 CJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BCBRkd7SY1UGBTvNjwTUZiHdR4k7LgdAwwkOsNr4HZc=;
 b=bsSV411EaFJ0vCZI6OvhAhVs861XQmjCXcVZZzmtTC9nAvCkyDwIDuEnkLNzbWST4j
 JYnooWuAZQp0JeCYTN/SNS8K6sh3VsVVPr+CWSu3+OlizVptd57ZaMFqMB7Q7kiDJaCM
 Lndov6y9xGB0t2KNe5vGJ208QIlDo3gzDRSonWPHUd9xRTpO4cb5xQ9fUjEIqaivS9/Z
 9D6HKCJht9FQEZ9WyF8TANW84qZIgzJkUxc9EiaRksOb6rV8fmHDq0GhNDux0YFv2DEX
 BUzttU67SLB7gPUxNGI+PWe++pKT5oflxpp4kM/3/VXAy4WZKTuQRItHV6iT7fp/pcxZ
 wEaA==
X-Gm-Message-State: AOAM533oI/QcME0GNptwrt7DFsYJajXBzp8q7K2gwvrBwViPS2GQfqpB
 /UZcxXyGKqhyeIvmatxwWyE=
X-Google-Smtp-Source: ABdhPJx43Sc1uffzDRFdDFnR7yJXhv8U6uF6XLhW8Y5iGr/UPkQiLkVVfgOiblm7b7nvYqS+PhbNwQ==
X-Received: by 2002:adf:a345:: with SMTP id d5mr16166666wrb.55.1602249375258; 
 Fri, 09 Oct 2020 06:16:15 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m1sm11297366wmm.34.2020.10.09.06.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 06:16:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/char/serial: remove duplicate .class_init in
 serial_mm_info
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20201009113843.60995-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ddff8d3-752b-2219-dd49-bfe53b925c43@amsat.org>
Date: Fri, 9 Oct 2020 15:16:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009113843.60995-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:38 PM, Laurent Vivier wrote:
> .class_init is already set to serial_mm_class_init.
> 
> Remove the duplicate entry.
> 
> Fixes: 17fd1a6490b1 ("serial-mm: add "regshift" property")
> Cc: marcandre.lureau@redhat.com

I was going to send exactly the same one tomorrow =)
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/char/serial.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 4386adabd466..97f71879ff2a 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1120,7 +1120,6 @@ static const TypeInfo serial_mm_info = {
>       .class_init = serial_mm_class_init,
>       .instance_init = serial_mm_instance_init,
>       .instance_size = sizeof(SerialMM),
> -    .class_init = serial_mm_class_init,
>   };
>   
>   static void serial_register_types(void)
> 


