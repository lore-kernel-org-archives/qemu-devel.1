Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E78DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4CD20760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+DIhTUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4CD20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDNz-0004xJ-AX
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqDMn-0003je-SA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:19:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqDMm-0007D6-7O
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593512391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5/YTSTtBJNgSHEoeRWodFZY56Vr3Pfh1xHTJBZZjh2U=;
 b=P+DIhTUJKqj5fovrMZgLAn1PSYcsugoDQy6HmXsHc2ERZKuRV0X5IbrOziOkcSCkqNMJcr
 qQdafpVDTudMFkiYxGBOQzTWJSGT8LFj0aIO8T20QMaOlOI2puZU5KmnlP/l3fBnPxhTh/
 Sk3A8ooPhXwTCF3rCup1z/KdjY7KWck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-eOgx7icWMWa1DHnG8Z69xg-1; Tue, 30 Jun 2020 06:19:47 -0400
X-MC-Unique: eOgx7icWMWa1DHnG8Z69xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3879464;
 Tue, 30 Jun 2020 10:19:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0226121E24;
 Tue, 30 Jun 2020 10:19:43 +0000 (UTC)
Subject: Re: [PATCH v9 02/34] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <4d3e11a48c18c3b4d34f567046334d4a1afde352.1593342067.git.berto@igalia.com>
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
Message-ID: <32a231b3-abc2-8d84-6a7d-eb8ccd388e33@redhat.com>
Date: Tue, 30 Jun 2020 12:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4d3e11a48c18c3b4d34f567046334d4a1afde352.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wVJkEGsId50wQroYrDxa7r4QGvYT6hPrY"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wVJkEGsId50wQroYrDxa7r4QGvYT6hPrY
Content-Type: multipart/mixed; boundary="E5hsCeLp3XpWOEFOmzYWZzzL6eFsR31om"

--E5hsCeLp3XpWOEFOmzYWZzzL6eFsR31om
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> qcow2_get_cluster_offset() takes an (unaligned) guest offset and
> returns the (aligned) offset of the corresponding cluster in the qcow2
> image.
>=20
> In practice none of the callers need to know where the cluster starts
> so this patch makes the function calculate and return the final host
> offset directly. The function is also renamed accordingly.
>=20
> There is a pre-existing exception with compressed clusters: in this
> case the function returns the complete cluster descriptor (containing
> the offset and size of the compressed data). This does not change with
> this patch but it is now documented.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h         |  4 ++--
>  block/qcow2-cluster.c | 42 +++++++++++++++++++++++-------------------
>  block/qcow2.c         | 24 +++++++-----------------
>  3 files changed, 32 insertions(+), 38 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 4b5fc8c4a7..9ab41cb728 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

[...]

> @@ -537,8 +542,6 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, ui=
nt64_t offset,
>          bytes_needed =3D bytes_available;
>      }
> =20
> -    *cluster_offset =3D 0;
> -

You drop this line without replacement now.  That means that
*host_offset is no longer set to 0 if the L1 entry is out of bounds or
empty (which causes this function to return QCOW2_CLUSTER_UNALLOCATED
and no error).  Was that intentional?

Max


--E5hsCeLp3XpWOEFOmzYWZzzL6eFsR31om--

--wVJkEGsId50wQroYrDxa7r4QGvYT6hPrY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl77Eb4ACgkQ9AfbAGHV
z0B1hgf9EY466rosg6ZG2Y7fdHXCgRpLjx3d47D9RPQF7b2S4poiPz/pciVvvzUk
toPoCP2F9xT7vby3QCPe2dEFLoLz88Xe5GW24NT9uI93q9fAa90IAgmMY2G1UjZq
KeMSzn+KBWFhNaI112G6Vd8aG9nodb9HtLfzjX8Qo5mIsUZ3pzPQnN5JlOeY6tyy
seOtsfmberymb/pkRfl98YkcYRFTHPydyupROgco6OteQw0OcgHC6nFf1aVapsUb
AmmtCTqChURd7qGzTx62V8ZUqCzglTGsNvhnk+Q/+Q0QVl8hU39MA/bz3/HlaxQH
SoFaFSbi0cQOyz65lMkSJqSUWACseA==
=nH5c
-----END PGP SIGNATURE-----

--wVJkEGsId50wQroYrDxa7r4QGvYT6hPrY--


