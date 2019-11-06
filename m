Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F1C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A5220869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4NzST4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSIi2-0002QA-5D
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 05:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSIh3-0001Le-Sr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSIh2-0006s3-Sh
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:37:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSIh2-0006rX-P5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573036660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N3XBRqoVFiAZpTcFooCao780k2Q7e6XZmLlnMdRzfjQ=;
 b=a4NzST4z5RWdKjgXSLoc6j01Da3u2mawSp+Vsan5CHPFAeqAaXCRMST7hX7jzojVxHg3tS
 GBJ+wVbTjJhFJTIBAdIkDWsuR9UirmNf+Aoow8S+Qa8XYr7x1CN4nRKzfH4ZjzvK9pVCJw
 TRz6trqTw5JcI3P3dCk2TVuDzJ7PNtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-qX7s-9kUNGeegYQKg1oCFw-1; Wed, 06 Nov 2019 05:37:36 -0500
X-MC-Unique: qX7s-9kUNGeegYQKg1oCFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E19F800054;
 Wed,  6 Nov 2019 10:37:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1C95D9CD;
 Wed,  6 Nov 2019 10:37:33 +0000 (UTC)
Subject: Re: backup_calculate_cluster_size does not consider source
To: Dietmar Maurer <dietmar@proxmox.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <1775789152.22.1573035507302@webmail.proxmox.com>
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
Message-ID: <f6efbd43-6bb4-8763-a01a-dd0379389565@redhat.com>
Date: Wed, 6 Nov 2019 11:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1775789152.22.1573035507302@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gXX0qXxbBPUUMbI9KWvDUKRmswKasX9cb"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gXX0qXxbBPUUMbI9KWvDUKRmswKasX9cb
Content-Type: multipart/mixed; boundary="V1i2YfUEHduezfAoVWMhsiADGXZG9Wa1S"

--V1i2YfUEHduezfAoVWMhsiADGXZG9Wa1S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 11:18, Dietmar Maurer wrote:
>> The thing is, it just seems unnecessary to me to take the source cluster
>> size into account in general.  It seems weird that a medium only allows
>> 4 MB reads, because, well, guests aren=E2=80=99t going to take that into=
 account.
>=20
> Maybe it is strange, but it is quite obvious that there is an optimal clu=
ster
> size for each storage type (4M in case of ceph)...

Sure, but usually one can always read sub-cluster ranges; at least, if
the cluster size is larger than 4 kB.  (For example, it=E2=80=99s perfectly=
 fine
to read any bit of data from a qcow2 file with whatever cluster size it
has.  The same applies to filesystems.  The only limitation is what the
storage itself allows (with O_DIRECT), but that alignment is generally
not greater than 4 kB.)

As I said, I wonder how that even works when you attach such a volume to
a VM and let the guest read from it.  Surely it won=E2=80=99t issue just 4 =
MB
requests, so the network overhead must be tremendous?

Max


--V1i2YfUEHduezfAoVWMhsiADGXZG9Wa1S--

--gXX0qXxbBPUUMbI9KWvDUKRmswKasX9cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ComsACgkQ9AfbAGHV
z0BYEQgAoaNUw//vPipPSylkmH8JBpGejHtPzKpUgB1f5sHgO5kspShj6S9xu/NU
k3pEwyBtki2GcQTN8pzSjIGDBpmlNcpK3IFwwVHZ7iV857mhYgAu19fULXoFsSym
kGqccgjsaW1KO0EalQDIYNKU2CD+/W1o6fxfziqZDTkpxUeSMoS38zbiSfTUPcyD
0+pODw0eii4Nr56EApXbNlm7tixVZtUT5FZ3wH7hG9wa+IsBgZirbg6wXc3dECZs
UwbagCPasKjgcEQyLX2a/OE57TorO08SBwZHFjG8PxJNP58D333PnXoHPaHZRZ4B
EcTIYzHT/3xCiDImBX0mlgN4qSiIfQ==
=6Ule
-----END PGP SIGNATURE-----

--gXX0qXxbBPUUMbI9KWvDUKRmswKasX9cb--


