Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FCC208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax4lZNQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FCC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqPp-0007Th-Dz
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqPA-0006s0-Q1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:25:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqP6-0003BA-7R
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595330747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H/e2bX4W9LJ88LsS/9V9V7T27zXN47ptxI/TTkoKkdQ=;
 b=Ax4lZNQwmOMm4/mFXiiuzu4y4kkiXqm2X7e7f/2nEAg12Blh0kvHu1JV5T/kn3wkyIm29d
 A834FaTVilxpSUB6smSi+FwDnR7uqbW3wgQ5EXfVpkAFNIlkNloMW+tMe0PDnIwd3HOifp
 5bgrrgyQl9yx/aSGPft3V23lpzMoJro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-htJlJyzkPIKqqRhWVUgs0Q-1; Tue, 21 Jul 2020 07:25:45 -0400
X-MC-Unique: htJlJyzkPIKqqRhWVUgs0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E478017FB;
 Tue, 21 Jul 2020 11:25:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E9A5D9CA;
 Tue, 21 Jul 2020 11:25:43 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/2] iotests: Test sparseness for qemu-img convert
 -n
To: Kevin Wolf <kwolf@redhat.com>
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-3-kwolf@redhat.com>
 <4197f423-6501-b7d4-9214-6c7979d77bd7@redhat.com>
 <20200721112028.GA18481@linux.fritz.box>
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
Message-ID: <00954f0b-10e0-cae9-3f9c-66d79a38fb3f@redhat.com>
Date: Tue, 21 Jul 2020 13:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721112028.GA18481@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XbBS1nPxUgkJqzInYv1zmGaO22myWN3jm"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XbBS1nPxUgkJqzInYv1zmGaO22myWN3jm
Content-Type: multipart/mixed; boundary="XDHKHlkzoaOLL5BXKoDWTz9iHMlW83FDt"

--XDHKHlkzoaOLL5BXKoDWTz9iHMlW83FDt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.07.20 13:20, Kevin Wolf wrote:
> Am 21.07.2020 um 12:19 hat Max Reitz geschrieben:
>> On 20.07.20 15:18, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/122     | 34 ++++++++++++++++++++++++++++++++++
>>>  tests/qemu-iotests/122.out | 17 +++++++++++++++++
>>>  2 files changed, 51 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
>>> index dfd1cd05d6..1112fc0730 100755
>>> --- a/tests/qemu-iotests/122
>>> +++ b/tests/qemu-iotests/122
>>> @@ -281,6 +281,40 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST=
_IMG".orig
>>> =20
>>>  $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
>>> =20
>>> +echo
>>> +echo '=3D=3D=3D -n to an empty image =3D=3D=3D'
>>> +echo
>>> +
>>> +_make_test_img 64M
>>> +
>>> +# Convert with -n, which should not result in a fully allocated image,=
 not even
>>> +# with compat=3D0.10 (because the target doesn't have a backing file)
>>> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D1.1 64M
>>> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
>>> +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
>>> +
>>> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D0.10 64M
>>
>> It=E2=80=99s a shame that with this, the test will no longer pass with
>> refcount_bits=3D1.  (Or an external data file.)
>=20
> You mean because of the compat=3D0.10? We already use that in this test
> case, however just with "$QEMU_IMG convert" so that $IMGOPTS doesn't
> apply.
>=20
> I guess I could just override $IMGOPTS for this line to get the same
> behaviour here and make sure that none of these options are used.

Well... Not my favorite, but probably because I just never thought of that.

I suppose it works, so why not, actually.

Max


--XDHKHlkzoaOLL5BXKoDWTz9iHMlW83FDt--

--XbBS1nPxUgkJqzInYv1zmGaO22myWN3jm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8W0LUACgkQ9AfbAGHV
z0C8Wgf+P435RJSFeku4M5Ir4pbf87fK38ZHwHSNmXTnbiqoDxzwUkyfqzAEGaY8
Mxq3QcS1duLSCeMA//7BVvOcjNdP8jmAFmSc/tsJFLGBUAHTIN52mAzpA++7+8EN
UN3rgXKSOsaO8VpngM1nhY7bn3i+twsO+xqhkvcCJCE3VR4d5iR5x2V4e1OOAFq3
pEuTfQk9VNdPmm7Fe5Cx0Pz/DkKqWTQfDtAvvoYCVAolkMWjWXS9OL2Sr81gPFc1
Z3Mra7zMJ6WgfwYOIkSutoDPs+FzET0yab1kSy5QQ1sFSIIyKfdxF6YEkd7UIEjg
gwq0hfYQruZU3qaoHj3OCWLdKxeEiA==
=hUOL
-----END PGP SIGNATURE-----

--XbBS1nPxUgkJqzInYv1zmGaO22myWN3jm--


