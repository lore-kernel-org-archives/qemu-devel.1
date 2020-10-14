Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52228C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60BA2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T81hdh29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60BA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeIF-0004HN-N5
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSeH4-0003Sb-4S
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSeH2-0000Kh-Jx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602672287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rP7UCC++xS3Esx88yTZSynz0E3UAKES5VdyWy2iWQnk=;
 b=T81hdh29rtmZSsjMl/sKFzWGrBnx8lXaYlM6OZ5rtdsf/pyRBVy0WoKHZ2WcpkSKBnL+4H
 q1VVjZmxYjPy5ySx8c2S7ebxtVfbWsrPMxN7qLEdqKYmj+KgKYZwWzAuN0DHgnffNrknRV
 DmHME19Aq4D/i8/UPfF06IodY3L11Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-Pv0QNU4SMcKf5BtA32XntA-1; Wed, 14 Oct 2020 06:44:43 -0400
X-MC-Unique: Pv0QNU4SMcKf5BtA32XntA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D0E056FDC;
 Wed, 14 Oct 2020 10:44:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9F2C1992D;
 Wed, 14 Oct 2020 10:44:32 +0000 (UTC)
Subject: Re: [PATCH v11 02/13] copy-on-read: add filter append/drop functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-3-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <39aec06d-6dbd-a0e4-c3b8-d0f243864121@redhat.com>
Date: Wed, 14 Oct 2020 12:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="88d4sZYDZOh9Cxn99SItn5mns8zjAbhUK"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88d4sZYDZOh9Cxn99SItn5mns8zjAbhUK
Content-Type: multipart/mixed; boundary="6SFj2wgviR9KNGn3XA6RkwfSi1xwbE1y7"

--6SFj2wgviR9KNGn3XA6RkwfSi1xwbE1y7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> Provide API for the COR-filter insertion/removal.
> Also, drop the filter child permissions for an inactive state when the
> filter node is being removed.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/copy-on-read.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  block/copy-on-read.h | 35 +++++++++++++++++++++
>  2 files changed, 123 insertions(+)
>  create mode 100644 block/copy-on-read.h
>=20
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index cb03e0f..bcccf0f 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c

[...]

> @@ -159,4 +188,63 @@ static void bdrv_copy_on_read_init(void)
>      bdrv_register(&bdrv_copy_on_read);
>  }
> =20
> +
> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
> +                                         QDict *node_options,
> +                                         int flags, Error **errp)

I had hoped you could make this a generic block layer function. :(

(Because it really is rather generic)

*shrug*

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +{
> +    BlockDriverState *cor_filter_bs;
> +    Error *local_err =3D NULL;
> +
> +    cor_filter_bs =3D bdrv_open(NULL, NULL, node_options, flags, errp);
> +    if (cor_filter_bs =3D=3D NULL) {
> +        error_prepend(errp, "Could not create COR-filter node: ");
> +        return NULL;
> +    }
> +
> +    if (!qdict_get_try_str(node_options, "node-name")) {
> +        cor_filter_bs->implicit =3D true;
> +    }
> +
> +    bdrv_drained_begin(bs);
> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
> +    bdrv_drained_end(bs);
> +
> +    if (local_err) {
> +        bdrv_unref(cor_filter_bs);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return cor_filter_bs;
> +}


--6SFj2wgviR9KNGn3XA6RkwfSi1xwbE1y7--

--88d4sZYDZOh9Cxn99SItn5mns8zjAbhUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G1o0ACgkQ9AfbAGHV
z0CScwf8DDG0g+i1JlAvh4ghf/YzCdQnntfDxamFaZQ5++Tr22winSJyCCa/b9FZ
qUtqlj071oQKLB5GwhhVakHk2+m3thJcJlV016dMvkg5WNHP4uA9aVu+tt9tTetU
3K0exFye7AJZvnKjPWS0T4wV55i1F1wN1v2JelVfe6lRLkBo2C0dO77XdEv5tWUG
Yv3m+wvugaLpSZUhzgx8AMN1fy251/7bsOBgTvsRDGQAD3zUc/AZSzcsDHHSc1Rq
Wv9aQbkOrL4kQ99VvQ8EXMWKEaoKwtqGSWTFOxjCeVx20Q1n/byx3CgNrZyEpE/j
KEzGsJ/hw9sWc4JtUr3U/J+G7Ipl+A==
=zoDY
-----END PGP SIGNATURE-----

--88d4sZYDZOh9Cxn99SItn5mns8zjAbhUK--


