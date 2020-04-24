Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE81C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DC220728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBp2QZzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DC220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRv32-0001bE-Td
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRv2A-0000tL-CL
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRv29-0005ux-A1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:54:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRv28-0005tW-TO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587722047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=na8Uco6vBdMIJFhRndOs9BZnbm3JxO27wGQ9kTFDxBo=;
 b=jBp2QZzg48RFaFDXJI/2kFSNTtURB9qPsqRlEw596Qcd/cyDTk5rXpxdxdXONm6Et21W54
 Yes6Y6TlR3HYogUgd/heVN4UssENX7R+HfH4FN/6RaZcl3it+dazttEyfd11tZ66m3CCgg
 itXFKN3c0Oe2/7c+nTozeusJBQK5V8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-jIV8A1YAO4yz0DEnc_YCWg-1; Fri, 24 Apr 2020 05:54:03 -0400
X-MC-Unique: jIV8A1YAO4yz0DEnc_YCWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55741100A61D;
 Fri, 24 Apr 2020 09:54:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB643610EC;
 Fri, 24 Apr 2020 09:53:55 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-2-eblake@redhat.com>
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
Message-ID: <307f7619-5e4a-10c1-7d49-8ee6bb8d650c@redhat.com>
Date: Fri, 24 Apr 2020 11:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423221707.477404-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XaEhnGMv8OFo0H6qMzueRSP7oK7WM5IN6"
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XaEhnGMv8OFo0H6qMzueRSP7oK7WM5IN6
Content-Type: multipart/mixed; boundary="jBY9NwVpLWFjDOJmUXxQvc4ACnvyJ6ZUP"

--jBY9NwVpLWFjDOJmUXxQvc4ACnvyJ6ZUP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 00:17, Eric Blake wrote:
> There are several callers that need to create a new block backend from
> an existing BDS; make the task slightly easier with a common helper
> routine.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/sysemu/block-backend.h |  2 ++
>  block/block-backend.c          | 23 +++++++++++++++++++++++
>  block/crypto.c                 |  8 +++-----
>  block/parallels.c              |  7 +++----
>  block/qcow.c                   |  7 +++----
>  block/qcow2.c                  | 15 ++++++---------
>  block/qed.c                    |  7 +++----
>  block/sheepdog.c               |  9 ++++-----
>  block/vdi.c                    |  7 +++----
>  block/vhdx.c                   |  7 +++----
>  block/vmdk.c                   |  9 ++++-----
>  block/vpc.c                    |  7 +++----
>  blockdev.c                     |  8 +++-----
>  blockjob.c                     |  7 ++-----
>  14 files changed, 65 insertions(+), 58 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/blockdev.c b/blockdev.c
> index 5faddaa7052f..f43426ed5fbc 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

> @@ -2734,14 +2733,13 @@ void qmp_block_resize(bool has_device, const char=
 *device,
>          goto out;
>      }
>=20
> -    blk =3D blk_new(bdrv_get_aio_context(bs), BLK_PERM_RESIZE, BLK_PERM_=
ALL);
> -    ret =3D blk_insert_bs(blk, bs, errp);
> -    if (ret < 0) {
> +    blk =3D blk_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PERM_ALL, errp);
> +    if (!blk) {
>          goto out;
>      }
>=20
>      bdrv_drained_begin(bs);
> -    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
> +    blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);

This is also addressed by
https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg03656.html,
but it does make sense to fix it here, too.  Well, whichever lands first
lands first, I suppose (so @ret can be dropped).

Max


--jBY9NwVpLWFjDOJmUXxQvc4ACnvyJ6ZUP--

--XaEhnGMv8OFo0H6qMzueRSP7oK7WM5IN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6itzEACgkQ9AfbAGHV
z0D6EQf/dji1jPMvn98JpYCjfpx4rVD1/Qji3rvRS6PeAjcG0udu2SNRSOzY4C+S
4+4+e1RCq7lVxIwf0at585ZutpYHbjvb+mMGKmROiJao5gpvWZnuG6rVoitKG1/D
J+UPjjYMROaQ8OBhaGKrm+XS325rGtDO3wu3H3EupD2rwxwLQS0wHeulRTVow+2V
MSd2syquFU3ddqBuunt1mTZHd3ZbeNFUCwMNZ7+u/zDmi+uKdGVTBXrkJj0aC7zi
qyZxkZwWGLH9fk9WY8lFoPw6itIYG4VyAxOvkUctAoNHZ/wI7jlCIlkm9c9XMpQS
2rNt1GzAIJpSLHxrbXsbKC0LJ699Qg==
=lU7c
-----END PGP SIGNATURE-----

--XaEhnGMv8OFo0H6qMzueRSP7oK7WM5IN6--


