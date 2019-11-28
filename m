Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5950C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB112071F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvzJxl5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB112071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKnF-0001Ar-Tj
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iaKMD-00040S-Vf
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iaKM8-0001p3-3v
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:01:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iaKM4-0001i7-J3
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574949665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=imKrZIDAcl0nebVmsApMWpj6CWOw1uCyO5++70aPho0=;
 b=CvzJxl5zg0jIQBURBzUIsJbJD5gByyGfj2MtPfNIuM7jfya4aIgeyxaXPJMzv5OZd4Dm5+
 O5wg6sqJJE+nS611u54Gry71ucRc8UgPWgQrXjOavgsvo+hRgyFWcWqjyQwv6dj3oYs9VF
 od5lUo0bKiXVzneFCjdCLnRu7UW5smU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-3D96Tgx5P4CV3FL5VjOnmg-1; Thu, 28 Nov 2019 09:01:00 -0500
X-MC-Unique: 3D96Tgx5P4CV3FL5VjOnmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53AEF800D41;
 Thu, 28 Nov 2019 14:00:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-182.brq.redhat.com
 [10.40.204.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C74C600C8;
 Thu, 28 Nov 2019 14:00:57 +0000 (UTC)
Subject: Re: [PATCH for-5.0 02/31] block: Add BdrvChildRole
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191127131624.1062403-1-mreitz@redhat.com>
 <20191127131624.1062403-3-mreitz@redhat.com>
 <9d6e35ea-eed6-716a-75aa-e8f47f35b6b7@virtuozzo.com>
 <02c29aee-6f92-0648-c60a-875a3d8ca305@redhat.com>
 <7ca7fa9d-b464-7ff1-cb28-3ffb52efedb0@virtuozzo.com>
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
Message-ID: <cab438c9-3630-c236-e5a6-ccc30a606fed@redhat.com>
Date: Thu, 28 Nov 2019 15:00:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7ca7fa9d-b464-7ff1-cb28-3ffb52efedb0@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JOrfAI5HptpgXkAJtSZ57ar3JK8cjL8Qx"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JOrfAI5HptpgXkAJtSZ57ar3JK8cjL8Qx
Content-Type: multipart/mixed; boundary="ckbYbiZPGxYJS9ypxybWHQaKYVi9IxgSS"

--ckbYbiZPGxYJS9ypxybWHQaKYVi9IxgSS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.11.19 12:24, Vladimir Sementsov-Ogievskiy wrote:
> 28.11.2019 13:52, Max Reitz wrote:
>> On 28.11.19 10:31, Vladimir Sementsov-Ogievskiy wrote:
>>> 27.11.2019 16:15, Max Reitz wrote:
>>>> This enum will supplement BdrvChildClass when it comes to what role (o=
r
>>>> combination of roles) a child takes for its parent.
>>>>
>>>> Because empty enums are not allowed, let us just start with it filled.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index 38963ef203..36817d5689 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -279,6 +279,44 @@ enum {
>>>>        DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PA=
SSTHROUGH,
>>>>    };
>>>>   =20
>>>> +typedef enum BdrvChildRole {
>>>
>>> Don't you want to call it just BdrvChildFlags ?
>>> Benefits:
>>>
>>> 1. Do not intersect with old BdrvChildRole.
>>
>> Well, that doesn=E2=80=99t change the fact that the old BdrvChildRole ju=
st
>> doesn=E2=80=99t describe a role.
>>
>>> 2. I think, BDRV_CHILD_STAY_AT_NODE is not a role, but just a property =
or flag..
>>
>> I can be convinced to let STAY_AT_NODE stay a property of
>> BdrvChildClass. :-)
>=20
> or BdrvChild if we want it to be property of object, not class.

Sure, but that would then no longer concern this series, I think.  (That
is, either I make STAY_AT_NODE a BdrvChildRole in this series, or I just
don=E2=80=99t.)

Max


--ckbYbiZPGxYJS9ypxybWHQaKYVi9IxgSS--

--JOrfAI5HptpgXkAJtSZ57ar3JK8cjL8Qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3f0xgACgkQ9AfbAGHV
z0CfIAf+Im5powytEOzpofCiPZ/ONhc1mwwcbyGR2cOvciQOA0hdrOYlyvIzMiW4
eMhbUlafGRMVfqKPUj40QNIcpQbiWmHxEUrNqXWxcv4zbVwFJj7RbEfBcLLt8uGL
fXIv8puEL4FiFKhbmYJDGaDD1oDtGIh3VeKTaee4Ib5Md9woH4xRHGe2Jqdvvvyt
8x1xhiDCklmbyqVfJHyfn2bwk+ccVin4IZ1GWsKZfVipsOuka0E0Qtf3r6BrbMpU
8hzm4iEyw6Iz8KXTEHpEUKES5nfqtIaVNis28LqZmkFy9gRX08+ybbSXfyFy/bbx
6f9VES7qe0LTIYYnPAquSnmmKH/AAQ==
=qJLT
-----END PGP SIGNATURE-----

--JOrfAI5HptpgXkAJtSZ57ar3JK8cjL8Qx--


