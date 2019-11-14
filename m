Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93910C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C60206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4RAYQuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C60206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIvW-0007tP-Bn
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVItv-0006n3-AU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVItt-0000sk-JQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:27:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43152
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVItq-0000oG-Vu
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573752435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s6NS6oXwG9MSSPnWoLkzYwgGh2SBe3PEJ3mXfYSmRjo=;
 b=h4RAYQuHVUM9RLzB2hyQOQuUmHsNKHPwox8nzLcVqGhNeXqmASN6GLWVnohakcXzU7q6wj
 jfmSCMYhOcKdY+RQSYC0LgpdyRGyxecmT3xDo2tqnGAnVw4K3KUavd7XX04Ro4zbwi06AJ
 8LGuO3Ec4lGxPnvkRo055TwFsHOGeU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-lV2oTLvgMtWhJwHE9ngSMA-1; Thu, 14 Nov 2019 12:27:12 -0500
X-MC-Unique: lV2oTLvgMtWhJwHE9ngSMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B538026BD;
 Thu, 14 Nov 2019 17:27:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E79A5E25B;
 Thu, 14 Nov 2019 17:27:07 +0000 (UTC)
Subject: Re: Convert VMDK to RAW
To: janine.schneider@fau.de, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <009201d59b06$475883f0$d6098bd0$@fau.de>
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
Message-ID: <97e53c9c-7d3d-75e7-8227-7a1ff186f52e@redhat.com>
Date: Thu, 14 Nov 2019 18:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <009201d59b06$475883f0$d6098bd0$@fau.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9L1X55mk2QEFH0tnW7PJFlddLOysQ2Uki"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9L1X55mk2QEFH0tnW7PJFlddLOysQ2Uki
Content-Type: multipart/mixed; boundary="cTGwnSNZcSHGO72Z7oVyglRvp7uuSNZT9"

--cTGwnSNZcSHGO72Z7oVyglRvp7uuSNZT9
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 17:12, janine.schneider@fau.de wrote:
> Ladies and Gentlemen,
>=20
> =A0
>=20
> I am a PhD student at the Friedrich-Alexander-University
> Erlangen-Nuremberg in Bavaria, Germany and am currently working on a
> forensic reconstruction tool. The tool can be used to analyze physical
> and virtual hard disks and to reconstruct files. I would now like to
> extend the tool so that it is able to analyze VMDK files and convert
> them to raw. Unfortunately I have not been able to understand how to
> correctly unpack and assemble VMDK containers. Since qemu is able to
> convert VMDK to raw, I wanted to ask you if you could explain to me how
> to put the grains together?

Hi,

I=92m not quite sure what you mean by a =93VMDK container=94.  VMDK disk
images can consist of multiple files that are linked together by a
descriptor file.  In theory all you need to do is tell qemu-img to
convert that descriptor file into a raw image.  For example:

(Sorry, I don=92t know much about VMware, so all I can do is use qemu
tools to demonstrate)

$ qemu-img create -f vmdk -o subformat=3DtwoGbMaxExtentSparse foo.vmdk 4G
Formatting 'foo.vmdk', fmt=3Dvmdk size=3D4294967296 compat6=3Doff
hwversion=3Dundefined subformat=3DtwoGbMaxExtentSparse
$ ls
foo-s001.vmdk=A0 foo-s002.vmdk=A0 foo.vmdk
$

In this example, foo.vmdk is the descriptor file and it points to the
other two (data) files:

$ cat foo.vmdk
# Disk DescriptorFile
version=3D1
CID=3D6d8d65ed
parentCID=3Dffffffff
createType=3D"twoGbMaxExtentSparse"

# Extent description
RW 4194304 SPARSE "foo-s001.vmdk"
RW 4194304 SPARSE "foo-s002.vmdk"

# The Disk Data Base
#DDB

ddb.virtualHWVersion =3D "4"
ddb.geometry.cylinders =3D "8322"
ddb.geometry.heads =3D "16"
ddb.geometry.sectors =3D "63"
ddb.adapterType =3D "ide"
$


So to convert this VMDK disk image to a raw image, you=92d simply do this:

$ qemu-img convert -f vmdk -O raw -p foo.vmdk foo.img
    (100.00/100%)
$

Max


--cTGwnSNZcSHGO72Z7oVyglRvp7uuSNZT9--

--9L1X55mk2QEFH0tnW7PJFlddLOysQ2Uki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3NjmkACgkQ9AfbAGHV
z0AkzQf/eCWu7o1cP7EZLLWvSj2p3dDpz7gpVQlhlHmiSR1IUIzSd0VpCsG7RviE
nBi4eZslVqCIrOmWFcuuTepEAL99SuZ/JZHBRJLPGCeswEN09HuHEF1V3V0V0HNF
FwMZ8F6C4FeV8pMsxCYWaDbhiNIJjWVbezxgSTRVDvCgKtbpkAkCFhBLw0A5ZOJ2
CNPCczfDifgdj1xdG8DvF/IKcAYQPgujmj3ntOy1KadscDoVLciFUwwiYQ321EGD
U3+V6KWAX2j1LQJHtM2/F/DnAzK5rAcIhceq4r6EOIkYtx9UO0ySyiiiI2aNRTru
RvoxI7JjTy3G1bOLd1blDPUnh9M2Rg==
=IV64
-----END PGP SIGNATURE-----

--9L1X55mk2QEFH0tnW7PJFlddLOysQ2Uki--


