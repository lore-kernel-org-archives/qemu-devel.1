Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6CAC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D94820720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D11AfOtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D94820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4eF-0007Hp-IF
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY4df-0006h5-0G
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:22:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY4dd-0004Fc-H5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589188936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xpCMpgp2eOj5QEKsF5MFdfKRTdkDsI22iUq17sI6IxU=;
 b=D11AfOtvRE1XwyzQ+73OCaIcPm51Q42BUY4ONaNt5SLbetyRMF5ztkSahScSeJqUfJNTmU
 gVK5tElbhxTpPotK1kJ0tFArbr3h4tcO3v5KuhPDYbyINx78POBk8tw/Y6H7tV5e/XvG8I
 Fj+Sqj6XeqchRkufx6VvUWPT9VZqKJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-4TheFBb5OLqGVmZpPXCbpw-1; Mon, 11 May 2020 05:22:14 -0400
X-MC-Unique: 4TheFBb5OLqGVmZpPXCbpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09B5C475;
 Mon, 11 May 2020 09:22:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1293F38E;
 Mon, 11 May 2020 09:22:01 +0000 (UTC)
Subject: Re: [PATCH v3 3/9] block: Make it easier to learn which BDS support
 bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-4-eblake@redhat.com>
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
Message-ID: <aba3eddd-1201-9182-6011-9fe0bbca1b76@redhat.com>
Date: Mon, 11 May 2020 11:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508180340.675712-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KoHrgWC9lcnKwTG6vq5DCZNEWpY4IyeLt"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KoHrgWC9lcnKwTG6vq5DCZNEWpY4IyeLt
Content-Type: multipart/mixed; boundary="b0jGwRJyB55rVdf7qdvOw6moXoVq2if3a"

--b0jGwRJyB55rVdf7qdvOw6moXoVq2if3a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.05.20 20:03, Eric Blake wrote:
> Upcoming patches will enhance bitmap support in qemu-img, but in doing
> so, it turns out to be nice to suppress output when bitmaps make no
> sense (such as on a qcow2 v2 image).  Add a hook to make this easier
> to query.
>=20
> In the future, when we improve the ability to look up bitmaps through
> a filter, we will probably also want to teach the block layer to
> automatically let filters pass this request on through.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h                | 1 +
>  include/block/block_int.h    | 1 +
>  include/block/dirty-bitmap.h | 1 +
>  block/dirty-bitmap.c         | 9 +++++++++
>  block/qcow2-bitmap.c         | 7 +++++++
>  block/qcow2.c                | 1 +
>  6 files changed, 20 insertions(+)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index f4de0a27d5c3..fb2b2b5a7b4d 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -764,6 +764,7 @@ bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverS=
tate *bs,
>  int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>                                              const char *name,
>                                              Error **errp);
> +bool qcow2_dirty_bitmap_supported(BlockDriverState *bs);
>=20
>  ssize_t coroutine_fn
>  qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index df6d0273d679..cb1082da4c43 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -560,6 +560,7 @@ struct BlockDriver {
>                               uint64_t parent_perm, uint64_t parent_share=
d,
>                               uint64_t *nperm, uint64_t *nshared);
>=20
> +    bool (*bdrv_dirty_bitmap_supported)(BlockDriverState *bs);

All BDSs support bitmaps, but only some support persistent dirty
bitmaps, so I think the name should reflect that.

Conceptually, this looks reasonable.  This information might indeed be
nice to have, and I=E2=80=99m not sure whether we should extend any existin=
g
interface to return it.

(The interfaces that come to my mind are:
(1) bdrv_can_store_new_dirty_bitmap() below, which we could make accept
a NULL @name to return basically the same information.  But it=E2=80=99s st=
ill a
bit different, because I=E2=80=99d expect that function to return whether a=
ny
bitmap can be stored then, not whether the node supports bitmaps at all.
 So e.g. if there are already too many bitmaps, it should return false,
even though the node itself does support bitmaps.

(2) bdrv_get_info()/BlockDriverInfo: This information would fit in very
nicely here, but do we have to put it here just because it does?  I
don=E2=80=99t think so.  This patch adds 20 lines of code, that shows that =
it=E2=80=99s
very simple to add a dedicated method, and it=E2=80=99s certainly a bit eas=
ier
to use than to invoke bdrv_get_info() and throw away all the other
information.  Perhaps this patch only shows that BlockDriverInfo doesn=E2=
=80=99t
make much sense in the first place, and most of its fields should have
been scalar return values from dedicated functions.)

Max


--b0jGwRJyB55rVdf7qdvOw6moXoVq2if3a--

--KoHrgWC9lcnKwTG6vq5DCZNEWpY4IyeLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65GTIACgkQ9AfbAGHV
z0BIswf6AuHSSVg8BoM2paXheSqDvrx56rYZNDu2vq/LoMDh5ZHhhySMFh8RLk0A
ChccmDnYTgBgqZpPBBNZ2U0O4fizA7FoxSff5SkZiWbsfigoxJqRd50i1yFjUUky
L9afNvBgIWuuMx3MDYlXl1rbvOBrHF8ekiWJtweU8IWASgoNaNz8bTx/c1896k5w
q5Ncny2CD1RHinh4KARMNiNcYaSVkyLKHac2c2j/ITB9rSsDa2dGPffsngO6+eL9
cyy1gKdDudp5VkDJT54Nb+ApMTzxfTU8Zn+TkdXQJZuYUskoSSlnFkAEWS2HTo0e
8in0x/lGcDXxyzAyU90vBM06JykE7A==
=Ayp5
-----END PGP SIGNATURE-----

--KoHrgWC9lcnKwTG6vq5DCZNEWpY4IyeLt--


