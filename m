Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FEE621569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv+0Y3E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEE621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itv4O-0006wB-59
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itv38-0005kN-Od
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itv34-0004bA-RQ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:02:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itv34-0004Zz-NK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579618952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Ir6oVuJWCDT6SbwlWMkOhIMBFOdLF0j8vixnJ53pWU=;
 b=Lv+0Y3E2jOvwGNNKT7/yUe9yAMWckmmQw26MZXWjFEoa86rbhB1S6D9JK0NlC9tEp7HSQy
 avYtgm6Xe2SCl2wzBfFMUbWxABk3xPS/e6JUl9Crv/hemo/ptNVi6PbYsSHGaL9sSFEE3I
 2KEcel3UQpwI/KBYqxtddJ8QwDxIq0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-1zeB-CUfNkyb2lOs_OK1Mw-1; Tue, 21 Jan 2020 10:02:21 -0500
X-MC-Unique: 1zeB-CUfNkyb2lOs_OK1Mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8F0CDB60;
 Tue, 21 Jan 2020 15:02:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D050B7DB5D;
 Tue, 21 Jan 2020 15:02:18 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <id:m21rryz8al.fsf@dme.org>
 <20200117103434.1363985-1-david.edmondson@oracle.com>
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
Message-ID: <38073ceb-922e-b0fb-0c20-05fb4831e9a8@redhat.com>
Date: Tue, 21 Jan 2020 16:02:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117103434.1363985-1-david.edmondson@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JtmCInuJTyC6qbCkEJqfv6YArVvA50BEP"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JtmCInuJTyC6qbCkEJqfv6YArVvA50BEP
Content-Type: multipart/mixed; boundary="npITdt1pfexVSdaLEIiL3Ze97J2i5kgpD"

