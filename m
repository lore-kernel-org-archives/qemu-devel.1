Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED484C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E59214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjTRSur7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E59214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUbX-0001Y0-Rf
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwUam-0000zU-Se
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwUal-0006rE-2K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:24:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwUak-0006qI-Tu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580232238;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwDYR8xbIGR790ZgP3HK9zKlils55l4PwkHY7IEa8MI=;
 b=XjTRSur7ApcND2yIIMBf8NqE3Xeo+Xpa5yHxaF2q9AZuRgmrIc5hP6zJmdFAMENUF0982Q
 eIDMTOeerHhic43P7o5egLiVZxGmkm7QA7lTmXN40GB+AXklW0PxEx99H+CWQG7NXBSQXT
 Nzotf/bfra2AjDezDKauGV2YoIUR76o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-znaocZXYPlaBRYVjD6AASA-1; Tue, 28 Jan 2020 12:23:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17113107ACC9;
 Tue, 28 Jan 2020 17:23:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE77B5C219;
 Tue, 28 Jan 2020 17:23:46 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:23:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 04/13] block: amend: separate amend and create options
 for qemu-img
Message-ID: <20200128172343.GW1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-5-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114193350.10830-5-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: znaocZXYPlaBRYVjD6AASA-1
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 09:33:41PM +0200, Maxim Levitsky wrote:
> Some options are only useful for creation
> (or hard to be amended, like cluster size for qcow2), while some other
> options are only useful for amend, like upcoming keyslot management
> options for luks
>=20
> Since currently only qcow2 supports amend, move all its options
> to a common macro and then include it in each action option list.
>=20
> In future it might be useful to remove some options which are
> not supported anyway from amend list, which currently
> cause an error message if amended.

I think I would have done that in this commit. At least the
encrypt.* options shouldn't be added to the amend_opts list,
since they're being removed from it again a few patches later.

