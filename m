Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9B0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659CE20820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzAIS2ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659CE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL94p-0005yh-71
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7zp-0000ik-HG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7zo-00072g-82
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:47:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7zo-00072S-4g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571327243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgVYCSOlhESvWj/zXy/dExBdwGrqBN9YwqGRkMkl1AE=;
 b=LzAIS2ny4UxvSpGpU5gje5pq1DXIw//E26zePQBnHGz6+UHHxlcqTp5iEsrIQva7UwIm5C
 uRSa46Ccrt9spMGLiB3yq2mogecDniN3oMjQ+qnfnJIID9O56cojrYDM1ntPAWGcxQDsa1
 p8cpE/RXy0hgq172pJmaFNWiq+a97YA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-ZrlhSmk1Nc2Iee29OD4x5g-1; Thu, 17 Oct 2019 11:47:20 -0400
Received: by mail-wr1-f71.google.com with SMTP id c6so1160284wrp.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=atKtApwX7b7B7r986ObcYRVMPx73Rp8wpx7ZhwiXqI4=;
 b=GOxBSO+lH3AMOO6hqxZd4XXLMIOwO6VFyw3VeZHEo7WpTu3CRwcAxHxnemJCbuLPwv
 yjs6afDY47hEyNFHuMuyXExQ26LvRAc2sE5/0hxe0m7l/qF2/qL47zRtmOlxXvrYdJjg
 6p7Ugp8MDmkWCwFQHpOjC6oxbS0ts4wYFkZcEq/gTg8DARSYP0N5nv+tFclUyUOymB6p
 2LfvudpjuKM5nw/GBuBSX5lvcDa36jP/XbUZ19RBDmtj7H7a9CgH114Rvr87eWoVGPVa
 ODI24HHWsPu8gOPZmZG8S8LYAgyLsUWYnajDwYonnSnZkVw8aTHkg7Q43yMeOP/2VeaL
 qYiQ==
X-Gm-Message-State: APjAAAVK6UDpDxynboNuuQmI99I+iTZljOfLCSn+IRXY2OXVQtSoec/n
 GF9cj5OdoEyvAnojPhh1xblqnzFBQBwh09iYBN2RdF+tdv5kMN4EciVvi8WL8xWuc2FoF9s52iy
 BIO8lgahY8f56lt8=
X-Received: by 2002:a5d:420b:: with SMTP id n11mr3597737wrq.88.1571327239199; 
 Thu, 17 Oct 2019 08:47:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYK9hayAm2Y7xnEvkuYIlWN4Us/eXLQwkRxPAyaf5K+efR6UxUu/bRL24WTJSPhwz/2ZeHOA==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr3597719wrq.88.1571327238988; 
 Thu, 17 Oct 2019 08:47:18 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id 143sm5293421wmb.33.2019.10.17.08.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:47:18 -0700 (PDT)
Subject: Re: [PATCH 6/8] hw/watchdog/etraxfs_timer.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b959611-2c0d-0368-a035-bfd03daf6e13@redhat.com>
Date: Thu, 17 Oct 2019 17:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-7-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: ZrlhSmk1Nc2Iee29OD4x5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:29 PM, Peter Maydell wrote:
> Switch the etraxfs_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/etraxfs_timer.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
> index ab27fe1895b..afe3d30a8ea 100644
> --- a/hw/timer/etraxfs_timer.c
> +++ b/hw/timer/etraxfs_timer.c
> @@ -26,7 +26,6 @@
>   #include "hw/sysbus.h"
>   #include "sysemu/reset.h"
>   #include "sysemu/runstate.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "qemu/timer.h"
>   #include "hw/irq.h"
> @@ -59,9 +58,6 @@ typedef struct ETRAXTimerState {
>       qemu_irq irq;
>       qemu_irq nmi;
>  =20
> -    QEMUBH *bh_t0;
> -    QEMUBH *bh_t1;
> -    QEMUBH *bh_wd;
>       ptimer_state *ptimer_t0;
>       ptimer_state *ptimer_t1;
>       ptimer_state *ptimer_wd;
> @@ -155,6 +151,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
>       }
>  =20
>       D(printf ("freq_hz=3D%d div=3D%d\n", freq_hz, div));
> +    ptimer_transaction_begin(timer);
>       ptimer_set_freq(timer, freq_hz);
>       ptimer_set_limit(timer, div, 0);
>  =20
> @@ -176,6 +173,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
>               abort();
>               break;
>       }
> +    ptimer_transaction_commit(timer);
>   }
>  =20
>   static void timer_update_irq(ETRAXTimerState *t)
> @@ -240,6 +238,7 @@ static inline void timer_watchdog_update(ETRAXTimerSt=
ate *t, uint32_t value)
>  =20
>       t->wd_hits =3D 0;
>  =20
> +    ptimer_transaction_begin(t->ptimer_wd);
>       ptimer_set_freq(t->ptimer_wd, 760);
>       if (wd_cnt =3D=3D 0)
>           wd_cnt =3D 256;
> @@ -250,6 +249,7 @@ static inline void timer_watchdog_update(ETRAXTimerSt=
ate *t, uint32_t value)
>           ptimer_stop(t->ptimer_wd);
>  =20
>       t->rw_wd_ctrl =3D value;
> +    ptimer_transaction_commit(t->ptimer_wd);
>   }
>  =20
>   static void
> @@ -311,9 +311,15 @@ static void etraxfs_timer_reset(void *opaque)
>   {
>       ETRAXTimerState *t =3D opaque;
>  =20
> +    ptimer_transaction_begin(t->ptimer_t0);
>       ptimer_stop(t->ptimer_t0);
> +    ptimer_transaction_commit(t->ptimer_t0);
> +    ptimer_transaction_begin(t->ptimer_t1);
>       ptimer_stop(t->ptimer_t1);
> +    ptimer_transaction_commit(t->ptimer_t1);
> +    ptimer_transaction_begin(t->ptimer_wd);
>       ptimer_stop(t->ptimer_wd);
> +    ptimer_transaction_commit(t->ptimer_wd);
>       t->rw_wd_ctrl =3D 0;
>       t->r_intr =3D 0;
>       t->rw_intr_mask =3D 0;
> @@ -325,12 +331,9 @@ static void etraxfs_timer_realize(DeviceState *dev, =
Error **errp)
>       ETRAXTimerState *t =3D ETRAX_TIMER(dev);
>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>  =20
> -    t->bh_t0 =3D qemu_bh_new(timer0_hit, t);
> -    t->bh_t1 =3D qemu_bh_new(timer1_hit, t);
> -    t->bh_wd =3D qemu_bh_new(watchdog_hit, t);
> -    t->ptimer_t0 =3D ptimer_init_with_bh(t->bh_t0, PTIMER_POLICY_DEFAULT=
);
> -    t->ptimer_t1 =3D ptimer_init_with_bh(t->bh_t1, PTIMER_POLICY_DEFAULT=
);
> -    t->ptimer_wd =3D ptimer_init_with_bh(t->bh_wd, PTIMER_POLICY_DEFAULT=
);
> +    t->ptimer_t0 =3D ptimer_init(timer0_hit, t, PTIMER_POLICY_DEFAULT);
> +    t->ptimer_t1 =3D ptimer_init(timer1_hit, t, PTIMER_POLICY_DEFAULT);
> +    t->ptimer_wd =3D ptimer_init(watchdog_hit, t, PTIMER_POLICY_DEFAULT)=
;
>  =20
>       sysbus_init_irq(sbd, &t->irq);
>       sysbus_init_irq(sbd, &t->nmi);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


