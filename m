Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3EC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFE7214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa5N2ofa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFE7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jha-00045q-0A
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3jgz-0003Yj-GE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3jgx-0001qB-Nq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:56:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3jgx-0001po-6Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581958578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=45TC9loqMGn8RCRXzD+TXer0wTFRTq0uweAA6sniTE0=;
 b=Xa5N2ofazqX2IWL/3MllIv+GCyBIXkxkozJycPaYVpPdf0ArxzKSJdwdS09syIWw7neInk
 KxWAp+KFjg+8N/e9zHs/JOgEfSddC3s6/EOC9iysVniwNHT2eDFr0brK+oI/nt+Dmef4CL
 Z1i9nMITcFLWoY2EW+QmYs4rzfC+cgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-763HOxF9M-uYzAfM6dwYTA-1; Mon, 17 Feb 2020 11:56:15 -0500
X-MC-Unique: 763HOxF9M-uYzAfM6dwYTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0903800D55;
 Mon, 17 Feb 2020 16:56:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F2A2CC39;
 Mon, 17 Feb 2020 16:56:13 +0000 (UTC)
To: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Subject: qcow2: Zero-initialization of external data files
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
Message-ID: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
Date: Mon, 17 Feb 2020 17:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ncPtxHryCGBDiFaTTn88jPF7UYRvp1h1n"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ncPtxHryCGBDiFaTTn88jPF7UYRvp1h1n
Content-Type: multipart/mixed; boundary="CYUhujAji5i8HcYkJOFmFKAFX9x5lDO3y"

--CYUhujAji5i8HcYkJOFmFKAFX9x5lDO3y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

AFAIU, external data files with data_file_raw=3Don are supposed to return
the same data as the qcow2 file when read.  But we still use the qcow2
metadata structures (which are by default initialized to =E2=80=9Ceverythin=
g
unallocated=E2=80=9D), even though we never ensure that the external data f=
ile
is zero, too, so this can happen:

$ dd if=3D/dev/urandom of=3Dfoo.raw 64M
[...]

$ sudo losetup -f --show foo.raw
/dev/loop0

$ sudo ./qemu-img create -f qcow2 -o \
    data_file=3D/dev/loop0,data_file_raw=3Don foo.qcow2 64M
[...]

$ sudo ./qemu-io -c 'read -P 0 0 64M' foo.qcow2
read 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 00.00 sec (25.036 GiB/sec and 400.5751 ops/sec)

$ sudo ./qemu-io -c 'read -P 0 0 64M' -f raw foo.raw
Pattern verification failed at offset 0, 67108864 bytes
read 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 00.01 sec (5.547 GiB/sec and 88.7484 ops/sec)

I suppose this behavior is fine for blockdev-create because I guess it=E2=
=80=99s
the user=E2=80=99s responsibility to ensure that the external data file is =
zero.
 But maybe it isn=E2=80=99t, so that=E2=80=99s my first question: Is it rea=
lly the
user=E2=80=99s responsibility or should we always ensure it=E2=80=99s zero?

My second question is: If we decide that this is fine for
blockdev-create, should at least qcow2_co_create_opts() ensure the data
file it just created is zero?

Max


--CYUhujAji5i8HcYkJOFmFKAFX9x5lDO3y--

--ncPtxHryCGBDiFaTTn88jPF7UYRvp1h1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5KxasACgkQ9AfbAGHV
z0BgmQf6A/cjD5z51M6/bmWn82QMEBH2kpeH6Sy+7gE/AxcwVmuHbUdoG0NQy6hy
wYSgU4BdXAHv3puYLmzqg9rkDL5DQl9ETd1Z9pE1Xg41GjWZYRS+WaU4E3tqz2JW
CxSgYbhmpuMLchyLrANSwbO3i+AP55YPPL+rj0HChUIe6LxtnP/iM3Mc0pKMDHoU
3RNA4u3605ghNA531+y5nSgkWgF/80MhcBQfLQ4L4XawDPicXLrn1RTRAgMLXz8w
NLEVbBnfJDuv4TajHIXIWPfxdwIPHHP2ZKigefqEdkycgWb+8v2JKISELRy/KYc3
dnb+a572YAzBvONybokXGvVMktaACg==
=sGgq
-----END PGP SIGNATURE-----

--ncPtxHryCGBDiFaTTn88jPF7UYRvp1h1n--