--npITdt1pfexVSdaLEIiL3Ze97J2i5kgpD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 17.01.20 11:34, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (filled with zeroes). In this
> situation there is no requirement for qemu-img to wastefully zero out
> the entire device.
>=20
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device is already zero filled.
> ---
>  qemu-img.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 95a24b9762..56ca727e8c 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -70,6 +70,7 @@ enum {
>      OPTION_PREALLOCATION =3D 265,
>      OPTION_SHRINK =3D 266,
>      OPTION_SALVAGE =3D 267,
> +    OPTION_TARGET_IS_ZERO =3D 268,
>  };
> =20
>  typedef enum OutputFormat {
> @@ -1593,6 +1594,7 @@ typedef struct ImgConvertState {
>      bool copy_range;
>      bool salvage;
>      bool quiet;
> +    bool target_is_zero;

As you already said, we probably don=E2=80=99t need this and it=E2=80=99d b=
e sufficient
to set the has_zero_init value directly.

>      int min_sparse;
>      int alignment;
>      size_t cluster_sectors;
> @@ -1984,10 +1986,11 @@ static int convert_do_copy(ImgConvertState *s)
>      int64_t sector_num =3D 0;
> =20
>      /* Check whether we have zero initialisation or can get it efficient=
ly */
> -    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
> +    s->has_zero_init =3D s->target_is_zero;

We cannot has_zero_init to true if the target has a backing file,
because convert_co_write() asserts that the target must not have a
backing file if has_zero_init is true.  (It=E2=80=99s impossible for a file=
 to
be initialized to zeroes if it has a backing file; or at least it
doesn=E2=80=99t make sense then to have a backing file.)

Case in point:

$ ./qemu-img create -f qcow2 src.qcow2 64M
Formatting 'src.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-img create -f qcow2 backing.qcow2 64M
Formatting 'backing.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D6553=
6
lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-img create -f qcow2 -b backing.qcow2 dst.qcow2 64M

Formatting 'dst.qcow2', fmt=3Dqcow2 size=3D67108864
backing_file=3Dbacking.qcow2 cluster_size=3D65536 lazy_refcounts=3Doff
refcount_bits=3D16
$ ./qemu-img convert -n -B backing.qcow2 -f qcow2 -O qcow2
--target-is-zero src.qcow2 dst.qcow2
qemu-img: qemu-img.c:1812: convert_co_write: Assertion
`!s->target_has_backing' failed.
[1]    80813 abort (core dumped)  ./qemu-img convert -n -B backing.qcow2
-f qcow2 -O qcow2 --target-is-zero

> +
> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
> +        !s->target_has_backing) {

(This will be irrelevant after target_has_backing is gone, but because
has_zero_init and target_has_backing are equivalent here, there is no
need to check both.)

>          s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
> -    } else {
> -        s->has_zero_init =3D false;
>      }
> =20
>      if (!s->has_zero_init && !s->target_has_backing &&
> @@ -2076,6 +2079,7 @@ static int img_convert(int argc, char **argv)
>          .buf_sectors        =3D IO_BUF_SIZE / BDRV_SECTOR_SIZE,
>          .wr_in_order        =3D true,
>          .num_coroutines     =3D 8,
> +        .target_is_zero     =3D false,
>      };
> =20
>      for(;;) {
> @@ -2086,6 +2090,7 @@ static int img_convert(int argc, char **argv)
>              {"force-share", no_argument, 0, 'U'},
>              {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OP=
TS},
>              {"salvage", no_argument, 0, OPTION_SALVAGE},
> +            {"target-is-zero", no_argument, 0, OPTION_TARGET_IS_ZERO},
>              {0, 0, 0, 0}
>          };
>          c =3D getopt_long(argc, argv, ":hf:O:B:Cco:l:S:pt:T:qnm:WU",
> @@ -2209,6 +2214,9 @@ static int img_convert(int argc, char **argv)
>          case OPTION_TARGET_IMAGE_OPTS:
>              tgt_image_opts =3D true;
>              break;
> +        case OPTION_TARGET_IS_ZERO:
> +            s.target_is_zero =3D true;
> +            break;
>          }
>      }
> =20
> @@ -2247,6 +2255,11 @@ static int img_convert(int argc, char **argv)
>          warn_report("This will become an error in future QEMU versions."=
);
>      }
> =20
> +    if (s.target_is_zero && !skip_create) {
> +        error_report("--target-is-zero requires use of -n flag");

Hm, I could imagine it being useful even without -n, but maybe it=E2=80=99s
safer to forbid this case for now and reconsider if someone were to ask.

> +        goto fail_getopt;
> +    }
> +
>      s.src_num =3D argc - optind - 1;
>      out_filename =3D s.src_num >=3D 1 ? argv[argc - 1] : NULL;

This patch should also add some documentation for the new option (in
qemu-img-cmds.hx and in qemu-img.texi for the man page).

Max


--npITdt1pfexVSdaLEIiL3Ze97J2i5kgpD--

--JtmCInuJTyC6qbCkEJqfv6YArVvA50BEP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4nEngACgkQ9AfbAGHV
z0CGCQgAoj0j7qGFC2006ceFx2CEBrEd/IhLJYuLVCX5fnAfpvHyUZyOzIG2UYOS
C82iXOWjS3bzTzVgjH/z54INJ4diDGJ9hKZSEu/OxLBZ+S+1WBO9CmH+6m0OrL3C
rG8q/IJQDfihxw/EU668t6jyrk2A2FStt0zdX+VcQg6OvIoQ6P7//rfmp9UBV/gI
j3Ak+2qhT+bUQP3KHvmGlry0T69lDFdrGMKnN9sQGHlNc0RIU4DFOqc9w2Ja36O4
dwwi6nms6SWDmqB1MhH9gH18c1sJ5H8Gv4syuzb/9i0Q9JqOJ/h1K9syDMofsKtM
rD6NiFpehNXbagjWIuxtqmn4+DRVKQ==
=CF/j
-----END PGP SIGNATURE-----

--JtmCInuJTyC6qbCkEJqfv6YArVvA50BEP--


