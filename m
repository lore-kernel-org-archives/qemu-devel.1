Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15891C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2162071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcnGgP+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2162071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvBS-0000RL-V3
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRvAF-0007eI-KI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRvAE-0004pN-KG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:02:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRvAE-0004mz-3N
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587722548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XgYyYxHPo8xoE+m9924B0DsU8L9xqAYJJzVV+Wd5HIY=;
 b=YcnGgP+35ZLQVQMoMZbl2tvtsch8fptk+LT0aIMenH660sK/6f0808An1jQlu386cwtyF0
 3Rl4n4wdadZQkRfyafKl0MlmdYnOD7zGowLj+w5Tma4EcezC4Z0H9NyhEb9svOfUleYTv8
 dgw35Mb4EUAt729NZWYX+IGXPLVxS9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-TQbBDy-VMMKFbWZf01lOXQ-1; Fri, 24 Apr 2020 06:02:21 -0400
X-MC-Unique: TQbBDy-VMMKFbWZf01lOXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B66A7100A8EB;
 Fri, 24 Apr 2020 10:02:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCC1C5C1D6;
 Fri, 24 Apr 2020 10:02:16 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-2-eblake@redhat.com>
 <307f7619-5e4a-10c1-7d49-8ee6bb8d650c@redhat.com>
 <f3808938-8b27-3af0-c2da-996459a5c921@redhat.com>
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
Message-ID: <b8d91b29-67ea-3a50-864c-03ae907e092e@redhat.com>
Date: Fri, 24 Apr 2020 12:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f3808938-8b27-3af0-c2da-996459a5c921@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aQrJH1usNeiazIlSITT0t8fu2VxfwuNFC"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQrJH1usNeiazIlSITT0t8fu2VxfwuNFC
Content-Type: multipart/mixed; boundary="57lJJ86gBZWkwpjwV1qgOUO91XCmxZnfG"

--57lJJ86gBZWkwpjwV1qgOUO91XCmxZnfG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 11:56, Max Reitz wrote:
> On 24.04.20 11:53, Max Reitz wrote:
>> On 24.04.20 00:17, Eric Blake wrote:
>>> There are several callers that need to create a new block backend from
>>> an existing BDS; make the task slightly easier with a common helper
>>> routine.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  include/sysemu/block-backend.h |  2 ++
>>>  block/block-backend.c          | 23 +++++++++++++++++++++++
>>>  block/crypto.c                 |  8 +++-----
>>>  block/parallels.c              |  7 +++----
>>>  block/qcow.c                   |  7 +++----
>>>  block/qcow2.c                  | 15 ++++++---------
>>>  block/qed.c                    |  7 +++----
>>>  block/sheepdog.c               |  9 ++++-----
>>>  block/vdi.c                    |  7 +++----
>>>  block/vhdx.c                   |  7 +++----
>>>  block/vmdk.c                   |  9 ++++-----
>>>  block/vpc.c                    |  7 +++----
>>>  blockdev.c                     |  8 +++-----
>>>  blockjob.c                     |  7 ++-----
>>>  14 files changed, 65 insertions(+), 58 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> (With the Patchew warning fixed, of course (i.e., we should set ret to
> -EPERM or something in qcow.c))

Er, well, maybe I should have looked into more places.  The compiler
only warns about that single one because it=E2=80=99s the only place where =
@ret
is really uninitialized, but there are many more where we need to set
it: crypto.c, parallels.c, qcow.c, qcow2.c (both hunks), qed.c,
sheepdog.c, vdi.c, vhdx.c, and vpc.c.

(So basically everywhere but vmdk.c, blockdev.c, and blockjob.c.)

And now I=E2=80=99m going to get another coffee...

Max


--57lJJ86gBZWkwpjwV1qgOUO91XCmxZnfG--

--aQrJH1usNeiazIlSITT0t8fu2VxfwuNFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6iuScACgkQ9AfbAGHV
z0ArnggAtLHxovEVLHuv9hVrR8uPbHOmbmWTrZmt9j23wL/IRc7OM5ONjx1D3Ywa
l6f6bURAZ9Ctd1MeXlVctTfxDV9ueBGjyiTCgRPwOKhhYsgqt7jnxpPwoSZG2iXz
nGxIsD8TE5oz8aB9/wChUKNgqvsxDO6MxKPd002NKFy22EJTkjY2+1x2gHE7BEQM
BVO/B9DEecO6/aT49aS0F0uhQfNDWT7x4pDC/XN1OaXRzBdTbAo03Yj0ZLxY8fL3
tNr51srem9cPD83qYDvxy15j+M6z6qsR/Rmqo6/cSwFs5cccpQwiMqFpxfKcTkGd
O90XfZexoFjKZdFHMq5q4jYx38K3nA==
=8j2R
-----END PGP SIGNATURE-----

--aQrJH1usNeiazIlSITT0t8fu2VxfwuNFC--


