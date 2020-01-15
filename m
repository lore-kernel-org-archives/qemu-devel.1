Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E7CC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD66207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J731ml2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD66207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irsMw-0003AB-70
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irsLE-0001Tf-V6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irsLC-0002PK-40
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:44:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irsLC-0002P5-0y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579131889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYzb9Ijo1nMtYL3Oa45wYjXe74CGzSTjYh3JwrLB2CE=;
 b=J731ml2YTM8sfBwppD7Ve58uXw9oji6oalYxADDJlmCqMxfZUCAWe3O+sjyuRieh5I3URi
 iuXPZ1O5r1VnFcBy+rstY1a/isqlxEmx/ofCd9foKMIUOESgkt9vgv/oN0BRnK2RwV2O3K
 G60Dfvz3PxhXnNvShnEDlbY3njofbFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ol_fnI9JPtOZ8PfeBKwFgw-1; Wed, 15 Jan 2020 18:44:46 -0500
Received: by mail-wm1-f72.google.com with SMTP id f25so537126wmb.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tWL6EDrMlQylQ5qAVv5Nx+MzERkdTlbkYO3n2ErhjKU=;
 b=gAV457xmexmTBIZqVzL+VEv5Q8Wf9BTKR0mKgsmmMknMjaIV4xgbrCUGxftWxFzKGw
 9WuW6ZLDgUxAPDN8pQdDbJ3FJAnZx1mJ7EI7NLvWsRTYZVPLmdAnS/zzANSDe5bmUdp9
 QM43rKM6tkdQpe5+u412C95TZGOtvJplTOsJgMAga5BqdprXcsuWjtiKE9oWjv9v/QeD
 4LdlMon7qFZVXX3rnxigw7K6WEY6pydexK5AunWoor0dP9B7eM0QkmqT1YVKWit+jKBH
 ERyQ+YliHkxQZ6+l9Nu/fYabhkSeD1QvHn8KvliulKH7vBDTgWXgY8smF/DcKYzTg5X8
 okVg==
X-Gm-Message-State: APjAAAV2duJcl7z1w6EKf2EeyvryuFVfarm3yRv1oV2NCq3C08ZNEvZ6
 3uPRlI+Qnlw46Ihta7NlnNddcEAK6d+1EjyyK3LhZlECOyXj312l7Sw0dcf/mk2fFsPmNDhw1C+
 GqkFfQh0y6n6LfW8=
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr2704117wmc.173.1579131884972; 
 Wed, 15 Jan 2020 15:44:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7a9BWQGeVUopVsjXYS8CuYLRt8G3rE01OmVHmU2BTEt/mjKqnwMaLxZeB94ZCSoWjMO+FKw==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr2704088wmc.173.1579131884634; 
 Wed, 15 Jan 2020 15:44:44 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id 2sm26088299wrq.31.2020.01.15.15.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 15:44:44 -0800 (PST)
Subject: Re: [PATCH v7 10/11] vl: replace deprecated qbus_reset_all
 registration
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-11-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0cc5fa09-6014-e5aa-a7e4-de0c940a7e0b@redhat.com>
Date: Thu, 16 Jan 2020 00:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-11-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: ol_fnI9JPtOZ8PfeBKwFgw-1
X-Mimecast-Spam-Score: 0
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
> the sysbus reset registration.
>=20
> Apart for the raspi machines, this does not impact the behavior
> because:
> + at this point resettable just calls the old reset methods of devices
>    and buses in the same order as qdev/qbus.
> + resettable handlers registered with qemu_register_reset are
>    serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>    qdev/qbus_reset) inside this reset handler will not be masked out
>    by resettable mechanism; they do not go through resettable api.
>=20
> For the raspi machines, during the sysbus reset the sd-card is not
> reset twice anymore but only once. This is a consequence of switching
> both sysbus reset and changing parent to resettable; it detects the
> second reset is not needed. This has no impact on the state after
> reset; the sd-card reset method only reset local state and query
> information from the block backend.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> The raspi reset change can be observed by using the following command
> (reset will occurs, then do Ctrl-C to end qemu; no firmware is
> given here).
> qemu-system-aarch64 -M raspi3 \
>      -trace resettable_phase_hold_exec \
>      -trace qdev_update_parent_bus \
>      -trace resettable_change_parent \
>      -trace qdev_reset -trace qbus_reset
>=20
> Before the patch, the qdev/qbus_reset traces show when reset method are
> called. After the patch, the resettable_phase_hold_exec show when reset
> method are called.
>=20
> The traced reset order of the raspi3 is listed below. I've added empty
> lines and the tree structure.
>=20
>   +->bcm2835-peripherals reset
>   |
>   |       +->sd-card reset
>   |   +->sd-bus reset
>   +->bcm2835_gpio reset
>   |      -> dev_update_parent_bus (move the sd-card on the sdhci-bus)
>   |      -> resettable_change_parent
>   |
>   +->bcm2835-dma reset
>   |
>   |   +->bcm2835-sdhost-bus reset
>   +->bcm2835-sdhost reset
>   |
>   |       +->sd-card (reset ONLY BEFORE BEFORE THE PATCH)
>   |   +->sdhci-bus reset
>   +->generic-sdhci reset
>   |
>   +->bcm2835-rng reset
>   +->bcm2835-property reset
>   +->bcm2835-fb reset
>   +->bcm2835-mbox reset
>   +->bcm2835-aux reset
>   +->pl011 reset
>   +->bcm2835-ic reset
>   +->bcm2836-control reset
> System reset
>=20
> In both case, the sd-card is reset (being on bcm2835_gpio/sd-bus) then mo=
ved
> to generic-sdhci/sdhci-bus by the bcm2835_gpio reset method.
>=20
> Before the patch, it is then reset again being part of generic-sdhci/sdhc=
i-bus.
> After the patch, it considered again for reset but its reset method is no=
t
> called because it is already flagged as reset.

I find this information helpful, have you considered including it in the=20
description?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   vl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index 751401214c..e5a537d4f9 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4362,7 +4362,15 @@ int main(int argc, char **argv, char **envp)
>  =20
>       /* TODO: once all bus devices are qdevified, this should be done
>        * when bus is created by qdev.c */
> -    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
> +    /*
> +     * TODO: If we had a main 'reset container' that the whole system
> +     * lived in, we could reset that using the multi-phase reset
> +     * APIs. For the moment, we just reset the sysbus, which will cause
> +     * all devices hanging off it (and all their child buses, recursivel=
y)
> +     * to be reset. Note that this will *not* reset any Device objects
> +     * which are not attached to some part of the qbus tree!
> +     */
> +    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
>       qemu_run_machine_init_done_notifiers();
>  =20
>       if (rom_check_and_register_reset() !=3D 0) {
>=20


