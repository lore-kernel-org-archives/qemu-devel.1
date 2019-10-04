Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A7FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3D2215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3D2215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNLW-0006f6-TI
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGNBS-0001T3-UY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGNBR-0000po-On
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGNBM-0000m3-Lt; Fri, 04 Oct 2019 08:59:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A6D6308FFB1;
 Fri,  4 Oct 2019 12:59:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14EAF5D784;
 Fri,  4 Oct 2019 12:59:30 +0000 (UTC)
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
 <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
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
Message-ID: <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
Date: Fri, 4 Oct 2019 14:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5cLub4nmsFP4gClL6A7oyyL9sRu5cEDmB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 04 Oct 2019 12:59:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5cLub4nmsFP4gClL6A7oyyL9sRu5cEDmB
Content-Type: multipart/mixed; boundary="QtvFdnAqSGT92ORuMy9Qdi0UnN4ZHjqwK"

--QtvFdnAqSGT92ORuMy9Qdi0UnN4ZHjqwK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 11:34, Vladimir Sementsov-Ogievskiy wrote:
> 02.10.2019 18:52, Max Reitz wrote:
>> On 02.10.19 17:06, Vladimir Sementsov-Ogievskiy wrote:
>>> 02.10.2019 18:03, Vladimir Sementsov-Ogievskiy wrote:
>>>> 02.10.2019 17:57, Max Reitz wrote:
>>>>> On 12.09.19 17:13, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset align=
ed-up
>>>>>> region in the dirty bitmap, which means that we may not copy some =
bytes
>>>>>> and assume them copied, which actually leads to producing corrupte=
d
>>>>>> target.
>>>>>>
>>>>>> So 9adc1cb49af8d forced dirty bitmap granularity to be
>>>>>> request_alignment for mirror-top filter, so we are not working wit=
h
>>>>>> unaligned requests. However forcing large alignment obviously decr=
eases
>>>>>> performance of unaligned requests.
>>>>>>
>>>>>> This commit provides another solution for the problem: if unaligne=
d
>>>>>> padding is already dirty, we can safely ignore it, as
>>>>>> 1. It's dirty, it will be copied by mirror_iteration anyway
>>>>>> 2. It's dirty, so skipping it now we don't increase dirtiness of t=
he
>>>>>>  =C2=A0=C2=A0=C2=A0 bitmap and therefore don't damage "synchronici=
ty" of the
>>>>>>  =C2=A0=C2=A0=C2=A0 write-blocking mirror.
>>>>>
>>>>> But that=E2=80=99s not what active mirror is for.=C2=A0 The point o=
f active mirror is
>>>>> that it must converge because every guest write will contribute tow=
ards
>>>>> that goal.
>>>>>
>>>>> If you skip active mirroring for unaligned guest writes, they will =
not
>>>>> contribute towards converging, but in fact lead to the opposite.
>>>>>
>>>>
>>>> The will not contribute only if region is already dirty. Actually, a=
fter
>>>> first iteration of mirroring (copying the whole disk), all following=
 writes
>>>> will contribute, so the whole process must converge. It is a bit sim=
ilar with
>>>> running one mirror loop in normal mode, and then enable write-blocki=
ng.
>>>>
>>>
>>>
>>> In other words, we don't need "all guest writes contribute" to conver=
ge,
>>> "all guest writes don't create new dirty bits" is enough, as we have =
parallel
>>> mirror iteration which contiguously handles dirty bits.
>>
>> Hm, in a sense.  But it does mean that guest writes will not contribut=
e
>> to convergence.
>>
>> And that=E2=80=99s against the current definition of write-blocking, w=
hich does
>> state that =E2=80=9Cwhen data is written to the source, write it (sync=
hronously)
>> to the target as well=E2=80=9D.
>>
>=20
> Hmm, understand. But IMHO our proposed behavior is better in general.
> Do you think it's a problem to change spec now?
> If yes, I'll resend with an option

Well, the thing is that I=E2=80=99d find it weird if write-blocking wasn=E2=
=80=99t
blocking in all cases.  And in my opinion, it makes more sense for
active mirror if all writes actively contributed to convergence.

Max


--QtvFdnAqSGT92ORuMy9Qdi0UnN4ZHjqwK--

--5cLub4nmsFP4gClL6A7oyyL9sRu5cEDmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XQjEACgkQ9AfbAGHV
z0CSwwf/Tuo6eNXCJtXceK7w7ilbPzPe7YV+pkSSxmaQmSrLblt71NlBvTZDl54q
vxBuSh/lolU8AorF8EIJ+mQW/YxMkFRKj8xHI+aDFgLPtv5P31kq6UP00zo2JnV/
Aww4w6VzD861DvXlUPtWqBliMVPnxoTr9hRg3kKCV+DzkwaJQ2VKy0BgxOSrAIL1
xH4tg596YMP90+dPnyKZdOSAwjtHxWmpIrDXAcmHTpaqPPcSt7C/rtj9Apu2j78/
J7E+MRF3/96Lwz1zcT4kbVWbcDlF3MJ0XhrG337j7xRLRl8aFFk5FVRvNNVLbJfL
0UTAlp/nNHZDA2LASix0jJec3pShHQ==
=Admr
-----END PGP SIGNATURE-----

--5cLub4nmsFP4gClL6A7oyyL9sRu5cEDmB--

