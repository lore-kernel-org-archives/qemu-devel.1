Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2652EC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A702076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIsB9VUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A702076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAbd-0007B0-2E
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jUAaz-0006iu-Qy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jUAay-0005Vq-5a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:55:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jUAax-0005RO-Nd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588258523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4VSMmHp+CmocLnNpGRqkpuw8cL+A3CPGGpQs+Uw455g=;
 b=HIsB9VUfi2pdtubKufA0B0kEMkuEHKYz7CtAAzCYs6ZYLqy/axqQHxA5c1ajhrqBhsjo/c
 /UY7jnNNoInsqZVVHwxN1BopfhJYap5bOMXZIrEg+/StAGwPhlcbmJ//85sco9w4BCgpXu
 F3KtRhwrOghAQnF3GTbI9hhl+OATHO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-E3NER9v8PJas5FkwmPQ21Q-1; Thu, 30 Apr 2020 10:55:18 -0400
X-MC-Unique: E3NER9v8PJas5FkwmPQ21Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46843835B42;
 Thu, 30 Apr 2020 14:55:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5426551151;
 Thu, 30 Apr 2020 14:55:15 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <1dcf85b6-d9e6-b952-537c-791daec34ad9@redhat.com>
Date: Thu, 30 Apr 2020 16:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421212019.170707-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5Nf0eOpZ7oXabaZdrnsHtzThJqJ8Tob9f"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Nf0eOpZ7oXabaZdrnsHtzThJqJ8Tob9f
Content-Type: multipart/mixed; boundary="pnkdNoUKnjlxeMT9oxR79NKcp9m1B1lXc"

--pnkdNoUKnjlxeMT9oxR79NKcp9m1B1lXc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 23:20, Eric Blake wrote:
> Include actions for --add, --remove, --clear, --enable, --disable, and
> --merge (note that --clear is a bit of fluff, because the same can be
> accomplished by removing a bitmap and then adding a new one in its
> place,

Well, ideally, all of qemu-img is just fluff because =E2=80=9Cthe same can =
be
accomplished by launching qemu and issuing the equivalent QMP commands=E2=
=80=9D. :)

>        but it matches what QMP commands exist).  Listing is omitted,
> because it does not require a bitmap name and because it was already
> possible with 'qemu-img info'.

Fair enough, although it can be said that qemu-img info=E2=80=99s output is
qcow2-specific.  It might be nice to have some definitely
format-independent output.  (But we don=E2=80=99t have persistent bitmaps i=
n
anything but qcow2 yet (or do we in NBD?), so I don=E2=80=99t expect anyone=
 to
care much.)

>                                 Merge can work either from another
> bitmap in the same image, or from a bitmap in a distinct image.
>=20
> While this supports --image-opts for the file being modified, I did
> not think it worth the extra complexity to support that for the source
> file in a cross-file bitmap merge.  Likewise, I chose to have --merge
> only take a single source rather than following the QMP support for
> multiple merges in one go; in part to simplify the command line, and
> in part because an offline image can achieve the same effect by
> multiple qemu-img bitmap --merge calls.  We can enhance that if needed
> in the future (the same way that 'qemu-img convert' has a mode that
> concatenates multiple sources into one destination).
>=20
> Upcoming patches will add iotest coverage of these commands while
> also testing other features.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/tools/qemu-img.rst |  24 +++++
>  qemu-img.c              | 198 ++++++++++++++++++++++++++++++++++++++++
>  qemu-img-cmds.hx        |   7 ++
>  3 files changed, 229 insertions(+)
>=20
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 7d08c48d308f..4f3b0e2c9ace 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -281,6 +281,30 @@ Command description:
>    For write tests, by default a buffer filled with zeros is written. Thi=
s can be
>    overridden with a pattern byte specified by *PATTERN*.
>=20
> +.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove | --c=
lear | --enable | --disable | --merge SOURCE_BITMAP [-b SOURCE_FILE [-F SOU=
RCE_FMT]]} [--object OBJECTDEF] [--image-opts] [-f FMT] FILENAME BITMAP

