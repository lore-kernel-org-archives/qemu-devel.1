Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF7C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CD420767
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlBkf1eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CD420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgHM-0000yl-Rr
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRg8H-0003zx-NR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRg8E-0003Xi-51
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:59:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRg8D-0003TB-Og
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587664760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dTSbqzx+DoLEj1roYD8uttUJ4/udjbfVAkQoayQgFvg=;
 b=XlBkf1eqR/+jjfxrV9tB6fI2WdyY92P+VPDanDND+4KzcBOUcmWyO2onHESEpJke9X/+lG
 Cs3FafLBjlraOFa83RTUbN8iE47OFCf5OwhYpgvSALVozzhnGUit108jWK9QJ3l+B58P6a
 /VIu77F+1KnY1m2g8/ggSzWAVK+w7yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GeXdZRZ_MTua_aymqiAguw-1; Thu, 23 Apr 2020 13:59:18 -0400
X-MC-Unique: GeXdZRZ_MTua_aymqiAguw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C01107ACCA;
 Thu, 23 Apr 2020 17:59:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ACA510016EB;
 Thu, 23 Apr 2020 17:59:12 +0000 (UTC)
Subject: Re: [PATCH v6 07/10] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-8-kwolf@redhat.com>
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
Message-ID: <99b692fa-cf66-361a-fbc8-1d89d94038cf@redhat.com>
Date: Thu, 23 Apr 2020 19:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423150127.142609-8-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BEEbNUX1S7mzrcztp5tbDbe1useV4CgYC"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BEEbNUX1S7mzrcztp5tbDbe1useV4CgYC
Content-Type: multipart/mixed; boundary="RZG97YjiFzMrH26T0PoUuONr1uaxRF4Ax"

--RZG97YjiFzMrH26T0PoUuONr1uaxRF4Ax
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.04.20 17:01, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
>=20
> Consider the following scenario where the overlay is shorter than its
> backing file:
>=20
>     base.qcow2:     AAAAAAAA
>     overlay.qcow2:  BBBB
>=20
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
>=20
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
>=20
>     base.qcow2:     A-A-AAAA
>     mid.qcow2:      BB-B
>     top.qcow2:      C--C--C-
>=20
> After commit top.qcow2 to mid.qcow2, the following happens:
>=20
>     mid.qcow2:      CB-C00C0 (correct result)
>     mid.qcow2:      CB-C--C- (before this fix)
>=20
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Seems like Berto gave you a rather broad R-b in v4. :)

> ---
>  block/io.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/block/io.c b/block/io.c
> index 795075954e..f618db3499 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3394,6 +3394,30 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child=
, int64_t offset, bool exact,
>          goto out;
>      }
> =20
> +    /*
> +     * If the image has a backing file that is large enough that it woul=
d
> +     * provide data for the new area, we cannot leave it unallocated bec=
ause
> +     * then the backing file content would become visible. Instead, zero=
-fill
> +     * the new area.
> +     *
> +     * Note that if the image has a backing file, but was opened without=
 the
> +     * backing file, taking care of keeping things consistent with that =
backing
> +     * file is the user's responsibility.
> +     */
> +    if (new_bytes && bs->backing) {
> +        int64_t backing_len;
> +
> +        backing_len =3D bdrv_getlength(backing_bs(bs));
> +        if (backing_len < 0) {
> +            ret =3D backing_len;

Shouldn=E2=80=99t we set errp?

Max

> +            goto out;
> +        }
> +
> +        if (backing_len > old_size) {
> +            flags |=3D BDRV_REQ_ZERO_WRITE;
> +        }
> +    }
> +
>      if (drv->bdrv_co_truncate) {
>          if (flags & ~bs->supported_truncate_flags) {
>              error_setg(errp, "Block driver does not support requested fl=
ags");
>=20



--RZG97YjiFzMrH26T0PoUuONr1uaxRF4Ax--

--BEEbNUX1S7mzrcztp5tbDbe1useV4CgYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6h128ACgkQ9AfbAGHV
z0CqCAgAqqLcwppgc44I+f4srpL2YjhUCcSkGZ7J+RRyZUP3nFrZeEDgO+Va5+nL
6iOd2gcZE+z4aNY1SnRbWsKC8a6dYvdDxmblD1qH6tkFUxvavhvJKjqF3BjSfkEM
r4WHGB9isg5g5APbXgExhyMi6MiBMUpLZbMvo20QaPbFzfDXC+/cd+sKLCJkSnJU
HeCzo4CQY/iERCWgkqKydYbVkSDuhBveks4QKcriikECpfDfdbDQRsPSm0NtWdnp
LpaU2ktBCRdZoPPW6mxAWpMJP0eIBFaxkmQpoZou0T6OLF8Krr6ucl7XznQV9dVB
rwp0WACg6mSdEkgZCPWUiLtxbVdWXQ==
=Kug5
-----END PGP SIGNATURE-----

--BEEbNUX1S7mzrcztp5tbDbe1useV4CgYC--


