Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380BC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7813214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEKfEQaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7813214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKAX-0000Xg-0G
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSK9h-00087s-TA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSK9g-0005if-Gr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:11:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSK9g-0005iN-Cr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573042280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fyIEqTKPmuoFvUnOIDq3SpMtI2lgVwsPtHHovXhbV6Y=;
 b=JEKfEQaUaVEV1MMGq3NPQ+bTsIKMezXNkIRzagGOL23H/AUXfggKJbroYpBRmz6Q8y99SC
 M89oxVuZMNEyr1eX4Upc6mLnchmvJHm4t97/tJNXE0bt5p+Zkxu6v3+SLvMYSLqavP/u3g
 TIMrhXe3d9Z+C6Qxo9GPM6H0L/e4hn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-iBzZO-aIMFyvKPZT-MxKIQ-1; Wed, 06 Nov 2019 07:11:16 -0500
X-MC-Unique: iBzZO-aIMFyvKPZT-MxKIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000211800D53;
 Wed,  6 Nov 2019 12:11:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D80B560C88;
 Wed,  6 Nov 2019 12:11:13 +0000 (UTC)
Subject: Re: [RFC PATCH 01/18] qemu-storage-daemon: Add barebone tool
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-2-kwolf@redhat.com>
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
Message-ID: <5fef0891-3081-d9f3-56db-22eb4ab663a0@redhat.com>
Date: Wed, 6 Nov 2019 13:11:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ES4dZDw0zoUOZ6p5uk9Ldf9QvDcKQXhUu"
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ES4dZDw0zoUOZ6p5uk9Ldf9QvDcKQXhUu
Content-Type: multipart/mixed; boundary="CTnbbBGncbNhBdWbfu0aL0pWmOO4z2Ee6"

--CTnbbBGncbNhBdWbfu0aL0pWmOO4z2Ee6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 15:01, Kevin Wolf wrote:
> This adds a new binary qemu-storage-daemon that doesn't yet do more than
> some typical initialisation for tools and parsing the basic command
> options --version, --help and --trace.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  configure             |   2 +-
>  qemu-storage-daemon.c | 141 ++++++++++++++++++++++++++++++++++++++++++
>  Makefile              |   1 +
>  3 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 qemu-storage-daemon.c
>=20
> diff --git a/configure b/configure
> index 08ca4bcb46..bb3d55fb25 100755
> --- a/configure
> +++ b/configure
> @@ -6034,7 +6034,7 @@ tools=3D""
>  if test "$want_tools" =3D "yes" ; then
>    tools=3D"qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $too=
ls"
>    if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" ] =
; then
> -    tools=3D"qemu-nbd\$(EXESUF) $tools"
> +    tools=3D"qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
>    fi
>    if [ "$ivshmem" =3D "yes" ]; then
>      tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> new file mode 100644
> index 0000000000..a251dc255c
> --- /dev/null
> +++ b/qemu-storage-daemon.c
> @@ -0,0 +1,141 @@
> +/*
> + * QEMU storage daemon
> + *
> + * Copyright (c) 2019 Kevin Wolf <kwolf@redhat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "block/block.h"
> +#include "crypto/init.h"
> +
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu-version.h"
> +#include "qemu/config-file.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/module.h"
> +
> +#include "trace/control.h"
> +
> +#include <getopt.h>
> +
> +static void help(void)
> +{
> +    printf(
> +"Usage: %s [options]\n"
> +"QEMU storage daemon\n"
> +"\n"
> +"  -h, --help             display this help and exit\n"
> +"  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
> +"                         specify tracing options\n"
> +"  -V, --version          output version information and exit\n"
> +"\n"
> +QEMU_HELP_BOTTOM "\n",
> +    error_get_progname());
> +}
> +
> +static int process_options(int argc, char *argv[], Error **errp)
> +{
> +    int c;
> +    char *trace_file =3D NULL;
> +    int ret =3D -EINVAL;
> +
> +    static const struct option long_options[] =3D {
> +        {"help", no_argument, 0, 'h'},
> +        {"version", no_argument, 0, 'V'},
> +        {"trace", required_argument, NULL, 'T'},
> +        {0, 0, 0, 0}
> +    };
> +
> +    while ((c =3D getopt_long(argc, argv, ":hT:V", long_options, NULL)) =
!=3D -1) {
> +        switch (c) {
> +        case '?':
> +            error_setg(errp, "Unknown option '%s'", argv[optind - 1]);
> +            goto out;

Am I doing something wrong or is optind really not updated when '?' is
returned?

Because I=E2=80=99m getting this:

$ ./qemu-storage-daemon -42
qemu-storage-daemon: Unknown option './qemu-storage-daemon'

But OTOH I also get:

$ ./qemu-img create -42
qemu-img: unrecognized option 'create'
Try 'qemu-img --help' for more information

So, uh, well.

Max


--CTnbbBGncbNhBdWbfu0aL0pWmOO4z2Ee6--

--ES4dZDw0zoUOZ6p5uk9Ldf9QvDcKQXhUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CuF8ACgkQ9AfbAGHV
z0CCPgf/X9Rmv7DCoueSNKQfwEJfV1vLUw7AJpvtDoB0VyM2Fp4CsREHpvgmhXUt
Et3kO5m6RUCUp60QwOT4o4fp9ChtHzQHYPGViOQpGImRkxyST+cnd7wCAUy3l0/K
aNE+F9KAQM9xZol9TiIB1Ocu6KCI4r0Z5eRkbVoeZNv0vBK89VuMsYvTMcAWJvGH
FX9ixmkUEi4DCg6qpAEw9KOSGL6gLRPd2gzBsnqZYX6cBNYQYRaotT34wJYCXl7C
PyOL23hxDTZLxI0bSgHOmW6R+Rne+L5Da88tbUMmxRojCe3Lc3m9ilfgFJH4aJke
48GrLQjEwoNr+t4hA2OTahCkq/jIcA==
=iHU7
-----END PGP SIGNATURE-----

--ES4dZDw0zoUOZ6p5uk9Ldf9QvDcKQXhUu--


