Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C137C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DA520733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLpIC8fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA520733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1HeG-0004ot-Fk
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 17:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1Hcn-0003qw-KT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1Hcm-0007hb-I5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:33:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1Hcm-0007gv-E6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581374032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOzgBWbJ86Vg+9gC3MnTubsxxUai2FkKcjjB61k2Rmc=;
 b=DLpIC8fF52QG+jdT2DZ9uqTbE2ywcspHUoNdNCVzNR/EiF2jqiAKTRa22TkmhXNyL2PUkU
 Ms+P1IcgJ9S8DQCnTwr9KxMs5DAwldj63WENRa4ePn3jeC3J8vBBxIOkBIamatVTScWX68
 TOfxR+7IYYW/mujEWfqXZi+cCZuMBO4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-MgphCBxXNFGpeVoZtwoIVQ-1; Mon, 10 Feb 2020 17:33:50 -0500
Received: by mail-qk1-f197.google.com with SMTP id a132so5903171qkg.5
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 14:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wzPLpHuUHgepNnh1ryHop3enJnwrICTRNfbiz+I9Qsw=;
 b=WUJ29SGbHLmXNHw4ZrfwiOcoG/+4ExaErxeBzxeY79p7BL8R4AVzW3gDJpK3JQvPf1
 laDmuuQyNflMIZgUqgyQVs/HClTPo5KF7WTWweTqU6thAdPWXqaXUSDrloR+5vxfCFxr
 kgC3sX7SuteJ8Pv8YYAL/5uz2F3cI2RSaZdPtkOpXw3hFBC/BVoToeuKgtATwvagQSjo
 WJSREVl6axT+wytHleTOxuVjyZywwAqae5dOT4WNK6WKY98+xe/XbETiZdfLsJqe7SfU
 hDb1SGnO9aPPI8IweHEai6weax4aNRXl6tcMtt1dGaGd18ImKqJ8D0T2iE6Iz/czmqSE
 5ezw==
X-Gm-Message-State: APjAAAUAmUF8zTdz8Ty+0n5wP5hVpgZkcevs8c9LEBWa42/TTXTKMLWa
 0EO3pwNNE9j0kJjfW/Gtto8JzQp1LznXhegRcfaPNocd1pxWh3GsD+Kb1/u96t/jhJXyCLeoDay
 xfv7FOV3lstgRbu8=
X-Received: by 2002:ad4:4dce:: with SMTP id cw14mr194859qvb.162.1581374029770; 
 Mon, 10 Feb 2020 14:33:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbyoUfxwDxhTyycQeOyXpu0UUy/XzVr+kwg41dtmeZzvGz2F0sIrNJry5jyzP1lUQ6nhYxgg==
X-Received: by 2002:ad4:4dce:: with SMTP id cw14mr194825qvb.162.1581374029470; 
 Mon, 10 Feb 2020 14:33:49 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id s22sm891995qke.19.2020.02.10.14.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 14:33:48 -0800 (PST)
Date: Mon, 10 Feb 2020 17:33:47 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration/rdma: rdma_accept_incoming_migration fix error
 handling
Message-ID: <20200210223347.GC984290@xz-x1>
References: <20200210194459.112085-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200210194459.112085-1-dgilbert@redhat.com>
X-MC-Unique: MgphCBxXNFGpeVoZtwoIVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 07:44:59PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> rdma_accept_incoming_migration is called from an fd handler and
> can't return an Error * anywhere.
> Currently it's leaking Error's in errp/local_err - there's
> no point putting them in there unless we can report them.
>=20
> Turn most into fprintf's, and the last into an error_reportf_err
> where it's coming up from another function.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/rdma.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 2379b8345b..f67161c98f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3980,13 +3980,13 @@ static void rdma_accept_incoming_migration(void *=
opaque)
>      RDMAContext *rdma =3D opaque;
>      int ret;
>      QEMUFile *f;
> -    Error *local_err =3D NULL, **errp =3D &local_err;
> +    Error *local_err =3D NULL;
> =20
>      trace_qemu_rdma_accept_incoming_migration();
>      ret =3D qemu_rdma_accept(rdma);
> =20
>      if (ret) {
> -        ERROR(errp, "RDMA Migration initialization failed!");
> +        fprintf(stderr, "RDMA ERROR: Migration initialization failed");

Is there any reason to explictly use stderr instead of the
error_reportf_err() below (then we simply jump to that for error
paths)?  The only difference of error_reportf_err() and stderr should
be when there's one HMP, while shall we always suggest to use
error_reportf_err() rather than stderr?

Thanks,

>          return;
>      }
> =20
> @@ -3998,13 +3998,16 @@ static void rdma_accept_incoming_migration(void *=
opaque)
> =20
>      f =3D qemu_fopen_rdma(rdma, "rb");
>      if (f =3D=3D NULL) {
> -        ERROR(errp, "could not qemu_fopen_rdma!");
> +        fprintf(stderr, "RDMA ERROR: could not qemu_fopen_rdma");
>          qemu_rdma_cleanup(rdma);
>          return;
>      }
> =20
>      rdma->migration_started_on_destination =3D 1;
> -    migration_fd_process_incoming(f, errp);
> +    migration_fd_process_incoming(f, &local_err);
> +    if (local_err) {
> +        error_reportf_err(local_err, "RDMA ERROR:");
> +    }
>  }
> =20
>  void rdma_start_incoming_migration(const char *host_port, Error **errp)
> --=20
> 2.24.1
>=20

--=20
Peter Xu


