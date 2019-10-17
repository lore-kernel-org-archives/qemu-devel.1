Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA1ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1C2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyveBE4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9GF-000230-Pp
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL8BV-0000jt-So
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL8BU-0003wT-QK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:59:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL8BU-0003wE-F5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571327967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgxfXQKkr5equlzC/PknHrgeF9deydhlD5fX1KLxo8M=;
 b=fyveBE4dxcu52nRjswQ5Fq5mK0S6NOvokQQqweL5uHCd/W+1UGmOIJ1b6pNtqaNcPeipOH
 ls8hLO58pvVS7gWXGYcpTinJ2ndggb+CNqhya2o8DZfg+sEgqHyyJDgb7wYEJFxWO44jMU
 YagmUhijnvvU/HHz3h4xy7zguFfg8qM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-8_nOJM5WMy26RFKbLaIYyA-1; Thu, 17 Oct 2019 11:59:24 -0400
Received: by mail-wr1-f71.google.com with SMTP id j14so898867wrm.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QJD8ZXrBCv+J8I/XlzghMfZwnqBkfjod0u7K3OlOY28=;
 b=a+WivWgSrO6a4xOyMZnRJinpc8bUahTlDnq7kE/Ko4v0Bduq4Cyf3XH5NEYL1oS7IF
 BG2Z+mErIdYQyW4mpy95Z3wCHfVagZfK8TctRZmg0VpfKIm3QVJnJ5MVoSCsYl/1RIWv
 xBUruUtE4JCJmqTL3+ASmOsMJy3aY+cCRDBIyoMcdM5+RxGwDyspvJfoSKpFEtoc+XRU
 iuf6ACwXMKYUv0MaHtzYXa5mu12TGOoykQwQ8w7NFGxEhPperBsSFjWjJxTHBCvgvGT9
 IzfTneakcB0yEuQT6H8c1cT5zy7C/79IZRmVwMQgBIdL7KJBI4kgX0ntluCeeqTx+yir
 thPw==
X-Gm-Message-State: APjAAAXm7fu5ZvlQuN8tBOObvPAF3KSsZgZfyzFwDV1nZC3/pkziYCRp
 vI6ONprd1yPvo5b1H32iRDVceJM75LbQgArOEJIiWqlpAGe1jzTbuBV22PxkMEhBevN27RWS3tz
 D4AgSvTGXsXX+Neo=
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr3696568wrr.66.1571327963307;
 Thu, 17 Oct 2019 08:59:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAvCfHknIrVs8Z5IX8WkSWQMhZIeqprJZEza06xPdIYR5RdkQhDcFukQcqoDew1hf1kYyZUA==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr3696542wrr.66.1571327963097;
 Thu, 17 Oct 2019 08:59:23 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id v20sm2296849wml.26.2019.10.17.08.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:59:22 -0700 (PDT)
Subject: Re: [PATCH 1/8] hw/timer/puv3_ost.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2808edfa-a837-de78-487f-0ae15c13d797@redhat.com>
Date: Thu, 17 Oct 2019 17:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-2-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: 8_nOJM5WMy26RFKbLaIYyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:28 PM, Peter Maydell wrote:
> Switch the puv3_ost code away from bottom-half based ptimers to the
> new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/puv3_ost.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
> index 0898da5ce97..697519593bb 100644
> --- a/hw/timer/puv3_ost.c
> +++ b/hw/timer/puv3_ost.c
> @@ -13,7 +13,6 @@
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
>   #include "hw/ptimer.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>  =20
>   #undef DEBUG_PUV3
> @@ -27,7 +26,6 @@ typedef struct PUV3OSTState {
>       SysBusDevice parent_obj;
>  =20
>       MemoryRegion iomem;
> -    QEMUBH *bh;
>       qemu_irq irq;
>       ptimer_state *ptimer;
>  =20
> @@ -68,6 +66,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
>       DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
>       switch (offset) {
>       case 0x00: /* Match Register 0 */
> +        ptimer_transaction_begin(s->ptimer);
>           s->reg_OSMR0 =3D value;
>           if (s->reg_OSMR0 > s->reg_OSCR) {
>               ptimer_set_count(s->ptimer, s->reg_OSMR0 - s->reg_OSCR);
> @@ -76,6 +75,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
>                       (0xffffffff - s->reg_OSCR));
>           }
>           ptimer_run(s->ptimer, 2);
> +        ptimer_transaction_commit(s->ptimer);
>           break;
>       case 0x14: /* Status Register */
>           assert(value =3D=3D 0);
> @@ -128,9 +128,10 @@ static void puv3_ost_realize(DeviceState *dev, Error=
 **errp)
>  =20
>       sysbus_init_irq(sbd, &s->irq);
>  =20
> -    s->bh =3D qemu_bh_new(puv3_ost_tick, s);
> -    s->ptimer =3D ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
> +    s->ptimer =3D ptimer_init(puv3_ost_tick, s, PTIMER_POLICY_DEFAULT);
> +    ptimer_transaction_begin(s->ptimer);
>       ptimer_set_freq(s->ptimer, 50 * 1000 * 1000);
> +    ptimer_transaction_commit(s->ptimer);
>  =20
>       memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3=
_ost",
>               PUV3_REGS_OFFSET);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


