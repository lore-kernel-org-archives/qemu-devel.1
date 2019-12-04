Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF22C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6705320637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwAtNGs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6705320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWEJ-00042h-Ga
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1icWDa-0003bE-M9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1icWDV-0006aD-Op
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:05:30 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1icWDV-0006Yc-Jq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:05:25 -0500
Received: by mail-ot1-x341.google.com with SMTP id g18so6539700otj.13
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=12CGcXZDnwCyqDH63IGWU3qL/3R9EW7RkUtKUhX8ZF4=;
 b=gwAtNGs1O6259vaozkDzHetTeJV0DrCK0M6Ipu08RRT/aqlAV6R3cgGsHPT9f4kVac
 gglDGzJvPsVZ1SO3P/xuQNRfhQYt1lFcSqTtST/6xkCRrPXSOMe5Ne/wcAyZdFiK8MYi
 PVZN7dR7b7mz6eXr4TlCwe+1CQMJnOnYbzrL3aoxf/JfHxDP7qe+MlUvLuLjB03Aln4J
 on39fvRVgE6GSjVs5IZZMEXt63ubKO45CroxN7NDTVh/NWpEYhUCdXlP+mZYdhjgHWbC
 DeOk95/8SGAGJJWviz7JY/sxiaIIT/XC2MhO1ycK3npsUGCSzyoAslD0dTMsgeHgFWu6
 qbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=12CGcXZDnwCyqDH63IGWU3qL/3R9EW7RkUtKUhX8ZF4=;
 b=r6orhRbvCMteLyanv3pyo/pGF7tTIms+EARly9sGDsEC1Foej78ZZ/o5Y8IQ7avNUd
 ALEkUHoud5VyDovgynY7tWvF4br5gHKI8nsVgx/SUuqGGpUWX5XeT/fqB+256CmemtxP
 zWXt9pTrkrXYHf5ACu77y+eC9CM1BBUOlQRIpcsWND4MsYASZ7bnXPK5jMyPcI2Bux1E
 BB5r1XJgzLsM5m/YnnJduWw56BWSP43z9d4nCR3oNmUTfGYeYGaB3doEl5dXZZuLUlFv
 SJ6dStehH2ouTMqwT0cCFxwg9d5M9ydUGi8CDgoxRVMZ4KQv+w+jLsGHY1gHcOFxkeTg
 Jyeg==
X-Gm-Message-State: APjAAAWue9n+sP+QokO0bvRdUDmuo5Cf+Pjww/GgK43B3pf8x0F/0/ey
 cNyNlaXUo+T/v/exKvn4NWI=
X-Google-Smtp-Source: APXvYqzBe4crTubY4x1NIMNyil8kC1sH93eCuN9VTmpMvRkh6kOyTC3+IFR8+LWY0BAXjri5aRGL0w==
X-Received: by 2002:a9d:6745:: with SMTP id w5mr2706264otm.221.1575471922458; 
 Wed, 04 Dec 2019 07:05:22 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id o4sm2260265ota.57.2019.12.04.07.05.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 04 Dec 2019 07:05:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20191128181100.23187-1-cohuck@redhat.com>
References: <20191128181100.23187-1-cohuck@redhat.com>
Message-ID: <157547191693.3810.11857712694339556499@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] qga: fence guest-set-time if hwclock not available
Date: Wed, 04 Dec 2019 09:05:16 -0600
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Cornelia Huck (2019-11-28 12:11:00)
> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
> =

> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
> =

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
> =

> v1 (RFC) -> v2:
> - use hwclock_path[]
> - use access() instead of stat()
> =

> ---
>  qga/commands-posix.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165daed8..ffb6420fa9cd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_=
ns, Error **errp)
>      pid_t pid;
>      Error *local_err =3D NULL;
>      struct timeval tv;
> +    const char hwclock_path[] =3D "/sbin/hwclock";
> +    static int hwclock_available =3D -1;
> +
> +    if (hwclock_available < 0) {
> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
> +    }
> +
> +    if (!hwclock_available) {
> +        error_setg(errp, QERR_UNSUPPORTED);
> +        return;
> +    }
>  =

>      /* If user has passed a time, validate and set it. */
>      if (has_time) {
> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)
>  =

>          /* Use '/sbin/hwclock -w' to set RTC from the system time,
>           * or '/sbin/hwclock -s' to set the system time from RTC. */
> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>                 NULL, environ);
>          _exit(EXIT_FAILURE);
>      } else if (pid < 0) {
> -- =

> 2.21.0
>=20

