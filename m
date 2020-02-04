Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C44C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A6B2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qsxx48oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A6B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz252-00086L-7V
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz24D-0006uJ-Vt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz24C-0004Gu-Cg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:32:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz24C-0004Dv-89
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580837571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fGBjDpLS3D3daZ5VAzymXuI4Z0E5n0wOwKq3gjnfXjg=;
 b=Qsxx48oeDp+xhtRoA5Wj+ITxNLnr82rw+lFKExv3Y8y77ulLnJ9E6o/+L+dnzFqVNxpVFy
 nYaSmDNpRLheKeByxJ4p8QGQ+05sddN3TeUvnicycgc2nvnyaBSRbvsoG5JkeMHKsAn2RN
 JhVymM3CqTPy6yHqVvH+zm1duMDwvMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-YQIOJyiZMMGTCoFA5mRWjA-1; Tue, 04 Feb 2020 12:32:47 -0500
X-MC-Unique: YQIOJyiZMMGTCoFA5mRWjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DFB78C0361;
 Tue,  4 Feb 2020 17:32:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAAC45D9C5;
 Tue,  4 Feb 2020 17:32:44 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
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
Message-ID: <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
Date: Tue, 4 Feb 2020 18:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oLwNroRkPMMIbwqmQMyjWISP5QBa41am6"
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oLwNroRkPMMIbwqmQMyjWISP5QBa41am6
Content-Type: multipart/mixed; boundary="bIKhK8YLNHAK6rSaWbMR3oiJme3gri01J"

--bIKhK8YLNHAK6rSaWbMR3oiJme3gri01J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.01.20 18:44, Eric Blake wrote:
> Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
> ([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)
>=20
> I'm working on adding an NBD extension that reports whether an image
> is already all zero when the client first connects.  I initially
> thought I could write the NBD code to just call bdrv_has_zero_init(),
> but that turned out to be a bad assumption that instead resulted in
> this patch series.  The NBD patch will come later (and cross-posted to
> the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
> repositories).

We had a discussion about this on IRC, and as far as I remember I wasn=E2=
=80=99t
quite sold on the =E2=80=9Cwhy=E2=80=9D.  So, again, I wonder why this is n=
eeded.

I mean, it does make intuitive sense to want to know whether an image is
fully zero, but if I continue thinking about it I don=E2=80=99t know any ca=
se
where we would need to figure it out and where we could accept =E2=80=9CWe =
don=E2=80=99t
know=E2=80=9D as an answer.  So I=E2=80=99m looking for use cases, but this=
 cover letter
doesn=E2=80=99t mention any.  (And from a quick glance I don=E2=80=99t see =
this series
using the flag, actually.)

(We have a use case with convert -n to freshly created image files, but
my position on this on IRC was that we want the --target-is-zero flag
for that anyway: Auto-detection may always break, our preferred default
behavior may always change, so if you want convert -n not to touch the
target image except to write non-zero data from the source, we need a
--target-is-zero flag and users need to use it.  Well, management
layers, because I don=E2=80=99t think users would use convert -n anyway.

And with --target-is-zero and users effectively having to use it, I
don=E2=80=99t think that=E2=80=99s a good example of a use case.)

I suppose there is the point of blockdev-create + blockdev-mirror: This
has exactly the same problem as convert -n.  But again, if you really
want blockdev-mirror not just to force-zero the image, you probably need
to tell it so explicitly (i.e., with a --target-is-zero flag for
blockdev-mirror).

(Well, I suppose we could save us a target-is-zero for mirror if we took
this series and had a filter driver that force-reports BDRV_ZERO_OPEN.
But, well, please no.)

But maybe I=E2=80=99m just an idiot and there is no reason not to take this
series and make blockdev-create + blockdev-mirror do the sensible thing
by default in most cases. *shrug*

Max


--bIKhK8YLNHAK6rSaWbMR3oiJme3gri01J--

--oLwNroRkPMMIbwqmQMyjWISP5QBa41am6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl45qroACgkQ9AfbAGHV
z0BrsQf/c09Rqmm+qoVxM3crwz3Lrt04bIqU4636RaZmN7tX5gquAAvJ0m6V4J18
94xwEbYWVEvVCbc3ffVbIB7r/KZ0pzEhTlBGY95U5yKyOhEAaJmftqtVOqzSy9wd
k+B1EHVFmxadJMSJNStddFxx8Ze1IDeq1JUFVZYdezf4jfb7MGe1VYpPQoFwT4a0
zK7lB+6h+9h43h/jaUxy6Z2lkbt63NWHHKRClhrfZrrw0e93j8SJnaLV9LE+z99w
1yauq9zTzEC+bVzUXQxXGZ0ayh/nXF3lIVrkCAy54gdR6AxBu7PgbwwOwx4YugQH
4qOUHxszbik+37GgK08Yqm5nBXJN2g==
=jL/p
-----END PGP SIGNATURE-----

--oLwNroRkPMMIbwqmQMyjWISP5QBa41am6--


