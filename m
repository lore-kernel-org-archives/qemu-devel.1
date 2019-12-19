Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A942C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224572068F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4HgzpEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224572068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihur7-0007PC-S0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihuor-0004kf-Lr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihuoq-0005h0-El
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32938
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihuoq-0005cT-74
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mykNxRokFfeiWSocSQ+QyCiIaNXut8etci4IhLewmnc=;
 b=C4HgzpEK58yCicsAtYpP06Ci3iSXDxT4m8SjSgjyK3kMzATbG4UhnUfRFA4jm4/pG9dd6c
 YwjWeCCkvtJM+s6vbjxBhjK21WZJml4pNe+UMopXz5GwF8V5PDaLeud4AVC5Zb40fpSJFy
 MctBdD6vBE1yIoLzMi5y7dtZcMFHmes=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-qhaN0gx6OSGkbm4fNlb3Xw-1; Thu, 19 Dec 2019 07:22:14 -0500
Received: by mail-qk1-f198.google.com with SMTP id 143so3483575qkg.12
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dYmJmwr+JHIzIM49SSWWyD96bOQbA2BPR1Ye5EXEH6I=;
 b=qVHcVNCJpc8a9dg46Jt1K4RSzdMGUmI5/rs9zkrMMwUXUokkkrqR5wEeBahq3xDOJe
 O6JOV8KykbpfHMfOvtLT7sH5aZxBOC50Wznx98mDeXiACThPqiSutafb+UXdg7qClA8+
 th2EXEgy4z7EDl4JoU5pRGmFjeCtNfb5YyqV3LwTehh8t35fQZwLxj9yTvjgE5YNjX/B
 8KUjKBUenSVTaU2r5f4iMuTq/rzGVPFfJbEZFC2jz8g+W7BaSR0Rvjs3SO1cr4ValRDR
 Ie/JXjxM06P8Qp13rjAiIPiHBmMa3u0GhCK8nWIZA3yDYDtJSk3SlDMob3JjZsTKlPuk
 n6Mg==
X-Gm-Message-State: APjAAAUiH6zQu52EjePdA6Z6lkfN/IXI6kSsyaqdZm4VtOSC20e8bf/J
 HWizUogO2ZSiBPvftgUUc0bkaMjCxQE6EOo9Zy0nXdhHw+QEkjNObhkff/bW+hZz0swYBdgiauE
 6w4bP8zS+8NOsk8Y=
X-Received: by 2002:a05:620a:1010:: with SMTP id
 z16mr6175165qkj.237.1576758133758; 
 Thu, 19 Dec 2019 04:22:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6TrNLgKcpfV+4fst6v2LkHF79HCtaYBbNW0tQPfOxUf9u/oqj6j0d4zCV1yv42EMgearNDg==
X-Received: by 2002:a05:620a:1010:: with SMTP id
 z16mr6175144qkj.237.1576758133543; 
 Thu, 19 Dec 2019 04:22:13 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id m68sm1209115qke.17.2019.12.19.04.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:22:12 -0800 (PST)
Date: Thu, 19 Dec 2019 07:22:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 09/14] vhost-user-blk: Explicit we ignore few
 QEMUChrEvent in IOEventHandler
Message-ID: <20191219072203-mutt-send-email-mst@kernel.org>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-10-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218172009.8868-10-philmd@redhat.com>
X-MC-Unique: qhaN0gx6OSGkbm4fNlb3Xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 06:20:04PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
>=20
>     CC      s390x-softmmu/hw/block/vhost-user-blk.o
>   hw/block/vhost-user-blk.c: In function =E2=80=98vhost_user_blk_event=E2=
=80=99:
>   hw/block/vhost-user-blk.c:370:5: error: enumeration value =E2=80=98CHR_=
EVENT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     370 |     switch (event) {
>         |     ^~~~~~
>   hw/block/vhost-user-blk.c:370:5: error: enumeration value =E2=80=98CHR_=
EVENT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   hw/block/vhost-user-blk.c:370:5: error: enumeration value =E2=80=98CHR_=
EVENT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add all missing enums
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/block/vhost-user-blk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 63da9bb619..ccaf2ad978 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -383,6 +383,11 @@ static void vhost_user_blk_event(void *opaque, int e=
vent)
>              s->watch =3D 0;
>          }
>          break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
>  }
> =20
> --=20
> 2.21.0


