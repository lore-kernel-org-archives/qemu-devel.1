Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ADAC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DA22077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPinn0Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DA22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSl6B-0003Ad-Sl
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSl4O-0001Jo-AG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSl4L-0003p4-Kq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:55:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28487
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSl4L-0003ow-FT
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573145737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vWIIooAjF1E+jMN15qG+mIngKU3D5IIGt6vXO/5FULo=;
 b=HPinn0Z5FOie18JJE2ytQLjYIiZeOQT2gm7qaU8HJ+9qAxOZi3M+txHuusLsYm4zdBekYD
 yQQT+sJBTK3Gk84rUq7884bDx4s0nOIvCvF/R0PRgT1KtXyzLNQ6Pp6T/VTFHbjZ3hSqIb
 /6ks9L/3XBHmQCjiIx1F6H/7t89iyz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-MOqxbjnONyWJVlvQacRO8A-1; Thu, 07 Nov 2019 11:55:32 -0500
X-MC-Unique: MOqxbjnONyWJVlvQacRO8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B119D1005502;
 Thu,  7 Nov 2019 16:55:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-149.ams2.redhat.com
 [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EF185C299;
 Thu,  7 Nov 2019 16:55:25 +0000 (UTC)
Subject: Re: [PATCH v2 20/21] iotests: Disable data_file where it cannot be
 used
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-21-mreitz@redhat.com>
 <d6b0e876927d8e6c28d708f7ac460e48f2b24384.camel@redhat.com>
 <ec97587f-db3b-65ba-0dab-16b2c86002d0@redhat.com>
 <4505781779e0e23d2c6df6ba3e6874fe4e4a9db2.camel@redhat.com>
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
Message-ID: <ff592f78-33f6-0d39-41be-346ba0338271@redhat.com>
Date: Thu, 7 Nov 2019 17:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4505781779e0e23d2c6df6ba3e6874fe4e4a9db2.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r40O3HsFfnXJJ1yv3ePUXFFSZV1ScqRlm"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r40O3HsFfnXJJ1yv3ePUXFFSZV1ScqRlm
Content-Type: multipart/mixed; boundary="10ddQzfRqSqaF6kUnCiLHW19E3b8zANZX"

--10ddQzfRqSqaF6kUnCiLHW19E3b8zANZX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.19 16:19, Maxim Levitsky wrote:
> On Thu, 2019-11-07 at 12:36 +0100, Max Reitz wrote:
>> On 06.11.19 16:52, Maxim Levitsky wrote:
>>> On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/007 | 5 +++--
>>>>  tests/qemu-iotests/014 | 2 ++
>>>>  tests/qemu-iotests/015 | 5 +++--
>>>>  tests/qemu-iotests/026 | 5 ++++-
>>>>  tests/qemu-iotests/029 | 5 +++--
>>>>  tests/qemu-iotests/031 | 6 +++---
>>>>  tests/qemu-iotests/036 | 5 +++--
>>>>  tests/qemu-iotests/039 | 3 +++
>>>>  tests/qemu-iotests/046 | 2 ++
>>>>  tests/qemu-iotests/048 | 2 ++
>>>>  tests/qemu-iotests/051 | 5 +++--
>>>>  tests/qemu-iotests/058 | 5 +++--
>>>>  tests/qemu-iotests/060 | 6 ++++--
>>>>  tests/qemu-iotests/061 | 6 ++++--
>>>>  tests/qemu-iotests/062 | 2 +-
>>>>  tests/qemu-iotests/066 | 2 +-
>>>>  tests/qemu-iotests/067 | 6 ++++--
>>>>  tests/qemu-iotests/068 | 5 +++--
>>>>  tests/qemu-iotests/071 | 3 +++
>>>>  tests/qemu-iotests/073 | 2 ++
>>>>  tests/qemu-iotests/074 | 2 ++
>>>>  tests/qemu-iotests/080 | 5 +++--
>>>>  tests/qemu-iotests/090 | 2 ++
>>>>  tests/qemu-iotests/098 | 6 ++++--
>>>>  tests/qemu-iotests/099 | 3 ++-
>>>>  tests/qemu-iotests/103 | 5 +++--
>>>>  tests/qemu-iotests/108 | 6 ++++--
>>>>  tests/qemu-iotests/112 | 5 +++--
>>>>  tests/qemu-iotests/114 | 2 ++
>>>>  tests/qemu-iotests/121 | 3 +++
>>>>  tests/qemu-iotests/138 | 2 ++
>>>>  tests/qemu-iotests/156 | 2 ++
>>>>  tests/qemu-iotests/176 | 7 +++++--
>>>>  tests/qemu-iotests/191 | 2 ++
>>>>  tests/qemu-iotests/201 | 6 +++---
>>>>  tests/qemu-iotests/214 | 3 ++-
>>>>  tests/qemu-iotests/217 | 3 ++-
>>>>  tests/qemu-iotests/220 | 5 +++--
>>>>  tests/qemu-iotests/243 | 6 ++++--
>>>>  tests/qemu-iotests/244 | 5 +++--
>>>>  tests/qemu-iotests/250 | 2 ++
>>>>  tests/qemu-iotests/267 | 5 +++--
>>>>  42 files changed, 117 insertions(+), 52 deletions(-)
>>
>> [...]
>>
>>>> diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
>>>> index c44fcf91bb..646ecd593f 100755
>>>> --- a/tests/qemu-iotests/031
>>>> +++ b/tests/qemu-iotests/031
>>>> @@ -40,9 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  # This tests qcow2-specific low-level functionality
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>> -# We want to test compat=3D0.10, which does not support refcount widt=
hs
>>>> -# other than 16
>>>> -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
>>>> +# We want to test compat=3D0.10, which does not support external data
>>>> +# files or refcount widths other than 16
>>>> +_unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\=
)'
>>>
>>> This is maybe another reason to split this test for compat=3D0.10 and f=
or compat=3D1.1
>>> But still can be done later of course.
>>
>> Hm, but I don=E2=80=99t really think this test is important for external=
 data
