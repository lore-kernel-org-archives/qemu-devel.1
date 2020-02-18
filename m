Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33509C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21C9206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxQvyAic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21C9206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j41aO-0005ka-6T
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j41Zl-00057g-VZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j41Zk-0005Cv-VK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:02:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j41Zk-0005CZ-Q9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582027324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lc4ag3OUKKWLF3z5n8PyZ5pRZYiD3VfVc5w7nKB+Xro=;
 b=DxQvyAicILOkphuX8F0r/XOO+bJbMiEMYCQe8A2224iqeaKvMfgWcyhHTqubMTqiHqi8Kj
 fkZLwkO1xTjXaTVPYJpSEBIj9LpctykpjcTeOWem/MpFOEQriRCDKqRZBldDmfbMN94NB5
 WttgEsdUnSgTwvOJ5rjIqOo9KwDY9lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-R_Q9PLNxM6WuVz7OhvNW9w-1; Tue, 18 Feb 2020 07:01:59 -0500
X-MC-Unique: R_Q9PLNxM6WuVz7OhvNW9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCFF4189F76D;
 Tue, 18 Feb 2020 12:01:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE13A388;
 Tue, 18 Feb 2020 12:01:56 +0000 (UTC)
Subject: Re: [PATCH v2 32/33] block: Pass BdrvChildRole in remaining cases
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-33-mreitz@redhat.com>
 <f4607467-cc6e-ce10-4afa-c2c2f8fb116f@redhat.com>
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
Message-ID: <1b8cc66d-dc0e-bfa8-c060-4decdfa1242a@redhat.com>
Date: Tue, 18 Feb 2020 13:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f4607467-cc6e-ce10-4afa-c2c2f8fb116f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8EHQPAaF8Q5yKVzwStXhyaWH39MUUCvZN"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8EHQPAaF8Q5yKVzwStXhyaWH39MUUCvZN
Content-Type: multipart/mixed; boundary="YEMU0mTGJ11Pgmpqj1EC10YqT6Ir2xchc"

--YEMU0mTGJ11Pgmpqj1EC10YqT6Ir2xchc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.02.20 16:53, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> These calls have no real use for the child role yet, but it will not
>> harm to give one.
>>
>> Notably, the bdrv_root_attach_child() call in blockjob.c is left
>> unmodified because there is not much the generic BlockJob object wants
>> from its children.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/block-backend.c | 11 +++++++----
>> =C2=A0 block/vvfat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
>> =C2=A0 2 files changed, 8 insertions(+), 5 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Is it worth an assert(role) somewhere now that you've converted all
> callers to pass at least one role?

Well, as the commit message states, block_job_add_bdrv() in blockjob.c
still passes BdrvChildRole=3D0 to bdrv_root_attach_child().  So it depends
on what function we=E2=80=99re looking at.

I suppose we could add such an assertion to bdrv_attach_child() because
we could expect all BDSs to pass some role for their children.

OTOH, maybe a BDS has a legitimate reason not to: Maybe it just wants to
take some permissions on some BDS without having any real relationship
to it.  Right now, some block jobs do that, well, except they do so
through the back door of adding the child BDS to the block job object
(which then passes no child role).  So maybe I=E2=80=99d actually rather no=
t add
such an assertion anywhere.

Max


--YEMU0mTGJ11Pgmpqj1EC10YqT6Ir2xchc--

--8EHQPAaF8Q5yKVzwStXhyaWH39MUUCvZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5L0jIACgkQ9AfbAGHV
z0DFIAf/QXzoGxVCi4y55isuXhe0TG2hMo5nFwODFy/ic/qKD9/v97JforkzIg+6
ecxsy3qFfRBcVQ9eLRcR3hl4/EMQciJF3s3AYHnnnwaFcrf3M6jyGAxeKvgkFH5n
K8njUxgT8RWdqamqkJpjIXD10TppEnUBy6wtScSttIVw3+SVoaPsga9vZD6QTfOB
S6xPkTp+JplN2b7fm5EqNJLpXXIT5KHtPwu7RMdW6QC4ixwuTv7FUDa9m1XMbSOk
An8UpjFvbfkw4F4BOu2H9zqz6Q4UyUYb+1SmrSXzdGb8KE4T+ib9nvK1GGjEUJM/
DWHzYVupIZMy3SDpPlACh7xmzG3U5Q==
=Jbg7
-----END PGP SIGNATURE-----

--8EHQPAaF8Q5yKVzwStXhyaWH39MUUCvZN--


