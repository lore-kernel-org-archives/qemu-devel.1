Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC2C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7952122B48
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 05:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebVD6p+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7952122B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igMf1-0000bo-LL
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 00:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igMeK-00009O-LX
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igMeI-0008Sm-SK
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:41:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igMeI-0008Rr-OG
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576388458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0s/ubqhSXOXO2e6r2j5Mz7iabVcLdvPZu+3hCSACoE=;
 b=ebVD6p+Z8BvVc7nKyk28F5UmTtUnxIEnYahTq3ekxBp3jv8ufXvQXs4X5nyErlo2p0Wc2c
 tOBlPyLEmr4Qqo2p5/jvi5wbpMR5YsJ/hfNYiVqv6rm2hfqOVjx4WkpL4tM2q4Ugto6Dh4
 Ot45T9ivzZb9OnzMQY1YqrEdMJJ9X9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-fgfCipS4M_a6z3rN2ATrcg-1; Sun, 15 Dec 2019 00:40:56 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so124029wrt.15
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 21:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ICAkoI6FXr31Hw+kfQLDohHBmOip9j6g5OFv1MOA51Y=;
 b=MuzKU1g0l7shx0yVPF+0VYqE+C8dwg6ecZLu3mk60/2C1BXd7kVHdx5gN8K3hrbhcg
 N6m192gz7cwAMekwU0ZSmScC4aReuCOEtbuyq8LSw5q0YmEC2n0j9FL19KME6KeNzVVp
 F/brC8Oi0Je9g1T0xgfe4FEwIWuxTcX198WA04rSpr4d1oLjdyZ335SlQUbfySI0nrIC
 /RkNukEG4Oi4yZ8GhUJtgHR8tkK2rA9rv71j45wtTxATLx/sfHPqvfXmFaqlfRUyVOxB
 8wOBV4Tf4rFPycCi9RfLtbm0oar9PpPEHFqoV4vyRWSTyoVbV8BOtylqW3YjdB/r14Wz
 akkg==
X-Gm-Message-State: APjAAAVW9EGGXoXLkTsIEamHS5L0GVPF7QVjjIz+KHfRcTDlV7vEvUBx
 GnzIKx1fC9ISOU9IRnUSk8QylIkr5qMpX82aVAyTC3I7gU2yzqb9SRAR5NvI6f4NYYMtvCdN/GV
 6eVfpIM83okUuMFs=
X-Received: by 2002:adf:f18b:: with SMTP id h11mr21923486wro.56.1576388455159; 
 Sat, 14 Dec 2019 21:40:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqypx4ZSHaLDPosY2LRxy90GT/YkjrqmxaT+sniI5kZHMeI+jPqH7t2raX+W9EIyWiH5SJ8xXg==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr21923474wro.56.1576388455001; 
 Sat, 14 Dec 2019 21:40:55 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g9sm16849700wro.67.2019.12.14.21.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 21:40:54 -0800 (PST)
Subject: Re: [PATCH v4 19/37] mips: use sysbus_add_io()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-20-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f6c3e1c-cb96-dac9-04b7-2319ecde7082@redhat.com>
Date: Sun, 15 Dec 2019 06:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-20-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: fgfCipS4M_a6z3rN2ATrcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/mips/mips_mipssim.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 3cd0e6eb33..2c2c7f25b2 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -227,8 +227,7 @@ mips_mipssim_init(MachineState *machine)
>           qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>           qdev_init_nofail(dev);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> -        memory_region_add_subregion(get_system_io(), 0x3f8,
> -                                    &SERIAL_IO(dev)->serial.io);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->seria=
l.io);

I'd simply squash this with the next patch, anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       }
>  =20
>       if (nd_table[0].used)
>=20


