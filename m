Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B66C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E1F24672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVeD7oCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E1F24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwnX-0000u4-Np
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdillama@redhat.com>) id 1ihwbx-0000hK-BS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1ihwbu-00024k-AQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:17:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1ihwbu-0001zJ-22
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576765021;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uooxkqH2nyWECXtMlX6ftfcOa0F/AD8GNe/PvHDGn7c=;
 b=GVeD7oCHCp3jZi82E0yHqIxA0bKPc1bthJRhloXx+jbTkh8XIc+r9Vtv2JRsET91hFxLlG
 HpLODV/JgIRp9mTxJ2hAQdumSLOBsZzXm7IGJztZty0HPumDsiQlkdS2OkPD7sckBn1P7o
 +mekQ5FR+NXP37RA9Fn3mIQeInEMy08=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-06d6FGeKOHykSegcl1J5NA-1; Thu, 19 Dec 2019 09:15:50 -0500
Received: by mail-ed1-f69.google.com with SMTP id b13so3612215edf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=2uBBYDIAK5Wt7vNMTKeCu7nJZC0ff8rpQ4m04RVR/uQ=;
 b=rROBRA/Om7tktkLTDqnJYCj/LuZmZ1yhkKIvnAAPe4ZhnL37XSzr58es69r4K7bKrT
 uFi1BIoHgQ/bvq0WCBcTpcINVvdwz2Y50LPi+6YJfMZWZXRTl3eQczexsPAgQjNfkFhW
 RG5w2yt1Qf+Gcvy+3utwz+nZma3HnFxI/xnAUZh75zLQPASM0CikB7DMdkv2oL8S30WN
 eZVvNjv5pW9CzIutbNoWncwowze0S3H2/pnDWXuV+uhJDHfa4S2Nk+fARWAcsAP3im0f
 no4hApHx9Kzj7emVIz9GZmK5YVLy8+y7hs6PlmXwmZXJkmyj0DYIhdS6TyOTAKxd+QRA
 bK9A==
X-Gm-Message-State: APjAAAXX9+JeMue9I/Ur7eATXNkMJuOPER2c312ti9WX7gIiEp56XqmS
 2kG0MKGZrAkHwuLxYLs8YQNwnFjn0TlouDVdv6+y2/PDFeYmpDVZOunEyADyf8XO5ou4kEHVfxc
 mn/cAO+6+GZsFggejV0rWiCXmHYNxC/A=
X-Received: by 2002:a17:906:e0d7:: with SMTP id
 gl23mr9431612ejb.230.1576764949047; 
 Thu, 19 Dec 2019 06:15:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUHEpuaY51K0Smvm0mYECwQdFiH5UFARDeKqLsbhlq/wxCin8JmTLl+0tR3oojBOmUBJxvF+cmWdr8ZUNsl0w=
X-Received: by 2002:a17:906:e0d7:: with SMTP id
 gl23mr9431573ejb.230.1576764948700; 
 Thu, 19 Dec 2019 06:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20191219133416.671431-1-fflorensa@online.net>
In-Reply-To: <20191219133416.671431-1-fflorensa@online.net>
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 19 Dec 2019 09:15:37 -0500
Message-ID: <CA+aFP1Dc0kP1jebqmbQXo=zLgwQsBoEq2GLRtaNgrw6XMf_EOg@mail.gmail.com>
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
To: Florian Florensa <fflorensa@online.net>
X-MC-Unique: 06d6FGeKOHykSegcl1J5NA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, dillaman <dillaman@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 8:44 AM Florian Florensa <fflorensa@online.net> wro=
te:
>
> Starting from ceph Nautilus, RBD has support for namespaces, allowing
> for finer grain ACLs on images inside a pool, and tenant isolation.
>
> In the rbd cli tool documentation, the new image-spec and snap-spec are :
>  - [pool-name/[namespace-name/]]image-name
>  - [pool-name/[namespace-name/]]image-name@snap-name
>
> When using an non namespace's enabled qemu, it complains about not
> finding the image called namespace-name/image-name, thus we only need to
> parse the image once again to find if there is a '/' in its name, and if
> there is, use what is before it as the name of the namespace to later
> pass it to rados_ioctx_set_namespace.
> rados_ioctx_set_namespace if called with en empty string or a null
> pointer as the namespace parameters pretty much does nothing, as it then
> defaults to the default namespace.
>
> The namespace is extracted inside qemu_rbd_parse_filename, stored in the
> qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
> and qemu itself.
>
> Signed-off-by: Florian Florensa <fflorensa@online.net>
> ---
>  block/rbd.c          | 30 ++++++++++++++++++++++++------
>  qapi/block-core.json |  3 +++
>  2 files changed, 27 insertions(+), 6 deletions(-)
>
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
>
> @@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
>      const char *start;
>      char *p, *buf;
>      QList *keypairs =3D NULL;
> -    char *found_str;
> +    char *found_str, *image_name;
>
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
> @@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char *fil=
ename, QDict *options,
>      qdict_put_str(options, "pool", found_str);
>
>      if (strchr(p, '@')) {
> -        found_str =3D qemu_rbd_next_tok(p, '@', &p);
> -        qemu_rbd_unescape(found_str);
> -        qdict_put_str(options, "image", found_str);
> +        image_name =3D qemu_rbd_next_tok(p, '@', &p);
>
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
>
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
>
>      return 0;
>
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
> --
> 2.24.1
>

Thanks for tackling this. I had this and msgr v2 support on my todo
list for QEMU but I haven't had a chance to work on them yet. The
changes look good to me and it works as expected during CLI
play-testing.

Reviewed-by: Jason Dillaman <dillaman@redhat.com>


