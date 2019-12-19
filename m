Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D07CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1840C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jweknhh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1840C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxCk-0003RQ-U2
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ihx9L-0006pe-Ey
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ihx9J-0005EG-Q8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:51:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ihx9J-0005Ax-JY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576767093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aIrsNoj4Dbcj+IopTqq17uJWh1SL+C95Q6EbmE3ZRo=;
 b=Jweknhh//x4t78DBoH62qAXndixIPNqd6C+LjRZN/slbGlCXh4GzP+PsRQ/ktj9mTFl50Z
 7jEYBjDsbYEnz/qVzOgYwWZQ/og+gKbmOcjwyA3r5DAxzq7JMlFXw60t02bE0UN7iQDQQ7
 NUe22yRyzCc6nzx1sjyIRqyIDpAMAlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-CHGZctxLPFSiHaoBeIf_XA-1; Thu, 19 Dec 2019 09:51:29 -0500
Received: by mail-wm1-f70.google.com with SMTP id t16so1457206wmt.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+Tr9qi9sJMs2xjz13zFJJnBncNlflx4iz80NU36XKiw=;
 b=I12ks8oJNk+YOtiHhf6rD+WB85iu1iXYVEnI9P02mnjl1DtDVRE5w+FoHM9aSCncB+
 x5DzdBModGK/RtmSYjAUbj5n/AIxft3dWmOvkKKXab48SVKWoDPZoNEjTfZA9aFGBujJ
 uRTdFlPwa8gtaPa/DpSm9FxLUKlcubqpq3luQLTKLZEOp/NjFiKZZcxKB8lCc4UUcPzM
 pgIfKmmMCKIvufU3pOhZz/Ltm1XX7uAyn9Y9hohLjKCiz404/2Wp4g8ZrlVeIsYP2va0
 aqQj/21TKBFfgNJJ3QUbLDLOqqHW9wXQp8JInrhhUsU2iv+ebyF6KhraQiZr6LLotEUO
 GEYQ==
X-Gm-Message-State: APjAAAUGm/Mh+jVLsWo32Zt2/o/b2fUwJh3gZqI8bxcBIW/TfmDGp0Fk
 bRvaf9O64wDm4qTDPC2J36Sx03jAmDZIQyYqg186Gz+VuFejS1+fmmmLBDZhV5ZxBPXB1+h7QE4
 6++pUAQjeqPRgYmo=
X-Received: by 2002:adf:9427:: with SMTP id 36mr9861381wrq.166.1576767088734; 
 Thu, 19 Dec 2019 06:51:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3yKJF9JTUxI0xdyvfm9q7X65vYl7gdWohqX9OUkD4vKYo1xNnnkItgSU8zsIguwbOu8vKPQ==
X-Received: by 2002:adf:9427:: with SMTP id 36mr9861360wrq.166.1576767088443; 
 Thu, 19 Dec 2019 06:51:28 -0800 (PST)
Received: from steredhat ([95.235.120.92])
 by smtp.gmail.com with ESMTPSA id 60sm6829161wrn.86.2019.12.19.06.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 06:51:27 -0800 (PST)
Date: Thu, 19 Dec 2019 15:51:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Florian Florensa <fflorensa@online.net>
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
Message-ID: <20191219145125.iwhxhzmt5mow5pea@steredhat>
References: <20191219133416.671431-1-fflorensa@online.net>
MIME-Version: 1.0
In-Reply-To: <20191219133416.671431-1-fflorensa@online.net>
X-MC-Unique: CHGZctxLPFSiHaoBeIf_XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: kwolf@redhat.com, mreitz@redhat.com, dillaman@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Florian,

