Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590EBC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2701520718
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2701520718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2soL-0001fS-5e
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 03:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j2snW-00019S-Fb
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j2snU-0007lB-VG
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:27:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2708 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j2snU-0007jQ-Ji; Sat, 15 Feb 2020 03:27:32 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1B02CD491ADDFC9E03CD;
 Sat, 15 Feb 2020 16:27:27 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Feb
 2020 16:27:17 +0800
Subject: Re: [PATCH 1/2] s390x: fix memleaks in cpu_finalize
To: <cohuck@redhat.com>, <rth@twiddle.net>, <david@redhat.com>
References: <20200215083203.5064-1-pannengyuan@huawei.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <626d0b84-e9ab-0c9c-7760-c281d14b1afb@huawei.com>
Date: Sat, 15 Feb 2020 16:27:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200215083203.5064-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: qemu-s390x@nongnu.org, euler.robot@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/15/2020 4:32 PM, pannengyuan@huawei.com wrote:

I'm sorry for the mail's subject, it's a single patch.
[PATCH 1/2]  --->  [PATCH]

> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x. The leak stack is as follow:
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>     #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:530
>     #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:551
>     #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qemu/timer.h:569
>     #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/s390x/cpu.c:285
>     #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:372
>     #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:516
>     #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qom/object.c:684
>     #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/s390-virtio-ccw.c:64
>     #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/machine-hmp-cmds.c:57
>     #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/monitor/hmp.c:1082
>     #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/qemu/monitor/misc.c:142
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  target/s390x/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index cf84d307c6..fff793a4eb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -294,6 +294,10 @@ static void s390_cpu_finalize(Object *obj)
>  
>      qemu_unregister_reset(s390_cpu_machine_reset_cb, cpu);
>      g_free(cpu->irqstate);
> +    timer_del(cpu->env.tod_timer);
> +    timer_del(cpu->env.cpu_timer);
> +    timer_free(cpu->env.tod_timer);
> +    timer_free(cpu->env.cpu_timer);
>  #endif
>  }
>  
> 

