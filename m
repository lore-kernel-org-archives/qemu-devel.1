Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D96CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C3521655
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRJbu0Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C3521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdFa-0000nE-Ro
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 09:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRdEv-0000O0-Jq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRdEt-0006Gq-6r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:21:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRdEs-0006GX-Q0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572877309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GAgrSujKOP0rtyR/HSt32Bro5jlm6MontWsahHYa9wo=;
 b=GRJbu0KgbRk11VIiUSavUDNIVd1L4mQucOkQyp9JttQBDK1YBB9FO9T9YLVPojxbDy6RAw
 s0y3nmzW5E3xHJ0Hl8xbT8CCtvvTaem0cZ8zE5CAsRnVnv+Va47F6Ru95byVWdUE4zs5gy
 hgBNaUe2oQVnwbf8I62ZtS1VrtEn5Aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-frxkSRANP9yhCyGGRYPhrg-1; Mon, 04 Nov 2019 09:21:46 -0500
X-MC-Unique: frxkSRANP9yhCyGGRYPhrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D431800D53;
 Mon,  4 Nov 2019 14:21:45 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 264DC60863;
 Mon,  4 Nov 2019 14:21:42 +0000 (UTC)
Subject: Re: [RFC PATCH v2 13/26] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <4cf84e3126dc87486b19514c211d46941cdff243.1572125022.git.berto@igalia.com>
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
Message-ID: <5a45821e-564f-957e-5121-e11db318d214@redhat.com>
Date: Mon, 4 Nov 2019 15:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4cf84e3126dc87486b19514c211d46941cdff243.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YcrAFJneS2UuVjpzwUysxeEAUIo7DkHIu"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YcrAFJneS2UuVjpzwUysxeEAUIo7DkHIu
Content-Type: multipart/mixed; boundary="aZOAs8RQsidui1E6NLoOF1iS5aIbibXQm"

--aZOAs8RQsidui1E6NLoOF1iS5aIbibXQm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> If an image has subclusters then there are more copy-on-write
> scenarios that we need to consider. Let's say we have a write request
> from the middle of subcluster #3 until the end of the cluster:
>=20
>    - If the cluster is new, then subclusters #0 to #3 from the old
>      cluster must be copied into the new one.

You mean for snapshots?

(That isn=E2=80=99t quite clear, and I only guess this based on the next bu=
llet
point which differentiates based on =E2=80=9Cthe old cluster was unallocate=
d=E2=80=9D.
That=E2=80=99s weird, too, because what does that mean, old cluster and new
cluster?  I suppose it=E2=80=99s abstract and it just means =E2=80=9CThere =
was no old
cluster and now we=E2=80=99ve allocated something=E2=80=9D.  I can only und=
erstand the
concept of old and new clusters for COW inside of an image, i.e. for
snapshots and compressed clusters (theoretically).)

>    - If the cluster is new but the old cluster was unallocated, then
>      only subcluster #3 needs copy-on-write. #0 to #2 are marked as
>      unallocated in the bitmap of the new L2 entry.
>=20
>    - If we are overwriting an old cluster and subcluster #3 is
>      unallocated or has the all-zeroes bit set then we need
>      copy-on-write on subcluster #3.
>=20
>    - If we are overwriting an old cluster and subcluster #3 was
>      allocated then there is no need to copy-on-write.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 136 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 108 insertions(+), 28 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 1f509bda15..990bc070af 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1034,14 +1034,16 @@ void qcow2_alloc_cluster_abort(BlockDriverState *=
bs, QCowL2Meta *m)
>   * If @keep_old is true it means that the clusters were already
>   * allocated and will be overwritten. If false then the clusters are
>   * new and we have to decrease the reference count of the old ones.
> + *
> + * Returns 1 on success, -errno on failure.

I think there should be a note here on why this doesn=E2=80=99t follow the
general 0/-errno schema (i.e., =E2=80=9C, because that is what callers gene=
rally
expect=E2=80=9D).

>   */

[...]

> +    if (!keep_old) {
> +        switch (type) {
> +        case QCOW2_CLUSTER_NORMAL:
> +        case QCOW2_CLUSTER_COMPRESSED:
> +        case QCOW2_CLUSTER_ZERO_ALLOC:
> +        case QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER:
> +            cow_start_from =3D 0;

Somehow (I don=E2=80=99t know why) I find this a bit tough to understand.

Wouldn=E2=80=99t it work to let cow_start start from the first subcluster f=
or
ZERO_ALLOC and UNALLOCATED_SUBCLUSTER?  We don=E2=80=99t need to COW those,=
 it
should be sufficient to just make the subclusters before that zero or
unallocated, respectively.

(Same for cow_end)

Max

> +            break;
> +        case QCOW2_CLUSTER_ZERO_PLAIN:
> +        case QCOW2_CLUSTER_UNALLOCATED:
> +            cow_start_from =3D sc_index << s->subcluster_bits;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }


--aZOAs8RQsidui1E6NLoOF1iS5aIbibXQm--

--YcrAFJneS2UuVjpzwUysxeEAUIo7DkHIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3AM/UACgkQ9AfbAGHV
z0A2mgf/UNWaqppOa8kSeyxmsgsK5PJbMLiKgeEszhHDoFNMSFYZN8N7BYmfdcoJ
164uZkPBd0ESxZfl/QFbfFL+DJOD7d8G+Qm+mLQhNMaQnedTrnHXzRs8+iS/p2oj
DNpC3gyV9fdiOVGV24RP2KAwx9HMxtg4wcVfZ1q0IeGeONO0PBqRJbYDsZCMjigZ
gDy+pSIndAFgDlSRABjAQPZMKD/6MccLgPuj9GMVzyH9hxAb3YNW2NwrGFaJT3qn
TGj23oz1VDJ7KkvasgIBiTf8kXxsx9STToqZ3Zqy65gcHzYXoA4IsiOcefIvCBbm
LCFjH3LFGDZ0+xzEB8g3htKhXGiPmQ==
=c6bP
-----END PGP SIGNATURE-----

--YcrAFJneS2UuVjpzwUysxeEAUIo7DkHIu--


