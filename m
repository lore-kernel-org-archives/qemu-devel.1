Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7682087E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtNSnFo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7682087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituM8-0005nA-8s
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ittb2-0008I5-2Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ittb0-0005Un-F3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:29:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ittb0-0005Ua-BH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579613370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zoCKB7MDtAbF+Tx+cmYlY4J0EdVNcm82DpWx9e2cDLA=;
 b=NtNSnFo8S2tXrYHmHPMOyhh+BcWL/Qt+QCOmGH2SwRsJvPysE4NrEPiiEpkJmnQYtooPEv
 W7fHQUWCoZmJWvgp143wrL6XBydFBJAEv0o0+zd2JyvrMtAkTJn4j1yY2tWX99Iqh/C3S+
 vCGTouh24gp/J1N2W2AYY31nSjOfO+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-AYXDr86cOWmlwutDo4ljJg-1; Tue, 21 Jan 2020 08:29:26 -0500
X-MC-Unique: AYXDr86cOWmlwutDo4ljJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 557008017CC;
 Tue, 21 Jan 2020 13:29:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2537819757;
 Tue, 21 Jan 2020 13:29:23 +0000 (UTC)
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
 <61b2915c-01fd-65ab-a5c0-5f2e089baf60@virtuozzo.com>
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
Message-ID: <0c12e6fc-3693-0663-13a2-56362c884520@redhat.com>
Date: Tue, 21 Jan 2020 14:29:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <61b2915c-01fd-65ab-a5c0-5f2e089baf60@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GbohHTnKiyIlqoRlw1pHAj3ekaVrsJYRz"
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
--GbohHTnKiyIlqoRlw1pHAj3ekaVrsJYRz
Content-Type: multipart/mixed; boundary="afHCjAOao4nKJjnvjEstLAnsbDW7PwiOd"

--afHCjAOao4nKJjnvjEstLAnsbDW7PwiOd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.01.20 13:53, Vladimir Sementsov-Ogievskiy wrote:
> 21.01.2020 15:39, Max Reitz wrote:
>> On 21.01.20 11:40, Vladimir Sementsov-Ogievskiy wrote:
>>> 21.01.2020 12:41, Max Reitz wrote:
>>>> On 21.01.20 10:23, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 21.01.2020 12:14, Max Reitz wrote:
>>>>>> On 20.01.20 18:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 20.01.2020 20:04, Max Reitz wrote:
>>>>>>>> On 16.01.20 16:54, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>> This test checks that bug is really fixed by previous commit.
>>>>>>>>>
>>>>>>>>> Cc: qemu-stable@nongnu.org # v4.2.0
>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
.com>
>>>>>>>>> ---
>>>>>>>>>      tests/qemu-iotests/283     | 75 ++++++++++++++++++++++++++++=
++++++++++
>>>>>>>>>      tests/qemu-iotests/283.out |  8 ++++
>>>>>>>>>      tests/qemu-iotests/group   |  1 +
>>>>>>>>>      3 files changed, 84 insertions(+)
>>>>>>>>>      create mode 100644 tests/qemu-iotests/283
>>>>>>>>>      create mode 100644 tests/qemu-iotests/283.out
>>>>>>>>
>>>>>>>> The test looks good to me, I just have a comment nit and a note on=
 the
>>>>>>>> fact that this should probably be queued only after Thomas=E2=80=
=99s =E2=80=9CEnable
>>>>>>>> more iotests during "make check-block"=E2=80=9D series.
>>>>>>>>
>>>>>>>>> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
>>>>>>>>> new file mode 100644
>>>>>>>>> index 0000000000..f0f216d109
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/tests/qemu-iotests/283
>>>>>>>>> @@ -0,0 +1,75 @@
>>>>>>>>> +#!/usr/bin/env python
>>>>>>>>> +#
>>>>>>>>> +# Test for backup-top filter permission activation failure
>>>>>>>>> +#
>>>>>>>>> +# Copyright (c) 2019 Virtuozzo International GmbH.
>>>>>>>>> +#
>>>>>>>>> +# This program is free software; you can redistribute it and/or =
modify
>>>>>>>>> +# it under the terms of the GNU General Public License as publis=
hed by
>>>>>>>>> +# the Free Software Foundation; either version 2 of the License,=
 or
