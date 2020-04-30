Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92922C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625C62063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWfNGNs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625C62063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9tj-0000j5-IN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU9jM-0004IQ-JC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU9jE-0002Ld-Mt
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:00:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jU9jD-0002IY-Lr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588255190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pmDosqE1Oirsf6ocNAOrftzvMqS58bUxRPXD6Qj3q6c=;
 b=MWfNGNs1nAOUTYqabNBeGirQ/xdaTZ2PG/76J5wM04P1bGwQFUQnpNFFpA80fwPrnUuLeg
 bo6hQLTY2F0U/chCJI0xLqzWbPvBgc9r8LalYV6Qgp6nay9iOvSmSIfS8CracNgu9+KVbO
 QQQwSUXNRAFpIEBpShekmF1vhXMAOyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-6LqEr2qLM4mhIKFK9sYVgQ-1; Thu, 30 Apr 2020 09:59:45 -0400
X-MC-Unique: 6LqEr2qLM4mhIKFK9sYVgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479B1EC1C3;
 Thu, 30 Apr 2020 13:59:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 602E75C1B0;
 Thu, 30 Apr 2020 13:59:42 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] blockdev: Split off basic bitmap operations for
 qemu-img
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-3-eblake@redhat.com>
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
Message-ID: <6ce69bac-9bbc-05fd-e658-89a2ad63a322@redhat.com>
Date: Thu, 30 Apr 2020 15:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421212019.170707-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6YgsGtQx2dCQBE5ldcbMONKKCaf4d8WSL"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6YgsGtQx2dCQBE5ldcbMONKKCaf4d8WSL
Content-Type: multipart/mixed; boundary="ZvNzlU4f2MjYhIOpn4bQcJSXbbRZV0jYC"

--ZvNzlU4f2MjYhIOpn4bQcJSXbbRZV0jYC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 23:20, Eric Blake wrote:
> Upcoming patches want to add some basic bitmap manipulation abilities
> to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
> (among other things, it would drag in block jobs and transaction
> support - qemu-img does offline manipulation, where atomicity is less
> important because there are no concurrent modifications to compete
> with), so it's time to split off the bare bones of what we will need
> into a new file blockbitmaps.o.
>=20
> In addition to exposing 6 QMP commands for use by qemu-img (add,
> remove, clear, enable, disable, merge), this also has to export three
> previously-static functions for use by blockdev.c transactions.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  Makefile.objs             |   2 +-
>  include/sysemu/blockdev.h |  14 ++
>  blockbitmaps.c            | 324 ++++++++++++++++++++++++++++++++++++++

Hm.  Can we get a better name?  blockdev-bitmaps.c, for example?

>  blockdev.c                | 293 ----------------------------------
>  MAINTAINERS               |   1 +
>  5 files changed, 340 insertions(+), 294 deletions(-)
>  create mode 100644 blockbitmaps.c

[...]

> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
> index a86d99b3d875..523b7493b1cd 100644
> --- a/include/sysemu/blockdev.h
> +++ b/include/sysemu/blockdev.h
> @@ -57,4 +57,18 @@ QemuOpts *drive_add(BlockInterfaceType type, int index=
, const char *file,
>  DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_typ=
e,
>                       Error **errp);
>=20
> +BdrvDirtyBitmap *block_dirty_bitmap_lookup(const char *node,
> +                                           const char *name,
> +                                           BlockDriverState **pbs,
> +                                           Error **errp);
> +BdrvDirtyBitmap *do_block_dirty_bitmap_remove(const char *node,
> +                                              const char *name, bool rel=
ease,
> +                                              BlockDriverState **bitmap_=
bs,
> +                                              Error **errp);
> +BdrvDirtyBitmap *do_block_dirty_bitmap_merge(const char *node,
> +                                             const char *target,
> +                                             BlockDirtyBitmapMergeSource=
List *bitmaps,
> +                                             HBitmap **backup, Error **e=
rrp);

Putting do_* functions into a normal header seems a bit weird.  Would
these fit better into block_int.h?

> +
>  #endif

[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cbc1fac2bfc..769cd357d281 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1989,6 +1989,7 @@ T: git https://github.com/jnsnow/qemu.git jobs
>  Block QAPI, monitor, command line
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> +F: blockbitmaps.c

The natural choice for something split off of blockdev.c, but I wonder
if the Dirty Bitmaps section wouldn=E2=80=99t be a better fit.

Max

>  F: blockdev.c
>  F: blockdev-hmp-cmds.c
>  F: block/qapi.c
>=20



--ZvNzlU4f2MjYhIOpn4bQcJSXbbRZV0jYC--

--6YgsGtQx2dCQBE5ldcbMONKKCaf4d8WSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6q2cwACgkQ9AfbAGHV
z0DYlAgAgnwMILd/tMvGQyksAM37mw5sfSTeTj4t98tKZZiLns0W5pwo1AQXcCJG
Coa1u3SuOqF+Kp93dNutTULH6UWiegLdp4471EXfVAHBYPNps/hYvz66JiZM0sf2
CgmHVUqL6kM4qy7kmOxJrrZT2z/RV+Sm9dkyvuaK9zFEfht01UzEUAhWB9OFd8I4
robC3LovqaJTUrEHuzps9auqaemZWtZWv2YEwOsGXzUEyZeBoXhwWKjDQk90g0HX
oFD4Gsoud5wTZxDcV86ZRrP35p7PnnGb5Uds2JIo/JoqJOuphmMjFodUZxWkTdBV
AgBClruSPnVfQ29A3mRjbQuoNgbscQ==
=NP8N
-----END PGP SIGNATURE-----

--6YgsGtQx2dCQBE5ldcbMONKKCaf4d8WSL--


