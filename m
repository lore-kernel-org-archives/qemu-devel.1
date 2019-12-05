Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE8C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B4924648
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsh8zUaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B4924648
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrMO-0007XM-NT
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icrIf-0005qS-NT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icrIe-00016x-B5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icrIe-00011m-6L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575552967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSvWGiwcYyHIkZlUs0Np8ESSyeXMoP3czXzEXaHWHX4=;
 b=Gsh8zUaA1BkhC7caEY5bU6Pdx/HK+MtxrnqYEsW+mMh+wortnm6fX0YibHK5Gv02wQsR0F
 RQP1q/OsiWunVyU51S0oAcLX7LxtUILz8ojG10RCL53hx7am986O10lbu2z+5D0btvFYYI
 qb3TC1q5W+p36udH2orxIs7njqGk0Jg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-K-3dLoxIMcyVkSxh-p8b2A-1; Thu, 05 Dec 2019 08:05:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so1497972wrq.12
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fj92lxVGCXbXKHQ8JuQgSjUh+mAGa2xF02ymyVU0mWo=;
 b=VjjPrFNPyyoPON7nlc4kPYLodMYTtdQq262CUU1Pd7bC00fLNRVpj7UZNtU3OZE1ol
 0wnc3pEKxPfjLwDaadarp5nic4ejkYgLoaAtRefu0KrfAYOJUKvzf1MG8ZMqmdAUBgLn
 pP/IIf2Iyt2a1nhNMOJlLrh+Zg7ALKmZ+hduot7g0y21m8DpdlgOpvmwTBVDFJw7hZSL
 2Y/DP8dBHvoxy/JnHLKdY0qxVvmuWTyQV7Evp0ZpsCllnSASb/0M9xgkbosX66uzis5F
 GgjCgihkmAxjJdTlxjDPHTmzw+gMbFtIgzuKj9zEohbWZ9Tt6AoFNP2L01mRZNaKiuRi
 2z/w==
X-Gm-Message-State: APjAAAXD+kCWnjSL9NQ7ODWWFHVEWqLHBrYISuf7TLIqf+3yOStgYgUU
 n+KRv2duFtX0fJVhQ4e1ceMyKoo4m39yXH1xI115N3bAXbn5lsSz5aTPZidijykQg7WTvfAXQDS
 oMxShN5yrHEjpUZs=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr5213806wmm.70.1575551121475; 
 Thu, 05 Dec 2019 05:05:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/xQA6B7q0JuHtYqGy4VJTGsOYFMbHUHfZZu+Wpw5INNEbfZd2+fLj2H+q+hdgGi/86SV4ag==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr5213776wmm.70.1575551121239; 
 Thu, 05 Dec 2019 05:05:21 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l26sm10456964wmj.48.2019.12.05.05.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 05:05:20 -0800 (PST)
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
Date: Thu, 5 Dec 2019 14:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205115350.18713-1-cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: K-3dLoxIMcyVkSxh-p8b2A-1
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cornelia,

On 12/5/19 12:53 PM, Cornelia Huck wrote:
> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
>=20
> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> v2->v3:
>    - added 'static' keyword to hwclock_path
>=20
> Not sure what tree this is going through; if there's no better place,
> I can also take this through the s390 tree.

s390 or trivial trees seems appropriate.

>=20
> ---
>   qga/commands-posix.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165daed8..0be301a4ea77 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_=
ns, Error **errp)
>       pid_t pid;
>       Error *local_err =3D NULL;
>       struct timeval tv;
> +    static const char hwclock_path[] =3D "/sbin/hwclock";
> +    static int hwclock_available =3D -1;
> +
> +    if (hwclock_available < 0) {
> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
> +    }
> +
> +    if (!hwclock_available) {
> +        error_setg(errp, QERR_UNSUPPORTED);

In include/qapi/qmp/qerror.h we have:

/*
  * These macros will go away, please don't use in new code, and do not
  * add new ones!
  */

Maybe we can replace it by "this feature is not supported on this=20
architecture"? (or without 'on this architecture').

> +        return;
> +    }
>  =20
>       /* If user has passed a time, validate and set it. */
>       if (has_time) {
> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)
>  =20
>           /* Use '/sbin/hwclock -w' to set RTC from the system time,
>            * or '/sbin/hwclock -s' to set the system time from RTC. */
> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>                  NULL, environ);
>           _exit(EXIT_FAILURE);
>       } else if (pid < 0) {
>=20


