Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627AEC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4BD20898
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbbRn9u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4BD20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRXc-0002ik-Ch
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXRWf-0001Sc-R6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXRWe-0006u8-H2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:04:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXRWd-0006tv-8D
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574262250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3wya0E3JyhKl6AlxO/qUi5Rj5CIXrSukTPwV9JRUBY=;
 b=bbbRn9u1XDcfsddlwipvRjNgTsGS/UwlOA2UISlTJRez8qiX0QcbaICzsUd6urwUU1ee8R
 PNxoOkbp5qw/UMoslNUiCTRusEpZDQT5Oq+lbjJJ+Ahq91XLFDkY06azqbinqfC4QWIpej
 9/DrCPZ3TW0YB9LHrC3wZ6TjahKlnPs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-7XeM_pK-M_63tSqy9baY8A-1; Wed, 20 Nov 2019 10:04:09 -0500
Received: by mail-qv1-f72.google.com with SMTP id 41so17342234qvw.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 07:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CwbsYE7LwDNlAX8HQOmgTV7yd8YWzXeNALPGGsu5NGQ=;
 b=CMibiWxf16cq8iMP5tVWUDonUtYIL7uzaPB3UxqTVyTXPrs/Q13YLTmVMLU6m1HnJ0
 ZmNj3UqIXT2rSJTXq1v9/PIGMHDfmQf95uM/ln8BCX5t62/OwbP0sQAbZtqBRzTba4wN
 r+qLqPqM8LvM0i7C7xSZTtnWV790nR5gL6+iyGXtU0kzVWN15vv9m3AlL3kx+Fo5NeYt
 2JBBWELv2Un1aAd+VAM7jAEqT9FT69kH+X//6VjeQjrLcNPVlRj1fx9oDbpg42cDFHCy
 W9+thxglxmoS974CUPY764ci7snkIxi4YVH9Uiilo/rVTP1pVw7k0Zcutf01sVXlRciK
 s8/Q==
X-Gm-Message-State: APjAAAVOfTM8pjnTWQegg0YAHl4JOhxHoQwXwKkxJrcNFn2toW+04zdZ
 M6bsWP0n3xwCCOKF+zNEaATTYaLdLVGQe77aSAGT9sbazxzdYdO9/9eFxI82ZPenrRFZNU0ufyC
 N86bT1miqJpb9Wes=
X-Received: by 2002:ad4:58b1:: with SMTP id ea17mr2859042qvb.155.1574262248595; 
 Wed, 20 Nov 2019 07:04:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdpoKcp1DOTvMlKOelbyvtorY27kitGahy4QyrJTDWx+7TRafxBDMaBWWYMbO/TMemF4IF9g==
X-Received: by 2002:ad4:58b1:: with SMTP id ea17mr2859019qvb.155.1574262248382; 
 Wed, 20 Nov 2019 07:04:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id a2sm11747028qkl.71.2019.11.20.07.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 07:04:05 -0800 (PST)
Date: Wed, 20 Nov 2019 10:04:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v2 3/4] net/virtio: avoid passing NULL to
 qdev_set_parent_bus
Message-ID: <20191120100034-mutt-send-email-mst@kernel.org>
References: <20191120143859.24584-1-jfreimann@redhat.com>
 <20191120143859.24584-4-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120143859.24584-4-jfreimann@redhat.com>
X-MC-Unique: 7XeM_pK-M_63tSqy9baY8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 03:38:58PM +0100, Jens Freimann wrote:
> Make sure we don't pass NULL to qdev_set_parent_bus(). Also simplify
> code a bit and fix a typo.
> This fixes CID 1407224.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>

patch itself is ok I think

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

but some questions on the commit log

> ---
>  hw/net/virtio-net.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ac4d19109e..78f1e4e87c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2805,25 +2805,33 @@ static bool failover_replug_primary(VirtIONet *n,=
 Error **errp)
>          n->primary_device_opts =3D qemu_opts_from_qdict(
>                  qemu_find_opts("device"),
>                  n->primary_device_dict, errp);
> -    }
> -    if (n->primary_device_opts) {
> -        if (n->primary_dev) {
> -            n->primary_bus =3D n->primary_dev->parent_bus;
> -        }
> -        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> -        n->primary_should_be_hidden =3D false;
> -        qemu_opt_set_bool(n->primary_device_opts,
> -                "partially_hotplugged", true, errp);
> -        hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
> -        if (hotplug_ctrl) {
> -            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp)=
;
> -            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
> +        if (!n->primary_device_opts) {
> +            error_setg(errp, "virtio_net: couldn't find primary device o=
pts");
> +            goto out;
>          }
> -        if (!n->primary_dev) {
> +    }
> +    if (!n->primary_dev) {
>              error_setg(errp, "virtio_net: couldn't find primary device")=
;
> -        }
> +            goto out;
>      }
> -    return *errp !=3D NULL;
> +
> +    n->primary_bus =3D n->primary_dev->parent_bus;
> +    if (!n->primary_bus) {
> +        error_setg(errp, "virtio_net: couldn't find primary bus");
> +        goto out;
> +    }
> +    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> +    n->primary_should_be_hidden =3D false;
> +    qemu_opt_set_bool(n->primary_device_opts,
> +                      "partially_hotplugged", true, errp);
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
> +    if (hotplug_ctrl) {
> +        hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
> +        hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
> +    }
> +
> +out:
> +    return *errp =3D=3D NULL;
>  }
> =20
>  static void virtio_net_handle_migration_primary(VirtIONet *n,

So the logic actually was inverted here? Then ... how did this work?
and how was it tested?
Also, pls mention the change in the commit log.

> @@ -2852,7 +2860,7 @@ static void virtio_net_handle_migration_primary(Vir=
tIONet *n,
>              warn_report("couldn't unplug primary device");
>          }
>      } else if (migration_has_failed(s)) {
> -        /* We already unplugged the device let's plugged it back */
> +        /* We already unplugged the device let's plug it back */
>          if (!failover_replug_primary(n, &err)) {
>              if (err) {
>                  error_report_err(err);
> --=20
> 2.21.0


