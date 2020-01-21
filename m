Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D96C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33EE207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+5my4S5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33EE207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itupA-0008Rh-2K
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itu5q-0003RN-Hb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itu5m-00066C-Sw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:01:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itu5m-00065o-OU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579615278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OiJJq4WsKvw3yK58UuyRnMKC08Jsfc3onwNM6tHVgXc=;
 b=O+5my4S5/mjZbz/2BpsKGNH01hz0YYMIJQ0DQFdWuTUO2P0am1GcoEbJixBoV4P2319MCs
 Yd9eqVNv9hhBQadGVt8RT2LjrXwkiDv+jyAdLHU86kIJEOf4xbIcA9QnpAxUvQKyffJrge
 s0W7+NLX/Y9obG1byvhIz7P04KSogrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-lngNwKK1PHyG62WMjeq43w-1; Tue, 21 Jan 2020 09:01:14 -0500
X-MC-Unique: lngNwKK1PHyG62WMjeq43w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D3D100550E;
 Tue, 21 Jan 2020 14:01:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCCF1001DE1;
 Tue, 21 Jan 2020 14:01:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
 <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
 <f52b6ff5-e993-d567-cbbe-1d6d158908da@redhat.com>
 <0e865df2-7d21-b18f-b73c-2948577b9dcb@virtuozzo.com>
 <1313e55e-0eb1-890a-4e8e-2517f1e80d38@redhat.com>
 <04a32d71-31da-a3e3-5c5f-cc6465fc9402@virtuozzo.com>
 <6923bc19-d203-63af-b206-8fe18e4a01c6@redhat.com>
 <6e0c4e88-6745-a668-6946-237032fdbedd@virtuozzo.com>
 <29434a72-d2cc-5976-cbd7-ceac714d4d65@redhat.com>
 <08bc201e-b40c-a79c-6388-bd17a3a8316c@virtuozzo.com>
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
Message-ID: <d6bc8179-9a83-3ecd-2c8d-f71e1021f5d9@redhat.com>
Date: Tue, 21 Jan 2020 15:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <08bc201e-b40c-a79c-6388-bd17a3a8316c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e2nuHTFvzX5XZGAvRfGeOwebI40A4q42k"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e2nuHTFvzX5XZGAvRfGeOwebI40A4q42k
Content-Type: multipart/mixed; boundary="DUcNDpWZKEle0czoYsuP8srpBcwGUwOEv"

