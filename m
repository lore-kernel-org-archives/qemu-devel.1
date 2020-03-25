Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE86C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC6D20722
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3L24Pys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC6D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4F5-0003UN-FZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jH4EP-0002vU-4T
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jH4EO-00078j-7n
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:29:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jH4EO-00078W-3n
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585135795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+/zPNopU/9VlwF424iJtRB+GEw+wevvwBtA5A5J4gZs=;
 b=K3L24PystdIuzTazIzuXwDlbfXuG06csS21sg4OvNLoCtj916M4tWOl6xxcBWXUGsFkk0j
 zH5WR1QEOsHqzedWSJwLNhaPor7fD0zw/ai/fZeJQ1Lz/d8H+db7nLua0Ub33I/0PhmtwP
 a4zT1IU39gv1JPNczERxLfduFB1xQls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kvS4iGDHN_elKHWybM0a3A-1; Wed, 25 Mar 2020 07:29:53 -0400
X-MC-Unique: kvS4iGDHN_elKHWybM0a3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4245A1005514;
 Wed, 25 Mar 2020 11:29:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-33.ams2.redhat.com
 [10.36.115.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A399B6266E;
 Wed, 25 Mar 2020 11:29:45 +0000 (UTC)
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
 <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
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
Message-ID: <d41243c5-91c6-3e4a-fa8d-6fbe009822c2@redhat.com>
Date: Wed, 25 Mar 2020 12:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y7qtw0xg3iBLZydxDwDG3fRI9v1XKhpG2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 mdroth@linux.vnet.ibm.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y7qtw0xg3iBLZydxDwDG3fRI9v1XKhpG2
Content-Type: multipart/mixed; boundary="YGzBvTnobi7KvVvI0sGdt50Od9ssImI3X"

--YGzBvTnobi7KvVvI0sGdt50Od9ssImI3X
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 12:11, Max Reitz wrote:
> On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
>> local_err is used again in mirror_exit_common() after
>> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
>> non-NULL local_err will crash.
>=20
> OK, but wouldn=92t it be better hygiene to set it to NULL every time it i=
s
> freed?  (There is a second instance of error_report_err() in this
> function.  I=92m a bit worried we might introduce another local_err use
> after that one at some point in the future, and forget to run the cocci
> script then.)
>=20
> Are the cocci scripts run regularly by someone?  E.g. as part of a pull
> to master?

Doesn=92t look like it.  I=92m currently running everything, and there=92s =
a
lot of results so far.

Max


--YGzBvTnobi7KvVvI0sGdt50Od9ssImI3X--

--Y7qtw0xg3iBLZydxDwDG3fRI9v1XKhpG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl57QKcACgkQ9AfbAGHV
z0B36gf/QWWJKnxbvaYMUjYofJ+WOb/yZgQSpKDZ8HWTRlRgpbfiliyCS+9NMGzK
ylGVbqInywDfJVdn3ZgvUwUkBq8f3pT/Pyw4O1PIsr2Ekur9MwvJ1Bdqp6c6EyRB
X9cXjFZXm95P/VrFvcNQKpG46BjACS72fH5kvLjuMeeTxaJun/IPy0QYdp0xh4wU
FIobPbaXQ79TQJDwbgYRAxeyT4K5kHsnkFLaQOZ+UaG7J6W8LUSxlVB6sIWEts2r
uu+EPaTyhKhlkNcftpJn77ORmY2KXCF6ngkP/87ndkGCc78XHNA55DRPA3sm7yaE
YDCoqkBv42wQUBoZn0b7Ak2h64QkPg==
=Rvs4
-----END PGP SIGNATURE-----

--Y7qtw0xg3iBLZydxDwDG3fRI9v1XKhpG2--