>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2.c             | 160 +++++++++++++++++++++-----------------
>  include/block/block_int.h |   4 +
>  qemu-img.c                |  18 ++---
>  3 files changed, 100 insertions(+), 82 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6bcf4a5fc4..c6c2deee75 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5445,83 +5445,96 @@ void qcow2_signal_corruption(BlockDriverState *bs=
, bool fatal, int64_t offset,
>      s->signaled_corruption =3D true;
>  }
> =20
> +#define QCOW_COMMON_OPTIONS                                         \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_SIZE,                                     \
> +        .type =3D QEMU_OPT_SIZE,                                      \
> +        .help =3D "Virtual disk size"                                 \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_COMPAT_LEVEL,                             \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"       \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_BACKING_FILE,                             \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "File name of a base image"                         \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_BACKING_FMT,                              \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Image format of the base image"                    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_DATA_FILE,                                \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "File name of an external data file"                \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_DATA_FILE_RAW,                            \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "The external data file must stay valid "           \
> +                "as a raw image"                                    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_ENCRYPT,                                  \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
> +                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
> +    },                                                              \
> +    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
> +        "ID of secret providing qcow AES key or LUKS passphrase"),  \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
> +    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
> +        .type =3D QEMU_OPT_SIZE,                                      \
> +        .help =3D "qcow2 cluster size",                               \
> +        .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_PREALLOC,                                 \
> +        .type =3D QEMU_OPT_STRING,                                    \
> +        .help =3D "Preallocation mode (allowed values: off, "         \
> +                "metadata, falloc, full)"                           \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_LAZY_REFCOUNTS,                           \
> +        .type =3D QEMU_OPT_BOOL,                                      \
> +        .help =3D "Postpone refcount updates",                        \
> +        .def_value_str =3D "off"                                      \
> +    },                                                              \
> +    {                                                               \
> +        .name =3D BLOCK_OPT_REFCOUNT_BITS,                            \
> +        .type =3D QEMU_OPT_NUMBER,                                    \
> +        .help =3D "Width of a reference count entry in bits",         \
> +        .def_value_str =3D "16"                                       \
> +    }                                                               \
> +
>  static QemuOptsList qcow2_create_opts =3D {
>      .name =3D "qcow2-create-opts",
>      .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
>      .desc =3D {
> -        {
> -            .name =3D BLOCK_OPT_SIZE,
> -            .type =3D QEMU_OPT_SIZE,
> -            .help =3D "Virtual disk size"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_COMPAT_LEVEL,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_BACKING_FILE,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "File name of a base image"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_BACKING_FMT,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Image format of the base image"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_DATA_FILE,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "File name of an external data file"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_DATA_FILE_RAW,
> -            .type =3D QEMU_OPT_BOOL,
> -            .help =3D "The external data file must stay valid as a raw i=
mage"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_ENCRYPT,
> -            .type =3D QEMU_OPT_BOOL,
> -            .help =3D "Encrypt the image with format 'aes'. (Deprecated =
"
> -                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",
> -        },
> -        {
> -            .name =3D BLOCK_OPT_ENCRYPT_FORMAT,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Encrypt the image, format choices: 'aes', 'luks'"=
,
> -        },
> -        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
> -            "ID of secret providing qcow AES key or LUKS passphrase"),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
> -        {
> -            .name =3D BLOCK_OPT_CLUSTER_SIZE,
> -            .type =3D QEMU_OPT_SIZE,
> -            .help =3D "qcow2 cluster size",
> -            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)
> -        },
> -        {
> -            .name =3D BLOCK_OPT_PREALLOC,
> -            .type =3D QEMU_OPT_STRING,
> -            .help =3D "Preallocation mode (allowed values: off, metadata=
, "
> -                    "falloc, full)"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_LAZY_REFCOUNTS,
> -            .type =3D QEMU_OPT_BOOL,
> -            .help =3D "Postpone refcount updates",
> -            .def_value_str =3D "off"
> -        },
> -        {
> -            .name =3D BLOCK_OPT_REFCOUNT_BITS,
> -            .type =3D QEMU_OPT_NUMBER,
> -            .help =3D "Width of a reference count entry in bits",
> -            .def_value_str =3D "16"
> -        },
> +        QCOW_COMMON_OPTIONS,
> +        { /* end of list */ }
> +    }
> +};
> +
> +static QemuOptsList qcow2_amend_opts =3D {
> +    .name =3D "qcow2-amend-opts",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
> +    .desc =3D {
> +        QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
>      }
>  };
> @@ -5581,6 +5594,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_inactivate            =3D qcow2_inactivate,
> =20
>      .create_opts         =3D &qcow2_create_opts,
> +    .amend_opts          =3D &qcow2_amend_opts,
>      .strong_runtime_opts =3D qcow2_strong_runtime_opts,
>      .mutable_opts        =3D mutable_opts,
>      .bdrv_co_check       =3D qcow2_co_check,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 810a9ecb86..6f0abf8544 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -407,6 +407,10 @@ struct BlockDriver {
> =20
>      /* List of options for creating images, terminated by name =3D=3D NU=
LL */
>      QemuOptsList *create_opts;
> +
> +    /* List of options for image amend*/
> +    QemuOptsList *amend_opts;
> +
>      /*
>       * If this driver supports reopening images this contains a
>       * NULL-terminated list of the runtime options that can be
> diff --git a/qemu-img.c b/qemu-img.c
> index a79f3904db..befd53943b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3878,11 +3878,11 @@ static int print_amend_option_help(const char *fo=
rmat)
>          return 1;
>      }
> =20
> -    /* Every driver supporting amendment must have create_opts */
> -    assert(drv->create_opts);
> +    /* Every driver supporting amendment must have amend_opts */
> +    assert(drv->amend_opts);
> =20
>      printf("Creation options for '%s':\n", format);
> -    qemu_opts_print_help(drv->create_opts, false);
> +    qemu_opts_print_help(drv->amend_opts, false);
>      printf("\nNote that not all of these options may be amendable.\n");
>      return 0;
>  }
> @@ -3892,7 +3892,7 @@ static int img_amend(int argc, char **argv)
>      Error *err =3D NULL;
>      int c, ret =3D 0;
>      char *options =3D NULL;
> -    QemuOptsList *create_opts =3D NULL;
> +    QemuOptsList *amend_opts =3D NULL;
>      QemuOpts *opts =3D NULL;
>      const char *fmt =3D NULL, *filename, *cache;
>      int flags;
> @@ -4031,11 +4031,11 @@ static int img_amend(int argc, char **argv)
>          goto out;
>      }
> =20
> -    /* Every driver supporting amendment must have create_opts */
> -    assert(bs->drv->create_opts);
> +    /* Every driver supporting amendment must have amend_opts */
> +    assert(bs->drv->amend_opts);
> =20
> -    create_opts =3D qemu_opts_append(create_opts, bs->drv->create_opts);
> -    opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
> +    amend_opts =3D qemu_opts_append(amend_opts, bs->drv->amend_opts);
> +    opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
>      qemu_opts_do_parse(opts, options, NULL, &err);
>      if (err) {
>          error_report_err(err);
> @@ -4058,7 +4058,7 @@ out:
>  out_no_progress:
>      blk_unref(blk);
>      qemu_opts_del(opts);
> -    qemu_opts_free(create_opts);
> +    qemu_opts_free(amend_opts);
>      g_free(options);
> =20
>      if (ret) {
> --=20
> 2.17.2
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


