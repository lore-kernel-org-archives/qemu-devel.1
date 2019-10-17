Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B95FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D0B21848
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6xyNbyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D0B21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8jF-0000Hs-Sm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL81n-0003Ml-K5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL81m-0007X1-F4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:49:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL81m-0007Wn-Bj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571327365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAavJ1bG08G+ixru3FHCqancYuv4/k4zRHujbPwY6ek=;
 b=a6xyNbyc1d3WsxH+6cuidlLKz/+D8qhEc5EhdAs2CNT3sGYKTimSVy9txXiIV8t5Ur3vY6
 LuZifz4U5yyghllvhjdsC1FR5Hub7X6svJfHbYvkxCgEoUw+T3ncI6rP2Y5xwq+FP8BaiA
 ND9i3Hlr8iYi42uiiKjJ3O8GDbcZSRE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-ES0JfmnDOViIhNMU8zZEcA-1; Thu, 17 Oct 2019 11:49:21 -0400
Received: by mail-wr1-f69.google.com with SMTP id e25so568346wra.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k2cSsyHx52uJ6FyjJ1xirldLHsvGiEKihz08/+wOIf4=;
 b=sONXV8aPxEd6FwBrrUGqd9bN2fZQAG2kU/xABL1AQdutdzEUVWW1Vy3JrIATpwPfBR
 OmEHXBJjj2C3ST/MPzHJs68KHfygSvv16dWQ/eyHdS/Pl3HqgYvWyV0537+SwNrvwkE/
 2lGn9jlc3ZH5k5x3KTfKwGS2cKSDbf6p4Nxs2otp77rnxdDHFmSKKIgY2TGzBlYpJs4F
 gHN+k00wAXPlsTYsEICmNL4nmBcvctJzxGMbYhtbnQAvhDTxkwde33yPnacQ+XW+nudW
 HHrkfGx6nLFVgfhwhBqhLU2KhTGPBCFZ2lWGkUZ0GpoRHqVZefzRv4k7q+bd7vD3yO5c
 nWCw==
X-Gm-Message-State: APjAAAUsOFGFUe1ad19FASgPFoibEeCBxrlMOAFSoYnQAPDE38WUuoZo
 IN4fi4LzgA8lbR6VtUTZVXNJpocYmeEwOzZydx2o690G0MPPv8z+TJ/JBa1eNzZ2oVyr70SQLrq
 pUWlWTFe3uhMVjPk=
X-Received: by 2002:a1c:444:: with SMTP id 65mr3632586wme.84.1571327360462;
 Thu, 17 Oct 2019 08:49:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXKoEMtIgx4posVf4wQB6PZ0Rvq7Zriv3xJ0W4ygElPPO6C21fbbh6qx0bXOm7DnKBa7xhYQ==
X-Received: by 2002:a1c:444:: with SMTP id 65mr3632568wme.84.1571327360248;
 Thu, 17 Oct 2019 08:49:20 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id e9sm11919780wme.3.2019.10.17.08.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:49:19 -0700 (PDT)
Subject: Re: [PATCH 8/8] hw/m68k/mcf5208.c: Switch to transaction-based ptimer
 API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e590107-5f91-457f-8cb0-f0ac8b38a162@redhat.com>
Date: Thu, 17 Oct 2019 17:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-9-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: ES0JfmnDOViIhNMU8zZEcA-1
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

On 10/17/19 3:29 PM, Peter Maydell wrote:
> Switch the mcf5208 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/m68k/mcf5208.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 34d34eba17c..158c5e4be75 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -9,7 +9,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -79,6 +78,7 @@ static void m5208_timer_write(void *opaque, hwaddr offs=
et,
>               return;
>           }
>  =20
> +        ptimer_transaction_begin(s->timer);
>           if (s->pcsr & PCSR_EN)
>               ptimer_stop(s->timer);
>  =20
> @@ -94,8 +94,10 @@ static void m5208_timer_write(void *opaque, hwaddr off=
set,
>  =20
>           if (s->pcsr & PCSR_EN)
>               ptimer_run(s->timer, 0);
> +        ptimer_transaction_commit(s->timer);
>           break;
>       case 2:
> +        ptimer_transaction_begin(s->timer);
>           s->pmr =3D value;
>           s->pcsr &=3D ~PCSR_PIF;
>           if ((s->pcsr & PCSR_RLD) =3D=3D 0) {
> @@ -104,6 +106,7 @@ static void m5208_timer_write(void *opaque, hwaddr of=
fset,
>           } else {
>               ptimer_set_limit(s->timer, value, s->pcsr & PCSR_OVW);
>           }
> +        ptimer_transaction_commit(s->timer);
>           break;
>       case 4:
>           break;
> @@ -182,7 +185,6 @@ static void mcf5208_sys_init(MemoryRegion *address_sp=
ace, qemu_irq *pic)
>   {
>       MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
>       m5208_timer_state *s;
> -    QEMUBH *bh;
>       int i;
>  =20
>       /* SDRAMC.  */
> @@ -191,8 +193,7 @@ static void mcf5208_sys_init(MemoryRegion *address_sp=
ace, qemu_irq *pic)
>       /* Timers.  */
>       for (i =3D 0; i < 2; i++) {
>           s =3D g_new0(m5208_timer_state, 1);
> -        bh =3D qemu_bh_new(m5208_timer_trigger, s);
> -        s->timer =3D ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
> +        s->timer =3D ptimer_init(m5208_timer_trigger, s, PTIMER_POLICY_D=
EFAULT);
>           memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
>                                 "m5208-timer", 0x00004000);
>           memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 =
* i,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


