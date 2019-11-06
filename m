Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A624C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBF1206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/XuX/NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBF1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJQA-0008GQ-4l
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSJP0-0007By-Q0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSJOz-0007u0-Nt
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSJOz-0007t1-J9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573039384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eyg76jI79GLJicYubdra05istv81sd4MHxhgGAP7XT4=;
 b=e/XuX/NJVQCvcd92KqCyUC2fxh76nFYjm9kPFWsjNOIkzTVDRUFBYUDpoCbcJJ/PjjUtIb
 Eh7jafBFQZMHro4F4t3+SFjsIwrM7HPQM8tiVvibEr7lM0CwXc06IRdIcv7LUyaYhhQfWk
 PEtspbprb0LNUV1ZnYNxrBVsje0fYok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Rat7pAFyPJa0-FyYfpVnHQ-1; Wed, 06 Nov 2019 06:23:01 -0500
X-MC-Unique: Rat7pAFyPJa0-FyYfpVnHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338D11005500;
 Wed,  6 Nov 2019 11:23:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75F23600CD;
 Wed,  6 Nov 2019 11:22:58 +0000 (UTC)
Subject: Re: backup_calculate_cluster_size does not consider source
To: Dietmar Maurer <dietmar@proxmox.com>,
 Wolfgang Bumiller <w.bumiller@proxmox.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
 <37f72cb7-7085-3c40-7728-e41d59137b3b@redhat.com>
 <1868807950.27.1573039080274@webmail.proxmox.com>
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
Message-ID: <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
Date: Wed, 6 Nov 2019 12:22:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1868807950.27.1573039080274@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFPvHXf25LjRt7P164YVObrDQUnaX27XE"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFPvHXf25LjRt7P164YVObrDQUnaX27XE
Content-Type: multipart/mixed; boundary="preZmzZH4v53Q5pdw7DmJVC9F6gOEzJAa"

--preZmzZH4v53Q5pdw7DmJVC9F6gOEzJAa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 12:18, Dietmar Maurer wrote:
>> And if it issues a smaller request, there is no way for a guest device
>> to tell it =E2=80=9COK, here=E2=80=99s your data, but note we have a who=
le 4 MB chunk
>> around it, maybe you=E2=80=99d like to take that as well...?=E2=80=9D
>>
>> I understand wanting to increase the backup buffer size, but I don=E2=80=
=99t
>> quite understand why we=E2=80=99d want it to increase to the source clus=
ter size
>> when the guest also has no idea what the source cluster size is.
>=20
> Because it is more efficent.

For rbd.

Max


--preZmzZH4v53Q5pdw7DmJVC9F6gOEzJAa--

--YFPvHXf25LjRt7P164YVObrDQUnaX27XE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CrRAACgkQ9AfbAGHV
z0BT6wf/TD2xoJN9bYLCDXGuTZZ8ZW7m8kvtXrOneU3x+rNWQPatDsOqa9LfPWKe
Iqm8XsM1l/gGOKvbzD9bovcH3ZNPyxTV40lA+O0nmSkFkuIEJry2/LcbMJgxlKqD
RRgUHLdI7s9lnZ/7xRq0CeGntMf/GnBmYNir7bfar6M+9J+ITXlrHwE7GUSAD7GT
TB/Xp8F1lgXissjus3ZnWv3wSKUeIiB7vZDHCRaqi8i55WJZy+CJqsXdck5+pajy
1maCglyZhvBPM5itVkJ1GoFphPGQrDxBgG5duSeEP0MdvVgO5PgwwFFIUlHLTaZE
QREXx4B4aUvZvIzWheDMH5B22+0aYg==
=St1g
-----END PGP SIGNATURE-----

--YFPvHXf25LjRt7P164YVObrDQUnaX27XE--


