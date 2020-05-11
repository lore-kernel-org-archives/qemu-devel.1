Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF0C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B7020735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtqXm25S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B7020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6xt-0003ny-7U
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY6x1-0002pb-2T
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:50:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY6wz-00046B-4k
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589197824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5cr8eQKYiPXjIR8E4qctkknAcecZwLFBVZWY2vGhTgM=;
 b=VtqXm25SaOMxMpY+C/DkIzzn6i6AINyA/it1ORxHtSN+aJiH0YAdKoZRzh0g+dUR7DPhny
 Nzc0EGbXcpRgfyrBxwyBpW0VDu95EkOcimcKcCdPdPM1E2ip4A9Odlb1FcS3tqj/i0R97Y
 qNI2Of2MyWufiv+QPpuJ5JLM6uxAjGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-9q6I8TNFOMKjw0eksFYU0A-1; Mon, 11 May 2020 07:50:22 -0400
X-MC-Unique: 9q6I8TNFOMKjw0eksFYU0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CAF9107ACCD;
 Mon, 11 May 2020 11:50:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 960ED5D788;
 Mon, 11 May 2020 11:50:13 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
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
Message-ID: <98430e29-65e8-c0c7-c172-fdaa121f97c5@redhat.com>
Date: Mon, 11 May 2020 13:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508180340.675712-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3X74fvgcKcTYuMI0NfttJOLGZHQS5doM6"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Nir Soffer <nsoffer@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3X74fvgcKcTYuMI0NfttJOLGZHQS5doM6
Content-Type: multipart/mixed; boundary="iVSewRAWb5w08bt4T9v2SV05f6lKyzwtk"

--iVSewRAWb5w08bt4T9v2SV05f6lKyzwtk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.05.20 20:03, Eric Blake wrote:
> It's useful to know how much space can be occupied by qcow2 persistent
> bitmaps, even though such metadata is unrelated to the guest-visible
> data.  Report this value as an additional field, present when
> measuring an existing image and the output format supports bitmaps.
> Update iotest 178 and 190 to updated output, as well as new coverage
> in 190 demonstrating non-zero values made possible with the
> recently-added qemu-img bitmap command.
>=20
> The addition of a new field demonstrates why we should always
> zero-initialize qapi C structs; while the qcow2 driver still fully
> populates all fields, the raw and crypto drivers had to be tweaked to
> avoid uninitialized data.
>=20
> See also: https://bugzilla.redhat.com/1779904
>=20
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json             | 15 +++++++----
>  block/crypto.c                   |  2 +-
>  block/qcow2.c                    | 37 ++++++++++++++++++++++++---
>  block/raw-format.c               |  2 +-
>  qemu-img.c                       |  3 +++
>  tests/qemu-iotests/178.out.qcow2 | 16 ++++++++++++
>  tests/qemu-iotests/190           | 43 ++++++++++++++++++++++++++++++--
>  tests/qemu-iotests/190.out       | 23 ++++++++++++++++-
>  8 files changed, 128 insertions(+), 13 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 943df1926a91..9a7a388c7ad3 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -633,18 +633,23 @@
>  # efficiently so file size may be smaller than virtual disk size.
>  #
>  # The values are upper bounds that are guaranteed to fit the new image f=
ile.
> -# Subsequent modification, such as internal snapshot or bitmap creation,=
 may
> -# require additional space and is not covered here.
> +# Subsequent modification, such as internal snapshot or further bitmap
> +# creation, may require additional space and is not covered here.
>  #
> -# @required: Size required for a new image file, in bytes.
> +# @required: Size required for a new image file, in bytes, when copying =
just
> +#            guest-visible contents.
>  #
>  # @fully-allocated: Image file size, in bytes, once data has been writte=
n
> -#                   to all sectors.
> +#                   to all sectors, when copying just guest-visible cont=
ents.
> +#
> +# @bitmaps: Additional size required for bitmap metadata in a source ima=
ge,

s/in/from/?  Otherwise it sounds like this would be about allocation in
the source, which it clear can=E2=80=99t be, but, well.

> +#           if that bitmap metadata can be copied in addition to guest
> +#           contents. (since 5.1)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 838d810ca5ec..f836a6047879 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4849,16 +4875,21 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *=
opts, BlockDriverState *in_bs,
>          required =3D virtual_size;
>      }
>=20
> -    info =3D g_new(BlockMeasureInfo, 1);
> +    info =3D g_new0(BlockMeasureInfo, 1);
>      info->fully_allocated =3D
>          qcow2_calc_prealloc_size(virtual_size, cluster_size,
>                                   ctz32(refcount_bits)) + luks_payload_si=
ze;
>=20
> -    /* Remove data clusters that are not required.  This overestimates t=
he
> +    /*
> +     * Remove data clusters that are not required.  This overestimates t=
he
>       * required size because metadata needed for the fully allocated fil=
e is
> -     * still counted.
> +     * still counted.  Show bitmaps only if both source and destination
> +     * would support them.
>       */
>      info->required =3D info->fully_allocated - virtual_size + required;
> +    info->has_bitmaps =3D version >=3D 3 && in_bs &&
> +        bdrv_dirty_bitmap_supported(in_bs);

Why is it important whether the source format supports persistent dirty
bitmaps?

I=E2=80=99m asking because I=E2=80=99d like there to be some concise reason=
 when and why
the @bitmaps field appears.  =E2=80=9CWhenever the target supports bitmaps=
=E2=80=9D is
more concise than =E2=80=9CWhen both source and target support bitmaps=E2=
=80=9D.  Also,
the latter is not really different from =E2=80=9CWhen any bitmap data can b=
e
copied=E2=80=9D, but in the latter case we should not show it when there ar=
e no
bitmaps in the source (even though the format supports them).

