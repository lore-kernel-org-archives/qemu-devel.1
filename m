Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007BC33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D77F2073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfEICrBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D77F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irjn4-0000xu-KZ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 09:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irjmC-00005R-LN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irjm8-0005OM-NM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:36:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irjm8-0005Nc-IG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579098963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yXn9y9piuL3ZtZYaXl57WNEvWJGHqWIs7hXfmIJb0n0=;
 b=BfEICrBD+45nFJgkLwelC7N1LsJIhQ94iW0yV5a4EYC4n63JUyYcEyG0uxh1+iSSkKr0UT
 JW76QoC+eZAt5H6llLmiBAkjrw/ln1K4l1JVZdtW+KxQYtCYQLqj6tkMsXKD76D8eKLXFD
 QuazazGr6M2jVfvXOwTVkIbM7jPSnR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-MgRNEd5kPS2xSiKzIPKv0g-1; Wed, 15 Jan 2020 09:36:02 -0500
X-MC-Unique: MgRNEd5kPS2xSiKzIPKv0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D9A801E6C;
 Wed, 15 Jan 2020 14:36:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF455C21B;
 Wed, 15 Jan 2020 14:35:57 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] luks: extract
 block_crypto_calculate_payload_offset()
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200109111012.559052-1-stefanha@redhat.com>
 <20200109111012.559052-2-stefanha@redhat.com>
 <7ea9cf7e-2622-c17a-6936-3109e4cd228a@redhat.com>
 <20200115134000.GG163546@stefanha-x1.localdomain>
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
Message-ID: <c9caf1f7-2986-b2ba-71b9-8bca2572e98c@redhat.com>
Date: Wed, 15 Jan 2020 15:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115134000.GG163546@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rzPO61SHabUryMJds4MdY2HIlBtaAH0lS"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rzPO61SHabUryMJds4MdY2HIlBtaAH0lS
Content-Type: multipart/mixed; boundary="qFfLRPI2YBOaPzWgFQL6UtrdQOS6SJRtM"

--qFfLRPI2YBOaPzWgFQL6UtrdQOS6SJRtM
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.01.20 14:40, Stefan Hajnoczi wrote:
> On Tue, Jan 14, 2020 at 04:25:44PM +0100, Max Reitz wrote:
>> On 09.01.20 12:10, Stefan Hajnoczi wrote:
>>> The qcow2 .bdrv_measure() code calculates the crypto payload offset.
>>> This logic really belongs in block/crypto.c where it can be reused by
>>> other image formats.
>>>
>>> The "luks" block driver will need this same logic in order to implement
>>> .bdrv_measure(), so extract the block_crypto_calculate_payload_offset()
>>> function now.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  block/crypto.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  block/crypto.h |  5 ++++
>>>  block/qcow2.c  | 59 ++++------------------------------------------
>>>  3 files changed, 73 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/block/crypto.c b/block/crypto.c
>>> index 24823835c1..ed32202fa2 100644
>>> --- a/block/crypto.c
>>> +++ b/block/crypto.c
>>> @@ -185,6 +185,70 @@ block_crypto_create_opts_init(QDict *opts, Error *=
*errp)
>>
>> [...]
>>
>>> +/* Determine the number of bytes for the crypto header */
>>> +bool block_crypto_calculate_payload_offset(QemuOpts *opts,
>>> +                                           const char *optprefix,
>>> +                                           size_t *len,
>>> +                                           Error **errp)
>>> +{
>>> +    QDict *cryptoopts_qdict;
>>> +    QCryptoBlockCreateOptions *cryptoopts;
>>> +    QCryptoBlock *crypto;
>>> +
>>> +    /* Extract options into a qdict */
>>> +    if (optprefix) {
>>> +        QDict *opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
>>> +
>>> +        qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, optprefi=
x);
>>> +        qobject_unref(opts_qdict);
>>> +    } else {
>>> +        cryptoopts_qdict =3D qemu_opts_to_qdict(opts, NULL);
>>> +    }
>>> +
>>> +    /* Build QCryptoBlockCreateOptions object from qdict */
>>> +    qdict_put_str(cryptoopts_qdict, "format", "luks");
>>
>> Should this be a parameter?
>=20
> Maybe one day, but there are no users who need it yet.

Sure, but would it hurt? O:-)

I=92m just asking because this file doesn=92t implement luks crypto, so it
seems a bit strange to reference it here.  Actually, now that I think
about it...  This file only implements the luks block driver.  Is this
even the right place for the common
block_crypto_calculate_payload_offset() function?  Would it make more
sense in crypto/block.c or crypto/block-luks.c?

Max


--qFfLRPI2YBOaPzWgFQL6UtrdQOS6SJRtM--

--rzPO61SHabUryMJds4MdY2HIlBtaAH0lS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4fI0wACgkQ9AfbAGHV
z0DHHAf/WXr6lzLEj+XgmxZjU1Vy5GmNfBNt7q19rnCOs/TuwjB9aQKyZyTjL0Ko
bUJyNtnm8ibDpA2mXacJgjx+09exvmqGlQvu8tPHmQmY0I1NxBDjE2lyLSU+sctu
0fcRYnOZKOAbSeaKVOfnPqMw1zmo4Wu9CXT3yVuwixAn12dPP7vW+Ynr34vIdDta
Je209dmm4p3cdfsvx4xELqbrUKRm7xcR+11SKsQ6CWDASCCiQXv1m/D8Dv6TngDr
pIftipH4bkjV0wVF70hhux9Mhq7ePUFBjEReQjXVK1bKaGKfAa2sOtkGowHxNhxB
pH3Q3Bf4xBU/NWI2oYSCKZ1l1K0XGQ==
=U3Ux
-----END PGP SIGNATURE-----

--rzPO61SHabUryMJds4MdY2HIlBtaAH0lS--


