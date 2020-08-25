Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB24F2074A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb2U9pBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB24F2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYjD-0005Ih-VK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAYib-0004i2-AT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAYiZ-0002Zp-J3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598361026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=66EGx37QWYYRhen2ZkuDRHxo6UJrxBW+eDwBf4oJqVc=;
 b=gb2U9pBKaJUyn4KH6PViIPl5H/CiiLVBt586mkaJS1FS8CtabnIpc1E6wQswipYWyp+bIz
 dZNWf9fwwfF5r97gxT6adDgZbmXcIOHL32BtXFjr9+9HYWP9Yp48PPukskehxdZCWlItMk
 o/9/tiPpR64hS10ng/3ANw+YNwWKwPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-BCSVYAsjMjWvJQ645-ULAQ-1; Tue, 25 Aug 2020 09:10:22 -0400
X-MC-Unique: BCSVYAsjMjWvJQ645-ULAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7298030A5;
 Tue, 25 Aug 2020 13:10:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-72.ams2.redhat.com
 [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BB019144;
 Tue, 25 Aug 2020 13:10:15 +0000 (UTC)
Subject: Re: [PATCH v5 06/10] block: introduce BDRV_REQ_NO_WAIT flag
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-7-vsementsov@virtuozzo.com>
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
Message-ID: <15cbc4e6-2a81-935f-ea26-5e98b80f40c2@redhat.com>
Date: Tue, 25 Aug 2020 15:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821141123.28538-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yQv549sZ2bCGuBlGk5L8tJhoH4d5GuQSN"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yQv549sZ2bCGuBlGk5L8tJhoH4d5GuQSN
Content-Type: multipart/mixed; boundary="zJk4bmZ5cKqhVca2jG6L5v4SRnsYQMRsH"

--zJk4bmZ5cKqhVca2jG6L5v4SRnsYQMRsH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
> Add flag to make serialising request no wait: if there are conflicting
> requests, just return error immediately. It's will be used in upcoming
> preallocate filter.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block.h |  9 ++++++++-
>  block/io.c            | 11 ++++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index b8f4e86e8d..877fda06a4 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -67,8 +67,15 @@ typedef enum {
>       * written to qiov parameter which may be NULL.
>       */
>      BDRV_REQ_PREFETCH  =3D 0x200,
> +
> +    /*
> +     * If we need to wait for other requests, just fail immediately. Use=
d
> +     * only together with BDRV_REQ_SERIALISING.
> +     */
> +    BDRV_REQ_NO_WAIT =3D 0x400,
> +
>      /* Mask of valid flags */
> -    BDRV_REQ_MASK               =3D 0x3ff,
> +    BDRV_REQ_MASK               =3D 0x7ff,
>  } BdrvRequestFlags;
> =20
>  typedef struct BlockSizes {
> diff --git a/block/io.c b/block/io.c
> index dd28befb08..c93b1e98a3 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_=
t offset, uint64_t bytes,
>      assert(!(bs->open_flags & BDRV_O_INACTIVE));
>      assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
>      assert(!(flags & ~BDRV_REQ_MASK));
> +    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISIN=
G)));
> =20
>      if (flags & BDRV_REQ_SERIALISING) {
> -        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
> +        QEMU_LOCK_GUARD(&bs->reqs_lock);
> +
> +        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
> +
> +        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(=
req)) {

bdrv_find_conflicting_request() will return NULL even if there are
conflicting requests, but those have a non-NULL waiting_for.  Is that
something to consider?

(I would like to think that will never have a real impact because then
we must find some other conflicting request; but isn=E2=80=99t is possible =
that
we find an overlapping request that waits for another request with which
it overlaps, but our request does not?)

Max

> +            return -EBUSY;
> +        }
> +
> +        bdrv_wait_serialising_requests_locked(req);
>      } else {
>          bdrv_wait_serialising_requests(req);
>      }
>=20



--zJk4bmZ5cKqhVca2jG6L5v4SRnsYQMRsH--

--yQv549sZ2bCGuBlGk5L8tJhoH4d5GuQSN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9FDbYACgkQ9AfbAGHV
z0A2hAf/RGEXk/+pVKVj4Gcdnp5YSZIZVYoFFMGLxVTmrTFr5U393OVLRhbAFzpa
xQQ54Y0C/BxlyGB7Xw5dkEc1+Q4LUteN0o1I58in4EqQhTXIGVOp3YnLY2bWHOEV
IGn710MNKY3Z8sAY5BBOHRY71OHtqpqLPE4f4VVnBrRE/UfpWZF68VlNB8KMAW5N
y18FzuvpLfiMcREw88nOH5TUlmrxQyHO8552xP1A4pL3OJ32WomY2Zl4QPpStxmt
9i5eFtAsWZ6vVfvo+GVrBHZCOeDLIupwxhcOq4QLufpTir1ySEZ5UsaUx5FPHrLm
k8W5HrXiit85gRDlZG5/2TNPOIJmVg==
=FAhW
-----END PGP SIGNATURE-----

--yQv549sZ2bCGuBlGk5L8tJhoH4d5GuQSN--


