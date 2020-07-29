Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DBC20663
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKQil1ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DBC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jlz-000571-MW
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0jlC-0004cl-Uj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:56:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0jlA-0005yb-7e
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596020190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ht78+oGhXejmTC2eVuc8w25I1kfWDgLQ1Cr0HsRBPxQ=;
 b=cKQil1aoU3LzO4kmWZvxsx/SIpsZ3Iq+r1bKrhtzfIMRFi59LLf63hiz04H/hxrKImU4Ev
 qRAF6bIyxXJRxYjEqv0riGsNO+kSMmYa3xfWKPE5RpAzKiVFwk3WJ9bU6gMdWin/bAgA6s
 2q75wxlHMPeMV87qf6FGaAH3VIgDcFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-TimHqEpONmCyuVg5iBHcag-1; Wed, 29 Jul 2020 06:56:28 -0400
X-MC-Unique: TimHqEpONmCyuVg5iBHcag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DBF891270;
 Wed, 29 Jul 2020 10:56:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-105.ams2.redhat.com
 [10.36.113.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46EB95D9E8;
 Wed, 29 Jul 2020 10:56:26 +0000 (UTC)
Subject: Re: qemu-img convert asserts while converting from vhdx to raw
To: Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Jeff Cody <codyprime@gmail.com>
References: <8906F385-C6C0-4F60-A15C-07B2AE7F0B7A@nutanix.com>
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
Message-ID: <fa95eeba-5f3d-912d-01ba-14dbcc4c24dd@redhat.com>
Date: Wed, 29 Jul 2020 12:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8906F385-C6C0-4F60-A15C-07B2AE7F0B7A@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7TOWA61rWFauIO1bwub6cOlOcL2fcZMyr"
Received-SPF: pass client-ip=63.128.21.74; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7TOWA61rWFauIO1bwub6cOlOcL2fcZMyr
Content-Type: multipart/mixed; boundary="UlccaZDzgsLlp4gHdPtBP6cd3cnX21U5x"

--UlccaZDzgsLlp4gHdPtBP6cd3cnX21U5x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.07.20 18:53, Swapnil Ingle wrote:
> Hey Guys,
>=20
> =C2=A0
>=20
> We are seeing following assert when trying to convert disk image from
> vhdx to raw.=C2=A0
>=20
> This issue is seen only for disk with 4k logical sector size.

Honestly, looking at the vhdx code, it just can=E2=80=99t work for 4k logic=
al
sectors without a major rework.  As far as I can see, for some reason it
likes to assume that qemu block layer sectors (which are always 512
bytes) are always the same as vhdx sectors (which aren=E2=80=99t).

Did you ever get any vhdx image with 4k logical sectors to work?

The problem I see is that we don=E2=80=99t have an active maintainer for vh=
dx,
so as unfortunate as it is, if it=E2=80=99s really never worked, the only
realistic solution I see would be to outright refuse to open images with
4k sectors...

Max

> $ qemu-img convert -f vhdx -O raw 4KTest1.vhdx test.raw
>=20
> qemu-img: util/iov.c:388: qiov_slice: Assertion `offset + len <=3D
> qiov->size' failed.
>=20
> Aborted
>=20
> =C2=A0
>=20
> $ qemu-img --version
>=20
> qemu-img version 5.0.91 (v5.1.0-rc1-2-g3cbc897-dirty)
>=20
> Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
>=20
> =C2=A0
>=20
> =C2=A0$ qemu-img check -r all 4KTest1.vhdx
>=20
> No errors were found on the image.
>=20
> =C2=A0
>=20
> $ qemu-img info 4KTest1.vhdx
>=20
> image: 4KTest1.vhdx
>=20
> file format: vhdx
>=20
> virtual size: 10 GiB (10737418240 bytes)
>=20
> disk size: 35.7 GiB
>=20
> cluster_size: 33554432
>=20
> =C2=A0
>=20
> The vhdx disk metadata is following,=C2=A0
>=20
> =C2=A0
>=20
> VhdFormat : VHDX
>=20
> VhdType : Dynamic
>=20
> LogicalSectorSize : 4096=C2=A0
>=20
> PhysicalSectorSize : 4096
>=20
> BlockSize : 33554432
>=20
> =C2=A0
>=20
> Following is the backtrace of the assert,=C2=A0
>=20
> =C2=A0
>=20
> #0=C2=A0 0x00007ffff64cf387 in raise () from /lib64/libc.so.6
>=20
> #1=C2=A0 0x00007ffff64d0a78 in abort () from /lib64/libc.so.6
>=20
> #2=C2=A0 0x00007ffff64c81a6 in __assert_fail_base () from /lib64/libc.so.=
6
>=20
> #3=C2=A0 0x00007ffff64c8252 in __assert_fail () from /lib64/libc.so.6
>=20
> #4=C2=A0 0x00005555556abf5a in qiov_slice (qiov=3D0x7ffff4122a20, offset=
=3D0,
> len=3D2096640, head=3D0x7ffff4122648, tail=3D0x7ffff4122650,
>=20
> =C2=A0=C2=A0=C2=A0 niov=3D0x7ffff4122640) at util/iov.c:388
>=20
> #5=C2=A0 0x00005555556ac0f6 in qemu_iovec_init_extended (qiov=3D0x7ffff41=
22730,
> head_buf=3D0x0, head_len=3D0, mid_qiov=3D0x7ffff4122a20, mid_offset=3D0,
>=20
> =C2=A0=C2=A0=C2=A0 mid_len=3D2096640, tail_buf=3D0x0, tail_len=3D0) at ut=
il/iov.c:429
>=20
> #6=C2=A0 0x00005555556ac438 in qemu_iovec_init_slice (qiov=3D0x7ffff41227=
30,
> source=3D0x7ffff4122a20, offset=3D0, len=3D2096640) at util/iov.c:495
>=20
> #7=C2=A0 0x0000555555609bd6 in bdrv_driver_preadv (bs=3D0x555555982a80,
> offset=3D15841886208, bytes=3D2096640, qiov=3D0x7ffff4122a20, qiov_offset=
=3D0,
>=20
> =C2=A0=C2=A0=C2=A0 flags=3D0) at block/io.c:1134
>=20
> #8=C2=A0 0x000055555560ad55 in bdrv_aligned_preadv (child=3D0x5555559891f=
0,
> req=3D0x7ffff4122900, offset=3D15841886208, bytes=3D2096640, align=3D1,
>=20
> =C2=A0=C2=A0=C2=A0 qiov=3D0x7ffff4122a20, qiov_offset=3D0, flags=3D0) at =
block/io.c:1515
>=20
> #9=C2=A0 0x000055555560b67b in bdrv_co_preadv_part (child=3D0x5555559891f=
0,
> offset=3D15841886208, bytes=3D2096640, qiov=3D0x7ffff4122a20, qiov_offset=
=3D0,
>=20
> =C2=A0=C2=A0=C2=A0 flags=3D0) at block/io.c:1756
>=20
> #10 0x000055555560b4b4 in bdrv_co_preadv (child=3D0x5555559891f0,
> offset=3D15841886208, bytes=3D2096640, qiov=3D0x7ffff4122a20, flags=3D0)
>=20
> =C2=A0=C2=A0=C2=A0 at block/io.c:1714
>=20
> #11 0x00005555555e3266 in vhdx_co_readv (bs=3D0x55555597b370,
> sector_num=3D4194304, nb_sectors=3D4095, qiov=3D0x7ffff4122e10) at
> block/vhdx.c:1208
>=20
> #12 0x0000555555609da1 in bdrv_driver_preadv (bs=3D0x55555597b370,
> offset=3D2147483136, bytes=3D2097152, qiov=3D0x7ffff4122e10, qiov_offset=
=3D0,
>=20
> =C2=A0=C2=A0=C2=A0 flags=3D0) at block/io.c:1169
>=20
> #13 0x000055555560ad55 in bdrv_aligned_preadv (child=3D0x555555989150,
> req=3D0x7ffff4122cb0, offset=3D2147483136, bytes=3D2097152, align=3D512,
>=20
> =C2=A0=C2=A0=C2=A0 qiov=3D0x7ffff4122e10, qiov_offset=3D0, flags=3D0) at =
block/io.c:1515
>=20
> #14 0x000055555560b67b in bdrv_co_preadv_part (child=3D0x555555989150,
> offset=3D2147483136, bytes=3D2097152, qiov=3D0x7ffff4122e10, qiov_offset=
=3D0,
>=20
> =C2=A0=C2=A0=C2=A0 flags=3D0) at block/io.c:1756
>=20
> #15 0x000055555560b4b4 in bdrv_co_preadv (child=3D0x555555989150,
> offset=3D2147483136, bytes=3D2097152, qiov=3D0x7ffff4122e10, flags=3D0)
>=20
> =C2=A0=C2=A0=C2=A0 at block/io.c:1714
>=20
> #16 0x00005555555f34c3 in blk_do_preadv (blk=3D0x55555597b010,
> offset=3D2147483136, bytes=3D2097152, qiov=3D0x7ffff4122e10, flags=3D0)
>=20
> =C2=A0=C2=A0=C2=A0 at block/block-backend.c:1211
>=20
> #17 0x00005555555f351b in blk_co_preadv (blk=3D0x55555597b010,
> offset=3D2147483136, bytes=3D2097152, qiov=3D0x7ffff4122e10, flags=3D0)
>=20
> =C2=A0=C2=A0=C2=A0 at block/block-backend.c:1223
>=20
> #18 0x000055555557347b in blk_co_pread (blk=3D0x55555597b010,
> offset=3D2147483136, bytes=3D2097152, buf=3D0x7fffefdff000, flags=3D0)
>=20
> =C2=A0=C2=A0=C2=A0 at /home/swapnil/dev/github/qemu/include/sysemu/block-=
backend.h:140
>=20
> #19 0x00005555555771aa in convert_co_read (s=3D0x7fffffffdc30,
> sector_num=3D4194303, nb_sectors=3D4096, buf=3D0x7fffefdff000 "") at
> qemu-img.c:1830
>=20
> #20 0x000055555557785c in convert_co_do_copy (opaque=3D0x7fffffffdc30) at
> qemu-img.c:2007
>=20
> #21 0x00005555556a9e4e in coroutine_trampoline (i0=3D1436133568, i1=3D218=
45)
> at util/coroutine-ucontext.c:173
>=20
> #22 0x00007ffff64e1190 in ?? () from /lib64/libc.so.6
>=20
> #23 0x00007fffffffd2e0 in ?? ()
>=20
> #24 0x0000000000000000 in ?? ()
>=20
> =C2=A0
>=20
> Thanks and Regards,
>=20
> -Swapnil
>=20
> =C2=A0
>=20



--UlccaZDzgsLlp4gHdPtBP6cd3cnX21U5x--

--7TOWA61rWFauIO1bwub6cOlOcL2fcZMyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8hVdgACgkQ9AfbAGHV
z0CM1Af/ZReTjBBDrxPEPT9zq1EvfwZh7e2w/n4sR8TtQAMw0yXp3Kjf3cX75lq5
IE8U5DthbB33bZZE3OBmLDjazcmrWIGkVClnedz8uumzZXaISdkhDV02eLbEw9eM
CmXx9ckgb6/zCWR+wVBHlXviJHdHsPeegLsZcSuNlJjVaniquS9jZpgEGgOaUFq9
Xg3uEnb1sLpwhlfyVM2s5HNnC3YkUGDNH27XIkdzbsp/9V+cWHshwAD9AdUNQzdp
Nc+H6HmFIQ6hWpze6Mg0EXV1SV6FIe8lF9b+86WvzEJCcgXiHUDQbVGm3tzT7yx5
oeKKRT7W7SXFqGr1lfuQa4kYBXaWMw==
=g91h
-----END PGP SIGNATURE-----

--7TOWA61rWFauIO1bwub6cOlOcL2fcZMyr--


