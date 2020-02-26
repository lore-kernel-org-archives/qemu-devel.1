Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED94FC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D6320838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz7PRPES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D6320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tiO-0006HL-VP
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6thZ-0005fC-Q9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6thY-0006a0-8O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6thY-0006Vz-1d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BYbh+L8QJgvkuhkFhMERBhxLrjoqb/X0T+cScO2dcJY=;
 b=Dz7PRPESy8rk60uHjn1+MfSHtxcRgVXAsMLtYOoJMrjh3jDI6Yug8Iuqb31odd24FWJZAF
 /cY5HKrwI/ngv65SKU1Q5JK7n+55UqmIJTNwtCCym9Ws/R9TSpz0dxQ8a3WAzGN3lXrvLf
 tJjdQFKmbMfbduoFd9GST+AWQUM9oq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-nQHSSb54M3KgJ5Q7W8WmtA-1; Wed, 26 Feb 2020 05:13:54 -0500
X-MC-Unique: nQHSSb54M3KgJ5Q7W8WmtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF0DB18CA241;
 Wed, 26 Feb 2020 10:13:52 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B310B101D482;
 Wed, 26 Feb 2020 10:13:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] qemu-img: free memory before re-assign
To: Pan Nengyuan <pannengyuan@huawei.com>, kwolf@redhat.com
References: <20200226033037.18253-1-pannengyuan@huawei.com>
 <20200226033037.18253-3-pannengyuan@huawei.com>
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
Message-ID: <03a50206-6407-41e8-f11a-6e866f0c3798@redhat.com>
Date: Wed, 26 Feb 2020 11:13:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226033037.18253-3-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="thu3KI6nIwzh13iqfKRjzrPmkPeTKR5ld"
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
Cc: euler.robot@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--thu3KI6nIwzh13iqfKRjzrPmkPeTKR5ld
Content-Type: multipart/mixed; boundary="MpxrEVc3vTLZ0SXsXnYIuCCKqX8aEtabB"

--MpxrEVc3vTLZ0SXsXnYIuCCKqX8aEtabB
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.02.20 04:30, Pan Nengyuan wrote:
> collect_image_check() is called twice in img_check(), the filename/format=
 will be alloced without free the original memory.
> It is not a big deal since the process will exit anyway, but seems like a=
 clean code and it will remove the warning spotted by asan.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  qemu-img.c | 2 ++
>  1 file changed, 2 insertions(+)

I think this should happen in the caller.  And there I think it would
make more sense to completely discard the old object and allocate a new one=
:

qapi_free_ImageCheck(check);
check =3D g_new0(ImageCheck, 1);

This way, we can=92t forget to free any fields if new pointers were to be
added to the ImageCheck object.

Max


--MpxrEVc3vTLZ0SXsXnYIuCCKqX8aEtabB--

--thu3KI6nIwzh13iqfKRjzrPmkPeTKR5ld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5WRNwACgkQ9AfbAGHV
z0BNJwf/UL4xmBu2YBjR5OV9Xu98XnFZTCa9uu/NjbQrc+v2XvBel0I6574iEmQs
v9IMZ8It0GCAZzLBG1guQ8odc1ciP+ku/xobxNfttjv80Z/YmZMWp4EfzhVGla5k
+xjerWfFa1X6WXoixdCEiFELZDcQQ82nSWFKiQ4fGD4XcUMhQ9qhH6K9+2m5fP6v
GSSbZ8tWzUI0sV7lGXeDZpBxZ6KNe5Ejjlb8cNHgFTcov+Bka6sX9ZFHZnxf3XzS
a0dMqPnvs/fk7gKv6rDGPPwZjqef7HCcGEGqRDXaVnldprFnczonOo/Y7+qbzAfn
mbvPQpmn+TF4Q455eBeXGB/aa21U+g==
=FZ67
-----END PGP SIGNATURE-----

--thu3KI6nIwzh13iqfKRjzrPmkPeTKR5ld--