On Thu, Dec 19, 2019 at 02:34:16PM +0100, Florian Florensa wrote:
> Starting from ceph Nautilus, RBD has support for namespaces, allowing
> for finer grain ACLs on images inside a pool, and tenant isolation.
>=20
> In the rbd cli tool documentation, the new image-spec and snap-spec are :
>  - [pool-name/[namespace-name/]]image-name
>  - [pool-name/[namespace-name/]]image-name@snap-name
>=20
> When using an non namespace's enabled qemu, it complains about not
> finding the image called namespace-name/image-name, thus we only need to
> parse the image once again to find if there is a '/' in its name, and if
> there is, use what is before it as the name of the namespace to later
> pass it to rados_ioctx_set_namespace.
> rados_ioctx_set_namespace if called with en empty string or a null
> pointer as the namespace parameters pretty much does nothing, as it then
> defaults to the default namespace.
>=20
> The namespace is extracted inside qemu_rbd_parse_filename, stored in the
> qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
> and qemu itself.
>=20
> Signed-off-by: Florian Florensa <fflorensa@online.net>
> ---
>  block/rbd.c          | 30 ++++++++++++++++++++++++------
>  qapi/block-core.json |  3 +++
>  2 files changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 027cbcc695..e43099fc75 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    char *nspace;
>      uint64_t image_size;
>  } BDRVRBDState;
> =20
> @@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
>      const char *start;
>      char *p, *buf;
>      QList *keypairs =3D NULL;
> -    char *found_str;
> +    char *found_str, *image_name;
> =20
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
> @@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char *fil=
ename, QDict *options,
>      qdict_put_str(options, "pool", found_str);
> =20
>      if (strchr(p, '@')) {
> -        found_str =3D qemu_rbd_next_tok(p, '@', &p);
> -        qemu_rbd_unescape(found_str);
> -        qdict_put_str(options, "image", found_str);
> +        image_name =3D qemu_rbd_next_tok(p, '@', &p);
> =20
>          found_str =3D qemu_rbd_next_tok(p, ':', &p);
>          qemu_rbd_unescape(found_str);
>          qdict_put_str(options, "snapshot", found_str);
>      } else {
> -        found_str =3D qemu_rbd_next_tok(p, ':', &p);
> +        image_name =3D qemu_rbd_next_tok(p, ':', &p);
> +    }
> +    /* Check for namespace in the image_name */
> +    if (strchr(image_name, '/')) {
> +        found_str =3D qemu_rbd_next_tok(image_name, '/', &image_name);
>          qemu_rbd_unescape(found_str);
> -        qdict_put_str(options, "image", found_str);
> +        qdict_put_str(options, "nspace", found_str);
> +    } else {
> +        qdict_put_str(options, "nspace", "");
>      }
> +    qemu_rbd_unescape(image_name);
> +    qdict_put_str(options, "image", image_name);
>      if (!p) {
>          goto done;
>      }
> @@ -343,6 +350,11 @@ static QemuOptsList runtime_opts =3D {
>              .type =3D QEMU_OPT_STRING,
>              .help =3D "Rados pool name",
>          },
> +        {
> +            .name =3D "nspace",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Rados namespace name in the pool",
> +        },
>          {
>              .name =3D "image",
>              .type =3D QEMU_OPT_STRING,
> @@ -472,6 +484,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
>      loc->has_conf =3D !!loc->conf;
>      loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
>      loc->has_user =3D !!loc->user;
> +    loc->nspace   =3D g_strdup(qdict_get_try_str(options, "nspace"));
>      loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
>      keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
> =20
> @@ -648,6 +661,11 @@ static int qemu_rbd_connect(rados_t *cluster, rados_=
ioctx_t *io_ctx,
>          error_setg_errno(errp, -r, "error opening pool %s", opts->pool);
>          goto failed_shutdown;
>      }
> +    /*
> +     * Set the namespace after opening the io context on the pool,
> +     * if nspace =3D=3D NULL or if nspace =3D=3D "", it is just as we di=
d nothing
> +     */
> +    rados_ioctx_set_namespace(*io_ctx, opts->nspace);
> =20
>      return 0;
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0cf68fea14..9ebc020e93 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3657,6 +3657,8 @@
>  #
>  # @pool:               Ceph pool name.
>  #
> +# @nspace:             Rados namespace name in the Ceph pool.
> +#

I think we need to add (Since: 5.0).

The patch LGTM, but I'd like to use 'namespace' instead of cryptic
'nspace'. (as BlockdevOptionsNVMe did)
What do you think?


With those fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>  # @image:              Image name in the Ceph pool.
>  #
>  # @conf:               path to Ceph configuration file.  Values
> @@ -3683,6 +3685,7 @@
>  ##
>  { 'struct': 'BlockdevOptionsRbd',
>    'data': { 'pool': 'str',
> +            'nspace': 'str',
>              'image': 'str',
>              '*conf': 'str',
>              '*snapshot': 'str',
> --=20
> 2.24.1
>=20
>=20


