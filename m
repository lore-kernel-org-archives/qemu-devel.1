Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107AC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD7820848
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzLQhi82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD7820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLiQ-0000SV-1x
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 07:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inLhj-0008GW-8l
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inLhh-0004Ec-Tf
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:05:23 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inLhh-00048N-Im
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:05:21 -0500
Received: by mail-oi1-x22d.google.com with SMTP id v140so14142849oie.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SpyBTMyj0svKRO+0dlhe4l8qHXDJqvarVDOn1TRqPOo=;
 b=xzLQhi82E0dJ3XFvdHGcln5XykOvpV5LSjQWEN7X48RxCjynkomhKnoFn/pOzGMuMi
 S71lUf8Bs0a9Uf12nifRrN6o2zcqtrG+aAd4QrBhfQ2zjiOLKJg6hffXhi7EP9WUdMDW
 bjTtGEOkh+6BynKtIbgEJMzmhBl7lwnkNSnxun8hEsuIn6dcP/TSbJ3zAuEjfxXTpO23
 7FkghNOtZ55sLpreKRrIaudk+8MzCvtySXUGTmhFlNR0D1bznvPaEkz4p8KQq/2SL5hx
 L10+8Z6OAEA35++2qY4eTzE7wna/u8m6Es93EN98kF3HiJvYtHfKItIWrasrhAirrFhQ
 ucNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SpyBTMyj0svKRO+0dlhe4l8qHXDJqvarVDOn1TRqPOo=;
 b=GuBgXVSASTFSZlcjI16Or7Ezz+YF3+S6Lz/g8s+6hAuLcfJuVCxQ8nub9psMuCLBLk
 XQAYwaXUt37yUe1DU2ILd4dba4Tp0H30vx6yfg3rvmyGs42Sn0nf/5elCtGe75ZZvvad
 1vnQz8k5TcjwmYMMk2POD95VPu0Q0/lyXCSpxg3tnl2BRKZzGTvjX1lrjtY5JrvZH36A
 c2VNybE2n+aOS8G81xpanm0+WBHy3VpZwkuOEgROtNMsk2hb6ppngarP3sgF6x9LFqmY
 FUCb7uvNhXvkT608NS+7JS8RS0qdfkVPcm7B3JbOvV/QAqeThfOGoamOShRIMzro1ygz
 az3Q==
X-Gm-Message-State: APjAAAWK5jAuUUCqAaxLxtLIeyY5/AGu0m5Vr9LW5gouL3GkCLdgR590
 EBzRPBXltMs4uUxiT2c2sv7zGPgOgPJC64jVhfXdgQ==
X-Google-Smtp-Source: APXvYqwqDIAuElnFPKmja7ppMg0UJZKFu8bY7H8swqBd20jSGOCCOoGb/JP0y93ZH5+h3T9wVytSSsRetHHJBD9Ic/I=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3960824oid.98.1578053120317;
 Fri, 03 Jan 2020 04:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20191214094526.8698-1-cohuck@redhat.com>
 <20191214094526.8698-17-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-17-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 12:05:08 +0000
Message-ID: <CAFEAcA-0q006spm3Jya8MxxrpWTQB6=u5kspuZHzn3XURvefLA@mail.gmail.com>
Subject: Re: [PULL v2 16/16] qga: fence guest-set-time if hwclock not available
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Dec 2019 at 09:46, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The Posix implementation of guest-set-time invokes hwclock to
> set/retrieve the time to/from the hardware clock. If hwclock
> is not available, the user is currently informed that "hwclock
> failed to set hardware clock to system time", which is quite
> misleading. This may happen e.g. on s390x, which has a different
> timekeeping concept anyway.
>
> Let's check for the availability of the hwclock command and
> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Message-Id: <20191205115350.18713-1-cohuck@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  qga/commands-posix.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165daed8..0be301a4ea77 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t time_=
ns, Error **errp)
>      pid_t pid;
>      Error *local_err =3D NULL;
>      struct timeval tv;
> +    static const char hwclock_path[] =3D "/sbin/hwclock";
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
>
>      /* If user has passed a time, validate and set it. */
>      if (has_time) {
> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)
>
>          /* Use '/sbin/hwclock -w' to set RTC from the system time,
>           * or '/sbin/hwclock -s' to set the system time from RTC. */
> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>                 NULL, environ);
>          _exit(EXIT_FAILURE);
>      } else if (pid < 0) {
> --

FWIW, Coverity thought this might be a time-of-check-time-of-use
bug based on our doing an access() check and then later doing
an execle(). This seems like a false positive to me, so I've
marked it as such (CID 1411029).

thanks
-- PMM

