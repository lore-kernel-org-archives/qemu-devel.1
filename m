Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEDBC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD0D217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egOXznpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD0D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNnE-0003YW-QJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izNmD-0002QK-UL
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izNmC-0003k1-TB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:43:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izNmC-0003fa-Lg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580921024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ojd1ekvCDGjIcBuiHnkCw60DuW6QaKd0dTZjG46MCNs=;
 b=egOXznpm1f30Qw+iyt59MMKLKnNkt6MilFT5CLLP7jOK6pTIiLjTWQB69AWK1DoSi6xYdM
 iLoXDjpGL1h0Ed9beVWPGsk3fvivU2zVN0YJO9Q0jeXgXh0xEltQukZKxbqzeHt5o5qBqm
 4At/zR4tXwj6cTff6wCB1pElzAGL9BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-G6mWUtdWPP-Spo1tsdaxZQ-1; Wed, 05 Feb 2020 11:43:42 -0500
X-MC-Unique: G6mWUtdWPP-Spo1tsdaxZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1813210054E3;
 Wed,  5 Feb 2020 16:43:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62FAF5D9E2;
 Wed,  5 Feb 2020 16:43:27 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
 <89497824-33be-7238-982e-bd0edb2f5d00@redhat.com>
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
Message-ID: <4ffeafb0-1dd9-720c-f6a5-9af6e95b5f62@redhat.com>
Date: Wed, 5 Feb 2020 17:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <89497824-33be-7238-982e-bd0edb2f5d00@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JOOQSVLJEpcSCmqIop45tK2ZqEUIeuVov"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JOOQSVLJEpcSCmqIop45tK2ZqEUIeuVov
Content-Type: multipart/mixed; boundary="QiVYX5FMapEiIxDDPn0pomZgNlUL6SgNe"

--QiVYX5FMapEiIxDDPn0pomZgNlUL6SgNe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 18:51, Eric Blake wrote:
> On 2/4/20 11:42 AM, Max Reitz wrote:
>=20
>>>
>>> I understand that this is preexisting logic, but could I ask: why?
>>> What's wrong
>>> if driver can guarantee that created file is all-zero, but is not sure
>>> about
>>> file resizing? I agree that it's normal for these flags to have the sam=
e
>>> value,
>>> but what is the reason for this restriction?..
>>
>> If areas added by truncation (or growth, rather) are always zero, then
>> the file can always be created with size 0 and grown from there.=C2=A0 T=
hus,
>> images where truncation adds zeroed areas will generally always be zero
>> after creation.
>>
>>> So, the only possible combination of flags, when they differs, is
>>> create=3D0 and
>>> truncate=3D1.. How is it possible?
>>
>> For preallocated qcow2 images, it depends on the storage whether they
>> are actually 0 after creation.=C2=A0 Hence qcow2_has_zero_init() then de=
fers
>> to bdrv_has_zero_init() of s->data_file->bs.
>>
>> But when you truncate them (with PREALLOC_MODE_OFF, as
>> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), t=
he new
>> area is always going to be 0, regardless of initial preallocation.
>>
>>
>> I just noticed a bug there, though: Encrypted qcow2 images will not see
>> areas added through growth as 0.=C2=A0 Hence, qcow2=E2=80=99s
>> bdrv_has_zero_init_truncate() implementation should not return true
>> unconditionally, but only for unencrypted images.
>=20
> Hence patch 5 earlier in the series :)

Ah, good. :-)

Max


--QiVYX5FMapEiIxDDPn0pomZgNlUL6SgNe--

--JOOQSVLJEpcSCmqIop45tK2ZqEUIeuVov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl468K0ACgkQ9AfbAGHV
z0A0Iwf+J2kubZG9AR1FBI3Op2al2du7vPslaz3AsxrmsqEpoqu26vaotqPsUS0D
poyyKXCiKznMYaWorVzAj+o4CY6zKCoghhoBieXINnXNUBufNt6X3UQZFxUflSC8
xAmvEZU0tJHdpp4UpXeCNvDk3jT5yW863YbOziz2jQ7jFjt3MNHTuj0L+nsUVaII
sbqwQ9QBp88t5zkrpm7oPBa2QOLcMpXlyHz5vKANpwlcwe3ZO9x2BNLviOAqUAky
G3kszBxq8epovuYLy6ZTdDFhpSL7l7OQRBXcwqgUUKVpX7Uubz82E8fkOwXbB06E
+Lwx5Z6/EA01h9vEUNGAbs0k/EUO9A==
=ZsMD
-----END PGP SIGNATURE-----

--JOOQSVLJEpcSCmqIop45tK2ZqEUIeuVov--


