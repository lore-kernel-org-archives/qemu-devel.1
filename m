Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF75CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77644206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7KOd7ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77644206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0ci-0005ce-Po
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iO0TX-0004pf-RL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iO0TW-0001Xz-AU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:21:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iO0TW-0001XU-6A
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5qWhTkPXrs5VbYappQ2Y97lDG+B7Dge6u0CxH+VESGg=;
 b=V7KOd7tayHDZ0FvUpOefLgQpGct6+81NOpSSfHhIlrMJfPrYZamwa2IokyRbNfGNFlCXeU
 8N10h9Q+QQvnoghLaz9UssjICJKiUi8Oe3SYxuiB0BeeW8h4hQe+Z1390+McXjhoLwwwlj
 9kk6Bpd+arjM5GfeTeBA4zfvwRbxuTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-sHfOcmpwOsKemRfvFnmOHA-1; Fri, 25 Oct 2019 10:21:52 -0400
X-MC-Unique: sHfOcmpwOsKemRfvFnmOHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974EA1005509;
 Fri, 25 Oct 2019 14:21:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-230.ams2.redhat.com
 [10.36.117.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9839560161;
 Fri, 25 Oct 2019 14:21:46 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <CAFEAcA8Y8fGKC3DkdM+wkU5Oe6ACZMtvWjpry9qFgPJc5KYjdA@mail.gmail.com>
 <19d50c64-c07a-3122-dea3-a5d97a2d35da@redhat.com>
 <CAFEAcA-3nt69+fUCf4YysVqsWd3z8r1iuURPYAPWUdHcd41p_Q@mail.gmail.com>
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
Message-ID: <e77cacde-05ab-64c6-8f60-0222f096daf2@redhat.com>
Date: Fri, 25 Oct 2019 16:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3nt69+fUCf4YysVqsWd3z8r1iuURPYAPWUdHcd41p_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3aC9MOCt6r2YUj7Yo712cMCUyLL6QtFIC"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3aC9MOCt6r2YUj7Yo712cMCUyLL6QtFIC
Content-Type: multipart/mixed; boundary="VVSIXE89QQF5Q5VM8w7xJWqbIPyC6yDfv"

--VVSIXE89QQF5Q5VM8w7xJWqbIPyC6yDfv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.19 16:17, Peter Maydell wrote:
> On Fri, 25 Oct 2019 at 15:16, Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 25.10.19 15:46, Peter Maydell wrote:
>>> On Fri, 25 Oct 2019 at 11:09, Max Reitz <mreitz@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel drive=
r, as
>>>> I=E2=80=99ve explained here:
>>>>
>>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
>>>>
>>>> In combination with our commit c8bb23cbdbe32f, this may lead to guest
>>>> data corruption when using qcow2 images on XFS with aio=3Dnative.
>>>
>>> Have we reported that upstream to the xfs folks?
>>
>> I=E2=80=99ve created an RH BZ here:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547
>=20
> Currently "You are not authorized to access bug #1765547." for
> anonymous browsers, just fyi.

Err.  Oops.  That wasn=E2=80=99t my intention.  I hate that misfeature.

Thanks for telling me, I fixed it. :-)

Max


--VVSIXE89QQF5Q5VM8w7xJWqbIPyC6yDfv--

--3aC9MOCt6r2YUj7Yo712cMCUyLL6QtFIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2zBPgACgkQ9AfbAGHV
z0ACMQf/UA+9juzD/yXWmEwRICxYRBizaHX8E7d08uJYnwU+HB76KH/zohHUwDIF
Lrqp7pHvEdDH7RT5bHZMymvmvVS77dN6abLoLKpzdEp2X4D7FlSyIT1mQaVxUBpJ
eCjSUT7YMYmN1oGfb37mo0xEdY64dVrTv4fcu1XM1ixQbZamrwLnABp1mjAgswwS
L8bfh7/t+X5oT+A0/VcHvS87mlCY74vkiyRLr95pOxlS7xwj/ARyP4asV0GmNiN6
NzxTHhOew4HpEBKRRTMXs3Vk8u7wYMwh1nKk2lI1Qu1QQtlygka2xLHJZ1d6g5hJ
bK0tvkcyO2NdWvqohNSziitngjZdtg==
=CrHJ
-----END PGP SIGNATURE-----

--3aC9MOCt6r2YUj7Yo712cMCUyLL6QtFIC--


