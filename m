Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6177C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1C220737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt2+1ms+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1C220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHShL-00056S-PG
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHScM-00064A-RZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHScL-0006q5-5M
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHScL-0006pj-1Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zLTom2a4AQfN9+tiB7Whmw2GHs05P2b/m2ljhWyoc6Q=;
 b=Mt2+1ms+N5q7DXjn9H7FfISpg7L+dNOvEvI2sZ/1aPyakkLeLNrDUxtFYMTvh4zrmhFEjV
 8cCPQ36XR8tJwflkMQuyhqR5e7OJc4kGqf2rB/ChBLsv9j2yGRIxe1sy2FQJhurTfB5zn8
 u8fDXQT91Uw8kWT0JGWYQfTNkmOf060=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-P_lOMh5rO62p0Bmhe-ZvqA-1; Thu, 26 Mar 2020 09:32:09 -0400
X-MC-Unique: P_lOMh5rO62p0Bmhe-ZvqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC30C107ACC4;
 Thu, 26 Mar 2020 13:32:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4F45E001;
 Thu, 26 Mar 2020 13:32:07 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 0/4] bug fixes extracted from larger qcow2 zero
 bit work
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
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
Message-ID: <9017607c-7fa7-4f22-a424-e272edaba942@redhat.com>
Date: Thu, 26 Mar 2020 14:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324174233.1622067-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IUqdR8ubwkaCIm8YXdl9bIytpshwqRrNG"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IUqdR8ubwkaCIm8YXdl9bIytpshwqRrNG
Content-Type: multipart/mixed; boundary="Y9IXxbZJNH1GR3mykdq4mvxbmqJhwyvSe"

--Y9IXxbZJNH1GR3mykdq4mvxbmqJhwyvSe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.03.20 18:42, Eric Blake wrote:
> My proposal [1] to add an autoclear all-zero-content bit to the qcow2
> format has now stalled into 5.1 territory, but several patches in my
> initial proposal are uncontroversial and obvious bug fixes worth
> having in 5.0.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08075.html
>=20
> Eric Blake (4):
>   qcow2: Comment typo fixes
>   qcow2: List autoclear bit names in header
>   qcow2: Avoid feature name extension on small cluster size
>   sheepdog: Consistently set bdrv_has_zero_init_truncate

OK, so my only real gripe was with the question whether we could make
patch 3 decide dynamically when to include or not include the feature
name table.  There=E2=80=99s little difference in practice: Right now, we c=
ould
probably get away with including it in images with 4k clusters, then it
would automatically switch to 8k clusters minimum (which is the limit
chosen in patch 3 as-is), and at some theoretical point in the far, far
future it would switch 16k clusters minimum.

I don=E2=80=99t think anyone really cares about whether the feature name ta=
ble
is in images with 4k clusters or not, and I think we still have a couple
of decades before we the table gets too big for images with 8k clusters
(and we probably won=E2=80=99t be using qcow2 then anymore).

So tl;dr: There=E2=80=99s no practical benefit of deciding dynamically, hen=
ce
I=E2=80=99m taking this series as-is:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Thanks!

Max


--Y9IXxbZJNH1GR3mykdq4mvxbmqJhwyvSe--

--IUqdR8ubwkaCIm8YXdl9bIytpshwqRrNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl58rtUACgkQ9AfbAGHV
z0A01gf+MGZC8Ynj9wKKv1MGCmLLesXBs79p2Ndnx02l7cf6UlJVF9qikUR2GHer
UiYlaeRX6H+q090xrlGaqiHlRS9DMrWbidQF8aY7+cS4jG70kehmOxVPexakDD26
zDp2tMvPXMjHvYWbpwYnHsuqk/7TNfrkSHGTYoQvHLwCI3UlSoNQ/Ddd7/ryNww3
iAYXuxWcGHtW6MZT8aHnbz3YsNfL/colzXBUV0vNqhD62j7NMw3qcvQes5EMI+px
6Th0M365N34JoPkfTMMiT2TVWFDUYADYS2CK+NEf5WZDQGr6Na6G9wBXEtEOxPw2
qmriduGJVhkFRWauAv7GikaXaUNk4g==
=dNGS
-----END PGP SIGNATURE-----

--IUqdR8ubwkaCIm8YXdl9bIytpshwqRrNG--


