Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED956C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACADA207DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVxbIyMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACADA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83Of-0004Fm-Qo
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k82YS-0004c6-VR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:25:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k82YR-0000tf-Bw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597760733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=90uu1gc8u2zW9HTtObOvz1uXaozhja6ySEf9NUG3ipI=;
 b=JVxbIyMVbp35lsyoQJid+chK2BEc+g18BimoPcyLU+cJ3oGYHMfsEye+1/Y1AaM25WseEo
 ZfTrMR6N+fFT/b1/ohbz+PVfzxEI6C3lPs1Zb8b4hnQBKWpDp6cQpIrdp+GtV53MYah2go
 kRD6F2/PPh4SUzsPwGxxpR1HrZeQ+24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-avYxWoUvPg6_fcH_jg-oLw-1; Tue, 18 Aug 2020 10:25:31 -0400
X-MC-Unique: avYxWoUvPg6_fcH_jg-oLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865E880BCA1;
 Tue, 18 Aug 2020 14:25:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-119.ams2.redhat.com
 [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 620D05D757;
 Tue, 18 Aug 2020 14:25:29 +0000 (UTC)
Subject: Re: [RFC PATCH 16/22] block/export: Allocate BlockExport in
 blk_exp_add()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-17-kwolf@redhat.com>
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
Message-ID: <4b937863-ee77-26e5-7ad6-867002e6e2fb@redhat.com>
Date: Tue, 18 Aug 2020 16:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-17-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZujjayNp4T5ES1qga4vf84EQ4HPtMJIMj"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZujjayNp4T5ES1qga4vf84EQ4HPtMJIMj
Content-Type: multipart/mixed; boundary="xEPYPRySBe2Md370nGpSF9Y1o70efxzRJ"

--xEPYPRySBe2Md370nGpSF9Y1o70efxzRJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> Instead of letting the driver allocate and return the BlockExport
> object, allocate it already in blk_exp_add() and pass it. This allows us
> to initialise the generic part before calling into the driver so that
> the driver can just use these values instead of having to parse the
> options a second time.
>=20
> For symmetry, move freeing the BlockExport to blk_exp_unref().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h |  3 ++-
>  include/block/nbd.h    | 11 ++++++-----
>  block/export/export.c  | 17 ++++++++++++++++-
>  blockdev-nbd.c         | 24 +++++++++++++-----------
>  nbd/server.c           | 30 +++++++++++++-----------------
>  5 files changed, 50 insertions(+), 35 deletions(-)

[...]

> diff --git a/block/export/export.c b/block/export/export.c
> index ef86bf892b..9de108cbc1 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c

[...]

> @@ -46,7 +48,19 @@ BlockExport *blk_exp_add(BlockExportOptions *export, E=
rror **errp)
>          return NULL;
>      }
> =20
> -    return drv->create(export, errp);

assert(drv->instance_size >=3D sizeof(BlockExport)) might be nice before
dereferencing *exp.

With that:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    exp =3D g_malloc0(drv->instance_size);
> +    *exp =3D (BlockExport) {
> +        .drv        =3D &blk_exp_nbd,
> +        .refcount   =3D 1,
> +    };


--xEPYPRySBe2Md370nGpSF9Y1o70efxzRJ--

--ZujjayNp4T5ES1qga4vf84EQ4HPtMJIMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl875NcACgkQ9AfbAGHV
z0CV7QgAoJeg3yseNLyYrcYHZ3e4unaS+bG8/fSM1iNFQtkfW3UpbjRSvOKYfEDn
04CLTKjg8etbnA7Pe3q4oss/jefL3ahih0foWD2inzflLIqIyuluBsAsjoFHla38
ofAGLTEVEDghcpn2fdwqDBziTjZ2Gvt9CXF574kNyQlE+8yA33676MZJCWlNalq3
Gz9ruix2GS6qSvjq4bQf+R8th4o1NwZpIf4F/bPp6DzXlnbwiTDFgPLOzGndjWDa
TMrQwuS+1rR5+nIOsDhGgaQc07GvkrolLqqa+u6RZj97h/oEA4SDLrd/0ryQTzXG
2v8K0qs46MpFxc/D7Eu0FHMXNMFjWA==
=ow3D
-----END PGP SIGNATURE-----

--ZujjayNp4T5ES1qga4vf84EQ4HPtMJIMj--


