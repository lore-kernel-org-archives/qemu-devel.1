Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40186C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB2520709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB2520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBBN-0007rK-48
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kEBAl-0007Gj-Kw
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:50:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kEBAj-0007jE-PS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:50:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-J1_e5VInNbCJ_it4HWC6Sw-1; Fri, 04 Sep 2020 08:50:27 -0400
X-MC-Unique: J1_e5VInNbCJ_it4HWC6Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9B8A1084C9E;
 Fri,  4 Sep 2020 12:50:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-156.ams2.redhat.com
 [10.36.114.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC4F78B34;
 Fri,  4 Sep 2020 12:50:23 +0000 (UTC)
Subject: Re: [PATCH v8 5/7] copy-on-read: limit guest writes to base in COR
 driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <667dbbb4-b4b3-1e18-6c9b-466b75cbd00c@redhat.com>
Date: Fri, 4 Sep 2020 14:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DBspRaOwgwvPHZVEKbc74tyAPRyC7yuDk"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBspRaOwgwvPHZVEKbc74tyAPRyC7yuDk
Content-Type: multipart/mixed; boundary="eAvt4lHJxcT9oD6CPWEKoB3Kx4qE850kM"

--eAvt4lHJxcT9oD6CPWEKoB3Kx4qE850kM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.08.20 18:52, Andrey Shinkevich wrote:
> Limit the guest's COR operations by the base node in the backing chain
> during a stream job.

I don=E2=80=99t understand.   Shouldn=E2=80=99t we limit the areas where we=
 set the COR
flag?

> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/copy-on-read.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 1f858bb..ecbd1f8 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -57,6 +57,37 @@ static BlockDriverState *get_base_by_name(BlockDriverS=
tate *bs,
>      return base_bs;
>  }
> =20
> +/*
> + * Returns 1 if the block is allocated in a node between cor_filter_bs->=
file->bs
> + * and the base_bs in the backing chain. Otherwise, returns 0.
> + * The COR operation is allowed if the base_bs is not specified - return=
 1.
> + * Returns negative errno on failure.
> + */
> +static int node_above_base(BlockDriverState *cor_filter_bs, uint64_t off=
set,
> +                           uint64_t bytes)
> +{
> +    int ret;
> +    int64_t dummy;
> +    BlockDriverState *file =3D NULL;
> +    BDRVStateCOR *state =3D cor_filter_bs->opaque;
> +
> +    if (!state->base_bs) {
> +        return 1;
> +    }
> +
> +    ret =3D bdrv_block_status_above(cor_filter_bs->file->bs, state->base=
_bs,
> +                                  offset, bytes, &dummy, NULL, &file);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (file) {

Why check file and not the return value?

> +        return 1;
> +    }
> +
> +    return 0;

=E2=80=9Cdummy=E2=80=9D should really not be called that way, it should be =
evaluated
whether it=E2=80=99s smaller than bytes.

First, [offset, offset + dummy) may not be allocated above the base =E2=80=
=93
but [offset + dummy, offset + bytes) may be.  Then this function returns
0 here, even though there is something in that range that=E2=80=99s allocat=
ed.

Second, in that case we still shouldn=E2=80=99t return 1, but return the
shrunken offset instead.  Or, if there are multiple distinct allocated
areas, they should probably even all be copied separately.


(But all of that of course only if this function is intended to be used
to limit where we set the COR flag, because I don=E2=80=99t understand why =
we=E2=80=99d
want to limit where something can be written.)

Max

> +}
> +
>  static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>                      Error **errp)
>  {
> @@ -153,6 +184,12 @@ static int coroutine_fn cor_co_pwritev_part(BlockDri=
verState *bs,
>                                              QEMUIOVector *qiov,
>                                              size_t qiov_offset, int flag=
s)
>  {
> +    int ret =3D node_above_base(bs, offset, bytes);
> +
> +    if (!ret || ret < 0) {
> +        return ret;
> +    }
> +
>      return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offs=
et,
>                                  flags);
>  }
> @@ -162,6 +199,12 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDr=
iverState *bs,
>                                               int64_t offset, int bytes,
>                                               BdrvRequestFlags flags)
>  {
> +    int ret =3D node_above_base(bs, offset, bytes);
> +
> +    if (!ret || ret < 0) {
> +        return ret;
> +    }
> +
>      return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>  }
> =20
> @@ -178,6 +221,12 @@ static int coroutine_fn cor_co_pwritev_compressed(Bl=
ockDriverState *bs,
>                                                    uint64_t bytes,
>                                                    QEMUIOVector *qiov)
>  {
> +    int ret =3D node_above_base(bs, offset, bytes);
> +
> +    if (!ret || ret < 0) {
> +        return ret;
> +    }
> +
>      return bdrv_co_pwritev(bs->file, offset, bytes, qiov,
>                             BDRV_REQ_WRITE_COMPRESSED);
>  }
>=20



--eAvt4lHJxcT9oD6CPWEKoB3Kx4qE850kM--

--DBspRaOwgwvPHZVEKbc74tyAPRyC7yuDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9SOA0ACgkQ9AfbAGHV
z0D91QgAwjPCsM/YoZ9lbSACsA+aFJakP5MN6jdkJbXbq8qZMMbH8Bl3IA70OKu5
F5oeTggcx+/T28FO1q56ITA0ow2nG8DFylq1KY5IDe6cw7lTDwS+x2j2iYpN7rME
cD5+Nv2PTl8Q2OLnXNdPDMI+S442NeObYshxUquIQjUGpBtCB4SqO5lpINmzSNHa
z/0rNC+GZDmoeUEQjlaR48yGe+My8TfhLTBG6FzfKXgXs4uj6P/TDyscaRN4r/zn
rAeYpYJOM2ib/Tea+gTPjfgEp589iaCKo8+YlKYB4Q4Neb6Gq8zCrsRK9zUApxCp
no7H4HxDI/6k3B8xKVos+tJ/V0gRHg==
=+TsQ
-----END PGP SIGNATURE-----

--DBspRaOwgwvPHZVEKbc74tyAPRyC7yuDk--


