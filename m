Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E1C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE10217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mzj7Y0J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE10217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvPj-0006OF-Sr
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itvOM-00052K-Nn
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itvOL-0001F6-Lu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itvOL-0001EZ-IG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579620273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NvKa1xxZ35w8fmyx4emy1vlvEm/FgRpyiUYt+tLJ2eA=;
 b=Mzj7Y0J5NYrkTOli6NxNcIvIbo6AbxUKGerS9Tj7Z9EWZDQzHkxYCFQ0wtOPHtg31tbkQh
 5Z0HHFs8O27hHCBvmitmef+jwM7Tvov8r9xxO6yMXR1i44/JU1DzPm9Ht/5t/s1wD+kxQd
 0vuCywSMD5JP98RYfSD7IwCrO1+W6+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-MkO-ZyjkMVir9s2AozVAVg-1; Tue, 21 Jan 2020 10:24:28 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so1440808wrm.17
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mbIUVxx03MXngt2qezjCZVp/rbVYvXz3D3up0rc2+5s=;
 b=op8wJWTuRBWt86l19utmWGHRYCfpJAZjPkaewlv+eMN7sY+YepHcqWSO+POZO9XS/O
 yBI3fdFy+OZKwcMaR98bftJaQi3idHI3ZLYGbQt13fK/LUAHw/XXE7/xGhVqISZ/k7By
 SLpCimWNeKzjwOZU12ZCo5CqbnK12GR51CVFQHjyqe2UeHg7qEBaegqb/vFKdVXbz8bJ
 8hEgyrthGpah387EfT9wAwP9W4tENaktJytlFwMrQu0kT0NoTw3KWJY4kGz6+BuBwQA1
 XZDwkTyg8RLnH8W4GxFbMxvxbwC/faDzyIHXN+JF/kz736uasVZmS0d7TGzPFzuHNLLl
 Mqtg==
X-Gm-Message-State: APjAAAUwut6PaURN8If2QFj4pBj+quk5quEarnlolkObEN5QLsoWBdaZ
 gONJdH7quqUz5ZGBKP4zNMXYPcp+vveN1CRHBx+0ARNLwsb+3+GbWFDwGyl+TlvYYK5tZH6Dmc3
 oQ+vqWrrx7MJI6mQ=
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr5814879wru.52.1579620267286;
 Tue, 21 Jan 2020 07:24:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEyN5HMjP5KK2EvRvgDDxegL6jkBEjJvJWH55dSMFMARQA9KHtP0SAyzVWoKiMfw0j8RhQCA==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr5814844wru.52.1579620266932;
 Tue, 21 Jan 2020 07:24:26 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h66sm5161376wme.41.2020.01.21.07.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:24:26 -0800 (PST)
Subject: Re: [PATCH v2 010/109] virtiofsd: Fix fuse_daemonize ignored return
 values
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-11-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f719e165-9fbf-80cc-537e-d638bf65da90@redhat.com>
Date: Tue, 21 Jan 2020 16:24:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-11-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: MkO-ZyjkMVir9s2AozVAVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:22 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> QEMU's compiler enables warnings/errors for ignored values
> and the (void) trick used in the fuse code isn't enough.
> Turn all the return values into a return value on the function.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tools/virtiofsd/helper.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 46466f4054..0ad34f0619 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -10,12 +10,10 @@
>    * See the file COPYING.LIB.
>    */
>  =20
> -#include "config.h"
>   #include "fuse_i.h"
>   #include "fuse_lowlevel.h"
>   #include "fuse_misc.h"
>   #include "fuse_opt.h"
> -#include "mount_util.h"
>  =20
>   #include <errno.h>
>   #include <limits.h>
> @@ -173,6 +171,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct=
 fuse_cmdline_opts *opts)
>  =20
>   int fuse_daemonize(int foreground)
>   {
> +    int ret =3D 0, rett;
>       if (!foreground) {
>           int nullfd;
>           int waiter[2];
> @@ -194,8 +193,8 @@ int fuse_daemonize(int foreground)
>           case 0:
>               break;
>           default:
> -            (void)read(waiter[0], &completed, sizeof(completed));
> -            _exit(0);
> +            _exit(read(waiter[0], &completed,
> +                       sizeof(completed) !=3D sizeof(completed)));
>           }
>  =20
>           if (setsid() =3D=3D -1) {
> @@ -203,13 +202,22 @@ int fuse_daemonize(int foreground)
>               return -1;
>           }
>  =20
> -        (void)chdir("/");
> +        ret =3D chdir("/");
>  =20
>           nullfd =3D open("/dev/null", O_RDWR, 0);
>           if (nullfd !=3D -1) {
> -            (void)dup2(nullfd, 0);
> -            (void)dup2(nullfd, 1);
> -            (void)dup2(nullfd, 2);
> +            rett =3D dup2(nullfd, 0);
> +            if (!ret) {
> +                ret =3D rett;
> +            }
> +            rett =3D dup2(nullfd, 1);
> +            if (!ret) {
> +                ret =3D rett;
> +            }
> +            rett =3D dup2(nullfd, 2);
> +            if (!ret) {
> +                ret =3D rett;
> +            }
>               if (nullfd > 2) {
>                   close(nullfd);
>               }
> @@ -217,13 +225,16 @@ int fuse_daemonize(int foreground)
>  =20
>           /* Propagate completion of daemon initialization */
>           completed =3D 1;
> -        (void)write(waiter[1], &completed, sizeof(completed));
> +        rett =3D write(waiter[1], &completed, sizeof(completed));
> +        if (!ret) {
> +            ret =3D rett;
> +        }
>           close(waiter[0]);
>           close(waiter[1]);
>       } else {
> -        (void)chdir("/");
> +        ret =3D chdir("/");
>       }
> -    return 0;
> +    return ret;
>   }
>  =20
>   void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


