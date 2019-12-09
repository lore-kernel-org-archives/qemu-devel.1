Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBEC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06E32068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7PiLLb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06E32068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKrc-000867-QF
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ieKmm-0003LD-HJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ieKml-0000Xz-GF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:17:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ieKml-0000Xr-C7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575904638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TnwAA5xuFcM139Mz/syaLe5To6oPEnOlY9bKigmo+yM=;
 b=b7PiLLb5mmq9tLr9dBVluIqegC1IYlUHPGmFJKnwfy9YQ1n7feO8v5VQ1KY4L8X0bsryWJ
 /NwQWnm0PWydHzYOVneUqAiN2Mpyfoz0kJsEyxY134zq9XQhX0PFl5GUFAloTCzuF7ZPyD
 +qqqhcy+bkVGVAMUG8O6aPeHaFgd5Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-v7vCR0iHPMKXb3r8sF_qfw-1; Mon, 09 Dec 2019 10:17:14 -0500
X-MC-Unique: v7vCR0iHPMKXb3r8sF_qfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F29F1800D45;
 Mon,  9 Dec 2019 15:17:12 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC4C5D9D6;
 Mon,  9 Dec 2019 15:17:06 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 22/23] iotests: Check that @replaces can
 replace filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-23-mreitz@redhat.com>
 <c75475a4-f2ab-bd99-1c26-463c48c4d94c@virtuozzo.com>
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
Message-ID: <fabdd02a-391e-b37e-3b76-6cf3d268d52c@redhat.com>
Date: Mon, 9 Dec 2019 16:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c75475a4-f2ab-bd99-1c26-463c48c4d94c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zT6Y8UEZrJHUug0Sc4NTwbxLI2fQc3nFM"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zT6Y8UEZrJHUug0Sc4NTwbxLI2fQc3nFM
Content-Type: multipart/mixed; boundary="6fXBeBQE9dJ629Pff7TPY3ml04Fp2NcbD"

--6fXBeBQE9dJ629Pff7TPY3ml04Fp2NcbD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.12.19 16:58, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/041     | 46 ++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/041.out |  4 ++--
>>   2 files changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index ab0cb5b42f..9a00cf6f7b 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -1200,6 +1200,52 @@ class TestOrphanedSource(iotests.QMPTestCase):
>>           self.assertFalse('mirror-filter' in nodes,
>>                            'Mirror filter node did not disappear')
>>  =20
>> +# Test cases for @replaces that do not necessarily involve Quorum
>> +class TestReplaces(iotests.QMPTestCase):
>> +    # Each of these test cases needs their own block graph, so do not
>> +    # create any nodes here
>> +    def setUp(self):
>> +        self.vm =3D iotests.VM()
>> +        self.vm.launch()
>> +
>> +    def tearDown(self):
>> +        self.vm.shutdown()
>> +        for img in (test_img, target_img):
>> +            try:
>> +                os.remove(img)
>> +            except OSError:
>> +                pass
>> +
>> +    """
>> +    Check that we can replace filter nodes.
>> +    """
>=20
> PEP8 says, that doc string should appear after "def" line.
> (this applies to previous patch too)

OK.  I just noticed that in some previous patch I also left them having
single quotes, which I should fix.

Max


--6fXBeBQE9dJ629Pff7TPY3ml04Fp2NcbD--

--zT6Y8UEZrJHUug0Sc4NTwbxLI2fQc3nFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3uZXAACgkQ9AfbAGHV
z0BVwAf/UFEKXfGHxjYxDzYCxjSP1ZsuSq260doEidKWyHXc0qZkWdNJjoHwOb0N
AtMJOqm8r5Fl5/ZT2jQpY93U1LqjolmY/OG6Uaqe54MWTvP6cQeZlwGKZtu3U+cK
C7X0/8P4IhXNJwg8bJzdYMyu6q/kW293HZ7iXQ23YcPjrdZ0B1fFOejJaXAu49vJ
Z5l2e8lAd8SejGSdHyDE6H+1GZ8hRcjZNZm6nHj+66MuNhR8A4+Bz2AZO6pp/kUe
MmyK75+SQUphzd2SRos5jVYhsL9b3hXhE0WWePqqnpJ7c8BKMSA4I94Ve2apNzAw
CjZXN+ekJGIqxOjRKedw8cAIVecOFA==
=eH4+
-----END PGP SIGNATURE-----

--zT6Y8UEZrJHUug0Sc4NTwbxLI2fQc3nFM--


