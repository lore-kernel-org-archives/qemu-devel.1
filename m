Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020A2FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A692085B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVjbXEy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A692085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT45f-0003CN-P5
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT44F-0001pC-Vn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT44E-0001Yr-Oq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:12:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT44E-0001YT-Jn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573218766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KJ0CKYIUQpWwH8i4ZPOQtmCcyAdv0E09dsd/TbAbFYM=;
 b=NVjbXEy0nHMxvDJ+arzSpcU1NcO1IPrJDxSRzpiy0hKexcz6pCoOvhXMSvGzACFfjaSRvU
 QR13TabFL67Oldu2HQ8WWexhpusnXbChMPYCuE3heBhgqSVtdYFr5B3UpdDrbn0IovzrHW
 aB4xSuiRcl2lhh0DOxLmFeTEVUVf7d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-xE81yOo-Pu21ON5WjIKZLA-1; Fri, 08 Nov 2019 08:12:43 -0500
X-MC-Unique: xE81yOo-Pu21ON5WjIKZLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52960477;
 Fri,  8 Nov 2019 13:12:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1632B194B2;
 Fri,  8 Nov 2019 13:12:37 +0000 (UTC)
Subject: Re: [PATCH v2 05/11] block/crypto: implement the encryption key
 management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-6-mlevitsk@redhat.com>
 <bcc8844d-ec0f-93d1-209b-7b7af4f2c24a@redhat.com>
 <afdbbabe3a81e69b0699bca9f69112c317a5ebdc.camel@redhat.com>
 <05065ed2-6b42-ccae-64d9-4960885a7b8f@redhat.com>
 <248adc2a05942db73a310a7d3a0339345f4628a5.camel@redhat.com>
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
Message-ID: <3b5ab7e8-2f74-1dcb-535f-1c1ba8ada09b@redhat.com>
Date: Fri, 8 Nov 2019 14:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <248adc2a05942db73a310a7d3a0339345f4628a5.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XuVyZCNvF1UM7iCzXNzYi41kUgtuEzu9T"
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
--XuVyZCNvF1UM7iCzXNzYi41kUgtuEzu9T
Content-Type: multipart/mixed; boundary="leOZtHj2Rnv3XcUwXocbRKvmWeEtUwmWa"

--leOZtHj2Rnv3XcUwXocbRKvmWeEtUwmWa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 12:04, Maxim Levitsky wrote:
> On Fri, 2019-11-08 at 11:49 +0100, Max Reitz wrote:
>> On 08.11.19 10:30, Maxim Levitsky wrote:
>>> On Fri, 2019-10-04 at 20:41 +0200, Max Reitz wrote:
>>>> On 13.09.19 00:30, Maxim Levitsky wrote:
>>>>> This implements the encryption key management
>>>>> using the generic code in qcrypto layer
>>>>> (currently only for qemu-img amend)
>>>>>
>>>>> This code adds another 'write_func' because the initialization
>>>>> write_func works directly on the underlying file,
>>>>> because during the creation, there is no open instance
>>>>> of the luks driver, but during regular use, we have it,
>>>>> and should use it instead.
>>>>>
>>>>>
>>>>> This commit also adds a=09'hack/workaround' I and=09Kevin Wolf (thank=
s)
>>>>> made to=09make the driver=09still support write sharing,
>>>>> but be safe against concurrent  metadata update (the keys)
>>>>> Eventually write sharing for luks driver will be deprecated
>>>>> and removed together with this hack.
>>>>>
>>>>> The hack is that we ask=09(as a format driver) for
>>>>> BLK_PERM_CONSISTENT_READ always
>>>>> (technically always unless opened with BDRV_O_NO_IO)
>>>>>
>>>>> and then when we want to update=09the keys, we
>>>>> unshare=09that permission. So if someone else
>>>>> has the=09image open, even readonly, this=09will fail.
>>>>>
>>>>> Also thanks to Daniel Berrange for the variant of
>>>>> that hack that involves=09asking for read,
>>>>> rather that write permission
>>>>>
>>>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>>>> ---
>>>>>  block/crypto.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++=
--
>>>>>  1 file changed, 115 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/block/crypto.c b/block/crypto.c
>>>>> index a6a3e1f1d8..f42fa057e6 100644
>>>>> --- a/block/crypto.c
>>>>> +++ b/block/crypto.c
>>>>> @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
>>>>> =20
>>>>>  struct BlockCrypto {
>>>>>      QCryptoBlock *block;
>>>>> +    bool updating_keys;
>>>>>  };
>>>>> =20
>>>>> =20
>>>>> @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock=
 *block,
>>>>>      return ret;
>>>>>  }
>>>>> =20
>>>>> +static ssize_t block_crypto_write_func(QCryptoBlock *block,
>>>>> +                                       size_t offset,
>>>>> +                                       const uint8_t *buf,
>>>>> +                                       size_t buflen,
>>>>> +                                       void *opaque,
>>>>> +                                       Error **errp)
>>>>
>>>> There=E2=80=99s already a function of this name for creation.
>>>
>>> There is a long story why two write functions are needed.
>>> i tried to use only one, but at the end I and Daniel both agreed
>>> that its just better to have two functions.
>>>
>>> The reason is that during creation, the luks BlockDriverState doesn't e=
xist yet,
>>> and so the creation routine basically just writes to the underlying pro=
tocol driver.
>>>
>>> Thats is why the block_crypto_create_write_func receives a BlockBackend=
 pointer,
>>> to which the BlockDriverState of the underlying protocol driver is inse=
rted.
>>>
>>>
>>> On the other hand, for amend, the luks block device is open, and it onl=
y knows
>>> about its own BlockDriverState, and thus the io should be done on bs->f=
ile
>>>
>>> So instead of trying to coerce a single callback to do both of this,
>>> we decided to just have a little code duplication.
>>
>> I meant: This doesn=E2=80=99t compile.  There=E2=80=99s already another =
function of this
>> name.
>>
>=20
> You probably didn't apply the 'block-crypto: misc refactoring' patch,=20
> or I forgot to send it.

Maybe you forgot to mention anywhere that I should.

Max


--leOZtHj2Rnv3XcUwXocbRKvmWeEtUwmWa--

--XuVyZCNvF1UM7iCzXNzYi41kUgtuEzu9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3FacQACgkQ9AfbAGHV
z0AKyAf8Cq/jMm6ppH38DeuuTrEK8oFCHHWqToHxRKQjXyaIfiJciWckm9dcHyee
cdy8HzaDM4zZ/tbYx7Aq3FOUTFXu//BfbNL2gKRjm5WJe8pzv9DPoHLFyREmOCYj
xIupYdNYRzXRZ/JN5Pbq+hUuq+3lAgJ4o+6zjhA1RmYpGA82D2UkdAtNeiTMQyTO
oTjoi1vIDduecRmi1xNKkTCMSpWjqivIPRz2qYyg5nSFFzphiKHwsS2zPgcmNa7C
WcJvlwmsbNY9Ch4ObQIZgMdt7gw3n+LJjCVw7frTkSKNwnNGo/5LPE3FHgAPl5cy
AayqSwXr94eVQnIf/PgGmQBJfIbnhA==
=yvV+
-----END PGP SIGNATURE-----

--XuVyZCNvF1UM7iCzXNzYi41kUgtuEzu9T--


