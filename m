Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2FC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505F420731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIXohyBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlmW-0000dQ-6t
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTllp-0008RL-H3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTllo-0006ek-03
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:24:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55642
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTlln-0006ec-Gp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588163094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZ2QfpVh2zKkFnnPousOwFGQqwnTaUPGdbadxJhoSGI=;
 b=EIXohyByy9dt6lbfMpf15NCHm4eQ2xxr+P/OVbPAb47rXmODYJWo+SD7pviPL4dL17dYJg
 zrHMhMsaAjQq4VM8/MImEMzfIOKcT6xNzH+jX1wpqMUh1RnYkRfHX18FrIxwnJdRRPC6YB
 FYWRZuIIDV+jKAOHAyqrqDlYZkLK0L0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Z5Tg42koMn2FIYDfQURg9Q-1; Wed, 29 Apr 2020 08:24:51 -0400
X-MC-Unique: Z5Tg42koMn2FIYDfQURg9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 405691005510;
 Wed, 29 Apr 2020 12:24:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 420DB5C241;
 Wed, 29 Apr 2020 12:24:48 +0000 (UTC)
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <90ea0176-b01f-035a-7c9c-087a16009e38@virtuozzo.com>
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
Message-ID: <8e4618fb-f809-7cd1-489a-ea94a9ebfdbd@redhat.com>
Date: Wed, 29 Apr 2020 14:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <90ea0176-b01f-035a-7c9c-087a16009e38@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vAWc1aUX3T0s6lTlV882fcsoOBkVpDPf9"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vAWc1aUX3T0s6lTlV882fcsoOBkVpDPf9
Content-Type: multipart/mixed; boundary="sf14v6G5wDX2Po4MuwDKE6XPjCJeMteSK"

--sf14v6G5wDX2Po4MuwDKE6XPjCJeMteSK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 12:38, Denis Plotnikov wrote:
>=20
>=20
> On 29.04.2020 13:24, Max Reitz wrote:
>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>> zstd significantly reduces cluster compression time.
>>> It provides better compression performance maintaining
>>> the same level of the compression ratio in comparison with
>>> zlib, which, at the moment, is the only compression
>>> method available.
>>>
>>> The performance test results:
>>> Test compresses and decompresses qemu qcow2 image with just
>>> installed rhel-7.6 guest.
>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>
>>> The test was conducted with brd disk to reduce the influence
>>> of disk subsystem to the test results.
>>> The results is given in seconds.
>>>
>>> compress cmd:
>>> =A0=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|=
zstd]
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src.img [zlib|zs=
td]_compressed.img
>>> decompress cmd
>>> =A0=A0 time ./qemu-img convert -O qcow2
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [zlib|zstd]_comp=
ressed.img uncompressed.img
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 decompression
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0 zstd=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0=A0=A0 zstd
>>> ------------------------------------------------------------
>>> real=A0=A0=A0=A0 65.5=A0=A0=A0=A0=A0=A0 16.3 (-75 %)=A0=A0=A0 1.9=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 1.6 (-16 %)
>>> user=A0=A0=A0=A0 65.0=A0=A0=A0=A0=A0=A0 15.8=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 5.3=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.5
>>> sys=A0=A0=A0=A0=A0=A0 3.3=A0=A0=A0=A0=A0=A0=A0 0.2=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 2.0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.0
>>>
>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>> compressed image size in both cases: 1.4G
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> QAPI part:
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> =A0 docs/interop/qcow2.txt |=A0=A0 1 +
>>> =A0 configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>> =A0 qapi/block-core.json=A0=A0 |=A0=A0 3 +-
>>> =A0 block/qcow2-threads.c=A0 | 169 ++++++++++++++++++++++++++++++++++++=
+++++
>>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 ++
>>> =A0 slirp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 =
+-
>>> =A0 6 files changed, 181 insertions(+), 3 deletions(-)
>> [...]
>>
>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>> index 7dbaf53489..a0b12e1b15 100644
>>> --- a/block/qcow2-threads.c
>>> +++ b/block/qcow2-threads.c
>> [...]
>>
>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t src_size)
>>> +{
>> [...]
>>
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * The compressed stream from the input buffer may consist=
 of more
>>> +=A0=A0=A0=A0 * than one zstd frame.
>> Can it?
>=20
> Potentially, it can, if another implemention of qcow2 saves a couple of
> frames for some reason.

Well, it can=92t do that if qemu cannot decode it.  Maybe there should be
a note in the specification on the precise format to expect.

If we decide that it might make sense for someone to encode a cluster
with multiple frames, then OK.

Max


--sf14v6G5wDX2Po4MuwDKE6XPjCJeMteSK--

--vAWc1aUX3T0s6lTlV882fcsoOBkVpDPf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pcg4ACgkQ9AfbAGHV
z0AIbQgAumbMsoUaTsa1uhEQdR4hX3XRPgbXUdwc9H81jV/yX7xVPHSw4YMYfFmT
UtVI+8pONbOPMCZmN47SpPN0udNGlk50uqMiBIp0b6TXlMOri56E+XyHyuAQzY56
PmJttp+WzKFWKBwzI1X2Cal5KL/mqaSuFtxglyXDopyGoA3neVXS51aOsjifNpqX
cmWCU1lOGjvSJDWDnQzdXh6YXlHVOBtyR0P2eoSYzvAVJFVWDqOUbeW7OpVlQYf9
hoHo2Ws9L+Cp64Enf29EOz0d/AXUUcbv8jgxj4VBWc5/Olh7DDnkpDUu4ZZ3xpVM
2aFB6eeuEEr/G4t+H1m2TcoD67vArQ==
=ZZ7q
-----END PGP SIGNATURE-----

--vAWc1aUX3T0s6lTlV882fcsoOBkVpDPf9--


