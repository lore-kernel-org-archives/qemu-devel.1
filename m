Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55453C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23213214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGnm72rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23213214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07nN-0006fh-BQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j07mO-0005NX-1X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j07mN-0007Eb-20
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:50:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j07mM-0007EI-TO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581097858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6R45R65EH+V0KV5UCa8Ss/Vrgpx4Z0fY/KkFDpkx7sk=;
 b=gGnm72rNEr1cyntOwn1tEtuAX8q04Y59GJveCPchzsNLpmYovwedWfeAvAWFrqrsWzCpoG
 ISNCZzqhvuStW4KctwhqKZhYDGxFXOFEtTftj8bvpUqE2xrWjysjYc1+4ffQMWQMFWSiIQ
 2UA1ODRWYifH+Mi/YctuZ9AW5mIQUh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-i_sQO95yO36kWEm1EP5Cnw-1; Fri, 07 Feb 2020 12:50:54 -0500
X-MC-Unique: i_sQO95yO36kWEm1EP5Cnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE4C100551A;
 Fri,  7 Feb 2020 17:50:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DDAF1001281;
 Fri,  7 Feb 2020 17:50:49 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] block/block-copy: factor out
 block_copy_find_inflight_req
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-4-vsementsov@virtuozzo.com>
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
Message-ID: <9052fcb8-33a5-4030-b22b-1016698f1e6d@redhat.com>
Date: Fri, 7 Feb 2020 18:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127180840.11937-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1xUdRqpKsmO2knvJRKl6cKbbBjrbidngI"
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1xUdRqpKsmO2knvJRKl6cKbbBjrbidngI
Content-Type: multipart/mixed; boundary="LDv7vs2fNWgqLDufz8ejrNt3F5VK9oHqW"

--LDv7vs2fNWgqLDufz8ejrNt3F5VK9oHqW
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
> Split block_copy_find_inflight_req to be used in seprate.

*separate, but separate what?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 74295d93d5..94e7e855ef 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -24,23 +24,30 @@
>  #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
>  #define BLOCK_COPY_MAX_MEM (128 * MiB)
> =20
> +static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState=
 *s,

Hm.  Long already, but the name begs the question what in-flight
requests this is about.  Maybe drop the block_copy prefix (unless you
plan to make this function global) and call it =93find_inflight_conflict=94=
?
 (Or =93find_conflicting_inflight_req=94 to be more verbose)

> +                                                          int64_t start,
> +                                                          int64_t end)
> +{
> +    BlockCopyInFlightReq *req;
> +
> +    QLIST_FOREACH(req, &s->inflight_reqs, list) {
> +        if (end > req->start_byte && start < req->end_byte) {
> +            return req;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s=
,
>                                                         int64_t start,
>                                                         int64_t end)
>  {
>      BlockCopyInFlightReq *req;
> -    bool waited;
> -
> -    do {
> -        waited =3D false;
> -        QLIST_FOREACH(req, &s->inflight_reqs, list) {
> -            if (end > req->start_byte && start < req->end_byte) {
> -                qemu_co_queue_wait(&req->wait_queue, NULL);
> -                waited =3D true;
> -                break;
> -            }
> -        }
> -    } while (waited);
> +
> +    while ((req =3D block_copy_find_inflight_req(s, start, end))) {
> +        qemu_co_queue_wait(&req->wait_queue, NULL);
> +    }
>  }

The change itself looks rather nice to me.  Even without other users of
this new function, it turns what=92s happening into a more obvious pattern.

Max


--LDv7vs2fNWgqLDufz8ejrNt3F5VK9oHqW--

--1xUdRqpKsmO2knvJRKl6cKbbBjrbidngI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49o3cACgkQ9AfbAGHV
z0ANTAf+L251VSNd81liEIThKrXP53gBJfPqYws1Z41KYHW4gl9vCXg0sbAktHuZ
xMBsay8iMjyXuAQ+SwrptMyyUceRugBaBxymlfHwzdUZEkgm8gnJSUpcYSopRMZe
n0NTa60BuJgLx0j/4d5MSrGGuGeqJvA4K3AG15P3uBoAwspPWm/173kQqrhzI/aZ
Ju0tapwONYAEnzNi6W6YJmNYPOgsTRPe6FgWjgbNUHK6udhQhTVxyCvej2ZK6igG
nDQbRGVmzViB5TOMykAFHLLQIYouSR4KYECm+CNFNurks0IhEq4kPTNEuxQbQeSQ
HXci6HN4SmlSsDslqC8J8kAHpSP9JA==
=Y0kG
-----END PGP SIGNATURE-----

--1xUdRqpKsmO2knvJRKl6cKbbBjrbidngI--


