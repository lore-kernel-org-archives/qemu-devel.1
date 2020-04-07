Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2859FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAB62051A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQTwW1wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAB62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmOm-0002Rk-4U
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLmOD-0001wV-8P
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLmOA-0008EM-W6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:27:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26924
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLmOA-0008DO-Sj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586258849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nDFHhB1+CBim+ZXN0fWXAP35ehnOKomLsxSc2yU6tmU=;
 b=jQTwW1wzow/YQzm6d+tfoHXyLwNSa+Zkz8vWimXP2vdlSY/1y1EAkjulQPgRl8sofSuD3J
 ZdJQl/lCLboHYGTH/iRA1UT5bY4JIjRWjlpa6hqPKOoHKbU5rzjXd9hRQTlFQe5eHQ18+d
 tAzMJ+ad1WCodiy9LpXbEAueRim91TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-LkWLGPjJMtyLmHpzuLqYdw-1; Tue, 07 Apr 2020 07:27:25 -0400
X-MC-Unique: LkWLGPjJMtyLmHpzuLqYdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FBC6149C0;
 Tue,  7 Apr 2020 11:27:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-84.ams2.redhat.com
 [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B535C1BB;
 Tue,  7 Apr 2020 11:27:19 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <5c5ee71e-f2d7-201d-73d1-2ee9a68b042a@redhat.com>
 <eead4e39-0784-1550-f245-ebe98e73f17e@redhat.com>
 <20200407111304.GD7695@linux.fritz.box>
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
Message-ID: <3c0ed069-7eeb-e2f1-1afb-d5690cc3cf9d@redhat.com>
Date: Tue, 7 Apr 2020 13:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407111304.GD7695@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sohvAw7ojPy96Thl8BMSwBnwbQFQExz8r"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, t.lamprecht@proxmox.com, stefanha@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sohvAw7ojPy96Thl8BMSwBnwbQFQExz8r
Content-Type: multipart/mixed; boundary="LD9MDaXrh5NqYIbYVYGHF5nhiDwmGHNLh"

--LD9MDaXrh5NqYIbYVYGHF5nhiDwmGHNLh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.04.20 13:13, Kevin Wolf wrote:
> Am 07.04.2020 um 12:15 hat Max Reitz geschrieben:
>> On 07.04.20 12:04, Max Reitz wrote:
>>> On 06.04.20 19:14, Kevin Wolf wrote:
>>>> External callers of blk_co_*() don't currently increase the
>>>> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so ther=
e
>>>> is an inconsistency whether the counter has been increased or not.
>>>>
>>>> This patch moves the actual operations to static functions that can
>>>> later know they will always be called with in_flight increased exactly
>>>> once, even for external callers using the blk_co_*() coroutine
>>>> interfaces.
>>>>
>>>> If the public blk_co_*() interface is unused, remove it.
>>>>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>> ---
>>>>  include/sysemu/block-backend.h |  1 -
>>>>  block/block-backend.c          | 94 +++++++++++++++++++++++++++------=
-
>>>>  2 files changed, 76 insertions(+), 19 deletions(-)
>>>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> On second thought (I assumed this would be addressed by the third
>> patch), blk_prw() no longer increments in_flight, but the blk_co_*
>> functions do that now.  In v1, blk_prw() did that.
>>
>> I thought we=E2=80=99d want blk_prw() to set in_flight, just like blk_ai=
o_prwv()
>> does, and then let the synchronous functions that use blk_prw() pass the
>> blk_do_* functions to it.
>=20
> Does it make a difference, though?

You mean because blk_prw() has a fast path for =E2=80=9Calready in coroutin=
e=E2=80=9D?
Perhaps not.  Still, feels a bit weird to me not to have in_flight
incremented around a potential POLL loop.

Maybe mostly I was wondering why v1 did and v2 didn=E2=80=99t. *shrug*

Max

> But the change should be easy enough (inc/dec in blk_prw() and the let
> *_entry() call blk_do_*() instead of blk_co_*()) that I guess I can just
> do it and send a v3.
>=20
> Kevin
>=20



--LD9MDaXrh5NqYIbYVYGHF5nhiDwmGHNLh--

--sohvAw7ojPy96Thl8BMSwBnwbQFQExz8r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6MY5UACgkQ9AfbAGHV
z0CREggAtMsfDlI4LP6sqasqOg2w6rVxvX8phWTym63o/YKjdmPF/weeMurSIsS0
o3cI5Ao/QfrkssNllR5oQplP+k3yZdH8NLfyoYH2qnyfc6OaKlLLZJ7MEILOU5nK
e/G/6kYjjKUQfhM3gaTRcFUvry0qfYzi2/r2wXI3SKQ8Zth/ezmg3uwNwW5hjDdm
cUgTRyNOvbG1D5+c1BLSWa77sieb7pbh1Gm15FLcDFtKu+/FdYHE2KNy+ZPhsNWM
boB6SwEKDY8hRqNl27Z8wZvoDcqc1qXPF7Co89PQqlcjNiRnY3pkUENdJ1SiR45d
Hefs6elVmJC7qslpB4FaxYNP25aNxw==
=9bT4
-----END PGP SIGNATURE-----

--sohvAw7ojPy96Thl8BMSwBnwbQFQExz8r--


