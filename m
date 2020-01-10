Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EAEC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706922072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 13:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kez2WUaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706922072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipujW-0006bo-JN
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 08:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ipuik-00062A-LU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ipuih-0007cV-6Y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:53:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ipuig-0007UD-9o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 08:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578664376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq/NGXFSqkaw/VSE+4spXiYoi+YJmal98bbFU+f4iOM=;
 b=Kez2WUaHt8lhSzoL4ts6dQi7uFEuoLCooOB1eCc7oJpZwMLojSyyFC7B9XyyDxEG8wLvpZ
 Y3bhb6AquGciU8wJdnOQiDjE3XAAsJKEsNtZG2QAHuQg3fKRAXVvZzAa0htY0Cjr3Hz/S5
 0zR0laveLra5wb+g1xYlIzGiVfT8GYg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-I6rDSXJ5OlebFSdoSXaI6Q-1; Fri, 10 Jan 2020 08:52:55 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so1591386wmi.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 05:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SwFiat30isorbccAPeko04RFyxpe/hT1iMsqsohPf44=;
 b=Nm1YBis25HBRomxAMzBHEd9MYxNrGCrHOQDIFoWobuOAWZdRl2i+o32czQnnaOCKOK
 DXEiVighrOmc6ljG6IvD11soaTh/Iub58jdfYtynnPla5UvlCJ1/JlvfO4RoDxYuUWyc
 aTI8FrFogcJ4In3osWQ4P1Juwy91SxwCcpa4xqacaW7nZ7KgD+QnsDBWxQwoZMTsNx75
 ry9REiGacChztbMbgSuro0y6YrddNGSCppnugGe5Zjtqr8IaR02eIU0J+64Sl99F8AKI
 il87J4uG+QVG5dFrjjtTBJLWdKnZTXqPsk/r5wjFalgmXrqyrHxbrydUwIlpdRg8T4up
 osaA==
X-Gm-Message-State: APjAAAUD8J9H2aJDxTV/Ps9r5wTeqEBgNgl+OytkEq5Bb1q5c3OtKwwQ
 xHxOsVn1xHHu9B7FCKGWuS30pklvTSZporHkjgi2nN80LPxV0CTsROJpMcADZcbsX50gEQl5lQl
 hs5Zpn9p92MUBqig=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr3831655wrc.69.1578664374127; 
 Fri, 10 Jan 2020 05:52:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRzTWZBtxHu7Evh3p/QcZeVQIMjyKWz3QyHv/Iu5YaBQcvYg+w3WmaayZjcmr/WJxel2XHBw==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr3831618wrc.69.1578664373741; 
 Fri, 10 Jan 2020 05:52:53 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it.
 [79.31.49.84])
 by smtp.gmail.com with ESMTPSA id u1sm2296969wmc.5.2020.01.10.05.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 05:52:53 -0800 (PST)
Date: Fri, 10 Jan 2020 14:52:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Florian Florensa <fflorensa@online.net>
Subject: Re: [PATCH v3 1/1] block/rbd: Add support for ceph namespaces
Message-ID: <20200110135250.pokpir4jjvudxd7y@steredhat>
References: <20200110111513.321728-1-fflorensa@online.net>
 <20200110111513.321728-2-fflorensa@online.net>
MIME-Version: 1.0
In-Reply-To: <20200110111513.321728-2-fflorensa@online.net>
X-MC-Unique: I6rDSXJ5OlebFSdoSXaI6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: kwolf@redhat.com, dillaman@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 12:15:13PM +0100, Florian Florensa wrote:
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
>  block/rbd.c          | 44 +++++++++++++++++++++++++++++++-------------
>  qapi/block-core.json |  4 ++++
>  2 files changed, 35 insertions(+), 13 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 027cbcc695..84115d34b4 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    char *namespace;
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
> +        qdict_put_str(options, "namespace", found_str);
> +    } else {
> +        qdict_put_str(options, "namespace", "");
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
> +            .name =3D "namespace",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Rados namespace name in the pool",
> +        },
>          {
>              .name =3D "image",
>              .type =3D QEMU_OPT_STRING,
> @@ -467,13 +479,14 @@ static int coroutine_fn qemu_rbd_co_create_opts(con=
st char *filename,
>       * schema, but when they come from -drive, they're all QString.
>       */
>      loc =3D rbd_opts->location;
> -    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
> -    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
> -    loc->has_conf =3D !!loc->conf;
> -    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
> -    loc->has_user =3D !!loc->user;
> -    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
> -    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
> +    loc->pool        =3D g_strdup(qdict_get_try_str(options, "pool"));
> +    loc->conf        =3D g_strdup(qdict_get_try_str(options, "conf"));
> +    loc->has_conf    =3D !!loc->conf;
> +    loc->user        =3D g_strdup(qdict_get_try_str(options, "user"));
> +    loc->has_user    =3D !!loc->user;
> +    loc->q_namespace =3D g_strdup(qdict_get_try_str(options, "namespace"=
));
> +    loc->image       =3D g_strdup(qdict_get_try_str(options, "image"));
> +    keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs")=
;
> =20
>      ret =3D qemu_rbd_do_create(create_options, keypairs, password_secret=
, errp);
>      if (ret < 0) {
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
> +    rados_ioctx_set_namespace(*io_ctx, opts->q_namespace);
> =20
>      return 0;
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index fcb52ec24f..c6f187ec9b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3661,6 +3661,9 @@
>  #
>  # @pool:               Ceph pool name.
>  #
> +# @namespace:          Rados namespace name in the Ceph pool.
> +#                      (Since 5.0)
> +#
>  # @image:              Image name in the Ceph pool.
>  #
>  # @conf:               path to Ceph configuration file.  Values
> @@ -3687,6 +3690,7 @@
>  ##
>  { 'struct': 'BlockdevOptionsRbd',
>    'data': { 'pool': 'str',
> +            '*namespace': 'str',
>              'image': 'str',
>              '*conf': 'str',
>              '*snapshot': 'str',
> --=20
> 2.24.1
>=20


