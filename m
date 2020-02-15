Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E5C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05E52083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpfYWFV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05E52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2uhb-00029v-Uu
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 05:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2ugq-0001cZ-6F
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2ugo-0006DD-Km
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:28:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2ugo-0006CN-Hc
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 05:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581762523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35E57v9SE3NVNXYt6hXqf1KKKA8+S7q63xtJok3UIiw=;
 b=MpfYWFV+r/DdGApe03vMj41PvMi2UaCPgSRtxqTBmi/u8JGTjCOIEQzkoZdVRJLRl0fzR2
 xKxTfLRgRA0ZPOOQbrpB0MdAI76PKOZ27ZpzM/Mlueb3nGSG3nDdxuvN63juxBWx3xxBIz
 qtVKEuYPNkA2MIC4xR75Ojmc95F2Ags=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-zJhrFQ5-OxeJEb4_Ag3nPQ-1; Sat, 15 Feb 2020 05:28:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so5544396wrc.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 02:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=35E57v9SE3NVNXYt6hXqf1KKKA8+S7q63xtJok3UIiw=;
 b=haj6LqDhApRyowtLVuPjH5v0s77b6Gh4olixPUXbwsERqkdoKP9bH75poQ6rYlN1OF
 ejWzhZRGW/UDILU/TvdwJzWVsKMNNOl5Ta6lTdJSJnGjLvqKDgB+NxvaXQYm7rkzZSkB
 L3uHud8CWXHUTC12/7UPDRJ1Is87y0i/PHXBReB+ZZYYrwpDfOb1esyy9DcOcP96HO9C
 m6PaQuxGY5+EsYziZtAZgMsW4FyALAlLmcdFEQQTZz97W87Z5oQ8rwobd+9g1Hv/1vj8
 97EAAimMVZhFnXeRr/tPFz47ZyisgyyQbkL3Nr8fwFo8ZvOtQEmy8NKJLWknTT4GEH9e
 gUYg==
X-Gm-Message-State: APjAAAWL79/dqcv399KARMu4eU3BfaEO+M1jI2W+eMXE3mo+o3HsyqCO
 uk71S8jRCtfvKpGBb+zmPVXQVdqIeUemz7dcqgQ79RyaTcwt6kh2FTSaJuaAO+ixA4NeIPs9V06
 r65XEFEitzggX7kE=
X-Received: by 2002:a7b:c652:: with SMTP id q18mr10205168wmk.123.1581762517703; 
 Sat, 15 Feb 2020 02:28:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl6wNxGyXmjcCwnRWZqZMYHwOnP1Id2c+mefB0GjRXqbGZqHBTaWpcifxa+1Je8QxxNSdYDg==
X-Received: by 2002:a7b:c652:: with SMTP id q18mr10205148wmk.123.1581762517459; 
 Sat, 15 Feb 2020 02:28:37 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t12sm10503652wrq.97.2020.02.15.02.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 02:28:36 -0800 (PST)
Subject: Re: [PATCH 1/2] s390x: fix memleaks in cpu_finalize
To: pannengyuan@huawei.com, cohuck@redhat.com, rth@twiddle.net,
 david@redhat.com
References: <20200215083203.5064-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d92b8d7-907f-2969-55f3-2ee5746edf68@redhat.com>
Date: Sat, 15 Feb 2020 11:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215083203.5064-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: zJhrFQ5-OxeJEb4_Ag3nPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: zhang.zhanghailiang@huawei.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pan,

On 2/15/20 9:32 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x. The leak stack is as follow:
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>      #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>      #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>      #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:530
>      #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:551
>      #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:569
>      #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/s390x/cpu.c:285
>      #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:372
>      #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:516
>      #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:684
>      #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/s390-virtio-ccw.c:64
>      #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/machine-hmp-cmds.c:57
>      #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/monitor/hmp.c:1082
>      #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/qemu/monitor/misc.c:142
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>   target/s390x/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index cf84d307c6..fff793a4eb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -294,6 +294,10 @@ static void s390_cpu_finalize(Object *obj)
>   
>       qemu_unregister_reset(s390_cpu_machine_reset_cb, cpu);
>       g_free(cpu->irqstate);
> +    timer_del(cpu->env.tod_timer);
> +    timer_del(cpu->env.cpu_timer);

Similarly to your other cleanups, shouldn't we move the timer_new_ns() 
into a realize() function, then do the timer_del() in unrealize()?

> +    timer_free(cpu->env.tod_timer);
> +    timer_free(cpu->env.cpu_timer);

The timer_free() is correct.

>   #endif
>   }
>   
> 


