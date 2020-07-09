Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB2FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5206F2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyRXd5Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5206F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtRo7-0000Yf-Ju
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtRmx-00087a-0V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:20:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtRmt-0006o9-OJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594282809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JTidOwynI+vP4x9pUqGa9OoYUwqFACJw3ILv9THAIT0=;
 b=gyRXd5Y35JfY3NovqilCEQ7hXVt5Bs+Q0w2KziWJmrMSAcJTNo+v+dn67ccSytgUn3Gdk7
 BmNiD/mEiKiJa1WHj/bnM5PO55oFGraaz+bMvQFwvIyYDHpo1hUfsCV6MP3RPCeSvxnqB7
 F188hAEUvAU1FEDopHNVoF4sXPCwqas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-iEeql080OvSqqGgr0s6W7A-1; Thu, 09 Jul 2020 04:19:49 -0400
X-MC-Unique: iEeql080OvSqqGgr0s6W7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B3B588C79C;
 Thu,  9 Jul 2020 08:19:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 351B81002388;
 Thu,  9 Jul 2020 08:19:44 +0000 (UTC)
Subject: Re: [PATCH v7 00/47] block: Deal with filters
To: Eric Blake <eblake@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <4d7fa326-ef87-5753-cc2a-bb26fc555864@virtuozzo.com>
 <e51d9c26-bd94-bf8e-cfed-82db15243188@redhat.com>
 <54c4b18b-b6ee-b506-b153-b44eb3879da2@virtuozzo.com>
 <d866ace7-09c9-430e-53f8-ecf12d08b0a4@redhat.com>
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
Message-ID: <cc37e07b-e350-faeb-e2b0-75dde7e98a96@redhat.com>
Date: Thu, 9 Jul 2020 10:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d866ace7-09c9-430e-53f8-ecf12d08b0a4@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m7MJ6UcOKGWXFmEij9lqQpsSjMHIrZXn4"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
--m7MJ6UcOKGWXFmEij9lqQpsSjMHIrZXn4
Content-Type: multipart/mixed; boundary="ceQYSWe2Epe1EE1T7ehX1mmMhcWt4dJta"

--ceQYSWe2Epe1EE1T7ehX1mmMhcWt4dJta
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.20 22:37, Eric Blake wrote:
> On 7/8/20 2:46 PM, Andrey Shinkevich wrote:
>>
>> On 08.07.2020 20:32, Eric Blake wrote:
>>> On 7/8/20 12:20 PM, Andrey Shinkevich wrote:
>>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>>> v6:
>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.htm=
l
>>>>>
>>>>> Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
>>>>> Branch: https://git.xanclic.moe/XanClic/qemu.git
>>>>> child-access-functions-v7
>>>>>
>>>>>
>>>> I cloned the branch from the github and built successfully.
>>>>
>>>> Running the iotests reports multiple errors of such a kind:
>>>>
>>>> 128: readarray -td '' formatting_line < <(sed -e 's/, fmt=3D/\x0/')
>>>>
>>>> "./common.filter: line 128: readarray: -d: invalid option"
>>>>
>>>
>>> Arrgh. If I'm reading bash's changelog correctly, readarray -d was
>>> introduced in bash 4.4, so I'm guessing you're still on 4.3 or
>>> earlier? What bash version and platform are you using?
>>>
>> My bash version is 4.2.46.
>>
>> It is the latest in the virtuozzolinux-base repository. I should
>> install the 4.4 package manually.
>=20
> Well, if bash 4.2 is the default installed version on any of our
> platforms that meet our supported criteria, then we should instead fix
> the patch in question to avoid non-portable use of readarray.
>=20
> Per https://repology.org/project/bash/versions (hinted from
> docs/system/build-platforms.rst), at least CentOS 7 still ships bash
> 4.2, and per 'make docker', centos7 is still a viable build target.=C2=A0=
 So
> we do indeed need to fix our regression.

There is no regression.  It=E2=80=99s just that I based this series on an
earlier version of =E2=80=9CMake _filter_img_create more active=E2=80=9D =
=E2=80=93 when I sent a
pull request for that version, Peter already reported to me that it
failed on some test environments, so I revised it.

You=E2=80=99ll find there is no a7399eb in master; it=E2=80=99s 57ee95ed4ee=
 there and
doesn=E2=80=99t use -d.

(My branch on github/gitea is still based on that older version, though,
because that=E2=80=99s what I wrote it on.)

Max


--ceQYSWe2Epe1EE1T7ehX1mmMhcWt4dJta--

--m7MJ6UcOKGWXFmEij9lqQpsSjMHIrZXn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8G0x4ACgkQ9AfbAGHV
z0B2LwgAg73D3u8x9WhvsDQIYCuj9kDtE5/4WrytQZ9SMRN4p0mB5gpV3BiIXo73
ZR28da5HnoviXfQiAgSQDrIPclVbr7F1rgO89tVWpqFaYJ9XsCaEqkRynGyl9vQb
/gar0N0MkBDFZGFThIiVkXcSmPIpM7/9wJv0rIhCO+byV22S+Ve/E0PkR88mYX16
jVSVh6uSbgxz4paCeF2Luq0BVl/zR+uUXx+hMaXSU2vEF1FrrgV95bg/uhWpdGAu
+NWSvv8ru77+pKT31zG5G6CXaQSGOVjw3nsl+NSUXy2+5shrsnc2W4XvqmfuKVBl
weo9aWvwGhDW/7IsgFGO3Uk6bgDBFw==
=lPAV
-----END PGP SIGNATURE-----

--m7MJ6UcOKGWXFmEij9lqQpsSjMHIrZXn4--


