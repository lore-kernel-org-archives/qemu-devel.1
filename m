Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D503C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F49208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNQGBsKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F49208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByV9-0005n4-DY
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jByUI-0005DT-3i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jByUF-0000G5-Ec
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:21:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jByUD-0000Dh-Ud
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583922071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PiNfs9YzE7M7N1NiyuAmUw4o9lkdc8gwB4p2L4nj+/g=;
 b=CNQGBsKXDNvTxDYv5zKLNoUifxYUffssd3WIe7/cv8y5jQe5fxyOBEkZB+n6/zNW9ONw2F
 KEqiGqDQdXW6aKkNYK2UU6RNJ9QZTXxUmwUOAPp1AkahnhPOy6f/SEROfwTqonUEkHXM/q
 xlJURYAq915HzXnnmzucgdcB08Iocnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-3qgkiPItNPKRI9XjxNoFzQ-1; Wed, 11 Mar 2020 06:21:09 -0400
X-MC-Unique: 3qgkiPItNPKRI9XjxNoFzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65A80DBAE;
 Wed, 11 Mar 2020 10:21:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CA0F92D27;
 Wed, 11 Mar 2020 10:21:06 +0000 (UTC)
Subject: Re: [PATCH 1/3] block/file-posix: add raw_getlength_fd
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-2-vsementsov@virtuozzo.com>
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
Message-ID: <067c6030-086e-dcee-7cca-bc84cdba3259@redhat.com>
Date: Wed, 11 Mar 2020 11:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200130152218.7600-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="65PUT7Xn7iiXqHoC8eshafaHOAJqRNTtY"
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65PUT7Xn7iiXqHoC8eshafaHOAJqRNTtY
Content-Type: multipart/mixed; boundary="gfi6Inv3B3ptHrqEzA90K0GcjEcIaYOL3"

--gfi6Inv3B3ptHrqEzA90K0GcjEcIaYOL3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
> Add function which can handle separate fd, to be called from
> raw_probe_alignment in the following commit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/file-posix.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 1b805bd938..7f366046c2 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -178,7 +178,21 @@ typedef struct BDRVRawReopenState {
>  } BDRVRawReopenState;
> =20
>  static int fd_open(BlockDriverState *bs);
> -static int64_t raw_getlength(BlockDriverState *bs);
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd);
> +
> +static int64_t raw_getlength(BlockDriverState *bs)
> +{
> +    BDRVRawState *s =3D bs->opaque;
> +    int ret;
> +
> +    ret =3D fd_open(bs);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return raw_getlength_fd(bs, s->fd);
> +}
> +
> =20
>  typedef struct RawPosixAIOData {
>      BlockDriverState *bs;
> @@ -2063,10 +2077,8 @@ static int coroutine_fn raw_co_truncate(BlockDrive=
rState *bs, int64_t offset,
>  }
> =20
>  #ifdef __OpenBSD__
> -static int64_t raw_getlength(BlockDriverState *bs)
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd)
>  {
> -    BDRVRawState *s =3D bs->opaque;
> -    int fd =3D s->fd;
>      struct stat st;
> =20
>      if (fstat(fd, &st))
> @@ -2082,10 +2094,8 @@ static int64_t raw_getlength(BlockDriverState *bs)
>          return st.st_size;
>  }
>  #elif defined(__NetBSD__)
> -static int64_t raw_getlength(BlockDriverState *bs)
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd)
>  {
> -    BDRVRawState *s =3D bs->opaque;
> -    int fd =3D s->fd;
>      struct stat st;
> =20
>      if (fstat(fd, &st))
> @@ -2107,22 +2117,16 @@ static int64_t raw_getlength(BlockDriverState *bs=
)
>          return st.st_size;
>  }
>  #elif defined(__sun__)
> -static int64_t raw_getlength(BlockDriverState *bs)
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd)
>  {
> -    BDRVRawState *s =3D bs->opaque;
>      struct dk_minfo minfo;
>      int ret;
>      int64_t size;
> =20
> -    ret =3D fd_open(bs);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
>      /*
>       * Use the DKIOCGMEDIAINFO ioctl to read the size.
>       */
> -    ret =3D ioctl(s->fd, DKIOCGMEDIAINFO, &minfo);
> +    ret =3D ioctl(fd, DKIOCGMEDIAINFO, &minfo);
>      if (ret !=3D -1) {
>          return minfo.dki_lbsize * minfo.dki_capacity;
>      }
> @@ -2131,17 +2135,16 @@ static int64_t raw_getlength(BlockDriverState *bs=
)
>       * There are reports that lseek on some devices fails, but
>       * irc discussion said that contingency on contingency was overkill.
>       */
> -    size =3D lseek(s->fd, 0, SEEK_END);
> +    size =3D lseek(fd, 0, SEEK_END);
>      if (size < 0) {
>          return -errno;
>      }
>      return size;
>  }
>  #elif defined(CONFIG_BSD)
> -static int64_t raw_getlength(BlockDriverState *bs)
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd)
>  {
>      BDRVRawState *s =3D bs->opaque;

I think we should also drop this, and the fd_open() call in this function.

> -    int fd =3D s->fd;
>      int64_t size;
>      struct stat sb;
>  #if defined (__FreeBSD__) || defined(__FreeBSD_kernel__)
> @@ -2212,9 +2215,8 @@ again:
>      return size;
>  }
>  #else
> -static int64_t raw_getlength(BlockDriverState *bs)
> +static int64_t raw_getlength_fd(BlockDriverState *bs, int fd)
>  {
> -    BDRVRawState *s =3D bs->opaque;
>      int ret;
>      int64_t size;
> =20
> @@ -2223,7 +2225,7 @@ static int64_t raw_getlength(BlockDriverState *bs)
>          return ret;
>      }

