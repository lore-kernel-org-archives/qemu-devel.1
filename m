Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15FC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C9520720
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 07:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+j0zUOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C9520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iysX2-0003Hi-Uz
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 02:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iysVl-0002j8-Sp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iysVh-00013M-Rb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:20:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iysVf-0000wq-61
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 02:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580800834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOLWci9krfbBgg5aSvBrwrLxELnY8h+iwsTqiErkRF0=;
 b=R+j0zUObCU2QeOh+TYl86X64A30UBQ4wpefGZNtGM0TmbVaMHiu4QsEJQQmDzOJyLifeeQ
 qN2PxpixUzFt5BE0jCfgEUkVXQ59b2/aD97zuf3JRq9FAkMWRGWvgxWRMZMAVbzAEKq72i
 dUsbWQIu9VkY6buH2ERnrZzJ9bTBC2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-hnHNWnFPMlKSKoo7P35L_g-1; Tue, 04 Feb 2020 02:20:32 -0500
Received: by mail-wm1-f70.google.com with SMTP id p26so915532wmg.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 23:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vj6AIQZkANUQLH8G9lzr2VuMGgWh8z7iG0WTZki8HaA=;
 b=BuH40Osvep+rTNPSooLLK2AUjwQ6FHX4ia0+/cNOyIK2Pxd1opeOMvCd7cJBILxTYw
 vVosu2YWEk7pkoQHySwpejTzmhDXlTwvT7POTShDWRq9+FbrPOU/Bmc4a2oufXZe8bD4
 lmV3d0JwOSjln8Qnz1JSZ0PoCrfeLSc4Jqp+ZbNkr2+zBKXUO15hDr1Hiwk8hZCzkoo+
 QopPUB55lLzG2QjSC03/HWSQv/6s+lCgGsTqKJE6A44Oo3pAZOuTjSFaMFlos9cABc7o
 HQ5jN338p3DdFp3KdwWpkS2xpFyZnZUxG76YApvE7q6LAiNcCrYTPtaOnHf0EuZuXmFo
 bKjA==
X-Gm-Message-State: APjAAAUaEBuJBxnTUBzc31AShirpz9m8DZce+d2K7p3pWDV6sLrgBYWJ
 OcdRZ/lJ5fIhhggn0YB/t8qGTUfCCijojJfAKyVYJtTdF4TXixtDtGVE+gM92DkJ+okg0QKSeHX
 Ao0OObf4GCSgSSdY=
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr19172275wrv.291.1580800831231; 
 Mon, 03 Feb 2020 23:20:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqXuePfBV5ANz5Sn1EqIp/uJzUtS7W89g/z0fuH6AMyTmWHDl3wpX/Oy6MY6LHkhifv7U8bg==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr19172247wrv.291.1580800830946; 
 Mon, 03 Feb 2020 23:20:30 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id n16sm29132607wro.88.2020.02.03.23.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 23:20:30 -0800 (PST)
Subject: Re: [PATCH v2] pl031: add finalize function to avoid memleaks
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200204020554.9380-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5357e046-5e07-bcaa-7731-f619a819ec26@redhat.com>
Date: Tue, 4 Feb 2020 08:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204020554.9380-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: hnHNWnFPMlKSKoo7P35L_g-1
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
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 3:05 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> There is a memory leak when we call 'device_list_properties' with
> typename =3D pl031. It's easy to reproduce as follow:
>=20
>    virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-prop=
erties", "arguments": {"typename": "pl031"}}'
>=20
> The memory leak stack:
>    Direct leak of 48 byte(s) in 1 object(s) allocated from:
>      #0 0x7f6e0925a970 in __interceptor_calloc (/lib64/libasan.so.5+0xef9=
70)
>      #1 0x7f6e06f4d49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>      #2 0x564a0f7654ea in timer_new_full /mnt/sdb/qemu/include/qemu/timer=
.h:530
>      #3 0x564a0f76555d in timer_new /mnt/sdb/qemu/include/qemu/timer.h:55=
1
>      #4 0x564a0f765589 in timer_new_ns /mnt/sdb/qemu/include/qemu/timer.h=
:569
>      #5 0x564a0f76747d in pl031_init /mnt/sdb/qemu/hw/rtc/pl031.c:198
>      #6 0x564a0fd4a19d in object_init_with_type /mnt/sdb/qemu/qom/object.=
c:360
>      #7 0x564a0fd4b166 in object_initialize_with_type /mnt/sdb/qemu/qom/o=
bject.c:467
>      #8 0x564a0fd4c8e6 in object_new_with_type /mnt/sdb/qemu/qom/object.c=
:636
>      #9 0x564a0fd4c98e in object_new /mnt/sdb/qemu/qom/object.c:646
>      #10 0x564a0fc69d43 in qmp_device_list_properties /mnt/sdb/qemu/qom/q=
om-qmp-cmds.c:204
>      #11 0x564a0ef18e64 in qdev_device_help /mnt/sdb/qemu/qdev-monitor.c:=
278
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes V2 to V1:
> - Delay the timer_new until realize instead of putting it into instance_i=
nit, since the pl031 can't be hotplugged(suggested by Peter Maydell).
> ---
>   hw/rtc/pl031.c | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
> index ae47f09635..0b9253eb30 100644
> --- a/hw/rtc/pl031.c
> +++ b/hw/rtc/pl031.c
> @@ -190,7 +190,11 @@ static void pl031_init(Object *obj)
>       qemu_get_timedate(&tm, 0);
>       s->tick_offset =3D mktimegm(&tm) -
>           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> +}
>  =20
> +static void pl031_realize(DeviceState *dev, Error **errp)
> +{
> +    PL031State *s =3D PL031(dev);
>       s->timer =3D timer_new_ns(rtc_clock, pl031_interrupt, s);
>   }
>  =20
> @@ -321,6 +325,7 @@ static void pl031_class_init(ObjectClass *klass, void=
 *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->vmsd =3D &vmstate_pl031;
> +    dc->realize =3D pl031_realize;
>       device_class_set_props(dc, pl031_properties);
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


