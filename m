Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A45C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A0620663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9nv2Xg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A0620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGL9f-0004H7-Al
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jGL8s-0003Tl-93
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jGL8r-00031e-1K
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:21:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jGL8q-00031T-TX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584962472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNP1c6+bHJwei3vGv3ZqII30uVCJcfMsUZXRcFPu6vc=;
 b=G9nv2Xg5NJPhKi5jPfRP5UjRDtf24W59SydxDO+sYRQ23sxFevzjgx0PJe3GBV5r4Fljmh
 Pi7ahR+/qxI9Dk/kTKND9xALEp6UipD86BXE5zNEb4EWi8VhGSmELvXpdmlgqq+eSUkMYD
 g/C1U5X4SwPoZGMNEuwExovfRweY0iQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-UPuEO9-1OYGVwQwXPDoVWg-1; Mon, 23 Mar 2020 07:21:10 -0400
X-MC-Unique: UPuEO9-1OYGVwQwXPDoVWg-1
Received: by mail-wm1-f71.google.com with SMTP id n188so3437112wmf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mObUTRaw+KePQ33hPVYSH54M+JuZb3oIo2D5/6oNVx4=;
 b=qmWw5HoXPOmKCuZo05+Hyzd5F9oSn8MtICB67bsYigIvEPF/XaP85DSNKsGhWnfs8U
 za0oyUtUrPX4U2U8H5vkydAbhPZSrTp2wqzapauF+UexYxAb2/PDyAmn/g507zsyWzDD
 rri/iBUFWF8Xe1eowpyCZVcSO+7i+Xr206Ee+Xe9jKm2uCIWXHd/wwShIIbCwo5DY3ZS
 lV6m8IbX2ippJqPNj+LroMstRJHMwYFKmzr22+z66xaCb2K+l7Xnn6HzBPc+IEkOKgfa
 BZS3FebuwLwXxr4IFJelKYbnwwwWp/1RAhFvejG2K8o+es6g/WD2bn4nWm5SQAlvYDq2
 ImWw==
X-Gm-Message-State: ANhLgQ2tbYa2cvIrZFm3rmxa6rGSBZzq4pwuamochceT+mKQt3iprZhm
 qlR10U07yBTvA8nWRJTqaAYN6Bwyr6ip7RS/v1tEn/W+TyIeKI4b2KCIkf8uqwitLPPYoEh6hSA
 c1CRaCeU8XBWHgLo=
X-Received: by 2002:a05:600c:278a:: with SMTP id
 l10mr25743492wma.45.1584962469816; 
 Mon, 23 Mar 2020 04:21:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtDpwKmpZg/BOLqIG+Vc75EVX8Ngqoekze/4A9eUiV6/V282ByYqBuIu8K+rienvQAfvJhQXg==
X-Received: by 2002:a05:600c:278a:: with SMTP id
 l10mr25743456wma.45.1584962469518; 
 Mon, 23 Mar 2020 04:21:09 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id l17sm16871983wrm.57.2020.03.23.04.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:21:08 -0700 (PDT)
Date: Mon, 23 Mar 2020 12:21:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] qemu-ga: document vsock-listen in the man page
Message-ID: <20200323112106.zhcir23sa4ipll7l@steredhat>
References: <20200323110408.309111-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200323110408.309111-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 11:04:08AM +0000, Stefan Hajnoczi wrote:
> Although qemu-ga has supported vsock since 2016 it was not documented on
> the man page.
>=20
> Also add the socket address representation to the qga --help output.
>=20
> Fixes: 586ef5dee77180fc32e33bc08051600030630239
>        ("qga: add vsock-listen method")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/qemu-ga.rst | 5 +++--
>  qga/main.c               | 4 +++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 1313a4ae1c..3063357bb5 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -36,13 +36,14 @@ Options
>  .. option:: -m, --method=3DMETHOD
> =20
>    Transport method: one of ``unix-listen``, ``virtio-serial``, or
> -  ``isa-serial`` (``virtio-serial`` is the default).
> +  ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default)=
.
> =20
>  .. option:: -p, --path=3DPATH
> =20
>    Device/socket path (the default for virtio-serial is
>    ``/dev/virtio-ports/org.qemu.guest_agent.0``,
> -  the default for isa-serial is ``/dev/ttyS0``)
> +  the default for isa-serial is ``/dev/ttyS0``). Socket addresses for
> +  vsock-listen are written as ``<cid>:<port>``.
> =20
>  .. option:: -l, --logfile=3DPATH
> =20
> diff --git a/qga/main.c b/qga/main.c
> index 8ee2736f8e..f0e454f28d 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -234,7 +234,9 @@ QEMU_COPYRIGHT "\n"
>  "  -p, --path        device/socket path (the default for virtio-serial i=
s:\n"
>  "                    %s,\n"
>  "                    the default for isa-serial is:\n"
> -"                    %s)\n"
> +"                    %s).\n"
> +"                    Socket addresses for vsock-listen are written as\n"
> +"                    <cid>:<port>.\n"
>  "  -l, --logfile     set logfile path, logs to stderr by default\n"
>  "  -f, --pidfile     specify pidfile (default is %s)\n"
>  #ifdef CONFIG_FSFREEZE
> --=20
> 2.24.1
>=20

Thanks to update it!
I updated the wiki page some months ago, adding an example, but I forgot to
check the most important man page and --help output.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


