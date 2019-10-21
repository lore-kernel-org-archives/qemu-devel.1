Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB95CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6DE2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Apc1Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6DE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZ2p-0002rr-BQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iMZ22-00023O-Pi
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iMZ21-00020p-JC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:51:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iMZ21-00020a-Ce
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:51:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id l10so13926873wrb.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DhsjBZc8iNnKkZFyzeJie8+WMmdsSJO96MsKf975bA0=;
 b=H7Apc1Nu/1Qxa/lVspC+6XRZ6JcEPYT4J51Tx44rvXAaOBYJqu0+n0yWjLf8jG+4Nz
 xDGiSWmIX2HmH2qID1SOA+yJAx3C6CTeELFE2WZPMyuHWv65TQFtpQDOR1t//CswM4n/
 NRRcO49ttu2+bHpONMZN9lf50+OSBMJ0+KnEiXYZdknPWlzWzlC/if2oPKpxIpLWc8sJ
 8x7yLhNhUFXMGt8gw14RWl3i6fUHJNXtFysruZMMadiiSvN7Izq6eOcKiq+ClAlkN7uo
 j/QVaqMMAfy/YYFIJbvfdAmJViXzSOqZihlGbCtFWOwlTYz2chuaXbM20JOyXAXFggJG
 4eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DhsjBZc8iNnKkZFyzeJie8+WMmdsSJO96MsKf975bA0=;
 b=RZ10fWe46W9Lb89A7JtmP0zS+O3zzEO7sghxmsnuEvoexmajknRdCFvmJGlDwSGGV2
 LEaPvZtlPts9d/a89eqgMenU0qCW56BwgCrtXAK3Yv+c7Ivm8/6RMzuk4Ij0B//FKzmz
 IaTNREgPowhO3uq6q+SidR4ie1qNdPXugw1h7H8nkzrB4XDsJymZHy8Jn/FWsmaaPSAA
 PgY7NDdnLyuyDejb+5Y/BcZieFn7C7+c4Cz7GZya6N8ZCWkPwhByVpebOZZE4GADC21+
 C0o8V16KFSDfiIkhvxrmhSHcMnxiBqWl7Bjb6x1QBJi3YJC/xMohR2k35QVU+uiuG3YL
 N5Lw==
X-Gm-Message-State: APjAAAVAh1u/21RyLTmatPv8e/v7kKOEIZ7zQG9+nsWBoUpTYkaoO2EV
 UEMcEQIEh5+bIXjUWuoJlkdvrGB5nbVpfmcktJ5vMS1W
X-Google-Smtp-Source: APXvYqzWRZzDAHLMwyxyCGChzZJe+eabA5GMATOP6UveFsXg44hCW2od8zP5FMY7B7LU4bKDmF3wn3zorYX5OhK8Kc4=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr14213594wrc.202.1571669496091; 
 Mon, 21 Oct 2019 07:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-18-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-18-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Oct 2019 16:51:23 +0200
Message-ID: <CAJ+F1CKmujLfL=n-UPLeps7BcQ=WcibHzsCWt+Pff3zLbSwvYA@mail.gmail.com>
Subject: Re: [PATCH 17/30] virtiofsd: Add main virtio loop
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 piaojun@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 1:26 PM Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Processes incoming requests on the vhost-user fd.

Is there a reason to avoid using glib & its main loop?

>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/virtiofsd/fuse_virtio.c | 42 ++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
> index 22f71d260f..9c58f11634 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -11,12 +11,14 @@
>   * See the file COPYING.LIB
>   */
>
> +#include "fuse_virtio.h"
>  #include "fuse_i.h"
>  #include "fuse_kernel.h"
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
> -#include "fuse_virtio.h"
>
> +#include <assert.h>
> +#include <errno.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -80,15 +82,49 @@ static const VuDevIface fv_iface =3D {
>      .queue_is_processed_in_order =3D fv_queue_order,
>  };
>
> +/*
> + * Main loop; this mostly deals with events on the vhost-user
> + * socket itself, and not actual fuse data.
> + */
>  int virtio_loop(struct fuse_session *se)
>  {
>      fuse_log(FUSE_LOG_INFO, "%s: Entry\n", __func__);
>
> -    while (1) {
> -        /* TODO: Add stuffing */
> +    while (!fuse_session_exited(se)) {
> +        struct pollfd pf[1];
> +        pf[0].fd =3D se->vu_socketfd;
> +        pf[0].events =3D POLLIN;
> +        pf[0].revents =3D 0;
> +
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for VU event\n", __func__)=
;
> +        int poll_res =3D ppoll(pf, 1, NULL, NULL);
> +
> +        if (poll_res =3D=3D -1) {
> +            if (errno =3D=3D EINTR) {
> +                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going ar=
ound\n",
> +                         __func__);
> +                continue;
> +            }
> +            fuse_log(FUSE_LOG_ERR, "virtio_loop ppoll: %m\n");
> +            break;
> +        }
> +        assert(poll_res =3D=3D 1);
> +        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
> +            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x\n", _=
_func__,
> +                     pf[0].revents);
> +            break;
> +        }
> +        assert(pf[0].revents & POLLIN);
> +        fuse_log(FUSE_LOG_DEBUG, "%s: Got VU event\n", __func__);
> +        if (!vu_dispatch(&se->virtio_dev->dev)) {
> +            fuse_log(FUSE_LOG_ERR, "%s: vu_dispatch failed\n", __func__)=
;
> +            break;
> +        }
>      }
>
>      fuse_log(FUSE_LOG_INFO, "%s: Exit\n", __func__);
> +
> +    return 0;
>  }
>
>  int virtio_session_mount(struct fuse_session *se)
> --
> 2.23.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

