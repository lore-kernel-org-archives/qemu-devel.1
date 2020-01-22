Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E604FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1167217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA3w4LB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1167217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuICR-0007yG-Oe
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuIBb-0007GP-Qq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuIBa-0003q6-6g
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:44:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuIBa-0003pV-3J
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579707893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4KVVJ1u5oDYDtXqdfBb9+d//xhjWtTbLKUuIePQNG0=;
 b=VA3w4LB5EbWI8uLuO+vK4oER8BSZ4Fc6tMFIwhbSXaz/soAgFXUhAbL6tOfofAg2HxxsBH
 tAA1tQvvaS+ySwftmbDmJa9ML1BMUceVstoDGal2O1HQ0W3E37BOI/ja1HcIkUhpVRYsM8
 /x9aFiI9uTNzZioQCmoUY8inzbTd94g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-uL96CmzROOSOErL-HC5E0A-1; Wed, 22 Jan 2020 10:44:51 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so3279424wro.14
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LQ6Kxw7rljPMtxfW73ivv8V7wvF88luyszIBjRgTh4s=;
 b=QCnlEw9+uKSFnrga7AREqZvA84GIrB2n7G3GvS+Wc81FlOQ4tTmbfLqqfIFVY3nzrU
 TVVnaS9hH9cVnvLgO14qTlhKcWEK1YOfBJykjKZtO06Q+m+Ow0pWYAr/4kEKAaZhpqx8
 Gnql7ozZIEJTLW1ED4XTKwDPQB/OEuDwjsM7rjPmuqQRqmYOsedDlJfYf+mtH7lxHktt
 SH7WgKpv8wIYTL8Dy5mMspr95Y1VMbBXt0sDetc7ReTtmHwt8Gio/bIcxxbrndZKc0WS
 5KNSMT0FMy8CGx+7kcOergtn0Q9nVAIr9+qv+rSUyTpg0MHhK4ervy5hoRlrGOJcQOwB
 3zcQ==
X-Gm-Message-State: APjAAAWFNcLTqvGPWb5Y+ceIRtR9hXOKlyyM9UqwWpCbmS47OgnoewaI
 +QketuOUjWvJkr4m7lKPWeMGcDzIvhuC2Jqs8b0mY+Z4mSLzol8noknZyOKTD3lHicc54oM0vll
 LYa2kDI4EsfLay88=
X-Received: by 2002:a1c:8095:: with SMTP id b143mr3533940wmd.7.1579707890148; 
 Wed, 22 Jan 2020 07:44:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFePQDnM3Fi4ZNTfz7+jG+evR/zBzcB+uGWG+btXWP3Pr2MizVOxUSqmgV1bV63sFZqU8gEA==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr3533923wmd.7.1579707889927; 
 Wed, 22 Jan 2020 07:44:49 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b15sm4329473wmj.13.2020.01.22.07.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:44:49 -0800 (PST)
Subject: Re: [PATCH v2 097/109] virtiofsd: convert more fprintf and perror to
 use fuse log infra
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-98-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be9fe6ea-ddde-f81b-b96c-ee3b39f38196@redhat.com>
Date: Wed, 22 Jan 2020 16:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-98-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: uL96CmzROOSOErL-HC5E0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:24 PM, Dr. David Alan Gilbert (git) wrote:
> From: Eryu Guan <eguan@linux.alibaba.com>
>=20
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> ---
>   tools/virtiofsd/fuse_signals.c | 7 +++++--
>   tools/virtiofsd/helper.c       | 9 ++++++---
>   2 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signal=
s.c
> index 10a6f88088..5364cbe984 100644
> --- a/tools/virtiofsd/fuse_signals.c
> +++ b/tools/virtiofsd/fuse_signals.c
> @@ -11,6 +11,7 @@
>   #include "fuse_i.h"
>   #include "fuse_lowlevel.h"
>  =20
> +#include <errno.h>
>   #include <signal.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> @@ -46,13 +47,15 @@ static int set_one_signal_handler(int sig, void (*han=
dler)(int), int remove)
>       sa.sa_flags =3D 0;
>  =20
>       if (sigaction(sig, NULL, &old_sa) =3D=3D -1) {
> -        perror("fuse: cannot get old signal handler");
> +        fuse_log(FUSE_LOG_ERR, "fuse: cannot get old signal handler: %s\=
n",
> +                 strerror(errno));
>           return -1;
>       }
>  =20
>       if (old_sa.sa_handler =3D=3D (remove ? handler : SIG_DFL) &&
>           sigaction(sig, &sa, NULL) =3D=3D -1) {
> -        perror("fuse: cannot set signal handler");
> +        fuse_log(FUSE_LOG_ERR, "fuse: cannot set signal handler: %s\n",
> +                 strerror(errno));
>           return -1;
>       }
>       return 0;
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 781c47031c..a19959926c 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -208,7 +208,8 @@ int fuse_daemonize(int foreground)
>           char completed;
>  =20
>           if (pipe(waiter)) {
> -            perror("fuse_daemonize: pipe");
> +            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: pipe: %s\n",
> +                     strerror(errno));
>               return -1;
>           }
>  =20
> @@ -218,7 +219,8 @@ int fuse_daemonize(int foreground)
>            */
>           switch (fork()) {
>           case -1:
> -            perror("fuse_daemonize: fork");
> +            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: fork: %s\n",
> +                     strerror(errno));
>               return -1;
>           case 0:
>               break;
> @@ -228,7 +230,8 @@ int fuse_daemonize(int foreground)
>           }
>  =20
>           if (setsid() =3D=3D -1) {
> -            perror("fuse_daemonize: setsid");
> +            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: setsid: %s\n",
> +                     strerror(errno));
>               return -1;
>           }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


