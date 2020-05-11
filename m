Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A8C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42061206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQch8mqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42061206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6L4-00051A-ED
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY6KP-0004N3-De
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY6KO-0005fw-79
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589195430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dgWTyGqiyJ5Q/U+WgF4MnlRI7SNIGOSF/hjS0rrT0UA=;
 b=VQch8mqhkUKEGuhbRqSiXflXvzGnKuzPfBUsNJHXt2XQaVCyQA+/Lx1G020Rm8qvoVrjX0
 GbZzyuMIuwhwa1iXXAHMQPDuzARNYyrYlUgnqfma5fYE0pvcP8fYsOkTV2hwaBdx8HyFNv
 vZxC2W8OaDwInGbdRfTuEAohNunFc40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-tmwFeUx8PRe09gMlOu_W7g-1; Mon, 11 May 2020 07:10:28 -0400
X-MC-Unique: tmwFeUx8PRe09gMlOu_W7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5AA64AD2;
 Mon, 11 May 2020 11:10:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30355610AF;
 Mon, 11 May 2020 11:10:21 +0000 (UTC)
Subject: Re: [PATCH v3 6/9] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-7-eblake@redhat.com>
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
Message-ID: <ce9731fd-d137-f5d2-6dc4-071a0b9e0b97@redhat.com>
Date: Mon, 11 May 2020 13:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508180340.675712-7-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lAOumSAb6sBxNgI7vxqwNfDNPf0WoDhMi"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lAOumSAb6sBxNgI7vxqwNfDNPf0WoDhMi
Content-Type: multipart/mixed; boundary="mDDNpvZ1lTO8o4XxW7fCNF2csd9h9aESW"

--mDDNpvZ1lTO8o4XxW7fCNF2csd9h9aESW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.05.20 20:03, Eric Blake wrote:
> Include actions for --add, --remove, --clear, --enable, --disable, and
> --merge (note that --clear is a bit of fluff, because the same can be
> accomplished by removing a bitmap and then adding a new one in its
> place, but it matches what QMP commands exist).  Listing is omitted,
> because it does not require a bitmap name and because it was already
> possible with 'qemu-img info'.  A single command line can play one or
> more bitmap commands in sequence on the same bitmap name (although all
> added bitmaps share the same granularity, and and all merged bitmaps
> come from the same source file).  Merge defaults to other bitmaps in
> the primary image, but can also be told to merge bitmaps from a
> distinct image.

For the record: Yes, my comment was mostly about my confusion around the
{}.  So just replacing them by () would have pacified me.

But this is more fun, of course.

> While this supports --image-opts for the file being modified, I did
> not think it worth the extra complexity to support that for the source
> file in a cross-file merges.  Likewise, I chose to have --merge only
> take a single source rather than following the QMP support for
> multiple merges in one go (although you can still use more than one
> --merge in the command line); in part because qemu-img is offline and
> therefore atomicity is not an issue.
>=20
> Upcoming patches will add iotest coverage of these commands while
> also testing other features.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/tools/qemu-img.rst |  23 ++++
>  qemu-img.c              | 254 ++++++++++++++++++++++++++++++++++++++++
>  qemu-img-cmds.hx        |   7 ++
>  3 files changed, 284 insertions(+)
>=20
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 7d08c48d308f..68393c357386 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -281,6 +281,29 @@ Command description:

[...]

> +  Additional options ``-g`` set a non-default *GRANULARITY* for

sets?

With that fixed (or maybe not, you know that better than me):

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mDDNpvZ1lTO8o4XxW7fCNF2csd9h9aESW--

--lAOumSAb6sBxNgI7vxqwNfDNPf0WoDhMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65MokACgkQ9AfbAGHV
z0DEsQf/UZW2G2wuzLzeDSEax8RtCzHT6NvVdzCo9h3EBfGlb3BuocZqhGyMtPDH
2pnIsHJ8TpzPnzNdoPhyJy5O6VXTZ8+kcokwcGTZtkK/ZD+D2mAfW682W8XXA1tS
yVrc/xN+m4u8fxAD7eZHeT7fh9lsO9O7MHzON9hCreQz/r38uU/15bmioD6itvcG
oe6Aets8bYM5aILFd5XhAYBqC915j2DyG5eauyI6PUjnIOPu9VJMDaxWXD+ZHLZJ
FTx53l2Y+ayMcIMlmtQxGyU3zB+sfxub6ijQPVTZfMg5Lq7oR9wWj/u2x9oL7A4z
xkq976Swz3eN/M2i+JyXMTALq3SrBA==
=5QBC
-----END PGP SIGNATURE-----

--lAOumSAb6sBxNgI7vxqwNfDNPf0WoDhMi--


