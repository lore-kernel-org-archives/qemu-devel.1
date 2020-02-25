Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF9C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108812084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWkIgl7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108812084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dRI-0008Gl-85
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6dQN-0007RQ-8d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6dQM-0001CT-Av
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6dQM-0001CP-6E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582649469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D55gzuskg41PbBZQIIw3OomWbUKCfhCVp97674EFzJs=;
 b=eWkIgl7MCu/An242dNsP4NOJTUH0TrU1FGrvDqJFhLEOCxmXZcPg3x9qYTpGqj+j7Hd8v2
 m2PS6xmJSYoHlcvoaxKFpJthFW6wbs6XSsb87lyjfByo94DoS1+mPxb45Z2pcjLouSztCn
 YRXtInBpyFTkystUa6lY6istxLH1ZtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-mmq78bw7MomlRBSbznfxqg-1; Tue, 25 Feb 2020 11:51:07 -0500
X-MC-Unique: mmq78bw7MomlRBSbznfxqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566FE1088384;
 Tue, 25 Feb 2020 16:51:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8315D2718F;
 Tue, 25 Feb 2020 16:51:04 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] block/nbd: extract the common cleanup code
To: Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 pannengyuan@huawei.com
References: <1575517528-44312-1-git-send-email-pannengyuan@huawei.com>
 <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
 <20191205094259.r4qb4jxcrom76x7f@steredhat>
 <d5ff2791-0171-404b-3c19-69159921586b@redhat.com>
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
Message-ID: <192ae73b-f9b9-3a25-c82d-6ef5b22a7f57@redhat.com>
Date: Tue, 25 Feb 2020 17:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5ff2791-0171-404b-3c19-69159921586b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VQ8gla4Oxny3jb5mM7rzGq5giNhBnaSf5"
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
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VQ8gla4Oxny3jb5mM7rzGq5giNhBnaSf5
Content-Type: multipart/mixed; boundary="lQUKar4KQmp6Eu5fP3dkP7A5VvSr3RoVj"

--lQUKar4KQmp6Eu5fP3dkP7A5VvSr3RoVj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.12.19 15:04, Eric Blake wrote:
> On 12/5/19 3:42 AM, Stefano Garzarella wrote:
>> Hi Pan,
>>
>> On Thu, Dec 05, 2019 at 11:45:27AM +0800, pannengyuan@huawei.com wrote:
>>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>>
>>> The BDRVNBDState cleanup code is common in two places, add
>>> nbd_clear_bdrvstate() function to do these cleanups.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> I only suggested this change, so I think is better to change it in:
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Concur. I'll make that change while queuing this series through my NBD
> tree for 5.0.

Ping on that O:)

(Just going through mails in my inbox)

Max


--lQUKar4KQmp6Eu5fP3dkP7A5VvSr3RoVj--

--VQ8gla4Oxny3jb5mM7rzGq5giNhBnaSf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5VUHcACgkQ9AfbAGHV
z0AKfQgAjOJOLgQHG+l4FwcfkUhWoN3Knc6NQW50cDRsNgmKRR9qlBKSeWm3ilNr
AgskILqEdxdD5hwgcB17sSqCs1e2F9uL0ucNry5XuQtotq0FQGB7MIdBqtjzU2Vt
rjrRav7evtlCgvq5uKspMXN+Ps7Tz5n3yliTIbb+tPAB1anGDNU0gaYaeWryi0js
Zi5bAD6I/yX5jiaontBsyQ2XTU/c5tKMSShJgjbLu1sOp404gITc3cHynnkB0cCK
EQcKO4u8U7Rs0nCqW3fBrOirtS0fM31EpX/oDKEzNvMmFe1PBCwOgX3KMz/Vjodp
BfdfDTEwB5jE1G3x55ifLyq6x2jSZA==
=u/P0
-----END PGP SIGNATURE-----

--VQ8gla4Oxny3jb5mM7rzGq5giNhBnaSf5--


