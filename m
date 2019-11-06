Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0ECC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6822077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0RIiY1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6822077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLD8-0004Pp-9r
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSL5h-0002jH-Ac
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSL5g-0008Kq-0N
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:11:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSL5f-0008Ka-SM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573045875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4L6kYyF9SUzz8QMQzcQ2MU6nKDBhqgP856FNh/6S0eE=;
 b=Y0RIiY1stIqlwnh/y/WpY5TAI9ovpW4jpO/KESEfLtXoFsAa4hW1nxvXUYD0fHsvT7qQys
 vMhl00GRRBpXo53DYwGh8lMVstpBQJMmDHPCJnx6JpzYmHoJkZjTO9UZ9jniJl8qBvJkE2
 fL3fcJeNHLDgfFeGBzFv/CQRJoWuh6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-riTBriN_NEePHAOHhhi-ww-1; Wed, 06 Nov 2019 08:11:10 -0500
X-MC-Unique: riTBriN_NEePHAOHhhi-ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07BF01005500;
 Wed,  6 Nov 2019 13:11:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431875D70E;
 Wed,  6 Nov 2019 13:11:07 +0000 (UTC)
Subject: Re: [RFC PATCH 08/18] qemu-storage-daemon: Add --export option
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-9-kwolf@redhat.com>
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
Message-ID: <5d920618-219a-6dd2-5823-3fc3f09e6a61@redhat.com>
Date: Wed, 6 Nov 2019 14:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-9-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LIecHgLTNpQmoAcGCy5JuZU2K0HncD9nG"
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LIecHgLTNpQmoAcGCy5JuZU2K0HncD9nG
Content-Type: multipart/mixed; boundary="UXI2MjBGrpsU6i4JD1Im6Yt5u7IcdAQk2"

--UXI2MjBGrpsU6i4JD1Im6Yt5u7IcdAQk2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 15:01, Kevin Wolf wrote:
> Add a --export option to qemu-storage-daemon to export a block node. For
> now, only NBD exports are implemented. Apart from the 'type' option
> (which is the implied key), it maps the arguments for nbd-server-add to
> the command line. Example:
>=20
>     --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block.json       | 27 +++++++++++++++++++++++++++
>  qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)

Would it be better to collect the BlockExports in a list and work on it
after all arguments have been parsed?  As it is, it=E2=80=99s important tha=
t
users define block devices and things like NBD servers before --export.
 Yes, I know, that=E2=80=99s exactly how it works with qemu, but is that re=
ally
the best way?

Max


--UXI2MjBGrpsU6i4JD1Im6Yt5u7IcdAQk2--

--LIecHgLTNpQmoAcGCy5JuZU2K0HncD9nG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CxmoACgkQ9AfbAGHV
z0ANYAf+PedlHhe/YBcFc8CtAQSiAk5rnENU9H2IMwTIsLUC51r89RXsG6Hh+0c8
Ngq2Bcg/iZXd9Xx2f+KxbW0ve0XgSRlkm10bmrOtSm3baCHStiTc54myqatfavNa
ZUruS6dMVwwWEx6S10VkSo5yuUY2lCH5lloIpzJ6ydzr1F+aEw8on53blwMEVec/
eKmqNj6YbULMhQK/XV7qjFJb6ZWIbfqpQKippk4W9inpiphqUoB95S6Gq7i/LSB8
cn0Luz2J3SKqfoLx+o5cEuK9pHxZX8rhUaQNo3JjttiZJ9+SHZK+TBEMoYNysDVi
zDiMEmzc9M5vhRgXrlGwLs0/ScVyAg==
=RAx5
-----END PGP SIGNATURE-----

--LIecHgLTNpQmoAcGCy5JuZU2K0HncD9nG--


