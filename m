Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83977C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472A920663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWKHyLZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472A920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Sq-0001LA-Ee
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jH6S4-0000rr-Kv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jH6S3-0001h2-De
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:52:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jH6S3-0001gx-AM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585144331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i8B6x6vwNXPYxxgFxw7RQABSa5Efbv7nPaLItHVJnss=;
 b=DWKHyLZQY+LgOlRJ9syArBGO+UykDOPeyopY7u3yDKvSrtgXvZTsjTXdQvsBmz/PD1FRau
 30+cV8bWp6YES3zTgkEzvrYClPwuLFkaJvWyxMSkJ6BDpRi1VqGlc6YvbMJS/HKFPMKBI1
 9jmTxpGSPgekwLc6HwSHH2FFYwLIsYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-glHgGQMPOqGXHmnNxnTLwg-1; Wed, 25 Mar 2020 09:52:07 -0400
X-MC-Unique: glHgGQMPOqGXHmnNxnTLwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1D128024E9;
 Wed, 25 Mar 2020 13:52:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-33.ams2.redhat.com
 [10.36.115.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 738D994B5C;
 Wed, 25 Mar 2020 13:52:02 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] qcow2: Avoid feature name extension on small
 cluster size
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
 <20200324174233.1622067-4-eblake@redhat.com>
 <d28f2dfc-1f85-1157-0a57-341894205883@redhat.com>
 <f900616b-8e98-d0b1-efd7-f53b8c241c8f@redhat.com>
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
Message-ID: <61b5c2d0-fc76-cc70-ab25-bd75cd785d69@redhat.com>
Date: Wed, 25 Mar 2020 14:52:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f900616b-8e98-d0b1-efd7-f53b8c241c8f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mZcaIIvjewspJyDwPN4vAaAHKLHKmH5E1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mZcaIIvjewspJyDwPN4vAaAHKLHKmH5E1
Content-Type: multipart/mixed; boundary="37Av4K1DFet5RMJh1r5dZledg7bMO8p8O"

--37Av4K1DFet5RMJh1r5dZledg7bMO8p8O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 14:18, Eric Blake wrote:
> On 3/25/20 7:42 AM, Max Reitz wrote:
>> On 24.03.20 18:42, Eric Blake wrote:
>>> As the feature name table can be quite large (over 9k if all 64 bits
>>> of all three feature fields have names; a mere 8 features leaves only
>>> 8 bytes for a backing file name in a 512-byte cluster), it is unwise
>>> to emit this optional header in images with small cluster sizes.
>>>
>>> Update iotest 036 to skip running on small cluster sizes; meanwhile,
>>> note that iotest 061 never passed on alternative cluster sizes
>>> (however, I limited this patch to tests with output affected by adding
>>> feature names, rather than auditing for other tests that are not
>>> robust to alternative cluster sizes).
>>
>=20
>>> -=C2=A0=C2=A0=C2=A0 /* Feature table */
>>> -=C2=A0=C2=A0=C2=A0 if (s->qcow_version >=3D 3) {
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Feature table.=C2=A0 A mere 8 feature names=
 occupies 392 bytes, and
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * when coupled with the v3 minimum header of =
104 bytes plus the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * 8-byte end-of-extension marker, that would =
leave only 8 bytes
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * for a backing file name in an image with 51=
2-byte clusters.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Thus, we choose to omit this header for clu=
ster sizes 4k and
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * smaller.
>>
>> Can=E2=80=99t we do this decision more dynamically?=C2=A0 Like, always o=
mit it when
>> cluster_size - sizeof(features) < 2k/3k/...?
>>
>> Max
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (s->qcow_version >=3D 3 && s->cluster_size > 409=
6) {
>=20
> Yes.=C2=A0 But when you consider that sizeof(features) is a compile-time
> constant, it isn't really dynamic for a given qemu release, but rather a
> different way to spell things; about the only thing it would buy us is
> that our cutoff window for what cluster size no longer gets the header
> may automatically shift from 2k to 4k to 8k as future qemu versions add
> more qcow2 features.

Yes.

> If we want to write it like that, which size limit
> do you propose?=C2=A0 Or asked differently, how much space should we rese=
rve
> for other extension headers + backing file name?

Well, that was the =E2=80=9C2k/3k/...=E2=80=9D list. :)

The backing file name is limited to 1k, so I suppose that plus 1k for a
potential external data filename, plus 1k for the rest, so 3k in total?

Now that I look into the spec, I see that it actually doesn=E2=80=99t say t=
hat
the backing filename has to be part of the header cluster.  But, well.

It also only says that the image header must be part of the first
cluster, which in my opinion doesn=E2=80=99t necessarily include its extens=
ions.
 So header extensions (and the backing filename) could actually be in
consecutive clusters.  But that of course would be much more difficult
to implement.

Max


--37Av4K1DFet5RMJh1r5dZledg7bMO8p8O--

--mZcaIIvjewspJyDwPN4vAaAHKLHKmH5E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl57YgAACgkQ9AfbAGHV
z0CpRAf+Pep9Fqo3QPepXYvFKqIMKHdWylT/pg3P1hWrLHqhr8zjfkytthdMHHeW
ggCI7Fr+yuHBaRW4yaR0dX62ULYqetkFPimBfAWaKM2936b4kSPDnbLxePJUEe4w
P3zNrW8T6lX/qE8LXl4WlhfqAtYj04xq4zrIMNHdbL5DnLkqd0KQoPAiPnwoOmVx
L4LSo+SKDr89D592yW2CvHxFnYYSOB8D6hN+zroTHWUK1QtFydT4paZSDJm/eR0+
+IU0NBlqrME2zvDRfFXEtTwvOl0tRNocQ/lsscTsdk6A9GI2mn9xClYlikvDOl68
KhJdn/Sq+oIHZ1qCDUzAvSe7kZ0bIA==
=Zpcc
-----END PGP SIGNATURE-----

--mZcaIIvjewspJyDwPN4vAaAHKLHKmH5E1--


