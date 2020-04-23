Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24CEC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA2620704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBf1TREU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA2620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYOk-0004if-SB
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRYMy-000370-A2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRYMw-0002Xv-RM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:42:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRYMw-0002VX-DT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587634925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9T/MduhvMGXXSvlTCZ10Qh67DXMq8ALbcW0SRhLDJKQ=;
 b=IBf1TREUxpZTazkY2mqUyBhSa5juy1fPcsL/VoeJE2U1t9oEwtcz5lDGnnzfCfikVyhL2R
 KYHZu59gNjDu0Up+aazrZrwUTpy7wVXhsiQkD+0PcTn5DwJrnCR86Ndm500vCDRYTkthSI
 kJpsyG8Y9hSuc+xft7GIWLTg4nvQKBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-OLS798dONbCUjV571kg7Uw-1; Thu, 23 Apr 2020 05:42:01 -0400
X-MC-Unique: OLS798dONbCUjV571kg7Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82C911B18BC0;
 Thu, 23 Apr 2020 09:42:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 664CF19488;
 Thu, 23 Apr 2020 09:41:57 +0000 (UTC)
Subject: Re: [PATCH v5 1/9] block: Add flags to BlockDriver.bdrv_co_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-2-kwolf@redhat.com>
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
Message-ID: <f867217d-c202-5d5b-7fb4-ca68e6553265@redhat.com>
Date: Thu, 23 Apr 2020 11:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422152129.167074-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0rWvkoYQHXxDpHXmde3ctDsOR2WE1pWVk"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0rWvkoYQHXxDpHXmde3ctDsOR2WE1pWVk
Content-Type: multipart/mixed; boundary="T3NgBPXNOspd1AJvsWQaakERPOzl6n1kp"

--T3NgBPXNOspd1AJvsWQaakERPOzl6n1kp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.04.20 17:21, Kevin Wolf wrote:
> This adds a new BdrvRequestFlags parameter to the .bdrv_co_truncate()
> driver callbacks, and a supported_truncate_flags field in
> BlockDriverState that allows drivers to advertise support for request
> flags in the context of truncate.
>=20
> For now, we always pass 0 and no drivers declare support for any flag.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/block/block_int.h   | 10 +++++++++-
>  block/crypto.c              |  3 ++-
>  block/file-posix.c          |  2 +-
>  block/file-win32.c          |  2 +-
>  block/gluster.c             |  1 +
>  block/io.c                  |  8 +++++++-
>  block/iscsi.c               |  2 +-
>  block/nfs.c                 |  3 ++-
>  block/qcow2.c               |  2 +-
>  block/qed.c                 |  1 +
>  block/raw-format.c          |  2 +-
>  block/rbd.c                 |  1 +
>  block/sheepdog.c            |  4 ++--
>  block/ssh.c                 |  2 +-
>  tests/test-block-iothread.c |  3 ++-
>  15 files changed, 33 insertions(+), 13 deletions(-)

(I know I haven=E2=80=99t complained before, so *shrug*, but I wonder now
whether it actually makes sense to have the same BdrvRequestFlags for
all request types.  Or why we have the same flags type for read, write,
and zero-write already.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--T3NgBPXNOspd1AJvsWQaakERPOzl6n1kp--

--0rWvkoYQHXxDpHXmde3ctDsOR2WE1pWVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6hYuIACgkQ9AfbAGHV
z0DAigf+OxscORVSnpGUMeAtSj59x2B4o+6NrLq4HaQ++wTn/OWxS5X7FXtZtzQe
geTXnbbJmmSMPno2Hg8RXHMg/YX160Hzgt/2CyVBAkSH2aX6PQwVKlG0Pc0pmxRh
FC1nTMNZC+YceuDvocBcCZ/jfrlj536impR5mJLEgP+qiRQokUf+JUuZv/dNtEKd
YGE3A2HTLzO5vD0B8l5CjG7WbYJpC39TP6AV4CN48txxZJk2HorpsLhZut+f/K/y
XoQOyVPVYC9Hy719u5YVJ6Ep7K/dFDkviNhO0prFSltlOgsBJnB79jTpZEG4Fv5Z
AGkhf0BVrcIrlGdxuIDkouXpMBD/ZA==
=VIGm
-----END PGP SIGNATURE-----

--0rWvkoYQHXxDpHXmde3ctDsOR2WE1pWVk--


