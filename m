Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A1C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C567F214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSGdZe4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C567F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j057Z-000781-RQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j04pW-0000DU-Ra
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j04pU-00085p-HQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47617
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j04pU-000857-Db
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581086520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Id6jHij/PGKh2J66FgbjSKVYJfZS/jYgqt5+FPd4NWY=;
 b=iSGdZe4S6DELPnNZDHJkXYhkmrLpE5qA7hT2gKT8UN7plrMdB/PHMZJMBGq7OiEuZCUceJ
 +jQQrBw1M5+LTcK+AKF0oXCp+mVH5bMiI3fYwx34WO7T8QNDwZX01T2QNfY7GOY3/kJQlM
 Qig7w9zwukv4DWqbmapL8Oy/q9t7wxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zKVpkznGOLuRR8hwKj-lCw-1; Fri, 07 Feb 2020 09:41:55 -0500
X-MC-Unique: zKVpkznGOLuRR8hwKj-lCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB0F800D5F;
 Fri,  7 Feb 2020 14:41:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5CF60BF7;
 Fri,  7 Feb 2020 14:41:53 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, David Edmondson
 <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
 <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
 <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
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
Message-ID: <570489b5-8d1b-27c4-01d3-0e63130d2c57@redhat.com>
Date: Fri, 7 Feb 2020 15:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f110458f-b3e7-6301-64bf-2b4957f3601e@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OoyiFVJMr0NAEOAhwWDux8lAl2YDh7eTb"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OoyiFVJMr0NAEOAhwWDux8lAl2YDh7eTb
Content-Type: multipart/mixed; boundary="d2dAZrtJMbSkAl1JONBCYBb5R2jPce645"

--d2dAZrtJMbSkAl1JONBCYBb5R2jPce645
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.02.20 13:07, Vladimir Sementsov-Ogievskiy wrote:
> 07.02.2020 13:33, Max Reitz wrote:
>> On 04.02.20 15:23, Eric Blake wrote:
>>> On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>>>> I understand that it is safer to have restrictions now and lift them
>>>>> later, than to allow use of the option at any time and leave room for
>>>>> the user to shoot themselves in the foot with no way to add safety
>>>>> later.=C2=A0 The argument against no backing file is somewhat
>>>>> understandable (technically, as long as the backing file also reads
>>>>> as all zeroes, then the overall image reads as all zeroes - but why
>>>>> have a backing file that has no content?); the argument requiring -n
>>>>> is a bit weaker (if I'm creating an image, I _know_ it reads as all
>>>>> zeroes, so the --target-is-zero argument is redundant, but it
>>>>> shouldn't hurt to allow it).
>>>>
>>>> I know that it reads as all zeroes, only if this format provides zero
>>>> initialization..
>>>>
>>>>>
>>>>>> +++ b/qemu-img.c
>>>>>
>>>>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_re=
port("This will become an error in future QEMU
>>>>>> versions.");
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-i=
s-zero requires use of -n flag");
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> So I think we could drop this hunk with no change in behavior.
>>>>
>>>> I think, no we can't. If we allow target-is-zero, with -n, we'd better
>>>> to check that what we are creating is zero-initialized (format has
>>>> zero-init), and if not we should report error.
>>>>
>>>
>>> Good call.=C2=A0 Yes, if we allow --target-is-zero without -n, we MUST =
insist
>>> that bdrv_has_zero_init() returns 1 (or, after my followup series,
>>> bdrv_known_zeroes() includes BDRV_ZERO_CREATE).
>>
>> Why?
>>
>> I could imagine a user creating a qcow2 image on some block device with
>> preallocation where we cannot verify that the result will be zero.=C2=A0=
 But
>> they want qemu not to zero the device, so they would specify
>> --target-is-zero.
>=20
> If user create image, setting --target-is-zero is always valid. But if
> we in
> same operation create the image automatically, having --target-is-zero,
> when
> we know that what we are creating is not zero is misleading and should
> fail..

bdrv_has_zero_init() doesn=E2=80=99t return false only for images that we k=
now
are not zero.  It returns true for images where we know they are.  But
if we don=E2=80=99t know, then it returns false also.

> If we want to add a behavior to skip zeros unconditionally, we should
> call new
> option --skip-zeroes, to clearly specify what we want.

It was my impression that this was exactly what --target-is-zero means
and implies.

Max


--d2dAZrtJMbSkAl1JONBCYBb5R2jPce645--

--OoyiFVJMr0NAEOAhwWDux8lAl2YDh7eTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49dy8ACgkQ9AfbAGHV
z0DoxAf9F9oeR2Sdnrm5l8lgX2UBNKKBxpT25/ZAI3FWmeFBMybKlwHsrpZaWD8Q
OTxzoGPGkuhWcnjGvpkatGjPmNinovIzI9YItLNeY2C/zt7nKtUZzQfLr9zMezCl
7s/c2mh+DxzWPbzGs51QvmeRSLDDtIvJeNNbOMj9J9vUmJf2G2KF1+as1KYf01Qv
jZJHFUcDTjRZut0MPyBF1RrBvSsHBA9diRa3bX6tsQeoHlcYCVfp0CAZXJ4uAA9Z
2u/WCo3rQZHOvIoHTr5l1q+jfY8PddSojwNjH2taFsMzKXPim/92XR21priDropB
DiBSTq9Vd4dEX0MW9qO8+C8WD3FNNg==
=Y2bK
-----END PGP SIGNATURE-----

--OoyiFVJMr0NAEOAhwWDux8lAl2YDh7eTb--


