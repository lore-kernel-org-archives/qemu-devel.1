Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 18:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98520663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Fkdg+/4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB160-000389-Da
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 14:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jB14s-0002Y9-B9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 14:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jB14r-00014J-4f
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 14:55:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:40179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jB14q-000138-KY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 14:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=mme8EQYQogC5iE3rdRBviCaYxePS+3awRA3YPZI8xrc=; b=Fkdg+/4VEASmh6c2kLIJBDstg5
 eP2JCBt39BHVieQjTHTArr7DhF2oo4Xum86DmUafY7hAag7FNldOTTUtL4Dh+ovGEEutrP1eDH6TX
 1iy0PJAcqkHe0Kcj+YQi7thUIsC25gRCu/rt+Gv1dmUJwCbg6l7Z2GQDZYTMbvd/xRN0x2hSebCd1
 6TjNjnJVLC6AvB2N4MOa3iUVFcuZL+IwQuuwTY72uzd9c2rnD3YB7dQuilcKGwUpykVsbh655dPFc
 sh4jFg5iIYq75XvEdoBKKVByBfVwa+E7Y0l6WcGGPhf4+DXooCtGS1xvvM3yVZj+J4MpjfQMx/aCK
 VbxHrfPQVpZJB7pTgXm0a2J7coUv/KxUIC5kK8oCakDRtTK6HVp3HQyzdnXBqzUdFD+RWg2QzPBF8
 v7FZ4gNLtGojZy1vOBSUr8CvgC4fgJsylZoAOFM0fjtR82xkHtjBgAJP2ZpnLsYhJobpTXdG+gdh0
 2h0QrnSBhuCGyeW/7ZHL3Tjxu6j+9doaCr91hElDJYajNbZAH7LFUwga+v6EHbMT1sdKLrBE6uSkJ
 iz53MEd3q//rFw70MAZLmqPchj6ldGnv3pCe+eveYgtVHx3d8uddC8BBFdghrArz1nN/ro98IqCvL
 yoo8EXJk4y421EZrKUSQoTXhz/tm/vW1dlJCGCg0A=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v8 07/10] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Date: Sun, 08 Mar 2020 19:55:00 +0100
Message-ID: <2907258.0NpiEhWDFd@silver>
In-Reply-To: <20200306051536.27803-8-vsementsov@virtuozzo.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 6. M=E4rz 2020 06:15:33 CET Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
>=20
> This commit is generated by command
>=20
>     sed -n '/^virtio-9p$/,/^$/{s/^F: //p}' MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Acked-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> ---
>  hw/9pfs/9p-local.c | 12 +++++-------
>  hw/9pfs/9p.c       |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 54e012e5b4..0361e0c0b4 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1479,10 +1479,10 @@ static void error_append_security_model_hint(Error
> *const *errp)
>=20
>  static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error
> **errp) {
> +    ERRP_AUTO_PROPAGATE();
>      const char *sec_model =3D qemu_opt_get(opts, "security_model");
>      const char *path =3D qemu_opt_get(opts, "path");
>      const char *multidevs =3D qemu_opt_get(opts, "multidevs");
> -    Error *local_err =3D NULL;
>=20
>      if (!sec_model) {
>          error_setg(errp, "security_model property not set");
> @@ -1516,11 +1516,10 @@ static int local_parse_opts(QemuOpts *opts,
> FsDriverEntry *fse, Error **errp) fse->export_flags &=3D
> ~V9FS_FORBID_MULTIDEVS;
>              fse->export_flags &=3D ~V9FS_REMAP_INODES;
>          } else {
> -            error_setg(&local_err, "invalid multidevs property '%s'",
> +            error_setg(errp, "invalid multidevs property '%s'",
>                         multidevs);
> -            error_append_hint(&local_err, "Valid options are: multidevs=
=3D"
> +            error_append_hint(errp, "Valid options are: multidevs=3D"
>                                "[remap|forbid|warn]\n");
> -            error_propagate(errp, local_err);
>              return -1;
>          }
>      }
> @@ -1530,9 +1529,8 @@ static int local_parse_opts(QemuOpts *opts,
> FsDriverEntry *fse, Error **errp) return -1;
>      }
>=20
> -    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
> -        error_propagate_prepend(errp, local_err,
> -                                "invalid throttle configuration: ");
> +    if (fsdev_throttle_parse_opts(opts, &fse->fst, errp)) {
> +        error_prepend(errp, "invalid throttle configuration: ");
>          return -1;
>      }
>=20
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 9e046f7acb..3aa6a57f3a 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4023,6 +4023,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
>  int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>                                 Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      int i, len;
>      struct stat stat;
>      FsDriverEntry *fse;



