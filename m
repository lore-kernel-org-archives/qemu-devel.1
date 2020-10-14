Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D1EC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDDE20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E66Zro+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDDE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfVX-0004Xg-GY
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfRU-0008Bj-7Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSfRS-0001MP-9z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+ZtqrsPiMyhDOWZN5B/7QGP+FzOGG8xvRRXQKy291Pw=;
 b=E66Zro+r9yo1oFw7O93DuByvWsJsEclxwFm9arQHfIhRZm35Wg9z3/cVJiq+H11rOU3798
 l/c5tHkODxLczlz2T1d3Au6Ql7nDENKJSeUsULhBeoSKVau3RvYom3wstt/EgTlS0bIpPs
 Dm4jm3UAwrOWwQBzFOC0I6vZIFCF+y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-g08qSGGEMs2L0BLmKEZOgA-1; Wed, 14 Oct 2020 07:59:34 -0400
X-MC-Unique: g08qSGGEMs2L0BLmKEZOgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 639D7101962B;
 Wed, 14 Oct 2020 11:59:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E386EF7C;
 Wed, 14 Oct 2020 11:59:24 +0000 (UTC)
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
Message-ID: <a938ce00-70ee-7f6e-f4f6-08630c49e843@redhat.com>
Date: Wed, 14 Oct 2020 13:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y3Y89HR1TESSwbJiPPRjzy7rfphOR29WG"
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
--y3Y89HR1TESSwbJiPPRjzy7rfphOR29WG
Content-Type: multipart/mixed; boundary="7zIYIipchX0rNOmzBMTddVNCJhU8bVaC8"

--7zIYIipchX0rNOmzBMTddVNCJhU8bVaC8
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
> +        local_flags =3D flags;
> +
> +        /* In case of failure, try to copy-on-read anyway */
> +        ret =3D bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
> +        if (!ret) {

In case of failure, a negative value is going to be returned, we won=E2=80=
=99t
go into this conditional block, and local_flags isn=E2=80=99t going to cont=
ain
BDRV_REQ_COPY_ON_READ.

So the idea of CORing in case of failure sounds sound to me, but it
doesn=E2=80=99t look like that=E2=80=99s done.

> +            ret =3D bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),

I think this should either be bdrv_backing_chain_next() or we must rule
out the possibility of bs->file->bs being a filter somewhere.  I think
I=E2=80=99d prefer the former.

> +                                          state->base_overlay, true, off=
set,
> +                                          n, &n);
> +            if (ret) {

=E2=80=9Cret =3D=3D 1 || ret < 0=E2=80=9D would be more explicit (and in li=
ne with the =E2=80=9C!ret
|| ret < 0=E2=80=9D probably needed above), but correct either way.

Max


--7zIYIipchX0rNOmzBMTddVNCJhU8bVaC8--

--y3Y89HR1TESSwbJiPPRjzy7rfphOR29WG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G6BoACgkQ9AfbAGHV
z0CiHwf+KoxIB1Ldo9PHNVpp0z5CIdSvX/zl3yI/trCoCn/mYf87/EMr3uFYJ8rH
vD51FTFTMZ8+Dn7JTZgYNhmH1EbAo27yTdTD4SUba2aa9vVLeWEgRL1wqbPZY/pJ
Px0Ju2NkS16E++YKaYNIg20UoZGbSZgzI5d0JYjN6El5uqrDb9f9Mwf/Hk0z7Z9+
GeHrya66KiN2YqsryQ7LQ+ULZDDIJYz6K4wheL54aXaulzReUoIVmjutyoh95ggl
fDEyjPAEBYG0h561FSFOy07MtVV7GmFxYPKzDQURAtBXCzndeF1wwFHmQUDZpTUZ
4KAe0+oUqkqa3zhoccFEGQZ3zRn7mw==
=cp/7
-----END PGP SIGNATURE-----

--y3Y89HR1TESSwbJiPPRjzy7rfphOR29WG--