Or from the other perspective: As a user, I would never be annoyed by
the @bitmaps field being present.  I don=E2=80=99t mind a =E2=80=9C0=E2=80=
=9D.
OTOH, what information can it convey to me that it it=E2=80=99s optional an=
d
sometimes not present?
I can see these cases:

- That the source format doesn=E2=80=99t support bitmaps?  I want to conver=
t it
to something else anyway, so I don=E2=80=99t really care about what the sou=
rce
format can or can=E2=80=99t do.

- That the destination doesn=E2=80=99t support bitmaps?  Ah, yes, the fact =
that
the bitmap field is missing might be a warning sign for this.

- That qemu is too old to copy bitmaps?  Same here.

- That there are no bitmaps in the source?  OK, but then I disregard the
@bitmaps field anyway, present or not.

So from that standpoint, the best use seems to me to take =E2=80=9CThe @bit=
maps
field isn=E2=80=99t present=E2=80=9D as kind of a warning that something in=
 the convert
process won=E2=80=99t support copying bitmaps.  If it=E2=80=99s present, al=
l is well.
So basically there=E2=80=99d be an iff relationship between =E2=80=9Cmeasur=
e reports
@bitmaps=E2=80=9D and =E2=80=9Cconvert --bitmap can work=E2=80=9D.

But the distinction between =E2=80=9Cthe source format doesn=E2=80=99t supp=
ort bitmaps=E2=80=9D
and =E2=80=9Cthe source image doesn=E2=80=99t have bitmaps=E2=80=9D doesn=
=E2=80=99t seem that important
to me to make it visible in the interface.

[...]

> diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
> index 6d41650438e1..1b5fff45bfcd 100755
> --- a/tests/qemu-iotests/190
> +++ b/tests/qemu-iotests/190

[...]

> @@ -51,6 +51,45 @@ $QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
>  $QEMU_IMG measure -O qcow2 -o cluster_size=3D64k -f qcow2 "$TEST_IMG"
>  $QEMU_IMG measure -O qcow2 -o cluster_size=3D2M -f qcow2 "$TEST_IMG"
>=20
> +echo
> +echo "=3D=3D Huge file with bitmaps =3D=3D"
> +echo
> +
> +$QEMU_IMG bitmap --add --granularity 512 -f qcow2 "$TEST_IMG" b1
> +$QEMU_IMG bitmap --add -g 2M -f qcow2 "$TEST_IMG" b2
> +
> +# No bitmap output, since raw does not support it
> +$QEMU_IMG measure -O raw -f qcow2 "$TEST_IMG"
> +# No bitmap output, since no bitmaps on raw source
> +$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG"
> +# No bitmap output, since v2 does not support it
> +$QEMU_IMG measure -O qcow2 -o compat=3D0.10 -f qcow2 "$TEST_IMG"
> +
> +# Compute expected output:
> +echo
> +val2T=3D$((2*1024*1024*1024*1024))
> +cluster=3D$((64*1024))
> +b1clusters=3D$(( (val2T/512/8 + cluster - 1) / cluster ))
> +b2clusters=3D$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
> +echo expected bitmap $((b1clusters * cluster +
> +=09=09=09(b1clusters * 8 + cluster - 1) / cluster * cluster +
> +=09=09=09b2clusters * cluster +
> +=09=09=09(b2clusters * 8 + cluster - 1) / cluster * cluster +
> +=09=09=09cluster))
> +$QEMU_IMG measure -O qcow2 -o cluster_size=3D64k -f qcow2 "$TEST_IMG"
> +
> +# Compute expected output:
> +echo
> +cluster=3D$((2*1024*1024))
> +b1clusters=3D$(( (val2T/512/8 + cluster - 1) / cluster ))
> +b2clusters=3D$(( (val2T/2/1024/1024/8 + cluster - 1) / cluster ))
> +echo expected bitmap $((b1clusters * cluster +
> +=09=09=09(b1clusters * 8 + cluster - 1) / cluster * cluster +
> +=09=09=09b2clusters * cluster +
> +=09=09=09(b2clusters * 8 + cluster - 1) / cluster * cluster +
> +=09=09=09cluster))
> +$QEMU_IMG measure -O qcow2 -o cluster_size=3D2M -f qcow2 "$TEST_IMG"

Thanks!

Max


--iVSewRAWb5w08bt4T9v2SV05f6lKyzwtk--

--3X74fvgcKcTYuMI0NfttJOLGZHQS5doM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65O+sACgkQ9AfbAGHV
z0By4wgAnkHFlro/8+ZGtBE9HBrl8ehw9rGppowfzAyvMY/cMkIcMXDxNsh2SJdd
kO1PUuYMK6SVBxcV2SAN/YtsigHu3MccP8r7m7N5zKVKdxJoS4x5hYT7VCUlNdNQ
H6hoO90HmayjpveXSsy7AXXPeBw11Wma2re+cOae6hS3ULlBFWqPDG+Y+ktRPSLB
Pagk9rTebluweobjRSMMQEoWaoZvN4Iisg0Xc+TY9hgaxTaNMEd0ArSMIVeRt4fk
4Xcl59BvcJM2F1oNVBToYjS6EfNx2tOETfcMl6z9PSU7VREAXh+DgVcavYu7dGp7
YsNDWi9J49tSD4qrmu3EVdZU7LV0gA==
=72bv
-----END PGP SIGNATURE-----

--3X74fvgcKcTYuMI0NfttJOLGZHQS5doM6--


