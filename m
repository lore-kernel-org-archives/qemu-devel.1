Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004AC17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D26E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLTUDenV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D26E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCUy-0001Bk-Sb
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUCHH-0001Sy-5Y
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUCHF-0005rM-SQ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:10:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50260
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUCHF-0005rC-O5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KWwk22sWvytr6VCx3H00HBhRnULGDjawJJA39EcOVDE=;
 b=TLTUDenVkOMneghLGw5xv0P18kHVbCBQ5RRTDpjrA8fQPhgUvvNznGQOj1E4AhwUCzLfGT
 15lpywh/aHPr66gceTllaDbtdM6ClWSlLgFOJO65/UGNtVHmg5xBSplMKMLsU85NO+RQje
 aZUKJkkj5XTNHfCIXDGF7Q0XNs95uzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-8CHieidwMTaSooWrc0zVLg-1; Mon, 11 Nov 2019 11:10:51 -0500
X-MC-Unique: 8CHieidwMTaSooWrc0zVLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4824B107ACCC;
 Mon, 11 Nov 2019 16:10:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B349608FF;
 Mon, 11 Nov 2019 16:10:45 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] iotests: Skip "make check-block" if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20191022072135.11188-1-thuth@redhat.com>
 <20191022072135.11188-5-thuth@redhat.com>
 <76688061-c59d-953e-b3db-097e3f46fff0@redhat.com>
 <fcd271a6-2d90-5087-237d-f308b2367c04@redhat.com>
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
Message-ID: <6b002caa-1e53-b12f-3b67-833b87bacd51@redhat.com>
Date: Mon, 11 Nov 2019 17:10:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fcd271a6-2d90-5087-237d-f308b2367c04@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zM6j7dMVJE7j8sz4ebrFUsytZuez3hCgZ"
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zM6j7dMVJE7j8sz4ebrFUsytZuez3hCgZ
Content-Type: multipart/mixed; boundary="TNhFetbZW2FUXZvHNu3CY8vOTDSeHBkqu"

--TNhFetbZW2FUXZvHNu3CY8vOTDSeHBkqu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.11.19 15:02, Thomas Huth wrote:
> On 30/10/2019 12.21, Max Reitz wrote:
>> On 22.10.19 09:21, Thomas Huth wrote:
>>> The next patch is going to add some python-based tests to the "auto"
>>> group, and these tests require virtio-blk to work properly. Running
>>> iotests without virtio-blk likely does not make too much sense anyway,
>>> so instead of adding a check for the availability of virtio-blk to each
>>> and every test (which does not sound very appealing), let's rather add
>>> a check for this at the top level in the check-block.sh script instead
>>> (so that it is possible to run "make check" without the "check-block"
>>> part for qemu-system-tricore for example).
>>>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/check-block.sh | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>>> index 679aedec50..e9e2978818 100755
>>> --- a/tests/check-block.sh
>>> +++ b/tests/check-block.sh
>>> @@ -26,10 +26,24 @@ if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/=
dev/null ; then
>>>      exit 0
>>>  fi
>>> =20
>>> -if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
>>> +if [ -n "$QEMU_PROG" ]; then
>>> +    qemu_prog=3D"$QEMU_PROG"
>>> +else
>>> +    for binary in *-softmmu/qemu-system-* ; do
>>
>> Hm, I know I=E2=80=99ve already given my R-b, but looking at this again =
=E2=80=93 what
>> if the user builds qemu for multiple targets?  Then this will just test
>> any target, whereas the iotests might test something else, because the
>> algorithm there is slightly different:
>>
>> First, check $QEMU_PROG (same as here).
>>
>> Second, check $build_iotests/qemu.  I think we can do this here, because
>> we know that $build_iotests is $PWD/tests/qemu-iotests (or invoking
>> ./check below wouldn=E2=80=99t work).
>>
>> Third, and this is actually important, I think, is that we first look
>> for the qemu that matches the host architecture (uname -m, with an
>> exception for ppc64).  I think we really should do that here, too.
>>
>> Fourth, look for any qemu, as is done here.
>>
>> So I think we could do without #2, but it probably doesn=E2=80=99t hurt =
to check
>> that, too.  I don=E2=80=99t think we should do without #3, though.
>=20
> Maybe we should simply move the check into tests/qemu-iotests/check to
> avoid duplication of that logic?
> We could then also only simply skip the python tests instead of skipping
> everything, in case the chosen QEMU binary does not support virtio-blk.

You mean by adding a new flag e.g. -batch that=E2=80=99s supposed to genera=
lly
skip cases when in doubt that they can be run on the current host?
Sounds good to me.

Max


--TNhFetbZW2FUXZvHNu3CY8vOTDSeHBkqu--

--zM6j7dMVJE7j8sz4ebrFUsytZuez3hCgZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3JiAMACgkQ9AfbAGHV
z0BEiwgAsoueoiIW7d6XAuN2WEJgAWEKLoROypBBdFa7hNkn+WXJ2Xjr+VEvZ/e0
/wtu7EOlryq9IkiFZK5CfkTV3PSOkZqphhX/9FIKf+2STojFeLx7Tt2gVYpnZmT6
TrRNH597BLElgISjNivqzb3Ulk8lUrpI/XDbp6VtI3ML4UZcZ3uk+vOIGaBV3rZl
qc0f39o31ejnqTdCBysKYnYT7MPQumQ+RsaQY/7JIX2FjO8Fja0BiRIVw1dMo6CR
y48q9+nmrDCzyPjze/kaRvSR+Waec132RN3xC+gaOwwWLqin8iTMNPurmoFX57+v
/RFDeBOXnY9sGonulA++kXeheWzMVw==
=UEek
-----END PGP SIGNATURE-----

--zM6j7dMVJE7j8sz4ebrFUsytZuez3hCgZ--