And we can drop the fd_open() call here, too.

> =20
> -    size =3D lseek(s->fd, 0, SEEK_END);
> +    size =3D lseek(fd, 0, SEEK_END);
>      if (size < 0) {
>          return -errno;
>      }
>=20

If we drop those fd_open() calls, there is only one reason we=92d still
need the @bs parameter anyway, and that=92s the CD-ROM handling code for
FreeBSD.  Speaking of which: That code is broken after this patch
because cdrom_reopen() will change s->fd, which, after this patch, is
completely ignored by raw_getlength_fd().

So I don=92t know.  Should that CD handling code set =93fd =3D s->fd=94 aft=
er
cdrom_reopen()?  Or should we just drop it, because I actually can=92t
imagine it to be that important or used ever?  (I suppose it might do
something when you change the physical disk while qemu is running and
the device file is attached to qemu, but I=92m not sure whether such
passthrough things even work anymore.)

If we dropped it, we could drop the @bs parameter from
raw_getlength_fd() altogether.  I don=92t know whether that would actually
have any benefit in practice, though.

Max


--gfi6Inv3B3ptHrqEzA90K0GcjEcIaYOL3--

--65PUT7Xn7iiXqHoC8eshafaHOAJqRNTtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5ou5AACgkQ9AfbAGHV
z0AmIwf/ZXxxyXzV6+Dae47/pfsgBaNWAj4oL/KhvdT3U78yYu9IzOKh8Hfzhhc8
xed5brIlrxUnlskU7IkjpMTnxRa8p9wDUL2/ex+TKky28wuMYwiYvO3xxmbI7GRg
VT54Diz7vipGOx6GahAMCijX3SFCJGgf0GXZmEqPAeUJml20GPKvCsjstus9cDrq
Gr/wNuuucQ725aSuagOfnA2kNf2IbbS2vJgbEKCDk5KFPJ6yagJRUHeVZodmrMHB
el1G7OeVJ7pkEVXxWlZwJbW9MdW99/snbTlp9axRXMXwyhRDtATTGd92w7k8gMz1
8urDZcaVFwXTxN0R9kcwKaZI9qpXEA==
=8Q4M
-----END PGP SIGNATURE-----

--65PUT7Xn7iiXqHoC8eshafaHOAJqRNTtY--