>>>>>>>>> +# (at your option) any later version.
>>>>>>>>> +#
>>>>>>>>> +# This program is distributed in the hope that it will be useful=
,
>>>>>>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>>>>> +# GNU General Public License for more details.
>>>>>>>>> +#
>>>>>>>>> +# You should have received a copy of the GNU General Public Lice=
nse
>>>>>>>>> +# along with this program.  If not, see <http://www.gnu.org/lice=
nses/>.
>>>>>>>>> +#
>>>>>>>>> +
>>>>>>>>> +import iotests
>>>>>>>>> +
>>>>>>>>> +# The test is unrelated to formats, restrict it to qcow2 to avoi=
d extra runs
>>>>>>>>> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
>>>>>>>>> +
>>>>>>>>> +size =3D 1024 * 1024
>>>>>>>>> +
>>>>>>>>> +"""
>>>>>>>>> +On activation, backup-top is going to unshare write permission o=
n its
>>>>>>>>> +source child. It will be impossible for the following configurat=
ion:
>>>>>>>>
>>>>>>>> =E2=80=9CThe following configuration will become impossible=E2=80=
=9D?
>>>>>>>
>>>>>>> Hmm, no, the configuration is possible. But "it", i.e. "unshare wri=
te permission",
>>>>>>> is impossible with such configuration..
>>>>>>
>>>>>> But backup_top always unshares the write permission on the source.
>>>>>
>>>>> Yes, and I just try to say, that this action will fail. And the test =
checks that it
>>>>> fails (and it crashes with current master instead of fail).
>>>>
>>>> OK.  So what I was trying to say is that the comment currently only
>>>> states that this will fail.  I=E2=80=99d prefer it to also reassure me=
 that it=E2=80=99s
>>>> correct that this fails (because all writes on the backup source must =
go
>>>> through backup_top), and that this is exactly what we want to test her=
e.
>>>>
>>>> On first reading, I was wondering why exactly this comment would tell =
me
>>>> all these things, because I didn=E2=80=99t know what the test wants to=
 test in
>>>> the first place.
>>>>
>>>> Max
>>>
>>> Hmm, something like:
>>>
>>> Backup wants to copy a point-in-time state of the source node. So, it c=
atches all writes
>>> to the source node by appending backup-top filter above it. So we handl=
e all changes which
>>> comes from source node parents. To prevent appearing of new writing par=
ents during the
>>> progress, backup-top unshares write permission on its source child. Thi=
s has additional
>>> implication: as this "unsharing" is propagated by default by backing/fi=
le children,
>>> backup-top conflicts with any side parents of source sub-tree with writ=
e permission.
>>> And this is in good relation with the general idea: with such parents w=
e can't guarantee
>>> point-in-time backup.
>>
>> Works for me (thanks :-)), but a shorter =E2=80=9CWhen performing a back=
up, all
>> writes on the source subtree must go through the backup-top filter so it
>> can copy all data to the target before it is changed.  Therefore,
>> backup-top cannot allow other nodes to change data on its source child.=
=E2=80=9D
>> would work for me just as well.
>=20
> Hmm, I don't like this "Therefore". For me the last statement
> "cannot allow" doesn't looks like a consequence of the first
> "all writes must go through", it more like rephrasing (still
> not completely equal)... So, I'll keep my wording)

I mean, you can just drop the second sentence, and then it gets even
shorter...

Max


--afHCjAOao4nKJjnvjEstLAnsbDW7PwiOd--

--GbohHTnKiyIlqoRlw1pHAj3ekaVrsJYRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4m/LIACgkQ9AfbAGHV
z0DAFQf/XOM/v56bn5aUcR9BIHuNa0z/eevBBgrPGo0rbF+Nt05WiYKc1EG5YbEk
UbwYLe7dVqeJNXlfH8ToegwXkGy0To4H4yZI8RcDjGoQkx6dPTmhdxeAclJgoXvy
vOwv6O7trp1VYHHgNb+v5l+SuK4PN7d18Fm+fiyGb17UcieBsHHN2Em9PjHjtBq5
f+nT2aGzQ6vOTuP1hlDCTbTaVzm2fCt1hzFucWl2B9mcOFBl/VuURmNOEHg98u1H
oCYRjGU48Fkmr5Q7R6sdOmEqxhNafeZLlcnZn8ngJDneN6GA0yVcZw2xNhDK6+f6
K6ffh8SjAjFPiuJjIVTDUUBEixJ99Q==
=WiNa
-----END PGP SIGNATURE-----

--GbohHTnKiyIlqoRlw1pHAj3ekaVrsJYRz--


