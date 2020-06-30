Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45CD2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqwHFMnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45CD2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJvo-0000Xc-Is
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJtU-0007U1-1R
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:18:04 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJtQ-0004NH-Vl
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:18:03 -0400
Received: by mail-ed1-x543.google.com with SMTP id dg28so16945021edb.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R6c2p9VTzVDyF3kXn15e71U6b2Oi4e574jYXAVPFnHU=;
 b=YqwHFMnt153CDThYOZZppFKdOS4E6M/zqDNQJZ0g+25uuqlSh6mxw9t/mlcALPUScj
 vCy1rIxnz6AOrnlG5sPfiCqPcO1SUfxykL9Lt5dMAy4XwkTrjMz2+5mk0hlsWBCcnRpU
 28HS9ThJaLEFWhUWIMBIbOEfH2S1y9/1ttpiaUjzLoRkfjLCzbDvCsVERW1Qp6RlSPEK
 AU8WE0jsVIorA2XX+nA++Nh8LWEE/l9zM5tMRx7AxH7ptcFRr5xr43c8aVC0HoOZQHJB
 MM1C6wRoSVKHpWVQOl5UFARcVSVr+U7dMoO0w2syVdK+atEIGhmmFaYHW/pXUPCBO4GE
 4iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R6c2p9VTzVDyF3kXn15e71U6b2Oi4e574jYXAVPFnHU=;
 b=m+N2f2EuofNPFXv/WhVSUcgCB1ecxAyRea77p+g5BBdJRhs3WccEc2KSGGptC9uubD
 DxJDIxzAgFzAXrdfnkvhvYPtEGQcfvGHrKm8CFkqcrikPx83WXRQvNHXAKXATqo6LWXb
 T5WYnHayUNxeN8mjmlqyVlCEWeytb3aD6nPiGPMLcA9HxCGGYqpnE5Xz55pzKkMstMvX
 KcLl2NzKc6VfGqYyxWnxV5QGZccJ7l9DzWmgjsuek0O5QzNCN4l1ZG6uEt6SBxZztyaq
 2VVY4vYGff4YUB6pt5wiZC+HE9uCEcdQrHQWmi4OPY8x0dlFNt7UUsa6lv49cJ7w2Meg
 p+ng==
X-Gm-Message-State: AOAM5332C30KnoAFVUbbxClz1jDbOwfpXNaNhnZuAJ9NcF8/k3fXKNAo
 TJPZX9bn3CcqdY6rZMll2KM=
X-Google-Smtp-Source: ABdhPJxnAg+2E8CVYNQbXVyOV9aWTTPavd5OBa6b+mPEKh4bQIGoz8ZtNIoZfu0WWTytCUYilt4j6A==
X-Received: by 2002:aa7:d70f:: with SMTP id t15mr23467024edq.237.1593537478901; 
 Tue, 30 Jun 2020 10:17:58 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w18sm3554582edv.11.2020.06.30.10.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 10:17:58 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] hw/mips/malta: Introduce
 MaltaMachineClass::max_ramsize
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
References: <20200630145236.27529-1-f4bug@amsat.org>
 <20200630145236.27529-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8720fc1e-c4ab-9841-3422-d7419ddb6a17@amsat.org>
Date: Tue, 30 Jun 2020 19:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630145236.27529-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 4:52 PM, Philippe Mathieu-Daudé wrote:
> The maximum RAM size is tied to the machine. First add the
> MaltaMachineClass, and add 'max_ramsize' to it. Set it to
> the current value of 2 GB, and adapt the code checking for
> the requested RAM is usable by the machine.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/malta.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
> index 2c363fe099..17a1c0d1c4 100644
> --- a/hw/mips/malta.c
> +++ b/hw/mips/malta.c
> @@ -56,6 +56,7 @@
>  #include "sysemu/kvm.h"
>  #include "hw/semihosting/semihost.h"
>  #include "hw/mips/cps.h"
> +#include "qemu/cutils.h"
>  
>  #define ENVP_ADDR           0x80002000l
>  #define ENVP_NB_ENTRIES     16
> @@ -71,6 +72,17 @@
>  #define MAX_IDE_BUS         2
>  
>  #define TYPE_MALTA_MACHINE       MACHINE_TYPE_NAME("malta-base")
> +#define MALTA_MACHINE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(MaltaMachineClass, (klass), TYPE_MALTA_MACHINE)
> +#define MALTA_MACHINE_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(MaltaMachineClass, (obj), TYPE_MALTA_MACHINE)
> +
> +typedef struct MaltaMachineClass {
> +    /* Private */
> +    MachineClass parent_obj;
> +    /* Public */
> +    ram_addr_t max_ramsize;
> +} MaltaMachineClass;
>  
>  typedef struct {
>      MemoryRegion iomem;
> @@ -1232,7 +1244,7 @@ void mips_malta_init(MachineState *machine)
>      DriveInfo *dinfo;
>      int fl_idx = 0;
>      int be;
> -
> +    MaltaMachineClass *mmc = MALTA_MACHINE_GET_CLASS(machine);
>      DeviceState *dev = qdev_new(TYPE_MIPS_MALTA);
>      MaltaState *s = MIPS_MALTA(dev);
>  
> @@ -1248,10 +1260,16 @@ void mips_malta_init(MachineState *machine)
>      /* create CPU */
>      mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
>  
> -    /* allocate RAM */
> -    if (ram_size > 2 * GiB) {
> -        error_report("Too much memory for this machine: %" PRId64 "MB,"
> -                     " maximum 2048MB", ram_size / MiB);
> +    /*
> +     * The GT-64120A north bridge accepts at most 256 MiB per SCS for
> +     * address decoding, so we have a maximum of 1 GiB. We deliberately
> +     * ignore this physical limitation.
> +     */
> +    if (ram_size > mmc->max_ramsize) {
> +        char *maxsize_str = size_to_str(mmc->max_ramsize);
> +        error_report("Too much memory for this machine: %" PRId64 " MiB,"
> +                     " maximum %s", ram_size / MiB, maxsize_str);
> +        g_free(maxsize_str);
>          exit(1);
>      }
>  
> @@ -1446,6 +1464,7 @@ static void malta_machine_common_class_init(ObjectClass *oc, void *data)
>  static void malta_machine_default_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    MaltaMachineClass *mmc = MALTA_MACHINE_CLASS(oc);
>  
>      mc->desc = "MIPS Malta Core LV";
>      mc->block_default_type = IF_IDE;
> @@ -1456,6 +1475,7 @@ static void malta_machine_default_class_init(ObjectClass *oc, void *data)
>  #else
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
>  #endif
> +    mmc->max_ramsize = 2 * GiB;
>  }
>  
>  static const TypeInfo malta_machine_types[] = {
> 

Missing:

-- >8 --
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1541,6 +1541,7 @@ static const TypeInfo malta_machine_types[] = {
         .name          = TYPE_MALTA_MACHINE,
         .parent        = TYPE_MACHINE,
         .class_init    = malta_machine_common_class_init,
+        .class_size    = sizeof(MaltaMachineClass),
         .abstract      = true,
     }
 };
---