So I can do multiple operations in one roll, but they all use the same
BITMAP?  Sounds a bit weird.  It actually took me a while to understands
this, because I thought for sure that each command would take a bitmap
name.  (And was ready to complain that it looked like they don=E2=80=99t, b=
ut,
well, that=E2=80=99s because they don=E2=80=99t.)

Although I suppose some practical example like

$ qemu-img bitmap --add --merge sbmap --disable foo.qcow2 nbmap

does make sense.[1]


Would

$ qemu-img bitmap --add nbmap --merge nbmap sbmap --enable nbmap \
      foo.qcow2

make more sense?  Doesn=E2=80=99t really look like it, because at that poin=
t you
just have to ask why not just call qemu-img bitmap multiple times.

*shrug*


[1] However, that leads me to ask:  Why does --add need a --disabled
option?  Isn=E2=80=99t that equivalent to --add --disable?

> +
> +  Perform a modification of the persistent bitmap *BITMAP* in the disk
> +  image *FILENAME*.  The various modifications are:
> +
> +  ``--add`` to create *BITMAP*, with additional options ``-g`` to
> +  specify a non-default *GRANULARITY*, or whether the bitmap should be
> +  ``--disabled`` instead of enabled.
> +
> +  ``--remove`` to remove *BITMAP*.
> +
> +  ``--clear`` to clear *BITMAP*.
> +
> +  ``--enable`` to change *BITMAP* to start recording future edits.
> +
> +  ``--disable`` to change *BITMAP* to stop recording future edits.
> +
> +  ``--merge`` to merge the contents of *SOURCE_BITMAP* into *BITMAP*.
> +  This defaults to requiring a source bitmap from the same *FILENAME*,
> +  but can also be used for cross-image merge by supplying ``-b`` to
> +  specify a different *SOURCE_FILE*.
> +
> +  To see what bitmaps are present in an image, use ``qemu-img info``.
> +
>  .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--o=
utput=3DOFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
>=20
>    Perform a consistency check on the disk image *FILENAME*. The command =
can
> diff --git a/qemu-img.c b/qemu-img.c
> index 821cbf610e5f..02ebd870faa1 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -28,6 +28,7 @@
>  #include "qemu-common.h"
>  #include "qemu-version.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/qmp/qjson.h"
> @@ -71,6 +72,12 @@ enum {
>      OPTION_SHRINK =3D 266,
>      OPTION_SALVAGE =3D 267,
>      OPTION_TARGET_IS_ZERO =3D 268,
> +    OPTION_ADD =3D 269,
> +    OPTION_REMOVE =3D 270,
> +    OPTION_CLEAR =3D 271,
> +    OPTION_ENABLE =3D 272,
> +    OPTION_DISABLE =3D 273,
> +    OPTION_MERGE =3D 274,
>  };
>=20
>  typedef enum OutputFormat {
> @@ -4438,6 +4445,197 @@ out:
>      return 0;
>  }
>=20
> +static int img_bitmap(int argc, char **argv)
> +{
> +    Error *err =3D NULL;
> +    int c, ret =3D -1;
> +    QemuOpts *opts =3D NULL;
> +    const char *fmt =3D NULL, *src_fmt =3D NULL, *src_filename =3D NULL;
> +    const char *filename, *bitmap;
> +    BlockBackend *blk =3D NULL, *src =3D NULL;
> +    BlockDriverState *bs =3D NULL, *src_bs =3D NULL;
> +    bool image_opts =3D false;
> +    unsigned long granularity =3D 0;
> +    bool add =3D false, remove =3D false, clear =3D false;
> +    bool enable =3D false, disable =3D false, add_disabled =3D false;
> +    const char *merge =3D NULL;

So actually we can=E2=80=99t do one operation multiple times in one roll.

> +
> +    for (;;) {
> +        static const struct option long_options[] =3D {
> +            {"help", no_argument, 0, 'h'},
> +            {"object", required_argument, 0, OPTION_OBJECT},
> +            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {"add", no_argument, 0, OPTION_ADD},
> +            {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"clear", no_argument, 0, OPTION_CLEAR},
> +            {"enable", no_argument, 0, OPTION_ENABLE},
> +            {"disable", no_argument, 0, OPTION_DISABLE},
> +            {"disabled", no_argument, 0, OPTION_DISABLE},

So if --disable and --disabled are exactly the same, I really don=E2=80=99t=
 know
why --disabled even exists.

> +            {"merge", required_argument, 0, OPTION_MERGE},
> +            {"granularity", required_argument, 0, 'g'},
> +            {"source-file", required_argument, 0, 'b'},
> +            {"source-format", required_argument, 0, 'F'},
> +            {0, 0, 0, 0}
> +        };
> +        c =3D getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
> +        if (c =3D=3D -1) {
> +            break;
> +        }
> +
> +        switch (c) {
> +        case ':':
> +            missing_argument(argv[optind - 1]);
> +            break;
> +        case '?':
> +            unrecognized_option(argv[optind - 1]);
> +            break;
> +        case 'h':
> +            help();
> +            break;
> +        case 'b':
> +            src_filename =3D optarg;
> +            break;
> +        case 'f':
> +            fmt =3D optarg;
> +            break;
> +        case 'F':
> +            src_fmt =3D optarg;
> +            break;
> +        case 'g':
> +            if (qemu_strtosz(optarg, NULL, &granularity)) {
> +                error_report("Invalid granularity specified");
> +                return 1;
> +            }
> +            break;
> +        case OPTION_ADD:
> +            add =3D true;
> +            break;
> +        case OPTION_REMOVE:
> +            remove =3D true;
> +            break;
> +        case OPTION_CLEAR:
> +            clear =3D true;
> +            break;
> +        case OPTION_ENABLE:
> +            enable =3D true;
> +            break;
> +        case OPTION_DISABLE:
> +            disable =3D true;
> +            break;
> +        case OPTION_MERGE:
> +            merge =3D optarg;
> +            break;
> +        case OPTION_OBJECT:
> +            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> +                                           optarg, true);
> +            if (!opts) {
> +                goto out;
> +            }
> +            break;
> +        case OPTION_IMAGE_OPTS:
> +            image_opts =3D true;
> +            break;
> +        }
> +    }
> +
> +    if (qemu_opts_foreach(&qemu_object_opts,
> +                          user_creatable_add_opts_foreach,
> +                          qemu_img_object_print_help, &error_fatal)) {
> +        goto out;
> +    }
> +
> +    if (add && disable) {
> +        disable =3D false;
> +        add_disabled =3D true;
> +    }
> +    if (add + remove + clear + enable + disable + !!merge !=3D 1) {
> +        error_report("Need exactly one mode of --add, --remove, --clear,=
 "
> +                     "--enable, --disable, or --merge");

Aha.  So you can actually only do a single operation.

That means the doc shouldn=E2=80=99t use {}, in my opinion, because that to=
 me
means repetition (thanks to EBNF).  It definitely served to confuse me
greatly until this point.

I also don=E2=80=99t see why we would disallow multiple operations in one g=
o.
The --add --merge combination seems useful to me, and I don=E2=80=99t see a
problem in implementing it.

I don=E2=80=99t know why we don=E2=80=99t just create a list of operations =
to execute,
based on the order given in the argument list, and then execute them in
order.  That would even allow multiple --merge operations.

If we don=E2=80=99t want that (because we don=E2=80=99t want argument order=
 to matter),
we could still allow all operations to be done at least once and always
execute them in the same order, e.g.:
(1) add
(2) clear
(3) merge
(4) disable
(5) enable
(6) remove

> +        goto out;
> +    }
> +    if (granularity && !add) {
> +        error_report("granularity only supported with --add");
> +        goto out;
> +    }
> +    if (src_fmt && !src_filename) {
> +        error_report("-F only supported with -b");
> +        goto out;
> +    }
> +    if (src_filename && !merge) {
> +        error_report("alternate source file only supported with --merge"=
);

=E2=80=9Calternate=E2=80=9D sounds strange.  Why not be more precise and ca=
ll it a
=E2=80=9CMerge bitmap source file=E2=80=9D or =E2=80=9CFile to source merge=
 bitmap from=E2=80=9D?

> +        goto out;
> +    }
> +
> +    if (optind !=3D argc - 2) {
> +        error_report("Expecting filename and bitmap name");
> +        goto out;
> +    }
> +
> +    filename =3D argv[optind];
> +    bitmap =3D argv[optind + 1];
> +
> +    blk =3D img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, fals=
e,
> +                   false);
> +    if (!blk) {
> +        goto out;
> +    }
> +    bs =3D blk_bs(blk);
> +
> +    if (add) {
> +        qmp_block_dirty_bitmap_add(bs->node_name, bitmap,
> +                                   !!granularity, granularity, true, tru=
e,
> +                                   true, add_disabled, &err);
> +    } else if (remove) {
> +        qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
> +    } else if (clear) {
> +        qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
> +    } else if (enable) {
> +        qmp_block_dirty_bitmap_enable(bs->node_name, bitmap, &err);
> +    } else if (disable) {
> +        qmp_block_dirty_bitmap_disable(bs->node_name, bitmap, &err);
> +    } else if (merge) {
> +        BlockDirtyBitmapMergeSource *merge_src;
> +        BlockDirtyBitmapMergeSourceList *list;
> +
> +        if (src_filename) {
> +            src =3D img_open(NULL, src_filename, src_fmt, 0, false, fals=
e,
> +                           false);
> +            if (!src) {
> +                goto out;
> +            }
> +            src_bs =3D blk_bs(src);
> +        } else {
> +            src_bs =3D bs;
> +        }
> +
> +        merge_src =3D g_new0(BlockDirtyBitmapMergeSource, 1);
> +        merge_src->type =3D QTYPE_QDICT;
> +        merge_src->u.external.node =3D g_strdup(src_bs->node_name);
> +        merge_src->u.external.name =3D g_strdup(merge);
> +        list =3D g_new0(BlockDirtyBitmapMergeSourceList, 1);
> +        list->value =3D merge_src;
> +        qmp_block_dirty_bitmap_merge(bs->node_name, bitmap, list, &err);
> +        qapi_free_BlockDirtyBitmapMergeSourceList(list);
> +    }
> +
> +    if (err) {
> +        error_reportf_err(err, "Bitmap %s operation failed", bitmap);

Wouldn=E2=80=99t =E2=80=9COperation on bitmap %s failed=E2=80=9D work bette=
r?

Max

> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    ret =3D 0;
> +
> + out:
> +    blk_unref(src);
> +    blk_unref(blk);
> +    qemu_opts_del(opts);
> +    if (ret) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>  #define C_BS      01
>  #define C_COUNT   02
>  #define C_IF      04


--pnkdNoUKnjlxeMT9oxR79NKcp9m1B1lXc--

--5Nf0eOpZ7oXabaZdrnsHtzThJqJ8Tob9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6q5tEACgkQ9AfbAGHV
z0CPTggAveQ8jTv2/DGwBKEYbAYJA6lgkuIIXSym5hhBFVUTb53VXzkspjHonFoV
PNRFUEFP9GpbD8JyqGPAKU9LwEHohQqOU/VfykqBhucZVy6bdCUkk7RAqM3Igc6P
a3JyqqiEPfvdDvcTyEifnb0L0VkFlqfkkthx93GBsW5th85BUd0Mon2WY3MSlbmK
wfhwc2pwGZSqN6Go6ypC+QmvKn6q3S3IE9oBCsBA7XGhkjvxmp0Yp5eA4Wc1hea2
YKpkgEXSs0EbAhzipsWrdCtiwLctaCrI1KnB1XQ/bG+QgezRYk6eiGr23YYudp2i
4qUX/azV5rNPibfMiHJC6tnnRL+kgg==
=gj9K
-----END PGP SIGNATURE-----

--5Nf0eOpZ7oXabaZdrnsHtzThJqJ8Tob9f--


