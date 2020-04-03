Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD046C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F612073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grFCUDU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F612073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKM6A-0006Br-Jd
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jKM5K-0005ei-60
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jKM5I-0005Sx-LL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:10:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jKM5I-0005Rx-GS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585919408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qauU3fXtiJLJzZUPeVT/XrDy6WMM4+JenuqJbhfEx1U=;
 b=grFCUDU129r0LkdoopUxoYtoVMSci8uGemh44ZrxrFXmpIuanENhqLrB0oYQDn98UV3fIK
 AUYf409+BkVfFQ0di0zDvg6zsPua9IMyGkd1bYJTF+nKNgTSNlmg5UYbHRzTxOzOBSNNnV
 4O8qr+XVRjihDpZKGfVpJ7R+ullEQ+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-T9A7brYxPTCeCZ0SJQ8dcw-1; Fri, 03 Apr 2020 09:09:57 -0400
X-MC-Unique: T9A7brYxPTCeCZ0SJQ8dcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16733107ACC7;
 Fri,  3 Apr 2020 13:09:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-97.ams2.redhat.com
 [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E9F93AF;
 Fri,  3 Apr 2020 13:09:54 +0000 (UTC)
Subject: Re: [PATCH for-5.0] vpc: Don't round up already aligned BAT sizes
To: Kevin Wolf <kwolf@redhat.com>
References: <20200402093603.2369-1-kwolf@redhat.com>
 <e379efcd-58ef-c9bb-0ae8-b3435f30d141@redhat.com>
 <20200403120400.GC5336@linux.fritz.box>
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
Message-ID: <7112a410-d081-24e0-fbd2-d8739e6a84df@redhat.com>
Date: Fri, 3 Apr 2020 15:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403120400.GC5336@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ceg9A4ccInktbq10PDJSOxM4pI9zmxX3G"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ceg9A4ccInktbq10PDJSOxM4pI9zmxX3G
Content-Type: multipart/mixed; boundary="e6jOGu5SXOGqYLZgbXR7vfRhiCwBT3WnN"

--e6jOGu5SXOGqYLZgbXR7vfRhiCwBT3WnN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.04.20 14:04, Kevin Wolf wrote:
> Am 03.04.2020 um 10:55 hat Max Reitz geschrieben:
>> On 02.04.20 11:36, Kevin Wolf wrote:
>>> As reported on Launchpad, Azure apparently doesn't accept images for
>>> upload that are not both aligned to 1 MB blocks and have a BAT size tha=
t
>>> matches the image size exactly.
>>>
>>> As far as I can tell, there is no real reason why we create a BAT that
>>> is one entry longer than necessary for aligned image sizes, so change
>>> that.
>>>
>>> (Even though the condition is only mentioned as "should" in the spec an=
d
>>> previous products accepted larger BATs - but we'll try to maintain
>>> compatibility with as many of Microsoft's ever-changing interpretations
>>> of the VHD spec as possible.)
>>
>> So as far as I can tell we still don=E2=80=99t ensure that the image is =
aligned
>> to 1 MB blocks?
>>
>> Well, as long as it=E2=80=99s at least possible for the user to create v=
alid
>> images, that=E2=80=99s better.
>=20
> Yes, we still allow other image sizes because Azure is not the only
> product using VHD images, but it is the only one (to my knowledge) that
> makes this requirement.
>=20
> We're trying to stay compatible with at least three different Microsoft
> products (VirtualPC, HyperV, Azure) that all have their own
> interpretation of the spec and are inconsistent with each other.

OK, nice.  Thanks for the explanation!

Max


--e6jOGu5SXOGqYLZgbXR7vfRhiCwBT3WnN--

--Ceg9A4ccInktbq10PDJSOxM4pI9zmxX3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6HNZ8ACgkQ9AfbAGHV
z0Aolgf7BdJ2fKPLWyRMQsL53CwLk4Y8erebCrQBfgjO+4mi+DTqM0N+mQKrHEhr
sBVJvRXwrduVSJLAKKx3lj9TrTXj03VY24mvP6h31h/lKQRQphTTg0cwRuDXXd7/
qVJvtIzmIIE+35OSi8It1osjd89LH6BYfTNajwXh4tQz9MUEETsvZULGUMhEJP2N
F77FjxCdCV7ex8EXTncRbhnivgwapy8WrkL/+X9lS72tJmhCnX7tfB2CI6lBtlX+
RD+deq3/wCZH5dCd/RNHhuvSpcQTCVp0HhHX2793lue8ey6n1gxQwifJf7O1tKFo
VaD+kPTiKCM2XAvmgJsr6NOBECIkiQ==
=n1UY
-----END PGP SIGNATURE-----

--Ceg9A4ccInktbq10PDJSOxM4pI9zmxX3G--