>> files.  There is no I/O.
> I guess both yes and no, the external data file is a header extension as =
well.

Yes, but the test already involves a header extension.

>>>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>>>> index bbaf0ef45b..512598421c 100755
>>>> --- a/tests/qemu-iotests/036
>>>> +++ b/tests/qemu-iotests/036
>>>> @@ -43,8 +43,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  # This tests qcow2-specific low-level functionality
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>> -# Only qcow2v3 and later supports feature bits
>>>> -_unsupported_imgopts 'compat=3D0.10'
>>>> +# Only qcow2v3 and later supports feature bits;
>>>> +# qcow2.py does not support external data files
>>>
>>> Minor nitpick, maybe tag this with TODO or so. No need to do now.
>>
>> Hm, well, and the same applies here.  (Just not a very important test.)
> Same here, in theory external data file is a feature, and it could
> 'interact' with other features, but most likely you are right here as wel=
l.

Well, but the test currently doesn=E2=80=99t involve any known feature bits=
.
It=E2=80=99s mostly about checking what our qcow2 driver does with unknown
feature bits.

(If it wanted to involve known feature bits, it could have easily used
e.g. the dirty feature.)

>>>> diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
>>>> index a8feb76184..2af6b74b41 100755
>>>> --- a/tests/qemu-iotests/048
>>>> +++ b/tests/qemu-iotests/048
>>>> @@ -49,6 +49,8 @@ _compare()
>>>>  _supported_fmt raw qcow2 qed luks
>>>>  _supported_proto file
>>>>  _supported_os Linux
>>>> +# Using 'cp' is incompatible with external data files
>>>> +_unsupported_imgopts data_file
>>>
>>> You could compare the external files instead in theory *I think*.
>>> Another item on some TODO list I guess.
>>
>> This is a test of qemu-img compare, not of the image format.  So it
>> doesn=E2=80=99t make much sense to me to compare the external files, and=
 also it
>> should be completely sufficient to run this test only without external
>> data files.
> Yes but on the other hand, its is kind of nice to test that it can compar=
e correctly
> two qcow2 files which have external data files attached.