--DUcNDpWZKEle0czoYsuP8srpBcwGUwOEv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.20 14:55, Vladimir Sementsov-Ogievskiy wrote:
> 21.01.2020 16:51, Max Reitz wrote:
>> On 21.01.20 14:48, Vladimir Sementsov-Ogievskiy wrote:
>>> 21.01.2020 15:39, Max Reitz wrote:
>>>> On 21.01.20 11:40, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 21.01.2020 12:41, Max Reitz wrote:
>>>>>> On 21.01.20 10:23, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 21.01.2020 12:14, Max Reitz wrote:
>>>>>>>> On 20.01.20 18:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>> 20.01.2020 20:04, Max Reitz wrote:
>>>>>>>>>> On 16.01.20 16:54, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>>>> This test checks that bug is really fixed by previous commit.
>>>>>>>>>>>
>>>>>>>>>>> Cc: qemu-stable@nongnu.org # v4.2.0
>>>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuoz=
zo.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       tests/qemu-iotests/283     | 75 +++++++++++++++++++++++++=
+++++++++++++
>>>>>>>>>>>       tests/qemu-iotests/283.out |  8 ++++
>>>>>>>>>>>       tests/qemu-iotests/group   |  1 +
>>>>>>>>>>>       3 files changed, 84 insertions(+)
>>>>>>>>>>>       create mode 100644 tests/qemu-iotests/283
>>>>>>>>>>>       create mode 100644 tests/qemu-iotests/283.out
>>>>>>>>>>
>>>>>>>>>> The test looks good to me, I just have a comment nit and a note =
on the
>>>>>>>>>> fact that this should probably be queued only after Thomas=E2=80=
=99s =E2=80=9CEnable
>>>>>>>>>> more iotests during "make check-block"=E2=80=9D series.
>>>>>>>>>>
>>>>>>>>>>> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 0000000000..f0f216d109
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/tests/qemu-iotests/283
>>>>>>>>>>> @@ -0,0 +1,75 @@
>>>>>>>>>>> +#!/usr/bin/env python
>>>>>>>>>>> +#
>>>>>>>>>>> +# Test for backup-top filter permission activation failure
>>>>>>>>>>> +#
>>>>>>>>>>> +# Copyright (c) 2019 Virtuozzo International GmbH.
>>>>>>>>>>> +#
>>>>>>>>>>> +# This program is free software; you can redistribute it and/o=
r modify
>>>>>>>>>>> +# it under the terms of the GNU General Public License as publ=
ished by
>>>>>>>>>>> +# the Free Software Foundation; either version 2 of the Licens=
e, or
>>>>>>>>>>> +# (at your option) any later version.
>>>>>>>>>>> +#
>>>>>>>>>>> +# This program is distributed in the hope that it will be usef=
ul,
>>>>>>>>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty =
of
>>>>>>>>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e
>>>>>>>>>>> +# GNU General Public License for more details.
>>>>>>>>>>> +#
>>>>>>>>>>> +# You should have received a copy of the GNU General Public Li=
cense
>>>>>>>>>>> +# along with this program.  If not, see <http://www.gnu.org/li=
censes/>.
>>>>>>>>>>> +#
>>>>>>>>>>> +
>>>>>>>>>>> +import iotests
>>>>>>>>>>> +
>>>>>>>>>>> +# The test is unrelated to formats, restrict it to qcow2 to av=
oid extra runs
>>>>>>>>>>> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
>>>>>>>>>>> +
>>>>>>>>>>> +size =3D 1024 * 1024
>>>>>>>>>>> +
>>>>>>>>>>> +"""
>>>>>>>>>>> +On activation, backup-top is going to unshare write permission=
 on its
>>>>>>>>>>> +source child. It will be impossible for the following configur=
ation:
>>>>>>>>>>
>>>>>>>>>> =E2=80=9CThe following configuration will become impossible=E2=
=80=9D?
>>>>>>>>>
>>>>>>>>> Hmm, no, the configuration is possible. But "it", i.e. "unshare w=
rite permission",
>>>>>>>>> is impossible with such configuration..
>>>>>>>>
>>>>>>>> But backup_top always unshares the write permission on the source.
>>>>>>>
>>>>>>> Yes, and I just try to say, that this action will fail. And the tes=
t checks that it
>>>>>>> fails (and it crashes with current master instead of fail).
>>>>>>
>>>>>> OK.  So what I was trying to say is that the comment currently only
>>>>>> states that this will fail.  I=E2=80=99d prefer it to also reassure =
me that it=E2=80=99s
>>>>>> correct that this fails (because all writes on the backup source mus=
t go
>>>>>> through backup_top), and that this is exactly what we want to test h=
ere.
>>>>>>
>>>>>> On first reading, I was wondering why exactly this comment would tel=
l me
>>>>>> all these things, because I didn=E2=80=99t know what the test wants =
to test in
>>>>>> the first place.
>>>>>>
>>>>>> Max
>>>>>
>>>>> Hmm, something like:
>>>>>
>>>>> Backup wants to copy a point-in-time state of the source node. So, it=
 catches all writes
>>>>> to the source node by appending backup-top filter above it. So we han=
dle all changes which
>>>>> comes from source node parents. To prevent appearing of new writing p=
arents during the
>>>>> progress, backup-top unshares write permission on its source child. T=
his has additional
>>>>> implication: as this "unsharing" is propagated by default by backing/=
file children,
>>>>> backup-top conflicts with any side parents of source sub-tree with wr=
ite permission.
>>>>> And this is in good relation with the general idea: with such parents=
 we can't guarantee
>>>>> point-in-time backup.
>>>>
>>>> Works for me (thanks :-)), but a shorter =E2=80=9CWhen performing a ba=
ckup, all
>>>> writes on the source subtree must go through the backup-top filter so =
it
>>>> can copy all data to the target before it is changed.  Therefore,
>>>> backup-top cannot allow other nodes to change data on its source child=
.=E2=80=9D
>>>> would work for me just as well.
>>>>
>>>>> So, trying to backup the configuration with writing side parents of
>>>>> source sub-tree nodes should fail. Let's test it.
>>>
>>> But than, we need somehow link part about appending backup-top and so-o=
n...
>>>
>>> When performing a backup, all writes on the source subtree must go thro=
ugh the backup-top filter so it can copy all data to the target before it i=
s changed.
>>> backup-top filter is appended above source node, to achieve this thing,=
 so all parents of source node are handled.
>>> A configuration with side parents of source sub-tree with write permiss=
ion is unsupported (we'd have append several backup-top filter like nodes t=
o handle such parents).
>>> The test create an example of such configuration and checks that backup=
 fails.
>>
>> Sounds good!
>>
>> (Except maybe s/that backup fails/that a backup is then not allowed/?
>> =E2=80=9Cbackup fails=E2=80=9D might also mean that the job just produce=
s garbage.)
>=20
> OK for me. May be "backup is then not allowed (blockdev-backup command sh=
ould fail)".
>=20
> Should I resend? I think it's better drop "auto" mark and not create extr=
a dependency on other series.

I=E2=80=99d prefer a resend so I don=E2=80=99t modify the comment in a way =
you don=E2=80=99t want.

You can keep the test in auto, as I=E2=80=99ve just merged Thomas=E2=80=99s=
 series
(which was the dependency).

Max


--DUcNDpWZKEle0czoYsuP8srpBcwGUwOEv--

--e2nuHTFvzX5XZGAvRfGeOwebI40A4q42k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4nBCYACgkQ9AfbAGHV
z0Cm2ggAjqK4jZpJkVQKtY3HFyT6nNVE+p/vChWoCiWFbQgCoIJEadr5p5yPnbkE
zop+UIZxycxY0dB/sPWry2uk06JGNFxXQDJdz1vAPQVvCD95Xstp1SRKBAFtzL3f
sNyHteJdSGd+f0q3rGrAHOPvvDuxz6ldwr9q1vA/5OFrSl1Pwh5Iq2GTS0UV1obt
bHklFS14jgSqBLa2soUWYXAliI5Db0emeVcIvyVXcSedRRmoQ5j2TbNOf1Xk0LvY
eoMLol57N6BeK1HSGvTfgSYgd9U5RMO7rzcs14c0toXl8AnVVX2lefFFGGCNvT6X
nFBpBPp0zQa7XkCoCWLinMieW+OpXg==
=w2rh
-----END PGP SIGNATURE-----

--e2nuHTFvzX5XZGAvRfGeOwebI40A4q42k--


