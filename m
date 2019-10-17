Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F70FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C432D2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdCTMX/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C432D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8ef-00040X-8w
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL817-0002eu-G0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL816-0007J0-C5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32204
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL816-0007Ih-8R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571327323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKcc62ehRcnzZ89Q3j85/aBilRcTC66Wv7xdtTQzX1Q=;
 b=ZdCTMX/zOewrOSeJ05QQ5x/D7IP2GkWS3fXkyR42IGsuhYEcdL+SiG9bOI68Lpzs1V2z1t
 pqdVLPhfdLcyv7YMDIELZTnXwCXKre1tsMSI7fhrjXoWRxpPpM/NyPVUXDtx+Sh9HAxhz8
 X+FZak2W+sS9fC+wmhvyZ5UdGMN6GKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-VM41dRixM4K5KgHbiEyoig-1; Thu, 17 Oct 2019 11:48:40 -0400
Received: by mail-wm1-f72.google.com with SMTP id q22so1249609wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=//a6ZMda0piniY0slwuENg30EVcXCtJhVlmp9K1c7DU=;
 b=r7fOHecpWWqt97/iJenEwh7nmfuIKxP2gBKfxBf03PAS1g78ALLN1QAkLffdoSF2ES
 LAVNkf0DfFjPV+5OxOgh7AZZiTKNPcSLOCObF7Qxl2mimzYXm3HlJz4NJQ3+dNYjY8ge
 RyTf5pLExU4gECRTa4ZWKJvTcPwgo6+Hk4gL9+e9OgEK3cFK5RXGLwAeSxVh7sMQTLt+
 WHnOqG+DzFOeVDdt1OMKKZ5AaaQ6Xq6W+kt03Yt9Xd5WOupKyS7RXyUNwrHF+SfimUek
 fmEiBovYjrH8/RFPrarA4QUB5feAtxdZ+Cp3Pe3Ion+Ae7QGfuOnzT/HJQqrmRVK+im0
 o6ZA==
X-Gm-Message-State: APjAAAXBr37d1HCVCg2zBCFis8ie9EeXR6P0qUMRoyKFC7WOL4FNquGf
 Z6Vn+IuUQmKpMZwl3UcHA8apPXsnsdAazGU16k1t+vTETfIiWA93WmTV06yWsdXbJ1N0Ut+2CRL
 tmZEYTfwSV9HUVAU=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr3571383wro.214.1571327319083; 
 Thu, 17 Oct 2019 08:48:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoCWSs1W1UdvWUgiToSC/JHJpf8ncoFbVXGY70v98CfZtV6JGU9XoAeiHxkFmQ+EvryCDnqg==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr3571368wro.214.1571327318883; 
 Thu, 17 Oct 2019 08:48:38 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id u26sm2803794wrd.87.2019.10.17.08.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:48:38 -0700 (PDT)
Subject: Re: [PATCH 7/8] hw/m68k/mcf5206.c: Switch to transaction-based ptimer
 API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5bcdd56-aded-1d01-c20b-d1673f3ef70a@redhat.com>
Date: Thu, 17 Oct 2019 17:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-8-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: VM41dRixM4K5KgHbiEyoig-1
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:29 PM, Peter Maydell wrote:
> Switch the mcf5206 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/m68k/mcf5206.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index a49096367cb..c05401e0e50 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -8,7 +8,6 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>   #include "cpu.h"
>   #include "hw/hw.h"
>   #include "hw/irq.h"
> @@ -57,6 +56,7 @@ static void m5206_timer_recalibrate(m5206_timer_state *=
s)
>       int prescale;
>       int mode;
>  =20
> +    ptimer_transaction_begin(s->timer);
>       ptimer_stop(s->timer);
>  =20
>       if ((s->tmr & TMR_RST) =3D=3D 0)
> @@ -78,6 +78,7 @@ static void m5206_timer_recalibrate(m5206_timer_state *=
s)
>       ptimer_set_limit(s->timer, s->trr, 0);
>  =20
>       ptimer_run(s->timer, 0);
> +    ptimer_transaction_commit(s->timer);
>   }
>  =20
>   static void m5206_timer_trigger(void *opaque)
> @@ -123,7 +124,9 @@ static void m5206_timer_write(m5206_timer_state *s, u=
int32_t addr, uint32_t val)
>           s->tcr =3D val;
>           break;
>       case 0xc:
> +        ptimer_transaction_begin(s->timer);
>           ptimer_set_count(s->timer, val);
> +        ptimer_transaction_commit(s->timer);
>           break;
>       case 0x11:
>           s->ter &=3D ~val;
> @@ -137,11 +140,9 @@ static void m5206_timer_write(m5206_timer_state *s, =
uint32_t addr, uint32_t val)
>   static m5206_timer_state *m5206_timer_init(qemu_irq irq)
>   {
>       m5206_timer_state *s;
> -    QEMUBH *bh;
>  =20
>       s =3D g_new0(m5206_timer_state, 1);
> -    bh =3D qemu_bh_new(m5206_timer_trigger, s);
> -    s->timer =3D ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
> +    s->timer =3D ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_DEFAU=
LT);
>       s->irq =3D irq;
>       m5206_timer_reset(s);
>       return s;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


