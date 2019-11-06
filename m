Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D55C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5236C21848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hg8NVKwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5236C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMNI-0002n6-CB
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSMMF-0001uM-Od
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSMMA-0004im-Q5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSMMA-0004iX-M5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573050742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5AsTdsPewgzZ2I/NmcNx7qiTK/Fez4r2xJ8kPn2Yod0=;
 b=Hg8NVKwpkY/zy8uppeVOlYDhOSjsSvIwo8xFNHrH4X3p1lnm6qe6MQDALcT831JxNh61vp
 GIEhm36/sU9jbKtTl0RbxM7UfXur0+niKt9a4wodHwSmBHZrxXRaFuHUwUNFUPZehebj0C
 hb/OnrhriqyVTjbxwyNbfVlEtwYPC3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-9ae2zYetNxK9oZvQsdzzOg-1; Wed, 06 Nov 2019 09:32:18 -0500
X-MC-Unique: 9ae2zYetNxK9oZvQsdzzOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1051005500;
 Wed,  6 Nov 2019 14:32:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 630015D9CD;
 Wed,  6 Nov 2019 14:32:15 +0000 (UTC)
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
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
Message-ID: <64d79019-711d-8eb1-da72-a9b95f999ff5@redhat.com>
Date: Wed, 6 Nov 2019 15:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-19-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e5r2awgTosFFLSTnuUOwnQ5gRohdP1xw8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--e5r2awgTosFFLSTnuUOwnQ5gRohdP1xw8
Content-Type: multipart/mixed; boundary="P3JgiCIcJuwf7KuEY38QKsc3pqMhhFq8x"

--P3JgiCIcJuwf7KuEY38QKsc3pqMhhFq8x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 15:02, Kevin Wolf wrote:
> This adds and parses the --monitor option, so that a QMP monitor can be
> used in the storage daemon. The monitor offers commands defined in the
> QAPI schema at storage-daemon/qapi/qapi-schema.json.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  storage-daemon/qapi/qapi-schema.json | 15 ++++++++++++
>  qemu-storage-daemon.c                | 34 ++++++++++++++++++++++++++++
>  Makefile                             | 30 ++++++++++++++++++++++++
>  Makefile.objs                        |  4 ++--
>  monitor/Makefile.objs                |  2 ++
>  qapi/Makefile.objs                   |  5 ++++
>  qom/Makefile.objs                    |  1 +
>  scripts/qapi/gen.py                  |  5 ++++
>  storage-daemon/Makefile.objs         |  1 +
>  storage-daemon/qapi/Makefile.objs    |  1 +
>  10 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 storage-daemon/qapi/qapi-schema.json
>  create mode 100644 storage-daemon/Makefile.objs
>  create mode 100644 storage-daemon/qapi/Makefile.objs

[...]

> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 3e04e299ed..03d256f0a4 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -30,3 +30,8 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
>  obj-y +=3D qapi-events.o
>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
>  obj-y +=3D qapi-commands.o
> +
> +QAPI_MODULES_STORAGE_DAEMON =3D block block-core char common crypto intr=
ospect
> +QAPI_MODULES_STORAGE_DAEMON +=3D job monitor qom sockets pragma transact=
ion

I took a look into the rest, and I wonder whether query-iothreads from
misc.json would be useful, too.

> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 796c17c38a..c25634f673 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -44,6 +44,11 @@ class QAPIGen(object):
>          return ''
> =20
>      def write(self, output_dir):
> +        # Include paths starting with ../ are used to reuse modules of t=
he main
> +        # schema in specialised schemas. Don't overwrite the files that =
are
> +        # already generated for the main schema.
> +        if self.fname.startswith('../'):
> +            return

Sorry, but I=E2=80=99m about to ask a clueless question: How do we ensure t=
hat
the main schema is generated before something else could make sure of
the specialized schemas?

Max

>          pathname =3D os.path.join(output_dir, self.fname)
>          dir =3D os.path.dirname(pathname)
>          if dir:


--P3JgiCIcJuwf7KuEY38QKsc3pqMhhFq8x--

--e5r2awgTosFFLSTnuUOwnQ5gRohdP1xw8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3C2W0ACgkQ9AfbAGHV
z0C0PAgAr5vlMMKMtnddSYpOKcOwHZKOOqFKHSJiUnsuH5/NELlqZiBe12zs6gep
r4VGRUJi7uWbo/lP/BLqMwOtns6wCH5dA9axXxJiwenUKPHInCkHz0MyELTCjTii
whSrTFUxK8f8VengmbRSnDhfOcc58+aG0DM5aII+8mLjJDSU/vxljcVn1cjPvOiF
VcvGj6J4TQdAde4Eql+kqWCFIJmqHJXwMFUO1ioDAvmSoqM37Lf4RomOLs4rsf2s
Z3k8BwIeuoQsUYZczd5+6T7heWYJ5E0PWODyeGV1+3Ca42EAAnRWHuQNkaVf1wVF
mCci7bCJInbzLyfAvxOhc/OnukBTXg==
=WTsP
-----END PGP SIGNATURE-----

--e5r2awgTosFFLSTnuUOwnQ5gRohdP1xw8--


