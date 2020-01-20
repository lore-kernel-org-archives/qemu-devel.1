Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EEBC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6138C22525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9UgBEhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6138C22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcV1-000160-GY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itcTk-00009C-SO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itcTj-00039i-Fo
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itcTj-00039X-Ar
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579547570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nV9CCDQfq1LCJUm7gKOKZQDF2CViGC2Za+xpFJgv1po=;
 b=D9UgBEhPgrRn16XEq5Vo6zkgATTOcYZkmXXoOQRhsDja+OvB4vT/xG8CxwHdt7oNUjzUpZ
 MN+tBZaoIkpXkVejt2SPAtOB+Q7c127Hw5CUd/YcS+9PUnFqNiotBt1NF9/6OTEUlHnny+
 b8tIFj+8ZyfWgk1hrA/kwlfM69gF4Xo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-6-GJYTvwP0qNK5hF7LpoaQ-1; Mon, 20 Jan 2020 14:12:49 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so196308wrx.22
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 11:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yx6Vg8VJI9QHGc+Wnu/eB7hR+mtDv8JCNsEyNJP6Jnw=;
 b=Dztk+VjRiWNFW8SIWPIpmPDnVexdGOYZTrFWaM3QIqFpDvlB0IU1J2dzb6ww9JzDXR
 Eki1+e/P+LMnhn48Do3jE4nenBr+h1b6EcnL45G7BvVcOLkF6r1Vp+z22/zEDGdOqAow
 pBUlMbXd7RjocjlHUOo1NBsm2RWsA5KvO26mg2te3Zk1vFv5MRfa2stMdu6SoDJYeZYr
 1rvSk+b4d/EsFtvph4AFd2DCqiflUYJBaVOWjO//IPPWTDjY+C04yccHCA+0Tnt3G1uI
 DYYFY02BLXFsOZ/FD1rOyrGu8ZkxZ8VPxR6NbBVl3Tf3p7TN/h1vVS6et8Apxi4IbCaK
 pjTg==
X-Gm-Message-State: APjAAAVJdI2/+QN6bXFNbVnIPalrREDjgxd3anU0mbzvQDF30Ql4xdX4
 5/5nseytIaGY1DJEATundEdgJgeAs3fiTsQuE1XzlyTL7y4d+qshXxIJa4oGQX06v9nu67T+Z78
 FMzZpLwHKM/xhVOA=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr353351wma.72.1579547568275;
 Mon, 20 Jan 2020 11:12:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbFANKNiH5PyTAcqOgjZgV6/C56F5M86BWRfX0n7CtXSWtSDMjqqCd0xJsnzfMmi7R+B05fQ==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr353337wma.72.1579547568075;
 Mon, 20 Jan 2020 11:12:48 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n10sm47905210wrt.14.2020.01.20.11.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 11:12:47 -0800 (PST)
Subject: Re: [PATCH v3 2/2] hw/timer/m48t59: Convert debug printf()s to trace
 events
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200117165809.31067-1-philmd@redhat.com>
 <20200117165809.31067-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <237b70ba-9f2d-1882-a304-962435bf5af5@redhat.com>
Date: Mon, 20 Jan 2020 20:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117165809.31067-3-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 6-GJYTvwP0qNK5hF7LpoaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 5:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/rtc/m48t59-internal.h |  5 -----
>   hw/rtc/m48t59.c          | 11 +++++------
>   hw/rtc/trace-events      |  6 ++++++
>   3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
> index 4d4f2a6fed..cd648241e9 100644
> --- a/hw/rtc/m48t59-internal.h
> +++ b/hw/rtc/m48t59-internal.h
> @@ -26,11 +26,6 @@
>   #ifndef HW_M48T59_INTERNAL_H
>   #define HW_M48T59_INTERNAL_H
>  =20
> -#define M48T59_DEBUG 0
> -
> -#define NVRAM_PRINTF(fmt, ...) do { \
> -    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
> -
>   /*
>    * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 =
has
>    * alarm and a watchdog timer and related control registers. In the
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index fc592b9fb1..ecc92ca476 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -35,6 +35,7 @@
>   #include "exec/address-spaces.h"
>   #include "qemu/bcd.h"
>   #include "qemu/module.h"
> +#include "trace.h"
>  =20
>   #include "m48t59-internal.h"
>   #include "migration/vmstate.h"
> @@ -192,8 +193,7 @@ void m48t59_write(M48t59State *NVRAM, uint32_t addr, =
uint32_t val)
>       struct tm tm;
>       int tmp;
>  =20
> -    if (addr > 0x1FF8 && addr < 0x2000)
> -=09NVRAM_PRINTF("%s: 0x%08x =3D> 0x%08x\n", __func__, addr, val);
> +    trace_m48txx_nvram_mem_write(addr, val);
>  =20
>       /* check for NVRAM access */
>       if ((NVRAM->model =3D=3D 2 && addr < 0x7f8) ||
> @@ -450,8 +450,7 @@ uint32_t m48t59_read(M48t59State *NVRAM, uint32_t add=
r)
>   =09}
>           break;
>       }
> -    if (addr > 0x1FF9 && addr < 0x2000)
> -       NVRAM_PRINTF("%s: 0x%08x <=3D 0x%08x\n", __func__, addr, retval);
> +    trace_m48txx_nvram_mem_read(addr, retval);
>  =20
>       return retval;
>   }
> @@ -462,7 +461,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, u=
int64_t val,
>   {
>       M48t59State *NVRAM =3D opaque;
>  =20
> -    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" =3D> 0x%"PRIx64"\n", __func__, ad=
dr, val);
> +    trace_m48txx_nvram_io_write(addr, val);
>       switch (addr) {
>       case 0:
>           NVRAM->addr &=3D ~0x00FF;
> @@ -494,7 +493,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr=
, unsigned size)
>           retval =3D -1;
>           break;
>       }
> -    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <=3D 0x%08x\n", __func__, addr, r=
etval);
> +    trace_m48txx_nvram_io_read(addr, retval);
>  =20
>       return retval;
>   }
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index d6749f4616..52c1566198 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -17,3 +17,9 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks=
"
>   # aspeed-rtc.c
>   aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
>   aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " v=
alue 0x%08" PRIx64
> +
> +# m48t59.c
> +m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04"=
 PRIx64 " value:0x%02" PRIx64
> +m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%0=
4" PRIx64 " value:0x%02" PRIx64
> +m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%0=
4x value:0x%02x"
> +m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x=
%04x value:0x%02x"
>=20

I dropped the other patch from this series.

Since Herv=C3=A9 already reviewed it:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg671652.html
and it applies properly, can it get queued?

Thanks,

Phil.