But then we need to compare the qcow2 files themselves, and that doesn=E2=
=80=99t
work precisely because of the cp.

(I suppose we could work around it by sprinkling a dose of option
parsing, qemu-img amend, etc. on it, but I don=E2=80=99t see the point.)

>>>> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
>>>> index 9cd1d60d45..0053bad46a 100755
>>>> --- a/tests/qemu-iotests/051
>>>> +++ b/tests/qemu-iotests/051
>>>> @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>>  # A compat=3D0.10 image is created in this test which does not suppor=
t anything
>>>> -# other than refcount_bits=3D16
>>>
>>> Here also the compat=3D0.10 image is only a small part of the test,
>>> although it seems to get used later in the rest of the test,
>>>
>>> so the test I think should be split so that rest of the test could run =
in all
>>> configurations.=20
>>
>> This too isn=E2=80=99t an image format test (specifically, there=E2=80=
=99s no I/O but
>> for the snapshotting test, which mostly uses a different image anyway),
>> so I don=E2=80=99t think it=E2=80=99s necessary to allow this test for d=
ata_file.
> Same here, I agree but still what if there is some interaction between ba=
cking
> file and data file?

I=E2=80=99d suspect 244 is the better place to put such tests.

>>>> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
>>>> index 92243c2edd..8ad0d7a904 100755
>>>> --- a/tests/qemu-iotests/060
>>>> +++ b/tests/qemu-iotests/060
>>>> @@ -48,8 +48,10 @@ _filter_io_error()
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>>  _supported_os Linux
>>>> -# These tests only work for compat=3D1.1 images with refcount_bits=3D=
16
>>>> -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]=
\|$\)\)'
>>>> +# These tests only work for compat=3D1.1 images without an external
>>>> +# data file with refcount_bits=3D16
>>>
>>> Yea, with all hardcoded offsets, that isn't going to work.
>>
>> This isn=E2=80=99t about hardcoded offsets, it=E2=80=99s about the fact =
that the test
>> references data cluster that are part of the qcow2 file (i.e., not in an
>> external file).
> That true too! In theory, the test could have asked the qcow2 image
> where the data clusters are instead.

That isn=E2=80=99t what I mean.  This test lets a data cluster point into t=
he
refcount structure; with an external data file, it wouldn=E2=80=99t actuall=
y
point into the metadata, because all data clusters must be in the
external file, so there=E2=80=99s no corruption then.

[...]

>>>> diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
>>>> index b1ecafb41e..a3d13c414e 100755
>>>> --- a/tests/qemu-iotests/080
>>>> +++ b/tests/qemu-iotests/080
>>>> @@ -40,9 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>>  _supported_os Linux
>>>> -# - Internal snapshots are (currently) impossible with refcount_bits=
=3D1
>>>> +# - Internal snapshots are (currently) impossible with refcount_bits=
=3D1,
>>>> +#   and generally impossible with external data files
>>>>  # - This is generally a test for compat=3D1.1 images
>>>> -_unsupported_imgopts 'refcount_bits=3D1[^0-9]' 'compat=3D0.10'
>>>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file 'compat=3D0.=
10'
>>>
>>> I would more say that the test is too hardcoded for more that exact
>>> settings it expects. It is all right in this case IMHO.
>>> ACK.
>>
>> I suppose we=E2=80=99d want a different test for data file validation, i=
f
>> anything, but I don=E2=80=99t think there is anything to validate there.=
..
>>
> Well the external data file as I understand is an extension on its own,
> so in theory if you put some garbage there, it could reveal some bugs.
> What if for example data file points to the same qcow2 file?
> (or points through a symlink?)

To my knowledge, we=E2=80=99ve kind of given up on detecting loops because =
you
can always make one if you really want to...

> or it is NULL, or whatever.
> The test for example tests for 'Invalid backing file size'
> I guess that is what you mean here.

Well, in any case it=E2=80=99d be something for a completely new test case.

