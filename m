Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C46C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967E82082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhdnqh5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967E82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZE7T-0007Rt-EK
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZE3s-0004Nq-Jw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZE3r-0005wp-3s
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:05:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZE3q-0005v9-EA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lr6W4KR9wCbeu3QHPLleS62fXfo9S/hzHQ4EieD02R8=;
 b=Vhdnqh5dwaDJQAEuvCUgdYqjYB6SyqINqNUr1cjUmqjeATDNW3lrtieNp6i6jSHWKU7PPo
 fUKpcte6SJwXHdq5s0d5oeQQJPKNliOPzt7UjUsACFZt6J83DiHdLbW7MleuPsaifxpx/x
 3p830dJgZPcmFthRheklbcbU07oYIDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-Ui7liGxSNXCVa43C1JfoQg-1; Mon, 25 Nov 2019 08:05:47 -0500
Received: by mail-wr1-f71.google.com with SMTP id 90so5446625wrq.6
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mgG0bIcOz7g59k5sOe8AK4HwNncmlMwW5U4m6dEUMwA=;
 b=NTyBGPNb2PEByYc14zV/jx3k024ReC9X+0JbKUC7jQLxoEu1xrCAUSUpwmDa4XuKNC
 WKVD9oAeySJSvvqAtH3gK4yCh3g3g77mEF7+8mliJLssGqhdQ2kuqre7i/AjFB4DSmuJ
 jaMTMODR9ZJV0qunGZ7G1SOK2HGJc/qs11/CArOHQ0DHtMISwaPRorF6s/1zOpDOQwwb
 tOWPvbQybjkqm3PRanONmJTOHyguX4njqGfP/AF9svzaKylDjEDoTkolj2dixxZAfRVd
 1MAiESWzsV7qdzX+PGSbVHQABGG1cyB8TRXvWWMi2CNOvgRcS9b1+mU158kY3P+OEcK7
 tb2g==
X-Gm-Message-State: APjAAAUTKHr+mWv+RAUKnAOz+2Ic5j+05SDU6S0o56uZlllkD5TqO0UL
 KDJ5iqz3zUJw+fVF6tY5LYtgpoaHyEmvJBWxHVgDgTl3Vo10rlFRsJp3VAeEARvW1YQ5P1iWd6w
 w2ANjCdHqHYmS1qY=
X-Received: by 2002:adf:e387:: with SMTP id e7mr16114375wrm.180.1574687145756; 
 Mon, 25 Nov 2019 05:05:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwlWpOjbK+PSoKQj49eohkl9fLZYT0FBE5ZorBZrUYHjzliKPlGUkJTWpHfSVo2Com/Ea4n7A==
X-Received: by 2002:adf:e387:: with SMTP id e7mr16114323wrm.180.1574687145301; 
 Mon, 25 Nov 2019 05:05:45 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o187sm8561351wmo.20.2019.11.25.05.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 05:05:44 -0800 (PST)
Subject: Re: [PATCH v6 2/9] hw/core/clock-vmstate: define a vmstate entry for
 clock state
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-3-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e024d6ba-42a7-5f67-7cdd-edfc1b3a73e4@redhat.com>
Date: Mon, 25 Nov 2019 14:05:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190904125531.27545-3-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: Ui7liGxSNXCVa43C1JfoQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
 alistair@alistair23.me, mark.burton@greensocs.com, marcandre.lureau@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 2:55 PM, Damien Hedde wrote:
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
> This was in the previous reviewed commit. But it can't be in the
> clock.c file in order to allow linux-user builds.
> ---
>   hw/core/Makefile.objs   |  1 +
>   hw/core/clock-vmstate.c | 25 +++++++++++++++++++++++++
>   include/hw/clock.h      |  9 +++++++++
>   3 files changed, 35 insertions(+)
>   create mode 100644 hw/core/clock-vmstate.c
>=20
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index c66a5b2c6b..8fcebf2e67 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-y +=3D bus.o reset.o
>   common-obj-y +=3D resettable.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>   common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
> +common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
>   # irq.o needed for qdev GPIO handling:
>   common-obj-y +=3D irq.o
>   common-obj-y +=3D hotplug.o
> diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
> new file mode 100644
> index 0000000000..c781369c15
> --- /dev/null
> +++ b/hw/core/clock-vmstate.c
> @@ -0,0 +1,25 @@
> +/*
> + * Clock migration structure
> + *
> + * Copyright GreenSocs 2019
> + *
> + * Authors:
> + *  Damien Hedde <damien.hedde@greensocs.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "hw/clock.h"
> +
> +const VMStateDescription vmstate_clockin =3D {
> +    .name =3D "clock",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(frequency, ClockIn),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index fd11202ba4..e7efb6ad17 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -34,6 +34,15 @@ struct ClockOut {
>       QLIST_HEAD(, ClockIn) followers; /* list of registered clocks */
>   };
>  =20
> +/*
> + * vmstate description entry to be added in device vmsd.
> + */
> +extern const VMStateDescription vmstate_clockin;
> +#define VMSTATE_CLOCKIN(_field, _state) \
> +    VMSTATE_CLOCKIN_V(_field, _state, 0)
> +#define VMSTATE_CLOCKIN_V(_field, _state, _version) \
> +    VMSTATE_STRUCT_POINTER_V(_field, _state, _version, vmstate_clockin, =
ClockIn)
> +
>   /**
>    * clock_out_setup_canonical_path:
>    * @clk: clock
>=20


