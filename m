Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD7FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43799206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWY1koqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43799206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOJH-0006lM-Du
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLOGW-0001TW-RZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLOGV-00026d-0S
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLOGU-000267-SZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586166118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y3suTsH1bbq3JZgfq8zijBQI8w0ebNIfdnaWy1uPVnw=;
 b=iWY1koqFzDbKfKeXj0Ftof3eDnYqtXPv/BjX6wTClzJ925MjIBnJzmnCB4R87j7zw0Ohl3
 LFv9hLr7JNsLPehYcbwRLsGGy8vEnftpxHt5wRseWQoG/sN5aJVNGdmyTIsO19qhjbtItp
 2cAOskzI/6TcKiNkNqhwyNe0JrXREdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-ReYXmZ4yM8GdiFj3KvfFWA-1; Mon, 06 Apr 2020 05:41:54 -0400
X-MC-Unique: ReYXmZ4yM8GdiFj3KvfFWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1DBC8017F3;
 Mon,  6 Apr 2020 09:41:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-161.ams2.redhat.com
 [10.36.114.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F66B60BF1;
 Mon,  6 Apr 2020 09:41:46 +0000 (UTC)
Subject: Re: [PATCH for-5.0 2/2] block: Fix blk->in_flight during
 blk_wait_while_drained()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200403104415.20963-1-kwolf@redhat.com>
 <20200403104415.20963-3-kwolf@redhat.com>
 <30e7194e-afbc-2822-f086-9891539c0e3a@redhat.com>
 <20200403145017.GE5336@linux.fritz.box>
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
Message-ID: <e1af671f-ed90-29ab-429f-5d9dedbf5024@redhat.com>
Date: Mon, 6 Apr 2020 11:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403145017.GE5336@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dYM7hB2V3zWaoNennahEXioKnxcSJe8Vn"
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
--dYM7hB2V3zWaoNennahEXioKnxcSJe8Vn
Content-Type: multipart/mixed; boundary="UsfEIQFv8nM5szviunKqL2i1ciccVStmJ"

--UsfEIQFv8nM5szviunKqL2i1ciccVStmJ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.04.20 16:50, Kevin Wolf wrote:
> Am 03.04.2020 um 14:42 hat Max Reitz geschrieben:
>> On 03.04.20 12:44, Kevin Wolf wrote:
>>> Calling blk_wait_while_drained() while blk->in_flight is increased for
>>> the current request is wrong because it will cause the drain operation
>>> to deadlock.
>>>
>>> Many callers of blk_wait_while_drained() have already increased
>>> blk->in_flight when called in a blk_aio_*() path, but can also be calle=
d
>>> in synchonous code paths where blk->in_flight isn't increased. This
>>> means that these calls of blk_wait_while_drained() are wrong at least i=
n
>>> some cases.
>>>
>>> In order to fix this, increase blk->in_flight even for synchronous
>>> operations and temporarily decrease the counter again in
>>> blk_wait_while_drained().
>>>
>>> Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/block-backend.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> blk_co_pdiscard() and blk_co_flush() are called from outside of
>> block-backend.c (namely from mirror.c and nbd/server.c).  Is that OK?
>=20
> Hm... I think you're right that the NBD server has a problem now because
> we might now decrease blk->in_flight without having increased it.
> (Mirror should be fine anyway because it sets disable_request_queuing.)
>=20
> At first I was going to suggest that we could do the opposite of this
> patch and just move the dec/wait/inc sequence (which this patch removes
> for read/write) to all coroutine entry functions, so direct calls
> wouldn't incorrectly decrease the counter.
>=20
> But this is not what we want either, we do want to queue requests for
> drained BlockBackends even in the blk_co_*() API.
>=20
> Do you have another idea or do we have to turn blk_co_*() into wrappers
> around the existing functions, which would gain an additional bool
> parameter that tells whether we need to dec/inc or not?

So that whenever blk_co_* is called from outside of block-backend.c, we
don=92t dec/inc?

Sounds reasonable to me.

The only alternative I see would be ensuring we call
blk_wait_while_drained() only outside of in_flight sections (without
having to dec/inc around it).  But we can=92t call it in synchronous
sections.  And for those synchronous calls, we also have to wrap the
in_flight section around the whole asynchronous boilerplate, so there is
no place where they can call bdrv_wait_while_drained() without dec/inc
around it.

So I can=92t think of another way either.

Max


--UsfEIQFv8nM5szviunKqL2i1ciccVStmJ--

--dYM7hB2V3zWaoNennahEXioKnxcSJe8Vn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6K+VgACgkQ9AfbAGHV
z0CC0Qf+O3sceGqqQSatwkDHWs0f68tR5jHSXnUumlGaPdFvrI7bhjWfSBMlQrbo
PwpxBh1EtcaqOj4WPaFCKcJpWxz1k3YEedzknJgV2OlGGoQ/tudsgSfUfEWEFIqQ
90WTPIASVn3L2Qs3iwjiYyRe/3TWrCM5URCRhsdkgE8ca8fSFzGBmVs0RoO89TyU
gWuxsOD2wFN5MNlURI2Pi7BZhiO2MhD9x1S8L9+J+MK58tjob3Tbw1FYPivYGxCM
dfUxIwWn9Bcmnps8gLkFWvwY4JF4q7zAcjNtFf2a6MykEDR95aP/GwDEci50ivtM
cAwHUviDQwkMYJAeya1YM/EkTm5cZw==
=De8H
-----END PGP SIGNATURE-----

--dYM7hB2V3zWaoNennahEXioKnxcSJe8Vn--


