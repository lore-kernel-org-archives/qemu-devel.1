Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA81720872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Geer1v51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA81720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8xV-0003cL-3S
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7uu-0002kY-Fl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7ut-0005l7-7w
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:42:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7ut-0005kq-4J
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571326938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a07UfDwuAGThBjS6T7KYXThpOxsypoClZayAM26hbPs=;
 b=Geer1v51aU9HkKp8BF45LK4pbJmq30jqOoyYtkhtCwiFF2k1MJ0iHGTDJ+8Jc/NAy4q4HH
 6qkkOqY3dcyKEdGERP9zTs8VrlQlgvp2tAe09UhTrXZyH/f68zJ+znUQ/pIzKKpDJ3uHdk
 o4+4NjZAkx7V28yQB15MYwUQBpI7rTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-3RLQapbbOlemtfhbFhdi5g-1; Thu, 17 Oct 2019 11:42:16 -0400
Received: by mail-wr1-f70.google.com with SMTP id a15so1161966wrr.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zg5/OZkuAWoQWBZQfOcuXAo3VNdV02IdTEy+9pRNy6c=;
 b=U/n+ESwVhGp0AMSlR/x4RR+GeV9LdTmQKOI4EZxYTKCKL6XJymgnYX571Eyef+pK84
 I8u3sWIauEkvbOjISNYA8v/hrZfjFSbnBl97jGYBZhcEQs+U9lzYUUfwWv2WaHO0T8h/
 YCNoSRJCEZmKb5NMmz5ETXGaWn9R3gXPQnX9gyANZ70aG+SSYbsyz/DOVsIMEvj7VjTw
 TCMMvtlthkI3DCjhT/VzrdbHkfASx2F29y1cLzVf25XAV0BBgoUII2s0fKIf+eVLM1/c
 fxguqLX+7+zi/EH98GKlBhThmba/RvQiH1IBSBtc/Vhf2PId1giiIH6Qljmz9ScR3N3V
 AuCQ==
X-Gm-Message-State: APjAAAVl2ptwcLcv3hwiyPWx+eUt+sEOf9E+0z6K3zT89flJKJK9mgH0
 LStD00e1j3HKGGA89boQcH0jA0CmnZvT1j4XpTexqyg2xlobvOwXZDewhWO5Wfleh4N3aO6Mi1f
 FLDu1BZCzLjp3ws4=
X-Received: by 2002:adf:e983:: with SMTP id h3mr3430680wrm.95.1571326934446;
 Thu, 17 Oct 2019 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD9WGPuIKt6j3ChX1+f1+FRV88GWgSzOAwJ4HOmooJr9uWZI47mJHet2kkPl2CXTH8kHsSng==
X-Received: by 2002:adf:e983:: with SMTP id h3mr3430663wrm.95.1571326934202;
 Thu, 17 Oct 2019 08:42:14 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id e3sm2506192wme.39.2019.10.17.08.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:42:13 -0700 (PDT)