>>>> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
>>>> index 700068b328..1e29d96b3d 100755
>>>> --- a/tests/qemu-iotests/098
>>>> +++ b/tests/qemu-iotests/098
>>>> @@ -40,8 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> =20
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>> -# The code path we want to test here only works for compat=3D1.1 imag=
es
>>>> -_unsupported_imgopts 'compat=3D0.10'
>>>> +# The code path we want to test here only works for compat=3D1.1 imag=
es;
>>>> +# blkdebug can only inject errors on bs->file, so external data files
>>>> +# do not work with this test
>>>> +_unsupported_imgopts 'compat=3D0.10' data_file
>>>
>>> ACK, but this is already 3rd test we loose. Maybe add to a TODO to exte=
nd blkdebug
>>> to access data file as well.
>>
>> That won=E2=80=99t work, though.  The problem is that in the block graph=
,
>> blkdebug just exists between the format and the file node.  You=E2=80=99=
d need a
>> second instance above the external data file node, but then those
>> instances wouldn=E2=80=99t share data, and qcow2 only issues blkdebug ev=
ents to
>> the file node.
>>
>> One could make qcow2 duplicate all events to the data file, but then you
>> still wouldn=E2=80=99t share the same state in both instances.
>>
>> In all, it would just be a mess.
>=20
> I agree. That is more or less what I suspected.
> In theory you could make single blkdebug instance have 2 inputs and 2 out=
puts
> so it could filter both IO channels.

This wouldn=E2=80=99t work because no node is supposed to know its parents.=
  So
it can=E2=80=99t distinguish between the two =E2=80=9Coutputs=E2=80=9D.

We=E2=80=99d need a shared state somewhere and then two different blkdebug
instances that access it with some runtime option to tell each one what
it=E2=80=99s supposed to do.  But that=E2=80=99s what I mean by =E2=80=9Cme=
ss=E2=80=9D. :-)

> Interesting how we deal with backing files,
> since even without data file the qcow2 driver accesses two block devices,=
 and
> with data file it can access 3.

We simply never inject errors on the backing file. (AFAIK)

[...]

>>>> diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
>>>> index 3f27db71f2..5559df63a5 100755
>>>> --- a/tests/qemu-iotests/156
>>>> +++ b/tests/qemu-iotests/156
>>>> @@ -51,6 +51,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>  _supported_fmt qcow2 qed
>>>>  _supported_proto generic
>>>>  _unsupported_proto vxhs
>>>> +# Copying files around with cp does not work with external data files
>>>> +_unsupported_imgopts data_file
>>>
>>> Another place to fix later I guess.
>>
>> I don=E2=80=99t know, this type of storage migration simply doesn=E2=80=
=99t work this
>> way with external data files.
> I am curios why? The test seems only to use external snapshots, so why it
> would be different, other that copying the external files.

One would also need to adjust the qcow2 file to point to the copied data
file.

> I want to note again, that I noted all the tests just in case,
> most if not all of them probably indeed are best to be
> blacklisted for external files.

Yep, and it=E2=80=99s definitely good to have a kind of external perspectiv=
e on
it. :-)

Max


--10ddQzfRqSqaF6kUnCiLHW19E3b8zANZX--

--r40O3HsFfnXJJ1yv3ePUXFFSZV1ScqRlm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ETHwACgkQ9AfbAGHV
z0C4cAf9GWk2tzCS+N7IpQD/I6RQZUfOIeOnbRlBvuMLDw7Q5nvyDS0nCqJfeWwj
mKJxMQRPp67YKSYONUa80CAHEUhQRXI8whpYYd07sL5ZCk0YjWtjOhTo6QZVNURu
ClWOm9ksaKw+VWhvPb/h0qc7BIxxPVfw5NryBiYU3OB03JJgea409sDp2PqzXLJf
3pCrGbt9ZjC+DmNS6mGJKKYhefJEZVRdX0QEn5smr6U1OEa5RE90TvmGig1z+rAi
jg3mIwtX10NDdPZO28A7P2qug8ptuETD8vqyhgKebKBlqsAXvD1DEf0jrPMkwpHD
BQ+HXqzd9E/EObGt2pINa7JKh6p3cA==
=6oap
-----END PGP SIGNATURE-----

--r40O3HsFfnXJJ1yv3ePUXFFSZV1ScqRlm--


