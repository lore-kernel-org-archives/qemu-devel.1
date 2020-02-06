Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62780C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF14214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOgRhHJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF14214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpm6-0004kJ-Bn
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izplX-00045L-GC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izplU-0008SV-Tx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:36:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izplU-0008OD-Kk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581028610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6y4pzATAlHIDmyVJLNFGI5qV3mVGjQvszdgpvugpmQQ=;
 b=TOgRhHJKkpEeKTtWKZz1CuGJfuAh59ktiAvP7UdNutFD7k7EljEKhnFT+42/6mn0j637lr
 0Y30/Fr5weve35hPUtz5M+8ljwE29pkJzO71+WJUg5vGG0MB9gcFKrBAIJbtEQF0i36dZX
 vVjIMBJQCyNTs8nVhgONfBd/Qc+FXo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-IhZdW5t4NjmzcXlXWZjAFA-1; Thu, 06 Feb 2020 17:36:48 -0500
Received: by mail-wm1-f70.google.com with SMTP id s25so19751wmj.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 14:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SeYsvsep7ZhIjrKwb0JaKUkk96OxwMi4+9Kwg7zK+9Q=;
 b=ruuMTbtWcrn3sLMrPqOzbopL4juTjwcpQjYhzbYDGUi9+gi56TG4gUZhXcEleE2Av2
 NI9nzoxGKD6LVZc8o8CIIUn0WcAYG78Q2Rt6jd16K/uqDBuPjHNd7CH41C8BU3QnzMze
 mhZLGsWd4PsakzR0xeICJ7c1ZjeEWPoqzLaoPKHZClJPA6m2q/xX7ULPPEiRhJErkvlR
 T0YURnjsvlW/2FvJcPLumIPmVaIt3TCyxi2rjNOu03GrO/E0+1TlvGzr7q3e6CNRO5Cn
 JhrZRrxQoEQMrqY2JF32egcnDZGZQfZR/QcbVDXC2UJ7sV5ZiTxBkfpT/e6VPrZ/syUa
 tPUA==
X-Gm-Message-State: APjAAAVrQ3nckDDIjcM/USq0t4nh5qxQjQkVBtzQI36u7QJyC+YawlAk
 lidpQXBUOjiOch/VDFwZyTvSH4+GMQSCW4VGZjKCf6hjdkFDgOC+8rpnVok8Rg6/Qmr6xJnYY49
 YtFFqEhapYjipONI=
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr243594wrs.326.1581028607064; 
 Thu, 06 Feb 2020 14:36:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHvfI4hBvcGJmPtfp5YreiBzzXtQdP52YJ03XsstTM3EVnMQy8b6xNGfM2AOEZEWHCj/J/Kw==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr243573wrs.326.1581028606798; 
 Thu, 06 Feb 2020 14:36:46 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k16sm857932wru.0.2020.02.06.14.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 14:36:46 -0800 (PST)
Subject: Re: [PATCH] apic: Report current_count via 'info lapic'
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
References: <f6c36298-5e63-f4c6-654c-3b16010ae6da@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d05c5a8-34fb-3309-ebba-14d187813756@redhat.com>
Date: Thu, 6 Feb 2020 23:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f6c36298-5e63-f4c6-654c-3b16010ae6da@siemens.com>
Content-Language: en-US
X-MC-Unique: IhZdW5t4NjmzcXlXWZjAFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 8:50 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This is helpful when debugging stuck guest timers.
>=20
> As we need apic_get_current_count for that, and it is really not
> emulation specific, move it to apic_common.c and export it.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/intc/apic.c                  | 18 ------------------
>   hw/intc/apic_common.c           | 18 ++++++++++++++++++
>   include/hw/i386/apic_internal.h |  1 +
>   target/i386/helper.c            |  5 +++--
>   4 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index bd40467965..f2207d0ace 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -615,24 +615,6 @@ int apic_accept_pic_intr(DeviceState *dev)
>       return 0;
>   }
>  =20
> -static uint32_t apic_get_current_count(APICCommonState *s)
> -{
> -    int64_t d;
> -    uint32_t val;
> -    d =3D (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load=
_time) >>
> -        s->count_shift;
> -    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> -        /* periodic */
> -        val =3D s->initial_count - (d % ((uint64_t)s->initial_count + 1)=
);
> -    } else {
> -        if (d >=3D s->initial_count)
> -            val =3D 0;
> -        else
> -            val =3D s->initial_count - d;
> -    }
> -    return val;
> -}
> -
>   static void apic_timer_update(APICCommonState *s, int64_t current_time)
>   {
>       if (apic_next_timer(s, current_time)) {
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 9ec0f2deb2..6f4e877878 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -189,6 +189,24 @@ bool apic_next_timer(APICCommonState *s, int64_t cur=
rent_time)
>       return true;
>   }
>  =20
> +uint32_t apic_get_current_count(APICCommonState *s)
> +{
> +    int64_t d;
> +    uint32_t val;
> +    d =3D (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load=
_time) >>
> +        s->count_shift;
> +    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
> +        /* periodic */
> +        val =3D s->initial_count - (d % ((uint64_t)s->initial_count + 1)=
);
> +    } else {
> +        if (d >=3D s->initial_count)
> +            val =3D 0;
> +        else
> +            val =3D s->initial_count - d;

Using QEMU style if () {} else {}:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    }
> +    return val;
> +}
> +
>   void apic_init_reset(DeviceState *dev)
>   {
>       APICCommonState *s;
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
> index b04bdd947f..2597000e03 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -211,6 +211,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUSta=
te *cpu, target_ulong ip,
>                                TPRAccess access);
>  =20
>   int apic_get_ppr(APICCommonState *s);
> +uint32_t apic_get_current_count(APICCommonState *s);
>  =20
>   static inline void apic_set_bit(uint32_t *tab, int index)
>   {
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c3a6e4fabe..e3c3726c29 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -370,10 +370,11 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, in=
t flags)
>       dump_apic_lvt("LVTTHMR", lvt[APIC_LVT_THERMAL], false);
>       dump_apic_lvt("LVTT", lvt[APIC_LVT_TIMER], true);
>  =20
> -    qemu_printf("Timer\t DCR=3D0x%x (divide by %u) initial_count =3D %u\=
n",
> +    qemu_printf("Timer\t DCR=3D0x%x (divide by %u) initial_count =3D %u"
> +                " current_count =3D %u\n",
>                   s->divide_conf & APIC_DCR_MASK,
>                   divider_conf(s->divide_conf),
> -                s->initial_count);
> +                s->initial_count, apic_get_current_count(s));
>  =20
>       qemu_printf("SPIV\t 0x%08x APIC %s, focus=3D%s, spurious vec %u\n",
>                   s->spurious_vec,
>=20