Subject: Re: [PATCH 4/8] hw/watchdog/milkymist-sysctl.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd0692e7-5052-8950-8e6d-d6faf689eb21@redhat.com>
Date: Thu, 17 Oct 2019 17:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-5-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: 3RLQapbbOlemtfhbFhdi5g-1
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
> Switch the milkymist-sysctl code away from bottom-half based
> ptimers to the new transaction-based ptimer API.  This just requires
> adding begin/commit calls around the various places that modify the
> ptimer state, and using the new ptimer_init() function to create the
> timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/milkymist-sysctl.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
> index 5193c038501..66f86541114 100644
> --- a/hw/timer/milkymist-sysctl.c
> +++ b/hw/timer/milkymist-sysctl.c
> @@ -31,7 +31,6 @@
>   #include "hw/ptimer.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>  =20
>   enum {
> @@ -71,8 +70,6 @@ struct MilkymistSysctlState {
>  =20
>       MemoryRegion regs_region;
>  =20
> -    QEMUBH *bh0;
> -    QEMUBH *bh1;
>       ptimer_state *ptimer0;
>       ptimer_state *ptimer1;
>  =20
> @@ -161,14 +158,19 @@ static void sysctl_write(void *opaque, hwaddr addr,=
 uint64_t value,
>           s->regs[addr] =3D value;
>           break;
>       case R_TIMER0_COMPARE:
> +        ptimer_transaction_begin(s->ptimer0);
>           ptimer_set_limit(s->ptimer0, value, 0);
>           s->regs[addr] =3D value;
> +        ptimer_transaction_commit(s->ptimer0);
>           break;
>       case R_TIMER1_COMPARE:
> +        ptimer_transaction_begin(s->ptimer1);
>           ptimer_set_limit(s->ptimer1, value, 0);
>           s->regs[addr] =3D value;
> +        ptimer_transaction_commit(s->ptimer1);
>           break;
>       case R_TIMER0_CONTROL:
> +        ptimer_transaction_begin(s->ptimer0);
>           s->regs[addr] =3D value;
>           if (s->regs[R_TIMER0_CONTROL] & CTRL_ENABLE) {
>               trace_milkymist_sysctl_start_timer0();
> @@ -179,8 +181,10 @@ static void sysctl_write(void *opaque, hwaddr addr, =
uint64_t value,
>               trace_milkymist_sysctl_stop_timer0();
>               ptimer_stop(s->ptimer0);
>           }
> +        ptimer_transaction_commit(s->ptimer0);
>           break;
>       case R_TIMER1_CONTROL:
> +        ptimer_transaction_begin(s->ptimer0);

Copy/paste error I suppose, ptimer1 :)

>           s->regs[addr] =3D value;
>           if (s->regs[R_TIMER1_CONTROL] & CTRL_ENABLE) {
>               trace_milkymist_sysctl_start_timer1();
> @@ -191,6 +195,7 @@ static void sysctl_write(void *opaque, hwaddr addr, u=
int64_t value,
>               trace_milkymist_sysctl_stop_timer1();
>               ptimer_stop(s->ptimer1);
>           }
> +        ptimer_transaction_commit(s->ptimer0);

Ditto.

With it fixed:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           break;
>       case R_ICAP:
>           sysctl_icap_write(s, value);
> @@ -263,8 +268,12 @@ static void milkymist_sysctl_reset(DeviceState *d)
>           s->regs[i] =3D 0;
>       }
>  =20
> +    ptimer_transaction_begin(s->ptimer0);
>       ptimer_stop(s->ptimer0);
> +    ptimer_transaction_commit(s->ptimer0);
> +    ptimer_transaction_begin(s->ptimer1);
>       ptimer_stop(s->ptimer1);
> +    ptimer_transaction_commit(s->ptimer1);
>  =20
>       /* defaults */
>       s->regs[R_ICAP] =3D ICAP_READY;
> @@ -292,13 +301,15 @@ static void milkymist_sysctl_realize(DeviceState *d=
ev, Error **errp)
>   {
>       MilkymistSysctlState *s =3D MILKYMIST_SYSCTL(dev);
>  =20
> -    s->bh0 =3D qemu_bh_new(timer0_hit, s);
> -    s->bh1 =3D qemu_bh_new(timer1_hit, s);
> -    s->ptimer0 =3D ptimer_init_with_bh(s->bh0, PTIMER_POLICY_DEFAULT);
> -    s->ptimer1 =3D ptimer_init_with_bh(s->bh1, PTIMER_POLICY_DEFAULT);
> +    s->ptimer0 =3D ptimer_init(timer0_hit, s, PTIMER_POLICY_DEFAULT);
> +    s->ptimer1 =3D ptimer_init(timer1_hit, s, PTIMER_POLICY_DEFAULT);
>  =20
> +    ptimer_transaction_begin(s->ptimer0);
>       ptimer_set_freq(s->ptimer0, s->freq_hz);
> +    ptimer_transaction_commit(s->ptimer0);
> +    ptimer_transaction_begin(s->ptimer1);
>       ptimer_set_freq(s->ptimer1, s->freq_hz);
> +    ptimer_transaction_commit(s->ptimer1);
>   }
>  =20
>   static const VMStateDescription vmstate_milkymist_sysctl =3D {
>=20


