Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF0C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52069206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBChgXwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52069206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cze-0007MN-H6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cxt-0006dA-22
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cxq-0006J2-Mn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:45:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cxq-0006GC-J8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/fulFHrafqGq2n0MCIzj3y8MCjcVkLWUrr6GE47ebM=;
 b=LBChgXwTpTeLheMd8w63YIj/bxtgqnQ4J+5IP9uLSPRa9mj5Lk0n0CAbjx3HNGDA8amKlE
 xie6S20UDv3WYsv+rKH7GNQHKHFuWEmNYrVsvvMogjkWmGIcui4jtH4kcoN9FZWnZljpMh
 Cw6XcP6IaaUDqlbHPmhysI+BbGqBOwI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-NHz_dOfrPsyUI-UdQprqXQ-1; Mon, 17 Feb 2020 04:45:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so6777404wma.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+7hc+vITPTYEl7pL1mRIzG8mgOlv43afEzF0950NGHk=;
 b=Xjm2LUIbpWZgcXWLuPlUVSd2KFegu9Ox+2AFFBPYhttCZHO2LxK4VjsA6zXA9gkkzT
 iPd73ep7KyRyfikpd7ZLdUDPX4Pe4jo1RzEsYOkXqzus59kmYY7VJSaD3kj9uZflZphW
 LfO2z9YZMJSoJsJ0uj/xubL3JHc0Bbl9B5CbvEkJzt1v046fNePNCwuzAmQG2O8mU4rX
 9notIjEw0gfVvH23UXK3AeprrL70rxqSPO4ZPFDo1qVbozyY9AnKe1ynfDFYz5jPpyR1
 ufEbCuGjI9VCpzAlxpXd+tsTF24xErb4mwyZUfGkXSXllCvsB6PJsKyOFmuHZVYjUsAY
 j8ww==
X-Gm-Message-State: APjAAAXMhdcjINpG71cqBdkhX3WHAE0dPDTku6LTUi4csxmw5hGpkgjY
 drm/sMMyKHaNoKiB+NA+Zh6F0RXzvSmug9ZIxBPCi0u/C7i+4z58Fa/hb7BHIyrpcrq9Kynb5wA
 eP2yodXKiMTEKb1Y=
X-Received: by 2002:adf:de86:: with SMTP id w6mr22000417wrl.115.1581932709822; 
 Mon, 17 Feb 2020 01:45:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzy8IcxJ77U6gFFfxI1mAS7j3QRzwFpc1VA+X0+C8ZTD8SDCE+L/LZl8oKgWGgSL4qUMazDbA==
X-Received: by 2002:adf:de86:: with SMTP id w6mr22000366wrl.115.1581932709526; 
 Mon, 17 Feb 2020 01:45:09 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 18sm20105851wmf.1.2020.02.17.01.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 01:45:09 -0800 (PST)
Subject: Re: [PATCH v2 1/2] s390x: fix memleaks in cpu_finalize
To: pannengyuan@huawei.com, balrogg@gmail.com, peter.maydell@linaro.org,
 mav2-rk.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au,
 edgar.iglesias@gmail.com, alistair@alistair23.me
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-2-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <60b21fff-e6f4-93f7-ca7d-4f2ef6388870@redhat.com>
Date: Mon, 17 Feb 2020 10:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217032127.46508-2-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: NHz_dOfrPsyUI-UdQprqXQ-1
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
Cc: zhang.zhanghailiang@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 euler.robot@huawei.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 4:21 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390x. =
The leak stack is as follow:
>=20
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>      #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef9=
70)
>      #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>      #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include/q=
emu/timer.h:530
>      #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu/t=
imer.h:551
>      #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/qem=
u/timer.h:569
>      #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target/s=
390x/cpu.c:285
>      #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/qo=
m/object.c:372
>      #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new/q=
emu/qom/object.c:516
>      #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/qom=
/object.c:684
>      #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x/s=
390-virtio-ccw.c:64
>      #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/mac=
hine-hmp-cmds.c:57
>      #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/moni=
tor/hmp.c:1082
>      #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/qe=
mu/monitor/misc.c:142
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Cornelia Huck <cohuck@redhat.com>
> ---
> Changes v2 to v1:
> - Similarly to other cleanups, move timer_new into realize, then do
> timer_del in unrealize.
> ---
>   target/s390x/cpu.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index cf84d307c6..f18dbc6fe4 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -170,7 +170,12 @@ static void s390_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(dev);
>   #if !defined(CONFIG_USER_ONLY)
>       S390CPU *cpu =3D S390_CPU(dev);
> +    cpu->env.tod_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> +    cpu->env.cpu_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>   #endif
> +
>       Error *err =3D NULL;
>  =20
>       /* the model has to be realized before qemu_init_vcpu() due to kvm =
*/
> @@ -227,6 +232,16 @@ out:
>       error_propagate(errp, err);
>   }
>  =20
> +static void s390_cpu_unrealizefn(DeviceState *dev, Error **errp)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    S390CPU *cpu =3D S390_CPU(dev);
> +
> +    timer_del(cpu->env.tod_timer);
> +    timer_del(cpu->env.cpu_timer);
> +#endif
> +}
> +
>   static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
>   {
>       GuestPanicInformation *panic_info;
> @@ -279,10 +294,6 @@ static void s390_cpu_initfn(Object *obj)
>                           s390_cpu_get_crash_info_qom, NULL, NULL, NULL, =
NULL);
>       s390_cpu_model_register_props(obj);
>   #if !defined(CONFIG_USER_ONLY)
> -    cpu->env.tod_timer =3D
> -        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> -    cpu->env.cpu_timer =3D
> -        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>       s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>   #endif
>   }
> @@ -294,6 +305,8 @@ static void s390_cpu_finalize(Object *obj)
>  =20
>       qemu_unregister_reset(s390_cpu_machine_reset_cb, cpu);
>       g_free(cpu->irqstate);
> +    timer_free(cpu->env.tod_timer);
> +    timer_free(cpu->env.cpu_timer);
>   #endif
>   }
>  =20
> @@ -453,6 +466,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>  =20
>       device_class_set_parent_realize(dc, s390_cpu_realizefn,
>                                       &scc->parent_realize);
> +    dc->unrealize =3D s390_cpu_unrealizefn;
>       device_class_set_props(dc, s390x_cpu_properties);
>       dc->user_creatable =3D true;
>  =20
>=20

Thanks for v2.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


