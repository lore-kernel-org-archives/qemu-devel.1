Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50C920848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLeCAQXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50C920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfWh-0005cn-H8
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfTe-0002i7-RG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfTb-0001qb-OZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=88cI3uijKQZiNxTG1cOijQI5qui5yRPuLzRT4Tc/T3o=;
 b=PLeCAQXMlj8IhBh5yNrKRrMMXCCkh2Hf2a8ROydJLd1iMULgJ7lBA/UvlYjttQbFsEEgeX
 ddsTkoeX2bIMCMj2H0124xy7pow+X/GL+MIaEV2LlolCwlt6KdLStCqlxTK0pLOW7/PLJP
 yz2j/G38Y65gFueP+JjP58Z2kYSz/A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-ibejPOSWOeGm2P3CBFipwg-1; Wed, 14 Oct 2020 08:01:43 -0400
X-MC-Unique: ibejPOSWOeGm2P3CBFipwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EC0D107465B;
 Wed, 14 Oct 2020 12:01:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C635D9CD;
 Wed, 14 Oct 2020 12:01:38 +0000 (UTC)
Subject: Re: [PATCH v11 05/13] copy-on-read: limit COR operations to base in
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <6dc38263-ad9c-f238-7197-68e920b6080d@redhat.com>
Date: Wed, 14 Oct 2020 14:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ORo1HqaNwTkiG9vEV181JwuMUCss4W3nw"
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--ORo1HqaNwTkiG9vEV181JwuMUCss4W3nw
Content-Type: multipart/mixed; boundary="pdXmV3AcNWsgp0iyP3ZDdZILHaK3QjKmY"

--pdXmV3AcNWsgp0iyP3ZDdZILHaK3QjKmY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> Limit COR operations by the base node in the backing chain when the
> overlay base node name is given. It will be useful for a block stream
> job when the COR-filter is applied. The overlay base node is passed as
> the base itself may change due to concurrent commit jobs on the same
> backing chain.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/copy-on-read.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index c578b1b..dfbd6ad 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -122,8 +122,43 @@ static int coroutine_fn cor_co_preadv_part(BlockDriv=
erState *bs,
>                                             size_t qiov_offset,
>                                             int flags)
>  {
> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offse=
t,
> -                               flags | BDRV_REQ_COPY_ON_READ);
> +    int64_t n =3D 0;
> +    int64_t size =3D offset + bytes;

Just when I hit send I noticed that =E2=80=9Cend=E2=80=9D would be a more f=
itting name
for this variable.

> +    int local_flags;
> +    int ret;
> +    BDRVStateCOR *state =3D bs->opaque;
> +
> +    if (!state->base_overlay) {
> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_o=
ffset,
> +                                   flags | BDRV_REQ_COPY_ON_READ);
> +    }
> +
> +    while (offset < size) {

(because I got a bit confused looking at this)

(Though dropping @size (or @end) and just checking when @bytes becomes 0
should work, too.)

> +        local_flags =3D flags;
> +
> +        /* In case of failure, try to copy-on-read anyway */
> +        ret =3D bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
> +        if (!ret) {
> +            ret =3D bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
> +                                          state->base_overlay, true, off=
set,
> +                                          n, &n);
> +            if (ret) {
> +                local_flags |=3D BDRV_REQ_COPY_ON_READ;
> +            }
> +        }

Furthermore, I just noticed =E2=80=93 can the is_allocated functions not re=
turn
0 in @n, when @offset is a the EOF?  Is that something to look out for?
 (I=E2=80=99m not sure.)

Max

> +
> +        ret =3D bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offs=
et,
> +                                  local_flags);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        offset +=3D n;
> +        qiov_offset +=3D n;
> +        bytes -=3D n;
> +    }
> +
> +    return 0;
>  }
> =20
> =20
>=20



--pdXmV3AcNWsgp0iyP3ZDdZILHaK3QjKmY--

--ORo1HqaNwTkiG9vEV181JwuMUCss4W3nw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G6KAACgkQ9AfbAGHV
z0AQlAgAoY6VwV881pfGXy4iekBVJliHszTA1wptdNZ3m/INoJzcIf7Urk46fZqH
hW5+TiZwKc3p1+6VFU9blxkngetd3gV2/yhvbmQItBHgGEI7MCSnnCmkJkW4mxcS
Rrst6Jj1M4SxohnXRwLu/5eLiAvvo+YV+OYtQa19Jl8XWsLlt/+/HibW2yORqQdr
UENsEXIHnk3AoASt++jKnHQ+oW57+0GUCnxnFQvq8hjPK6Y8VfPdKIqgsOcpGc2M
3Et35Ao+BaPOkxO6IwzcbHtjmQWPHs6AgSM+oU73R1/xcPlkx6TPvjAiQeXd1vRq
0xDkdN+YBrjBwqewZBxTscXPOFXWCw==
=KhJm
-----END PGP SIGNATURE-----

--ORo1HqaNwTkiG9vEV181JwuMUCss4W3nw--


