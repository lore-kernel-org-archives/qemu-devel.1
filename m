Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0202DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C053A222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B30NTeYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C053A222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTUr-0003fp-VL
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLTTy-00031U-28
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLTTw-0007NF-Ms
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:43:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLTTw-0007Mp-6H
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571409834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y44R6NG+agF8VVfYHxrSqxwM5/55QeT1Cf2DRBB2rCM=;
 b=B30NTeYuvqnsfMXluY5LVs2kPRXu/IB65lQZJK5Lwvxzbo0fWtdea2ahZ1BwuxxBjOBKhZ
 jxt792qMUlzsbrstRoOezvl7OYyrsNz9nLA2es+GAQPVV1MpzmVWc/Gh3WRB9l8qaxVHzg
 acArFM4DvlM6rEDSbFHh3yTtWffhCXQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-HqnVJ-9LPfSBiUvf-ViAkw-1; Fri, 18 Oct 2019 10:43:51 -0400
Received: by mail-wr1-f69.google.com with SMTP id l4so141724wru.10
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oxTaWJF+E2pYjJeQevf8fSzAvW9kkJ7FLXGSFd8B/aQ=;
 b=VXWCIZyEneBQKnNHfVmJkT8OgfKsd3QQoW1iuXquQIU0Vs5emNZq9N6oFr/fFw8aYc
 VIc94M/nJcJzhJ6wqJWfa5Hddh0ynMXFnPEgrCFotd2App0ikpFCsr43/hH40KxlmGVX
 xU3PXYH8RSziHvuJchs0YEuZ3JarhJWRHwW0ZpTCd855rg+6BjGJeSI21Fz+Rr26KtK7
 5VrvVkRrulaKLMWvZPaTPKpvxVre7A3Y+2KewKBYgO0ezeGS0qgjBT/hdXVC2cEMxt1z
 EjI7wssx0uVpYy5t00sMe4KJSjI25dGK58M7K4t9P1JoilSXMmdAX7X6Rlnhvl4hhldm
 r0lw==
X-Gm-Message-State: APjAAAXbPh8q1+EPLpuSnxf5NPU9rN3H7uXPJA4BgTgDOL3ZSWjShPa9
 V2rtYyvJgKROSb6FDdim08L3C05SCsNqWqGhvEKnTPHAfliIH0SHDUPv5nArXVeUR96bAhqA480
 guQTQOPk2WfNKuoA=
X-Received: by 2002:a1c:f305:: with SMTP id q5mr7902548wmq.137.1571409829904; 
 Fri, 18 Oct 2019 07:43:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzA3uwZnn40m5/ET/7QkmysyCIWU5kkLfjCZYFxnVMPX3PCXZzp6fd0IQhR24ffv53hu3OMvQ==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr7902532wmq.137.1571409829662; 
 Fri, 18 Oct 2019 07:43:49 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id y11sm5218116wrp.44.2019.10.18.07.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:43:48 -0700 (PDT)
Subject: Re: [PATCH] hw/timer/exynos4210_mct: Initialize ptimer before
 starting it
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191018143149.9216-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2afaaa1-16e7-b13a-285d-c995f4011a26@redhat.com>
Date: Fri, 18 Oct 2019 16:43:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018143149.9216-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: HqnVJ-9LPfSBiUvf-ViAkw-1
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:31 PM, Peter Maydell wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>=20
> When booting a recent Linux kernel, the qemu message "Timer with delta
> zero, disabling" is seen, apparently because a ptimer is started before
> being initialized.  Fix the problem by initializing the offending ptimer
> before starting it.
>=20
> The bug is effectively harmless in the old QEMUBH setup
> because the sequence of events is:
>   * the delta zero means the timer expires immediately
>   * ptimer_reload() arranges for exynos4210_gfrc_event() to be called
>   * ptimer_reload() notices the zero delta and disables the timer
>   * later, the QEMUBH runs, and exynos4210_gfrc_event() correctly
>     configures the timer and restarts it
>=20
> In the new transaction based API the bug is still harmless,
> but differences of when the callback function runs mean the
> message is not printed any more:
>   * ptimer_run() does nothing as it's inside a transaction block
>   * ptimer_transaction_commit() sees it has work to do and
>     calls ptimer_reload()
>   * the zero delta means the timer expires immediately
>   * ptimer_reload() calls exynos4210_gfrc_event() directly
>   * exynos4210_gfrc_event() configures the timer
>   * the delta is no longer zero so ptimer_reload() doesn't complain
>     (the zero-delta test is after the trigger-callback in
>     the ptimer_reload() function)
>=20
> Regardless, the behaviour here was not intentional, and we should
> just program the ptimer correctly to start with.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> [PMM: Expansion/clarification of the commit message:
>   the message is about a zero delta, not a zero period;
>   added detail to the commit message of the analysis of what

Thanks for the details!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   is happening and why the kernel boots even with the message;
>   added note that the message goes away with the new ptimer API]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Philippe pointed me at this bugfix from Guenter. At one point
> in my working on the ptimer API changes I thought this bugfix
> would be necessary as a prerequisite, but in fact the issue
> was in my ptimer changes, and it just happened that fixing
> the MCT bug was a workaround for my bug. Even though the
> ptimer API changes actually coincidentally now suppress the
> annoying message about a zero delta, the behaviour is definitely
> not intentional, and since I spent the time working through the
> analysis of what was actually going on here I don't want
> to waste it :-)
> ---
>   hw/timer/exynos4210_mct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 72257584145..944120aea59 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -1254,7 +1254,7 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>           /* Start FRC if transition from disabled to enabled */
>           if ((value & G_TCON_TIMER_ENABLE) > (old_val &
>                   G_TCON_TIMER_ENABLE)) {
> -            exynos4210_gfrc_start(&s->g_timer);
> +            exynos4210_gfrc_restart(s);
>           }
>           if ((value & G_TCON_TIMER_ENABLE) < (old_val &
>                   G_TCON_TIMER_ENABLE)) {
>=20


