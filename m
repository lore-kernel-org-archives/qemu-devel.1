Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622F020873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/iRJWPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622F020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BSA-0008Qm-HZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2BRG-0007ZY-RA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2BRF-0007Ln-O6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:09:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2BRF-0007Lf-Kz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581588581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdXyG/D58nGTTZ4Q/Z+Ja2Drs+ebjXgkqHdk3W/qv8g=;
 b=Y/iRJWPaXzsR9xQm0eZh0Nhet8lGtw9HKOOsEfwpYij5TSNLuQd61zkzrOfSsF9Wwh5hqf
 KqXukQW6WFfvPaQ29XQLvBCMDwqjRvcN7UJzpSHDSLmxMrssqpsC1M4LX6qvJaEUlRKI06
 9gicn+HnPFILNq8B2/TWk2u0lfCFc9k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-hNHGAhW3Pe6WZAS-GY6zwg-1; Thu, 13 Feb 2020 05:09:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so2150082wrw.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 02:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IKlZaHBXk4EoDOO4VtPDWv8WiC25pil10IQwb52+r24=;
 b=iXsWl/yUfBbXB9HCY88gthtCet9hGr4krRgv/81ctrJ4exNPGq8s2It1eVrUtN+ZwY
 P/OiB6564O5eSC0xhQ5fP9bgzfh7NGsyA29xOZHCrrRxyV3FReF3kvA5u3MdlK4ubOIy
 reJPHBo9au9ezA9Jio4D2upMlsoB/0SgnMAhor8f7VscZxduzqpn3ba8pugpHjMWFa7u
 2TAyqYEKR0FqWIx2z88QeiDBZs2vwatFR20nXdY78IFUgTGJ5xe0KmGUHJs77iR8rzoR
 dExzxicqj2nJAAfmzxXFhxoy5m1pI1TyuwVezB/6KY3u1svj8gRBtwTGOkP3JboClJ5A
 t3aQ==
X-Gm-Message-State: APjAAAVZPm2KAYS+gmD5L4GSrDKdCEOUX4g/bcnsE2WXqstJc+R8FOnX
 RWTkzmXjjMYn6i60n89Mb5teVe4RCCMhh/Bz7N1yhGBoKl+ooaCKuTS2L1sX+JN7+n3Ee3RRqD6
 kIjtW7ZHrniCLu40=
X-Received: by 2002:adf:cd04:: with SMTP id w4mr22104298wrm.219.1581588573773; 
 Thu, 13 Feb 2020 02:09:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwErsgehsjoKxsQ8/N+7lmSsqQ3Y36vGPZdcUZ0YeTsPM4+dyzfEZ3nefZQfO6ZRvYSYDArdg==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr22104260wrm.219.1581588573435; 
 Thu, 13 Feb 2020 02:09:33 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w8sm2455892wmm.0.2020.02.13.02.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 02:09:32 -0800 (PST)
Subject: Re: [PATCH v2] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, i.mitsyanko@gmail.com,
 peter.maydell@linaro.org
References: <20200213025603.149432-1-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17ae20f0-fcf6-f9a0-b8e3-808255994dfb@redhat.com>
Date: Thu, 13 Feb 2020 11:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213025603.149432-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-MC-Unique: hNHGAhW3Pe6WZAS-GY6zwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, ehabkost@redhat.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 3:56 AM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> It's easy to reproduce as follow:
> virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-propert=
ies",
> "arguments":{"typename":"exynos4210.uart"}}'
>=20
> ASAN shows memory leak stack:
>    #1 0xfffd896d71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
>    #2 0xaaad270beee3 in timer_new_full /qemu/include/qemu/timer.h:530
>    #3 0xaaad270beee3 in timer_new /qemu/include/qemu/timer.h:551
>    #4 0xaaad270beee3 in timer_new_ns /qemu/include/qemu/timer.h:569
>    #5 0xaaad270beee3 in exynos4210_uart_init /qemu/hw/char/exynos4210_uar=
t.c:677
>    #6 0xaaad275c8f4f in object_initialize_with_type /qemu/qom/object.c:51=
6
>    #7 0xaaad275c91bb in object_new_with_type /qemu/qom/object.c:684
>    #8 0xaaad2755df2f in qmp_device_list_properties /qemu/qom/qom-qmp-cmds=
.c:152
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Changes V2 to V1:
> -Keep s->wordtime in exynos4210_uart_init (Base on Eduardo and Philippe's=
 comments).

Thanks.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/char/exynos4210_uart.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 25d6588e41..96d5180e3e 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -674,8 +674,6 @@ static void exynos4210_uart_init(Object *obj)
>       SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
>       Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>  =20
> -    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> -                                         exynos4210_uart_timeout_int, s)=
;
>       s->wordtime =3D NANOSECONDS_PER_SECOND * 10 / 9600;
>  =20
>       /* memory mapping */
> @@ -691,6 +689,9 @@ static void exynos4210_uart_realize(DeviceState *dev,=
 Error **errp)
>   {
>       Exynos4210UartState *s =3D EXYNOS4210_UART(dev);
>  =20
> +    s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                         exynos4210_uart_timeout_int, s)=
;
> +
>       qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
>                                exynos4210_uart_receive, exynos4210_uart_e=
vent,
>                                NULL, s, NULL, true);
>=20


