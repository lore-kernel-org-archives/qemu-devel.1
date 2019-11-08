Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AFBC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7BB218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF+bfZp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7BB218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1pS-0005Ur-7p
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT1oV-0004sC-K8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT1oU-0002xq-IL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:48:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT1oU-0002vS-Ek
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573210101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CXJNbZXnGJeAEJcaKDgQLuH+GZjL6IiURNnpwwwsrtE=;
 b=YF+bfZp3IouS42r2lScrjJ9V1ok6JH61X8XlE2FONeViVgHY+9EzikequIw7B/hCYXjTpk
 rAdmIOtoNvYlXuHrzssYtb1s1g2Bc37yCEVASwPEdmljrPR1gv1K727FL+jijR9X/fBBr6
 WipYSJkVwNFyB3TWXGVYAwxdET6PqH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-4dckPBUoMYWmtLVC7b_q5w-1; Fri, 08 Nov 2019 05:48:18 -0500
X-MC-Unique: 4dckPBUoMYWmtLVC7b_q5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93BA3800C72;
 Fri,  8 Nov 2019 10:48:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D309A5D6AE;
 Fri,  8 Nov 2019 10:48:12 +0000 (UTC)
Subject: Re: [PATCH v2 02/11] qcrypto-luks: extend the create options for
 upcoming encryption key management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
 <e0e85ab0-e84b-0ee8-8467-ff11e803f7cf@redhat.com>
 <5aa3ad22b0adb236f2ff67c183121c2896e0e1da.camel@redhat.com>
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
Message-ID: <af4b3495-0b8d-e269-4190-779535526ab4@redhat.com>
Date: Fri, 8 Nov 2019 11:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5aa3ad22b0adb236f2ff67c183121c2896e0e1da.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yblPhE1TIP6GeqNa56TINDhXEtaWv1VXH"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yblPhE1TIP6GeqNa56TINDhXEtaWv1VXH
Content-Type: multipart/mixed; boundary="Bbh3KKGZPy98CDhVj4UBRTtgZA5l3xY5O"

--Bbh3KKGZPy98CDhVj4UBRTtgZA5l3xY5O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 10:28, Maxim Levitsky wrote:
> On Fri, 2019-10-04 at 19:42 +0200, Max Reitz wrote:
>> On 13.09.19 00:30, Maxim Levitsky wrote:
>>> Now you can specify which slot to put the encryption key to
>>> Plus add 'active' option which will let  user erase the key secret
>>> instead of adding it.
>>> Check that active=3Dtrue it when creating.
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  block/crypto.c             |  2 ++
>>>  block/crypto.h             | 16 +++++++++++
>>>  block/qcow2.c              |  2 ++
>>>  crypto/block-luks.c        | 26 +++++++++++++++---
>>>  qapi/crypto.json           | 19 ++++++++++++++
>>>  tests/qemu-iotests/082.out | 54 ++++++++++++++++++++++++++++++++++++++
>>>  6 files changed, 115 insertions(+), 4 deletions(-)
>>
>> (Just doing a cursory RFC-style review)
>>
>> I think we also want to reject unlock-secret if it=E2=80=99s given for c=
reation;
> Agree, I'll do this in the next version.
>=20
>> and I suppose it=E2=80=99d be more important to print which slots are OK=
 than
>> the slot the user has given.  (It isn=E2=80=99t like we shouldn=E2=80=99=
t print that
>> slot index, but it=E2=80=99s more likely the user knows that than what t=
he
>> limits are.  I think.)
> I don't really understand what you mean here :-(=20
>=20
> Since this is qmp interface,
> I can't really print anything from it, other that error messages.

Exactly, I=E2=80=99m referring to the error message.  Right now it=E2=80=99=
s:

"Invalid slot %" PRId64 " is specified", luks_opts.slot

I think it should be something like:

"Invalid slot %" PRId64 " specified, must be between 0 and %u",
luks_opt.slot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1

Max


--Bbh3KKGZPy98CDhVj4UBRTtgZA5l3xY5O--

--yblPhE1TIP6GeqNa56TINDhXEtaWv1VXH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FR+sACgkQ9AfbAGHV
z0B6owgAu7OXEgShTXqY25b/iJN6jyhgSgjeuSQzvXe2W9h+wkTFywt7HHp8O/VU
bNXesKJ3nuc/b3KoVzaHTjRvRmycFnfHpRDA9o3rmSun2p+T3F8kCdr4ol8goGzV
WdA1rePYQYp4MyZdyKVb29WFzcs7f5YTI29fcKCQR3Xq5aRuBFaf4yiQAzKu16y0
UBPHMDFtniQoEyKmCzvQm2loAftxzHYSkUDmEq0iXTmlomgYtCywvvGuPmJio2kP
EACPiifNXsRnuo3OYkkPmq1xXOB1PKUQZ2Wb1CWVvxwSEafa9/ojMpRig5dn91/y
S0frcsaNR46j09bR2WkLI8QzB6QIug==
=JeOH
-----END PGP SIGNATURE-----

--yblPhE1TIP6GeqNa56TINDhXEtaWv1VXH--


