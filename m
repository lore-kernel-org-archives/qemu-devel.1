Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7797C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E3E20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUYaakFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E3E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Wm-0003Xn-Fa
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Us-0001Eu-Tq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:08:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5Ur-0006ML-6m
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594912108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZqpGuspYmzR+to6RBkjHQ6xrj/WUCYpOpZ9MX6Sfzxo=;
 b=UUYaakFypv0CANnzs6NW6E6TW70PpPWaVkfy0gCuyvW7UcneVWNdsWV51F02mD861T5o7v
 rJViGMEooOs/kWFDvKq4oeI/QlkxT9oNhLnBsuEY3VOIKeRbWo+mgYBD6UuMqt15gtBR53
 6128RERwyleTXAmIS2ySxMIBLrByeck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-NtaY6-FyNVeTc449IRyEZQ-1; Thu, 16 Jul 2020 11:08:24 -0400
X-MC-Unique: NtaY6-FyNVeTc449IRyEZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62745802C2D;
 Thu, 16 Jul 2020 15:08:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C9C74F64;
 Thu, 16 Jul 2020 15:08:22 +0000 (UTC)
Subject: Re: [PATCH v7 19/47] vmdk: Drop vmdk_co_flush()
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-20-mreitz@redhat.com>
 <da609c95-f48c-90c7-8a4c-d53c69441c4c@virtuozzo.com>
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
Message-ID: <fae68eff-0b3d-dbe8-703c-672417cb5e80@redhat.com>
Date: Thu, 16 Jul 2020 17:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da609c95-f48c-90c7-8a4c-d53c69441c4c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2wXVs9dN81Tf6XGUnfn81kYwVdCSNcFJ3"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2wXVs9dN81Tf6XGUnfn81kYwVdCSNcFJ3
Content-Type: multipart/mixed; boundary="lKyYwCbhQYjwrevboLCxkGRexrCmdACAs"

--lKyYwCbhQYjwrevboLCxkGRexrCmdACAs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.07.20 16:52, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Before HEAD^, we needed this because bdrv_co_flush() by itself would
>> only flush bs->file.=C2=A0 With HEAD^, bdrv_co_flush() will flush all
>> children on which a WRITE or WRITE_UNCHANGED permission has been taken.
>> Thus, vmdk no longer needs to do it itself.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/vmdk.c | 16 ----------------
>> =C2=A0 1 file changed, 16 deletions(-)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 62da465126..a23890e6ec 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -2802,21 +2802,6 @@ static void vmdk_close(BlockDriverState *bs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(s->migration_blocker);
>> =C2=A0 }
>> =C2=A0 -static coroutine_fn int vmdk_co_flush(BlockDriverState *bs)
>> -{
>> -=C2=A0=C2=A0=C2=A0 BDRVVmdkState *s =3D bs->opaque;
>> -=C2=A0=C2=A0=C2=A0 int i, err;
>> -=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> -
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->num_extents; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D bdrv_co_flush(s->ext=
ents[i].file->bs);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D err;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> -}
>> -
>> =C2=A0 static int64_t vmdk_get_allocated_file_size(BlockDriverState *bs)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> @@ -3075,7 +3060,6 @@ static BlockDriver bdrv_vmdk =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_close=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D vmdk_close,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_co_create_opts=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D vmdk_co_create_opts,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_co_create=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D vmdk_co_cr=
eate,
>> -=C2=A0=C2=A0=C2=A0 .bdrv_co_flush_to_disk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D vmdk_co_flush,
>=20
>=20
> After HEAD^ applied, wouldn't we get an endless recursion in
> bdrv_co_flush() if the HEAD (this patch) had not been merged into HEAD^?

Hm, how so?  HEAD^ just flushes all children, just like vmdk_co_flush()
does.  So it seems to me just like double the work.  (Which is
unfortunate but shouldn=E2=80=99t be a problem.)

Max


--lKyYwCbhQYjwrevboLCxkGRexrCmdACAs--

--2wXVs9dN81Tf6XGUnfn81kYwVdCSNcFJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QbWQACgkQ9AfbAGHV
z0BccggAnjcSANIDgomkM4V08/2kg+NWgTZClemqpqUyuo4h95251m9GrYkgzU2R
J3sPgJd0SIIOPRycGtV/JG2zvXKCmIbQV50z4v5a4V9hiV2TmWW57IKSnHvf/nt/
xSIDJ7W1F143PhbQiGWTuHW00O7w4v9q4hi33K5Tg8uw7Lj8BjSS0yRRj/oY6hWx
6qqdJ60k4tmv6ebco0Qjqbu0qkW+ZQnsquVI4hVXGoTC8L8ueqjBazy4WWPH4s+w
sPQY20AY0Popy/wiTxyxK+Ybi8K7TblzIXg+TpNuMLhSYqgZtZ4uat+KtarfN5//
NJcgRRwd5p2GeDs5di+O10xH0xCEbg==
=6Bj2
-----END PGP SIGNATURE-----

--2wXVs9dN81Tf6XGUnfn81kYwVdCSNcFJ3--


