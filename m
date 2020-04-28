Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27970C83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A71206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC2zDv9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A71206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMmW-0006CK-7X
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTMT9-0005yj-Db
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTLz8-0007XY-3A
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:57:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33007
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTLz7-0007XJ-Gk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588063976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cjdUEQHGZb0sfVpEwg7oXdqDO3o9GpcB0Vz3zhKTjAU=;
 b=UC2zDv9MQDNc9jiETAKYxsw8ObKTQg4n/kx5ELWHgIW5eR73ezEjKYsEeRrpY4QhewA0OI
 YPoBo43vOK10CgM6jAXyITYGKMs6qPSVo2XtEkNUjGWQl4ABprPFflBooCHGbN6RDwDLxH
 ZjArL6cJ7MIcPkr7Bhsb2qGwKIp0Akk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-dxStsTvXMfeZ4aPFnVq6wA-1; Tue, 28 Apr 2020 04:52:53 -0400
X-MC-Unique: dxStsTvXMfeZ4aPFnVq6wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6549D1899521;
 Tue, 28 Apr 2020 08:52:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01C3F1002388;
 Tue, 28 Apr 2020 08:52:50 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] block/block-copy: move task size initial
 calculation to _task_create
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-5-vsementsov@virtuozzo.com>
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
Message-ID: <630a5655-7b00-3ee4-943d-e4b5ad52db57@redhat.com>
Date: Tue, 28 Apr 2020 10:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325134639.16337-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KFVOL47rrfni8ryVIhgHL7balCRG4fnPb"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KFVOL47rrfni8ryVIhgHL7balCRG4fnPb
Content-Type: multipart/mixed; boundary="4hKalja2jVV1Lpf1R7NlLRQBhDvYNzKpA"

--4hKalja2jVV1Lpf1R7NlLRQBhDvYNzKpA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
> Comment "Called only on full-dirty region" without corresponding
> assertion is a very unsafe thing.

Not sure whether it=92s that unsafe for a static function with a single
caller, but, well.

> Adding assertion means call
> bdrv_dirty_bitmap_next_zero twice. Instead, let's move
> bdrv_dirty_bitmap_next_zero call to block_copy_task_create. It also
> allows to drop cur_bytes variable which partly duplicate task->bytes.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 47 ++++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 63d8468b27..dd406eb4bb 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -106,12 +106,23 @@ static bool coroutine_fn block_copy_wait_one(BlockC=
opyState *s, int64_t offset,
>      return true;
>  }
> =20
> -/* Called only on full-dirty region */
>  static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>                                               int64_t offset, int64_t byt=
es)

A bit of documentation on the new interface might be nice.  For one
thing, that @offset must be dirty, although there is an assertion that,
well, checks it.  (An assertion doesn=92t really check anything, it rather
verifies a contract.  And violation is fatal.)

For another, what the range [offset, offset + bytes) is; namely
basically the whole range of data that we might potentially copy, only
that the head must be dirty, but the tail may be clean.

Which makes me think that the interface is maybe less than intuitive.
It would make more sense if we could just call this function on the
whole region and it would figure out whether @offset is dirty by itself
(and return NULL if it isn=92t).

OTOH I suppose the interface how it is here is more useful for
task-ification.  But maybe that should be documented.

>  {
> +    int64_t next_zero;
>      BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
> =20
> +    assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
> +
> +    bytes =3D MIN(bytes, s->copy_size);
> +    next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, by=
tes);
> +    if (next_zero >=3D 0) {
> +        assert(next_zero > offset); /* offset is dirty */
> +        assert(next_zero < offset + bytes); /* no need to do MIN() */
> +        bytes =3D next_zero - offset;
> +    }
> +
> +    /* region is dirty, so no existent tasks possible in it */

s/existent/existing/?

(The code movement and how you replaced cur_bytes by task->bytes looks
good.)

Max

>      assert(!find_conflicting_task(s, offset, bytes));
> =20
>      bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);


--4hKalja2jVV1Lpf1R7NlLRQBhDvYNzKpA--

--KFVOL47rrfni8ryVIhgHL7balCRG4fnPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6n7uEACgkQ9AfbAGHV
z0CzWggAvwt2QGFcPWkETOOvrxjtRynLvO/RQAGJydwG/7qxDcO5BZxdnO7a3teD
Znp19KAqe0ehbgJrdSNuxRfu4a4Dvgg0WshrTaZ0se7A7qy+/XpEIjh6dIUTEnN4
3kAB4C+Zl4kktY4mjQJsjTwMOUIOL+feiYlCgy0ARM7zRXjr0r4WM7/V88+nEc8a
2Z/k/94miJc6Bx+9+92RaTpSR+Q/jUBtVPg6iUobZWVzYdQHOFHTlutVl0CO67xQ
McuP7FppaNOgcQnL8l5jHOF/O/xRWRigwM0MXU2DQJFcRPrpkasg24kZ0ccBp+K4
8z9UtEjPFywTOLciHL3SXJHIbKpElw==
=AJgQ
-----END PGP SIGNATURE-----

--KFVOL47rrfni8ryVIhgHL7balCRG4fnPb--


