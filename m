Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDAEC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBF020757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCnMh6hT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBF020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzSR-0002WM-6w
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jJzRV-00021l-Ho
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jJzRU-00072B-1O
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:59:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jJzRT-00071v-Sq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585832371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jzHIYaBzCrIskqpeDrFxFg4TLVQ/TMjKLy3j+HD4LKs=;
 b=QCnMh6hTev/kwPGNG/diDlaWMmizRqdcCeI7vdTmrN/r71BlxKUZOgEnkfxiEI9yhIRdUG
 BlZFvNSHZtXiui6bncyNnzC4hIhzvcm/I66s4Yf+97OdNAqj9HN1lKy5vwh8Ve8MvplUdW
 s9Y3Y4EQxwKWPsjHNYRheczOj7Hh6f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237--CISKgo4MgeCZGhlnJeBSw-1; Thu, 02 Apr 2020 08:59:28 -0400
X-MC-Unique: -CISKgo4MgeCZGhlnJeBSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 240791084434;
 Thu,  2 Apr 2020 12:59:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-246.ams2.redhat.com
 [10.36.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 919594D9E9;
 Thu,  2 Apr 2020 12:59:17 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] backup: don't acquire aio_context in backup_clean
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200401081504.200017-1-s.reiter@proxmox.com>
 <20200401081504.200017-4-s.reiter@proxmox.com>
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
Message-ID: <d342623b-c799-6103-18c8-656b036c60de@redhat.com>
Date: Thu, 2 Apr 2020 14:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401081504.200017-4-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xxGY4oDKo9foq0PszwJfH49sehk2pzCDi"
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xxGY4oDKo9foq0PszwJfH49sehk2pzCDi
Content-Type: multipart/mixed; boundary="TgL4KbXxdZ5xRmNxJ1eEcEWlsCSLY62x5"

--TgL4KbXxdZ5xRmNxJ1eEcEWlsCSLY62x5
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.04.20 10:15, Stefan Reiter wrote:
> All code-paths leading to backup_clean (via job_clean) have the job's
> context already acquired. The job's context is guaranteed to be the same
> as the one used by backup_top via backup_job_create.
>=20
> Since the previous logic effectively acquired the lock twice, this
> broke cleanup of backups for disks using IO threads, since the BDRV_POLL_=
WHILE
> in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release the l=
ock
> once, thus deadlocking with the IO thread.
>=20
> This is a partial revert of 0abf2581717a19.
>=20
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>=20
> With the two previous patches applied, the commit message should now hold=
 true.
>=20
>  block/backup.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TgL4KbXxdZ5xRmNxJ1eEcEWlsCSLY62x5--

--xxGY4oDKo9foq0PszwJfH49sehk2pzCDi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6F4aMACgkQ9AfbAGHV
z0CCvgf+NR7TamTud8WORVauca4dDo0mRZ/YyiJ+fB++mQfxZLQjU2yH59d1mNg/
URDFrQZ2gJwniTL0pYY00aNeJ9Q35qiFIG5LEaomyl5s1guBSfSHGKaLARSJKxxU
GjNN0/jRWk0r/9v+JHRI7gJGUJT6LqeA9OOY/RKqE6ycF3oJ+Ly7GlMkySZPzk/o
UvnWLWH8f44GUsR49PyIYfWiNe8JtUQ5LXGhWu+3hIqL3A92clDr62NDJ02fXWfW
LVZ/1ytYCHaCZib+3pFluWlNp7g79Eaz2L51TTPnTN8QzF89gBm2voiqX+2QaX1F
Jq0tQKRO0We/+LSYPcjcaSihPmL9Dw==
=pzd1
-----END PGP SIGNATURE-----

--xxGY4oDKo9foq0PszwJfH49sehk2pzCDi--


