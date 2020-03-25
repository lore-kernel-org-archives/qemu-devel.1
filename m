Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E4C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395E52078D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbrcB33n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395E52078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5Nb-0004YH-Ch
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jH5Ms-0003eP-0c
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jH5Mp-0005Cx-PD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:42:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35453)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jH5Mp-0005Cn-LX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585140163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=85R+rCfGY4aJCqW3c83HHNsVW1lSs9KcgpgPkHrba8c=;
 b=IbrcB33nzSKEzV46x4AuqjbPrfgYbYoY/4D/1bHwb7NBBdJMHQMzFpL9voWzgjc7/0n1cT
 Gh4915R1kT5P2X0iGE1m5PeAi9HMpQVXKr93UO58qQD05KhXKUsNzGY6bSfcD0wzu85oby
 yk/+mUDWkFf8YBq3lwYfufgHpn6IKFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-BPk3jasAOXuZOpIvtpDDOg-1; Wed, 25 Mar 2020 08:42:39 -0400
X-MC-Unique: BPk3jasAOXuZOpIvtpDDOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 454B218C43C0;
 Wed, 25 Mar 2020 12:42:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-33.ams2.redhat.com
 [10.36.115.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0996A10EFA63;
 Wed, 25 Mar 2020 12:42:34 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] qcow2: Avoid feature name extension on small
 cluster size
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
 <20200324174233.1622067-4-eblake@redhat.com>
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
Message-ID: <d28f2dfc-1f85-1157-0a57-341894205883@redhat.com>
Date: Wed, 25 Mar 2020 13:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324174233.1622067-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X2SSFfh7uLc8A1LfNkLlkqSKrafdvt1Gi"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X2SSFfh7uLc8A1LfNkLlkqSKrafdvt1Gi
Content-Type: multipart/mixed; boundary="xecndYOalW6zzx8CqVG9cleyvW3W7mDuP"

--xecndYOalW6zzx8CqVG9cleyvW3W7mDuP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.03.20 18:42, Eric Blake wrote:
> As the feature name table can be quite large (over 9k if all 64 bits
> of all three feature fields have names; a mere 8 features leaves only
> 8 bytes for a backing file name in a 512-byte cluster), it is unwise
> to emit this optional header in images with small cluster sizes.
>=20
> Update iotest 036 to skip running on small cluster sizes; meanwhile,
> note that iotest 061 never passed on alternative cluster sizes
> (however, I limited this patch to tests with output affected by adding
> feature names, rather than auditing for other tests that are not
> robust to alternative cluster sizes).

That=E2=80=99s a bit more brave than necessary, considering I don=E2=80=99t=
 think anyone
has ever run the iotests with the cluster_size option.  (I certainly
don=E2=80=99t, and I don=E2=80=99t plan to, because I don=E2=80=99t think i=
t=E2=80=99s that important to
test that.)  There are certainly many other iotests that fail with a
non-default cluster size.

Not that it=E2=80=99s wrong care about it.  On the opposite, I=E2=80=99m ha=
ppy you do. :)

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c          | 11 +++++++++--
>  tests/qemu-iotests/036 |  6 ++++--
>  tests/qemu-iotests/061 |  6 ++++--
>  3 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 67b0c214fba4..9475ace57163 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2823,8 +2823,15 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
>=20
> -    /* Feature table */
> -    if (s->qcow_version >=3D 3) {
> +    /*
> +     * Feature table.  A mere 8 feature names occupies 392 bytes, and
> +     * when coupled with the v3 minimum header of 104 bytes plus the
> +     * 8-byte end-of-extension marker, that would leave only 8 bytes
> +     * for a backing file name in an image with 512-byte clusters.
> +     * Thus, we choose to omit this header for cluster sizes 4k and
> +     * smaller.

Can=E2=80=99t we do this decision more dynamically?  Like, always omit it w=
hen
cluster_size - sizeof(features) < 2k/3k/...?

Max

> +     */
> +    if (s->qcow_version >=3D 3 && s->cluster_size > 4096) {
>          static const Qcow2Feature features[] =3D {
>              {
>                  .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,


--xecndYOalW6zzx8CqVG9cleyvW3W7mDuP--

--X2SSFfh7uLc8A1LfNkLlkqSKrafdvt1Gi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl57UbkACgkQ9AfbAGHV
z0AikQgAt2nGAD1ZfsmBiDdxBNKoc48B3VaowMPm0rTXSuG8MOTLUyfUDFEV0vCR
Ekgarf5oGFrGXaVSlbh9+V8l/pK3pJ1BrmYe4O2QXxWG2ECNaYDVaCRdcJl/ycJs
6cTFSwzuJ9tjUh++FFL6IKx3zja1vANXkDTC+MgwFUMqyI/VXP5Pt6Dku6G0DXi+
655hMC4YhxoAw3uvy7qxj3cHbl0u9DWCoO8Wp8NycmgIvR2J87fSfde4AxGyC2Ld
xRZ4MlvewiuUUi/jWZAE7NPc2qtdg5Lm/x7rQQMdZGVNCn0kyTpmd7FTcsmptRsA
kXz3Sb19HLHoeLEcfsQAKkFughRwwg==
=HOm/
-----END PGP SIGNATURE-----

--X2SSFfh7uLc8A1LfNkLlkqSKrafdvt1Gi--


