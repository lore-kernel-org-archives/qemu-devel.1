Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA672C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A714A205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKOw1F78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A714A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJXP-00054l-PM
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ieJWY-0004bV-1k
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ieJWW-0003w5-K6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:56:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ieJWW-0003uy-FL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575899787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pZP55XGAtBZGIJALzQrloSLlcbRLyLv2uiXVFD/xU10=;
 b=SKOw1F78uUUIDro8arknnyq9Q0d/V6T4NQn0hi69lFExNa+Hr0Ur98BzLqFwfRy8m31zTn
 zuEJ+bR/LpGuVsJ2Qe3zkoMSyQHSwe40gydvXtdilB2kBtbikApuzdq/VIjVrMFVF9Xb2O
 S9r4tErH8+mQDwYa+/SMEZbJr0sXSjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-lQbeUxCoOD2Lp_GgV--pLw-1; Mon, 09 Dec 2019 08:56:26 -0500
X-MC-Unique: lQbeUxCoOD2Lp_GgV--pLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BE410054E3;
 Mon,  9 Dec 2019 13:56:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4DB1001B03;
 Mon,  9 Dec 2019 13:56:22 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 02/23] blockdev: Allow resizing everywhere
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-3-mreitz@redhat.com>
 <w51pnh1czyv.fsf@maestria.local.igalia.com>
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
Message-ID: <fbf778c9-7da5-5637-9008-5c7f063701e1@redhat.com>
Date: Mon, 9 Dec 2019 14:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <w51pnh1czyv.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q2icHYKi2c9N6MJDjgaheiIod7shxNZSF"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2icHYKi2c9N6MJDjgaheiIod7shxNZSF
Content-Type: multipart/mixed; boundary="O2P2FFYyeD4WqUvvpEnrFymBNoCIRFrqI"

--O2P2FFYyeD4WqUvvpEnrFymBNoCIRFrqI
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.12.19 15:04, Alberto Garcia wrote:
> On Mon 11 Nov 2019 05:01:55 PM CET, Max Reitz wrote:
>> @@ -3177,11 +3177,6 @@ void qmp_block_resize(bool has_device, const char=
 *device,
>>      aio_context =3D bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>> =20
>> -    if (!bdrv_is_first_non_filter(bs)) {
>> -        error_setg(errp, QERR_FEATURE_DISABLED, "resize");
>> -        goto out;
>> -    }
>> -
>=20
> What happens with this case now?
>=20
> https://lists.gnu.org/archive/html/qemu-block/2019-11/msg00793.html

As far as I understand, we have a bug there and we=92ll fix it in 5.0.
It=92s just that in one case, it wasn=92t visible because resize wasn=92t
allowed on some nodes (where I think it should actually be allowed,
hence this patch).

So I think we should allow resize on those nodes (this patch) and fix
the bug, and that should be fine then.

Max


--O2P2FFYyeD4WqUvvpEnrFymBNoCIRFrqI--

--q2icHYKi2c9N6MJDjgaheiIod7shxNZSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3uUoQACgkQ9AfbAGHV
z0C60AgAu10DfyqqiQNIxMVE3Yr+ynaaNEhAgNPavtZlrTu3sCd18QYeusX8cfKG
4PSpz1mJ0fZgrodbNsAcdwz7C6W7MtYgf4Ed+e6qGlv5AVZn8QnxSIV5a6ZSkW4B
4rv66RFgsuolEHG5+ydF7fLG6ToWtpP8E62Dbl710+KQQJ8EMFyMQKF6j6/97NbB
WioTdd2rjGmEu55UNffjdAqd5lCG3a1vouXvb7zhNU31xW1HoZLNr/CM6nupLHxs
NZlnVjCuf3XF9gpjOfjYm16PFUjz8pzC6g2XIx+jvRIomhE98IqS7le807halC7l
F+x/bKpK4C/o9LBmL93Cc33Ec+MOew==
=bbbP
-----END PGP SIGNATURE-----

--q2icHYKi2c9N6MJDjgaheiIod7shxNZSF--


