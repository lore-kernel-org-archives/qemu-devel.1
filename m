Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AEFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1952920708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOlkUyE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1952920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvxG-0004C1-8T
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuvwa-0003IB-JA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuvwZ-000816-9h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:12:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuvwZ-0007zp-5M
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mRrbhqoeBAid/aZiD/t+WwIZAl30+SxUEYrZez2g1Go=;
 b=aOlkUyE0sxS3kLKOgIxX5mv6EAcTMv0v6MZbDJ68ceNSB8tHngL5pAPFcOH1X5r4F5RM+Q
 +DJnDayQoeUoJo7zfhTTHlaOI/tl1AFFQB9RHlt9R/ozZmQRLZQv4xXP+h3/ZoVCm655gN
 7HsSrmAbA5UjC8v+m00XPCDCsk62P2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-syCDQ5UoM_2AbJSGNwgHOw-1; Fri, 24 Jan 2020 05:12:00 -0500
X-MC-Unique: syCDQ5UoM_2AbJSGNwgHOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEBF6DB61;
 Fri, 24 Jan 2020 10:11:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-30.ams2.redhat.com
 [10.36.117.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD3B5DAA0;
 Fri, 24 Jan 2020 10:11:57 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Add --target-is-zero to convert
To: David Edmondson <dme@dme.org>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <id:m21rryz8al.fsf@dme.org>
 <20200117103434.1363985-1-david.edmondson@oracle.com>
 <38073ceb-922e-b0fb-0c20-05fb4831e9a8@redhat.com> <m2muaev03e.fsf@dme.org>
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
Message-ID: <6e4d1ae5-31f6-ad61-4d71-99e07204b082@redhat.com>
Date: Fri, 24 Jan 2020 11:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <m2muaev03e.fsf@dme.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NlBHHIqY4utRljJmvm7lpizysCh9HOcFP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NlBHHIqY4utRljJmvm7lpizysCh9HOcFP
Content-Type: multipart/mixed; boundary="aJHlKptKD7bK57PqnPhrdj5cUSQTTrj2t"

--aJHlKptKD7bK57PqnPhrdj5cUSQTTrj2t
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.01.20 13:17, David Edmondson wrote:
> On Tuesday, 2020-01-21 at 16:02:16 +01, Max Reitz wrote:
>=20
>> Hi,
>>
>> On 17.01.20 11:34, David Edmondson wrote:

[...]

>>> +
>>> +    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
>>> +        !s->target_has_backing) {
>>
>> (This will be irrelevant after target_has_backing is gone, but because
>> has_zero_init and target_has_backing are equivalent here, there is no
>> need to check both.)
>=20
> I don't understand this comment - I must be missing something.

Just the fact that for some reason I read =E2=80=9Ctarget_has_backing=E2=80=
=9D as
=E2=80=9Ctarget_is_zero=E2=80=9D.  Sorry for the false alarm. O:-)

Max


--aJHlKptKD7bK57PqnPhrdj5cUSQTTrj2t--

--NlBHHIqY4utRljJmvm7lpizysCh9HOcFP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4qwusACgkQ9AfbAGHV
z0A4PQgAnuhJaAdtWG924Gtk3qaPBgz9ySrJwEHA7fHOUCHjc/CPE9gajxY7g+QL
nT3vlV+I0li+Oc90EfjVcKRkownscXJgejaEDA+vQojW1rj3UzbyPLVgahgcghpR
PhKP1CH8n9ydkUgKeJRaJ1ZEqX5Np3/39Jww+h39bcHJ2sGFbkvhATlkFT3S1Fhs
j4Iq5G0ssFcxiCHOIGStinCe+9ZTtTty6D0ruvUlS8BWJfnSA0e7zCthP0KlzRyR
5F+bSjchMRhTCZaDmBz66gxf5FIeiZ9TwwdMN0JuTaHW4hG4KFMIg11UabCU178/
HtahLrDyAY1Tq16OQWNWgLFNYfE5Ig==
=zH+8
-----END PGP SIGNATURE-----

--NlBHHIqY4utRljJmvm7lpizysCh9HOcFP--


