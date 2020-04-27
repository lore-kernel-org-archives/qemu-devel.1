Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BFC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D064820575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfK1JLuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D064820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT30u-0005k8-W5
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT2z5-0003Rp-KM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT2z4-0002R9-Bu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:35:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jT2z3-0002NX-SI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587990935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=am+6JhHqPHeH+1zz2Z0uiXepRtlkTisEM4WS6q8y1IM=;
 b=TfK1JLuklm1rLIH2W+HAQ4I9R7I9odIAGeC+9vnNOof3Iin++2ysn914ulBYy24CjolGfp
 Y6CRoHvF89crxnTZ29JQHn4jMyZfQzzxxSYk6z3LDOiz9RWsngeJn05rlcx71h0j0yEnOX
 lcUEpK7uMUfi8hCP6P6H/qPqM1dPwyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-xgb_jsJ-OGOj88SRUUPfGQ-1; Mon, 27 Apr 2020 08:35:30 -0400
X-MC-Unique: xgb_jsJ-OGOj88SRUUPfGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5721005510;
 Mon, 27 Apr 2020 12:35:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com
 [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F51960CD3;
 Mon, 27 Apr 2020 12:35:26 +0000 (UTC)
Subject: Re: [PATCH v20 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-4-dplotnikov@virtuozzo.com>
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
Message-ID: <f8b52ed6-9532-ff65-5c18-0b5142c3b550@redhat.com>
Date: Mon, 27 Apr 2020 14:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421081117.7595-4-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="epyl4yDWlKiFa0hB3R9CUOPXTX5432Vhh"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--epyl4yDWlKiFa0hB3R9CUOPXTX5432Vhh
Content-Type: multipart/mixed; boundary="sctmHNTBcdTgoMQdCSdlOkuaDZE9gRWZ1"

--sctmHNTBcdTgoMQdCSdlOkuaDZE9gRWZ1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 10:11, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
>=20
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
>=20
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
>=20
> compress cmd:
>   time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|zstd]
>                   src.img [zlib|zstd]_compressed.img
> decompress cmd
>   time ./qemu-img convert -O qcow2
>                   [zlib|zstd]_compressed.img uncompressed.img
>=20
>            compression               decompression
>          zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
>=20
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/interop/qcow2.txt |   1 +
>  configure              |   2 +-
>  qapi/block-core.json   |   3 +-
>  block/qcow2-threads.c  | 157 +++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c          |   7 ++
>  5 files changed, 168 insertions(+), 2 deletions(-)

[...]

> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 7dbaf53489..0525718704 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -28,6 +28,11 @@
>  #define ZLIB_CONST
>  #include <zlib.h>
> =20
> +#ifdef CONFIG_ZSTD
> +#include <zstd.h>
> +#include <zstd_errors.h>
> +#endif
> +
>  #include "qcow2.h"
>  #include "block/thread-pool.h"
>  #include "crypto.h"
> @@ -166,6 +171,148 @@ static ssize_t qcow2_zlib_decompress(void *dest, si=
ze_t dest_size,
>      return ret;
>  }
> =20
> +#ifdef CONFIG_ZSTD
> +
> +/*
> + * qcow2_zstd_compress()
> + *
> + * Compress @src_size bytes of data using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          -ENOMEM destination buffer is not enough to store compressed=
 data
> + *          -EIO    on any other error
> + */
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    ZSTD_outBuffer output =3D { dest, dest_size, 0 };
> +    ZSTD_inBuffer input =3D { src, src_size, 0 };

Minor style note: I think it=92d be nicer to use designated initializers he=
re.

> +    ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * Use the zstd streamed interface for symmetry with decompression,
> +     * where streaming is essential since we don't record the exact
> +     * compressed size.
> +     *
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 potentially can finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {
> +        size_t zstd_ret;
> +        /*
> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +         * with ZSTD_e_end until it returns 0, at which point you are
> +         * free to start a new frame". We assume that "start a new frame=
"
> +         * means call ZSTD_compressStream2 in the very beginning or when
> +         * ZSTD_compressStream2 has returned with 0.
> +         */
> +        do {
> +            zstd_ret =3D ZSTD_compressStream2(cctx, &output, &input, ZST=
D_e_end);

The spec makes it sound to me like ZSTD_e_end will always complete in a
single call if there=92s enough space in the output buffer.  So the only
team we have to loop would be when there isn=92t enough space anyway:

It says this about ZSTD_e_end:
> flush operation is the same, and follows same rules as calling
> ZSTD_compressStream2() with ZSTD_e_flush.

Those rules being:
> Note that, if `output->size` is too small, a single invocation with
> ZSTD_e_flush might not be enough (return code > 0).

So it seems like it will only return a value > 0 if the output buffer is
definitely too small.

The spec also notes that the return value is greater than 0 if:
> >0 if some data still present within internal buffer (the value is
> minimal estimation of remaining size),

So it=92s a minimum estimate.  That=92s another point that heavily implies
to me that if the return value were less than what=92s left in the buffer,
the function wouldn=92t return but still try to write it out, until it
realizes that there isn=92t enough space in the output buffer, and then
return a value that exceeds the remaining output buffer size.

(Because if the function just played it safe, I would expect it to
return a maximum estimate.)


OTOH, if it were actually possible for ZSTD_e_end to finish a frame
earlier than the end of the input, I think it would make more sense to
use ZSTD_e_continue until the input is done and then finish with
ZSTD_e_end, like the spec seems to propose.  That way, we=92d always end
up with a single frame to make decompression simpler (and I think it
would also make more sense overall).


But anyway.  From how I understand the spec, this code simply always
ends up creating a single frame or erroring out, without looping ever.
So it isn=92t exactly wrong, it just seems overly complicated.  (Again,
assuming I understand the spec correctly.  Which seems like a tough
thing to assume, because the spec is not exactly obvious to read...)

(Running some quick tests by converting some images with zstd
compression seems to confirm that whenever ZSTD_compressStream2()
returns, either zstd_ret > output.size - output.pos, or zstd_ret =3D=3D 0
and input.pos =3D=3D input.size.  So none of the loops ever loop.)

Max

> +
> +            if (ZSTD_isError(zstd_ret)) {
> +                ret =3D -EIO;
> +                goto out;
> +            }
> +            /* Dest buffer isn't big enough to store compressed content =
*/
> +            if (zstd_ret > output.size - output.pos) {
> +                ret =3D -ENOMEM;
> +                goto out;
> +            }
> +        } while (zstd_ret);
> +    }
> +    /* make sure we can safely return compressed buffer size with ssize_=
t */
> +    assert(output.pos <=3D SSIZE_MAX);
> +    ret =3D output.pos;
> +out:
> +    ZSTD_freeCCtx(cctx);
> +    return ret;
> +}


--sctmHNTBcdTgoMQdCSdlOkuaDZE9gRWZ1--

--epyl4yDWlKiFa0hB3R9CUOPXTX5432Vhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6m0Y0ACgkQ9AfbAGHV
z0AJHQf5AdAxv0b03fxIzLGt3jg1yYRqTyKfXdzudwbn+BphAtj2ECKBrDB4fbQt
73L2Zsc4Ls1mhWfPc/eT752Y9Vy0HlszJx9gwVf57xVElUmW6oxOqboq0D+d+fud
+pne6qkxkcUWNmuaDFgVVagkCknVchvmkDSVRpOyBifxHFr0DymLHALMCyh0RHqy
jXlMbZOpakaEIeFi3K2GwslIUghrj4r6S0NwLpCDFom0k6GOyXgAboWPMZ028PKM
YZ6So5KYn4CE/tQWSXB1M+HFoOTkUy/TQqf7lRrOSvDdu4WbroTcdrm+wPABjiEC
BE3m1R5vbI9+j+iDitMZzEe97tUeyQ==
=3eJA
-----END PGP SIGNATURE-----

--epyl4yDWlKiFa0hB3R9CUOPXTX5432Vhh--


