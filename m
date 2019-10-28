Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9EBCA9EC2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C630214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8z6GaRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C630214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP38x-0004gO-QJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP34y-00089M-Ss
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP2t5-0000gf-MQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:08:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP2t5-0000gT-Hz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572260918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xknq4rBmDHducxBsNrT1udUV+ODOwE7PYt+4y7weaWo=;
 b=g8z6GaRBrPI9jyNErbU6u04kFepbV8oQ1mJlw5F2YVPXGXyhKOJQXSD0vzv9rs3MqlP0u8
 jsy8Iv3n1rYv/uXZPKkvhnYG7ijBeCc0/PoZAQ4ka1z1GvoVZJoshkngdzrbDiC3fvfB0T
 0ITsETkv6w8V+keWw4jsi6xv3uoEPno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-0r0LwqIBOxmMm-JKVIpxRw-1; Mon, 28 Oct 2019 07:08:37 -0400
X-MC-Unique: 0r0LwqIBOxmMm-JKVIpxRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED9C800D5E;
 Mon, 28 Oct 2019 11:08:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 100785D6A9;
 Mon, 28 Oct 2019 11:08:31 +0000 (UTC)
Subject: Re: [PATCH 7/8] block: Pass truncate exact=true where reasonable
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-8-mreitz@redhat.com>
 <0cda25dcff5e74358c304111fd31e3c9859d1a52.camel@redhat.com>
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
Message-ID: <46620e6b-a227-8f9c-51fd-67109281d323@redhat.com>
Date: Mon, 28 Oct 2019 12:08:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0cda25dcff5e74358c304111fd31e3c9859d1a52.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YuFn4DkmQBuIUtveQKcDjosaH4Bex10Pl"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YuFn4DkmQBuIUtveQKcDjosaH4Bex10Pl
Content-Type: multipart/mixed; boundary="OQ4RVpxlE1DqCVWztvQmyaXf7VSNXgxXX"

--OQ4RVpxlE1DqCVWztvQmyaXf7VSNXgxXX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 22:52, Maxim Levitsky wrote:
> On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
>> This is a change in behavior, so all instances need a good
>> justification.  The comments added here should explain my reasoning.
>>
>> qed already had a comment that suggests it always expected
>> bdrv_truncate()/blk_truncate() to behave as if exact=3Dtrue were passed
>> (c743849bee7 came eight months before 55b949c8476), so it was simply
>> broken until now.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/parallels.c | 11 +++++++++--
>>  block/qcow2.c     |  6 +++++-
>>  block/qed.c       |  2 +-
>>  qemu-img.c        |  7 ++++++-
>>  qemu-io-cmds.c    |  7 ++++++-
>>  5 files changed, 27 insertions(+), 6 deletions(-)

[...]

>> diff --git a/block/qed.c b/block/qed.c
>> index 7c2a65af40..8005cfc305 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>> @@ -674,7 +674,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevC=
reateOptions *opts,
>>      l1_size =3D header.cluster_size * header.table_size;
>> =20
>>      /* File must start empty and grow, check truncate is supported */
> I would update the above comment, with something like
>=20
> "QED format requires the underlying file to have the exact expected lengt=
h,
> which is 0 on creation"
> Or something similar.

I=E2=80=99ll change it to:

The QED format associates file length with allocation status,
so a new file (which is empty) must have a length of 0.

Hope that=E2=80=99s OK. :-)

Max


--OQ4RVpxlE1DqCVWztvQmyaXf7VSNXgxXX--

--YuFn4DkmQBuIUtveQKcDjosaH4Bex10Pl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22zC4ACgkQ9AfbAGHV
z0BTNgf9FXX0FSHEDN4TW5aVVzO1glYNyJ1l1ecel5OkgYFKQwwNqj2WO1wTmA9h
jdLXL/kZpMhJGeGKcWRPk1hktRMCYBVdpzbwGnMPvxRtDe2+eSdB+AsoSkLuJKwx
CFJLrWFSZvRFkHQ2wdkLAQim8H/CHwVcPhUYv3m8jiZ5ZIpXi3xONB6Y9mZTf6uc
blMHIJYSRJTAafnxGu2JnJXtgFLmy7cTpYYphGLr4qCxaLeQDiOwnoiz0t9bg4NC
bdnlWMjFYAfomcZ/06uuBlcd5zu+A6XHs/0rjn9ZjQDqN1SGmUxztjMfy4WZGDro
WAsRVxuym0ipayzrjfRFR5/o/GKXBw==
=c9GZ
-----END PGP SIGNATURE-----

--YuFn4DkmQBuIUtveQKcDjosaH4Bex10Pl--


