Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D21C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4B8206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWAvHQq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4B8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTKr7-0005co-27
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTKlc-0003Oy-Vx
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTKha-0004OB-Pr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:34:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTKha-0004Nn-8U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588059045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XfM6g16L8gMWViHoNiVe35HWW/Pk+9G5jdXSN69RKsI=;
 b=DWAvHQq72c+2ps8I5iG5Rnh9WO26dZMRYpEuhCzkhn8pFeXhsTdji9hmf8jOfF0+kum/qg
 Q6hM0F80ZP8Hnfrj8Aw+whIlGR2+6qtIm7hMQEelg9WoFjvdYtqeBcD7caf9QLl5Fkpeth
 oDRy9DgdU9IseGHHJyvyYFtQ1QOuoCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-DS3KRv-KOSWb192tJsPjyg-1; Tue, 28 Apr 2020 03:30:42 -0400
X-MC-Unique: DS3KRv-KOSWb192tJsPjyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F6598018A7;
 Tue, 28 Apr 2020 07:30:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B918F6FEF1;
 Tue, 28 Apr 2020 07:30:39 +0000 (UTC)
Subject: Re: [PATCH v2 1/6] block/block-copy: rename in-flight requests to
 tasks
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-2-vsementsov@virtuozzo.com>
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
Message-ID: <da290ef0-c8dc-7cf0-fcf6-71e28aa323d5@redhat.com>
Date: Tue, 28 Apr 2020 09:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325134639.16337-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ESkIqomp3G2e5afHvkUShoWELcZDpie3f"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESkIqomp3G2e5afHvkUShoWELcZDpie3f
Content-Type: multipart/mixed; boundary="foOsIrQRwQBrmJ2nvc4G4wRGi3WxISIcL"

--foOsIrQRwQBrmJ2nvc4G4wRGi3WxISIcL
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
> We are going to use aio-task-pool API and extend in-flight request
> structure to be a successor of AioTask, so rename things appropriately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 99 +++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 50 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 05227e18bf..61d1d26991 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> -static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *=
s,
> -        BlockCopyInFlightReq *req, int64_t new_bytes)
> +static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
> +                                                BlockCopyTask *task,
> +                                                int64_t new_bytes)
>  {
> -    if (new_bytes =3D=3D req->bytes) {
> +    if (new_bytes =3D=3D task->bytes) {
>          return;
>      }
> =20
> -    assert(new_bytes > 0 && new_bytes < req->bytes);
> +    assert(new_bytes > 0 && new_bytes < task->bytes);
> =20
> -    s->in_flight_bytes -=3D req->bytes - new_bytes;
> +    s->in_flight_bytes -=3D task->bytes - new_bytes;
>      bdrv_set_dirty_bitmap(s->copy_bitmap,
> -                          req->offset + new_bytes, req->bytes - new_byte=
s);
> +                          task->offset + new_bytes, task->bytes - new_by=
tes);
> +    s->in_flight_bytes -=3D task->bytes - new_bytes;

This line doesn=92t seem right.

(The rest does.)

Max


--foOsIrQRwQBrmJ2nvc4G4wRGi3WxISIcL--

--ESkIqomp3G2e5afHvkUShoWELcZDpie3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6n254ACgkQ9AfbAGHV
z0DdqQf+OkQEQtO0VAquDeNPZJfq8LdsKaU1+wxLZ3UjrBtMNwZ4iem7QLoVxGrl
zCp+WFCsh38dfP4SB7eK0HrSRS3zL735OvbBBtwKXgmPPXi76WRL3zAhJ2tfGvJx
mp+dQ8rkrLKg5OvT587k1YuyAV9FUkC3ul6WHuu6t2xD+h7kK8vetHtmPPIcbZPm
K5ycgqRq5PcapIv00+Vd/AR7v7MNSI1gK2xpB7jTF3RROMElWATlktY08FnmCpVW
JqTCEJj0l20lv5wnzEeKXGVsydu0bEhYCioVoseV/tGIeF2WyEWVMVLsHWOeYtaL
Idj61orvz+FNBw8ajLtPh5OerwILeA==
=KClO
-----END PGP SIGNATURE-----

--ESkIqomp3G2e5afHvkUShoWELcZDpie3f--


