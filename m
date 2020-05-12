Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F2C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922F920752
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBHzbIv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922F920752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOpQ-00007N-Rb
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOn8-00031M-79
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:53:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYOn7-0003pv-Hu
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:53:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so13924845wrt.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YUo5UMKHn6UCDXPR56CEsu5aymqY785YMnVFWOsKL5M=;
 b=YBHzbIv1lbmZVqgvd/JgrnbcLnnzZ8YePyX5PepalFAYw1b+PC4jUVzyE1d9+hCMlm
 TfKqeMluL576R/zl4AQC7OAhZr7F5yT75i47YbEUz4po3/70QOU0dCTR7SyZ4IlVN56f
 aPvzZKC5qkCbVjhzclEcC2xJAkfXBd0CTxDEUVXcJCRq3aJgxy0Gyw6vcEtipzkaBq84
 tDxULgdZVeJQF/kecDHW2Ge+2F10OL8fO5yAfOacNTF1j5AR4c6snU7zeg2iHGqu4hZv
 bnP4yskyi8/CztfLxLPvfkPZGXpcwPf8Fca9T8DZIabOFQBEbGo7/TZjTZhC2Jm9IzvX
 51RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUo5UMKHn6UCDXPR56CEsu5aymqY785YMnVFWOsKL5M=;
 b=hHmU3QE4p8HFKoUgfp0Q17TWXn60ffzDOPbDhafflK6Ij9zqGDVn9EK1EVrbzqBxA/
 hQUmsiceaJYnlRNhNvPYQAODra6VoNSuKLJNhjZXM4zvBXG3hmQy8cNaaZr0Mj5vp7q7
 xy3Elawa/QkKxVAVzGC3HrBUimfLRlAT01mfNRJ3pnMYEinoC4gAMoFolaftQWt6Rz+u
 cXaRspvYrnB5LlpYW/fx4/3HHpDCz03Hi23lBcbIzTSxbFlgOtkUlbryM0BJbsW+dUf1
 1AntAr4aS2VPFcBSG61T1pBKEOsMbx2IHLAxBgidW69tI7nzZSsZ+adoC+d9734jVJYo
 5i7g==
X-Gm-Message-State: AGi0PuaHXsFE1vKbT0lUQRjn4XrR2m7bulmHr0KYCFLBgd8l+PA8x6I7
 vX5gVEOncFvqm0OdoC28O6k=
X-Google-Smtp-Source: APiQypLSSQt5KymKCK9Y2mXCwRM2zJx6EO/hARY14NdHvUQpwH8y/k/M7hVIbI/z46MrciTRLridmQ==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr22986097wrw.314.1589266403357; 
 Mon, 11 May 2020 23:53:23 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a8sm21479068wrg.85.2020.05.11.23.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 23:53:22 -0700 (PDT)
Subject: Re: [PATCH] hw/char/parallel: Convert reset handler to DeviceReset
To: qemu-devel@nongnu.org
References: <20200504095623.7252-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23cdfab9-2cbc-6c43-033b-21a23990131d@amsat.org>
Date: Tue, 12 May 2020 08:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504095623.7252-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 5/4/20 11:56 AM, Philippe Mathieu-Daudé wrote:
> As TYPE_ISA_PARALLEL inherits from TYPE_ISA_DEVICE, it also
> inherits from the DEVICE methods. Convert its reset handler
> into a proper DeviceReset method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/char/parallel.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8dd67d1375..f68a96da8e 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -523,6 +523,13 @@ static int parallel_can_receive(void *opaque)
>        return 1;
>   }
>   
> +static void parallel_isa_reset(DeviceState *dev)
> +{
> +    ISAParallelState *isa = ISA_PARALLEL(dev);
> +
> +    parallel_reset(&isa->state);
> +}
> +
>   static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>   {
>       static int index;
> @@ -552,7 +559,6 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>   
>       base = isa->iobase;
>       isa_init_irq(isadev, &s->irq, isa->isairq);
> -    qemu_register_reset(parallel_reset, s);
>   
>       qemu_chr_fe_set_handlers(&s->chr, parallel_can_receive, NULL,
>                                NULL, NULL, s, NULL, true);
> @@ -625,6 +631,7 @@ static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> +    dc->reset = parallel_isa_reset;
>       dc->realize = parallel_isa_realizefn;
>       dc->vmsd = &vmstate_parallel_isa;
>       device_class_set_props(dc, parallel_isa_properties);
> 

