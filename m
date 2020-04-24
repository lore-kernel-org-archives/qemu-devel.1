Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7DC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBD8206B9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm8Awgqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBD8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRz0b-0006JK-Ax
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRyzc-0005YS-5M
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRyzb-0000px-MC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:07:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRyzb-0000mE-86
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587737266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+AQJfZeWITVw3K7XDV5cLTRcaNCz9razXopNLgix8mE=;
 b=Cm8Awgqk4OD6l4cMLvD4u5Nr2bS+7QwtEH2wWIzYGmdwjxjkm+pLytywpmWJcRb1X4V9J/
 YgwAjPVY5ciT8LyZKd+oxdKCTEd2LvyeXwXNO7nBwez9e2RgZpZT3IHShqijlPjhtfvRnb
 zhVXq6vro8HgXI7nrE6bv+5YUB0Yvao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-VQ4XO_E5PUOG9K_N7KixUQ-1; Fri, 24 Apr 2020 10:07:43 -0400
X-MC-Unique: VQ4XO_E5PUOG9K_N7KixUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62FA819067E4;
 Fri, 24 Apr 2020 14:07:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B98155D70C;
 Fri, 24 Apr 2020 14:07:36 +0000 (UTC)
Subject: Re: [PATCH v7 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424125448.63318-5-kwolf@redhat.com>
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
Message-ID: <ad81ea15-03a9-07c5-90c9-a3c51a07dc93@redhat.com>
Date: Fri, 24 Apr 2020 16:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424125448.63318-5-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gKFvYhRsfWkcnyGodQwMIys8QhNyVeQBy"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
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
--gKFvYhRsfWkcnyGodQwMIys8QhNyVeQBy
Content-Type: multipart/mixed; boundary="fYN912Q6tURLy0AQlxZZrz7nUEpp2BZUG"

--fYN912Q6tURLy0AQlxZZrz7nUEpp2BZUG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 14:54, Kevin Wolf wrote:
> If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
> undo any previous preallocation, but just adds the zero flag to all
> relevant L2 entries. If an external data file is in use, a write_zeroes
> request to the data file is made instead.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2-cluster.c |  2 +-
>  block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9cfbdfc939..98065d7808 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4214,6 +4215,39 @@ static int coroutine_fn qcow2_co_truncate(BlockDri=
verState *bs, int64_t offset,

[...]

> +        /* Write explicit zeros for the unaligned head */
> +        if (zero_start > old_length) {
> +            uint64_t len =3D zero_start - old_length;
> +            uint8_t *buf =3D qemu_blockalign0(bs, len);

I wonder whether I should raise the question of why this should be
block-aligned when we make no effort to align the offset its written to
(and we know it isn=E2=80=99t aligned to qcow2 clusters at least).

I probably should not.

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +            QEMUIOVector qiov;
> +            qemu_iovec_init_buf(&qiov, buf, len);
> +
> +            qemu_co_mutex_unlock(&s->lock);
> +            ret =3D qcow2_co_pwritev_part(bs, old_length, len, &qiov, 0,=
 0);
> +            qemu_co_mutex_lock(&s->lock);
> +
> +            qemu_vfree(buf);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "Failed to zero out the new=
 area");
> +                goto fail;
> +            }
> +        }


--fYN912Q6tURLy0AQlxZZrz7nUEpp2BZUG--

--gKFvYhRsfWkcnyGodQwMIys8QhNyVeQBy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6i8qcACgkQ9AfbAGHV
z0CHGwf/SggTyahiD49Z7Qi5RToh+BkTGwFuwn5d5atXqGDSDV77C0N93wM3pP5T
Btc8VZhZeQnQd+mb1IJc15yytyeL29uPjmdpL7kX29CTpe2IRoMHgV1lWYgRJKY7
MnY2eqoHYw8DvWxUjEdXgeFoVQKbeDr9t9boFqJ/N+EYND2juTxcsCH67jGPPyDe
jFCg/2NeFTRy03XRaTKiRZwTNKqQFtqFGgUR9rFq5nfSNtSIpkzyTjcrA2f/8CYB
/L58IPIQKTY+srq1ZqaxDrZE70N5cOvE7eNn2q8dve1m+vLfGoHd2+9l4m2RJYqo
kwvUG/WeqnxZ1WDrc96n6vgCuRhzZA==
=Egyl
-----END PGP SIGNATURE-----

--gKFvYhRsfWkcnyGodQwMIys8QhNyVeQBy--


