Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DAC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A172520714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tuj+xubZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY66W-0002t8-SK
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY65s-0002Qz-DI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY65p-0001RX-DQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:23:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY65p-0001Qt-A0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aC8QiWqcErF2UvlrUorIoc/FwNBS97X6exTWEfpGS0=;
 b=Tuj+xubZGbJM22XpmFS6BH8S0+5//AqYX1rD6AISPcAbUApKLEPtOMNy284/nT0rNN5r+x
 psJzov98ClDpASAWs8glapI+kS8Lg0izEx4Y80A9+ohKDYeHrOUTsY16JPewW0ogMKmz3h
 MLf4V/bLLhSSs7ZraoI9kLQwVipCrkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-3-NaIHXNMXu2N8lLdFAiAQ-1; Fri, 22 Nov 2019 05:23:07 -0500
Received: by mail-wm1-f71.google.com with SMTP id t203so2847202wmt.7
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nv9rVo+CtWdhAxdsEKPF+y3JRalWAPp04kUiqaz4ivg=;
 b=hGcZ6TEXwq7LEE+/DpTRGMbmEV41nG2RJ5uYbHq17OE0bQsYMEDHTYMuZ8AKIwopII
 ICsziAv/cPYxeme5sDXSv+Lsy6HnbR+ns4DB71MUjupV9iVNmUiYVHp2VNGzdeCDIBCr
 PGINNVM8X1sGoiOwS4MW+kgn/XuW4LNXtZCXCtbLoINiyTzmGJ2ODJCOfTMqXbQCvstO
 NLw27MJUwxRLzXK6pqEMsv8gUYEaRNdkAJZ5puZAi61S/nwWpy/wgeHttD+UH/ikFTwP
 5xSC1g+n4cupUS28uT3Jdz957L6V2SbTwuPiSuA1EdACRa+AHfhhrEssAgaqzWvkfo3L
 sUYQ==
X-Gm-Message-State: APjAAAXKLE+IyVeKgWfi8jK8pXwbcd1eyOJvqcaYPmOUpLC01wHbhs81
 8+DDLzcx3u0MOnFe/qhvJ2LnXFWLHiyBwq7avpyKJoEiUmn1F28kwPiCGNk/YVhTpKJPWZ67QlI
 9hhDaqq7eR51Z8+0=
X-Received: by 2002:adf:e885:: with SMTP id d5mr17024467wrm.117.1574418186367; 
 Fri, 22 Nov 2019 02:23:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1plrVIR/g4aqay7rLhkVNda19AtaJ5QUz2uadePRLEE5i8bMLiWJ4yXV5cyrBFo7AakvZdA==
X-Received: by 2002:adf:e885:: with SMTP id d5mr17024447wrm.117.1574418186164; 
 Fri, 22 Nov 2019 02:23:06 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id o189sm3118013wmo.23.2019.11.22.02.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:23:05 -0800 (PST)
Subject: Re: [PATCH] monitor: Fix slow reading
To: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7def6311-323d-eb52-2a79-0f1c54d486fa@redhat.com>
Date: Fri, 22 Nov 2019 11:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
Content-Language: en-US
X-MC-Unique: 3-NaIHXNMXu2N8lLdFAiAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Markus Armbruster <armbru@redhat.com>, yc-core@yandex-team.ru,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the chardev maintainers.

On 11/22/19 10:23 AM, Yury Kotov wrote:
> The monitor_can_read (as a callback of qemu_chr_fe_set_handlers)
> should return size of buffer which monitor_qmp_read or monitor_read
> can process.
> Currently, monitor_can_read returns 1 as a result of logical not.
> Thus, for each QMP command, len(QMD) iterations of the main loop
> are required to handle a command.
> In fact, these both functions can process any buffer size.
> So, return 1024 as a reasonable size which is enough to process
> the most QMP commands, but not too big to block the main loop for
> a long time.
>=20
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>   monitor/monitor.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 12898b6448..cac3f39727 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -50,6 +50,13 @@ typedef struct {
>       int64_t rate;       /* Minimum time (in ns) between two events */
>   } MonitorQAPIEventConf;
>  =20
> +/*
> + * The maximum buffer size which the monitor can process in one iteratio=
n
> + * of the main loop. We don't want to block the loop for a long time
> + * because of JSON parser, so use a reasonable value.
> + */
> +#define MONITOR_READ_LEN_MAX 1024

This looks reasonable.
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +
>   /* Shared monitor I/O thread */
>   IOThread *mon_iothread;
>  =20
> @@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
>   {
>       Monitor *mon =3D opaque;
>  =20
> -    return !atomic_mb_read(&mon->suspend_cnt);
> +    return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR_READ_LEN_MAX;
>   }
>  =20
>   void monitor_list_append(Monitor *mon)
>=20


