Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A68C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8310C222D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOg/4Zvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8310C222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzbV-0002Mb-MW
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWzag-0001uq-Cp
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWzab-00042M-J3
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:14:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWzab-00041y-Ef
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574154865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xYWTxUIolqxSTOGpPtEyJ+Cph87Fm3ko3BaI/OhVA0Y=;
 b=AOg/4Zvb+tU96XvROZ/EdmArJlRiJYbpyF6HUeNrj5jABQcBZN+QzgWaku9lKtXFxfP9me
 4e1lKE1eJjddhu+Y4Cxt0hhKwQGjrql5bigPtuEdfg9KqVq/H2zyGfWPHx0oB+pUhSTp3o
 Bk0EX7ff7ZwsktTZiUdtK6AdRsAwKGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-qmeOd2-JMP-HrxYeVfpFAw-1; Tue, 19 Nov 2019 04:14:21 -0500
X-MC-Unique: qmeOd2-JMP-HrxYeVfpFAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E6F80268C;
 Tue, 19 Nov 2019 09:14:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63817627DE;
 Tue, 19 Nov 2019 09:14:16 +0000 (UTC)
Subject: Re: [PATCH v3 1/8] blockdev: merge drive_backup_prepare with
 do_drive_backup
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191112113012.71136-1-slp@redhat.com>
 <20191112113012.71136-2-slp@redhat.com>
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
Message-ID: <4713f16c-35c2-7d5e-0326-bd50316291c1@redhat.com>
Date: Tue, 19 Nov 2019 10:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112113012.71136-2-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eB8F4dUgyIq2UDZMykSyQYdW0UacsdwEn"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eB8F4dUgyIq2UDZMykSyQYdW0UacsdwEn
Content-Type: multipart/mixed; boundary="WceQYJCGtPnYD7J6sOXxbyPUcHgrNoQ3Z"

--WceQYJCGtPnYD7J6sOXxbyPUcHgrNoQ3Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.11.19 12:30, Sergio Lopez wrote:
> Consolidate drive_backup_prepare() with do_drive_backup() as a first
> step towards streamlining all functionality through transactions.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 58 +++++++++++++++---------------------------------------
>  1 file changed, 16 insertions(+), 42 deletions(-)

qemu no longer compiles with this patch applied, for two reasons:

(1) actions[TRANSACTION_ACTION_KIND_DRIVE_BACKUP].prepare is initialized
with drive_backup_prepare on line 2175, but this patch merges it into
do_drive_backup(), which is only on line 3556, so we need a forward
declaration.

(2) qmp_drive_backup() calls do_drive_backup(), but that function no
longer exists.

Max


--WceQYJCGtPnYD7J6sOXxbyPUcHgrNoQ3Z--

--eB8F4dUgyIq2UDZMykSyQYdW0UacsdwEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3TsmUACgkQ9AfbAGHV
z0A8cgf/cHYvktSZL92SCwouX0iN25ain+SGRlPSxD5lujS2d0PCioOxfaVII+Rg
nOtHZXrjAPISuy+vuWkKSHR68yN47qEoBqnyEAIPW+lYAWy2Qi4Y6vv6+ivKaQ7R
eoOG2jk0WxRo2xqIip62OD0duDAGrHSsHGcZQrlme6WrW+seUd/1Sb+g1h5nl5Xx
lvPdKoFOqLnMrKoRaxP4zMWRGcl0Oqc48R1bT0bIaxzedkcTRETR/bPFStvM9KnJ
FW5gseYb4NLQ/v5O17fPY3P3c+G+zrgE6TzNHeOnR25l7WGHh7mUj8ieB9e2FGpZ
WRKbKWO4DjJfWjfctaztVvDVZWm5SQ==
=aCnG
-----END PGP SIGNATURE-----

--eB8F4dUgyIq2UDZMykSyQYdW0UacsdwEn--


