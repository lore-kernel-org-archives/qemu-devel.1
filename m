Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98869C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619432230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYBCT57A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619432230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNaT-0002Yd-Ge
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXNWO-0006Cm-AJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXNWN-00010i-9m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXNWL-0000y9-6p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574246856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NBtnF6/YO1mC1InAU3M2mPFRQhygBOFjsw1HWVoCjYM=;
 b=YYBCT57AMR2xECoFCJTZV9atfOUgGkRFEQdNEim7sr6gLtYClqQJuIH0Zpv4yS855bLtPX
 iJFOXepTDWFg4zNQnrQKf8ozvPNGMDQa+WBlFwE1MtRparsWelXNegGpIvTcTiK1nRNVGZ
 eP5RLQxAUdsucj3Iz3A02WVjpmLXNJA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-sY8wm4OQPYqRlUlxdr9m1A-1; Wed, 20 Nov 2019 05:47:33 -0500
Received: by mail-qk1-f197.google.com with SMTP id a129so15530511qkg.22
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tu6ysOujxYXRrXu3XCvnS7fy6Js7hETQv4Yr52UePe0=;
 b=q8owV9oakM5RUi1ZDrlFtiVdqM+Wbj88kH/HvHuuUmdqTNTEG9N49tvb8YjAJ0hzCv
 uyrp6/907cboBOp4locDifqKCq1ikEUr1icsNtRuFv9iREu9Q4cW1xdg8+lIo0ST1eSe
 gV/cax0w8gXUDgLrkQ4sK+UEOdKXpiRgkkNMilD8WsUEsnaEjzK4oxxspI8LWol4Si3C
 fHyo4CW57FOpkuYYHff7RSvKCBBuGe/HQbDyRDqkvmfF/DNJ5JljqLL6y7h/N6dX9F/X
 2q81W2rpbV88LAEEsvmGu7fiKNxlzsW2XNRSPX5mVlSNHWn25RT+RIFWroExzNd8Gnlh
 N98Q==
X-Gm-Message-State: APjAAAVECXGxW9TAATByUmZK1Dfo6qwKT7hOFN1HZ0epAjqjzacGtqIx
 IZM7pLVSJSTH5hRgqnCysClnIkuEt3OpYkfOmLArDxbXpTvM0A4FxJy6DUZ8wZ1mLoMrgOYKRLC
 hTCEmXJtoT4Hv30E=
X-Received: by 2002:ac8:3358:: with SMTP id u24mr1848376qta.63.1574246852704; 
 Wed, 20 Nov 2019 02:47:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbyn2b8JgxlIX40sqpgYW2+/oH8ZbGy9RnvocxL3gVqF3O/KbmRZhI4ZLiV8BXT57GH8gGzQ==
X-Received: by 2002:ac8:3358:: with SMTP id u24mr1848362qta.63.1574246852527; 
 Wed, 20 Nov 2019 02:47:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id h12sm11477957qkh.123.2019.11.20.02.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:47:31 -0800 (PST)
Date: Wed, 20 Nov 2019 05:47:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 4/4] net/virtio: return error when device_opts arg is NULL
Message-ID: <20191120054713-mutt-send-email-mst@kernel.org>
References: <20191114141613.15804-1-jfreimann@redhat.com>
 <20191114141613.15804-4-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114141613.15804-4-jfreimann@redhat.com>
X-MC-Unique: sY8wm4OQPYqRlUlxdr9m1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 03:16:13PM +0100, Jens Freimann wrote:
> device_opts could be NULL. Make sure we don't pass it to
> qemu_opts_to_dict. When we made sure it can't be NULL we can also remove
> it from the if condition.
> This fixes CID 1407222.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 81650d4dc0..d53aa5796b 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2878,9 +2878,12 @@ static int virtio_net_primary_should_be_hidden(Dev=
iceListener *listener,
>              QemuOpts *device_opts)
>  {
>      VirtIONet *n =3D container_of(listener, VirtIONet, primary_listener)=
;
> -    bool match_found;
> -    bool hide;
> +    bool match_found =3D false;
> +    bool hide =3D false;
> =20
> +    if (!device_opts) {
> +        return -1;
> +    }
>      n->primary_device_dict =3D qemu_opts_to_qdict(device_opts,
>              n->primary_device_dict);
>      if (n->primary_device_dict) {
> @@ -2888,7 +2891,7 @@ static int virtio_net_primary_should_be_hidden(Devi=
ceListener *listener,
>          n->standby_id =3D g_strdup(qdict_get_try_str(n->primary_device_d=
ict,
>                      "failover_pair_id"));
>      }
> -    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) =3D=
=3D 0) {
> +    if (g_strcmp0(n->standby_id, n->netclient_name) =3D=3D 0) {
>          match_found =3D true;
>      } else {
>          match_found =3D false;
> --=20
> 2.21.0


