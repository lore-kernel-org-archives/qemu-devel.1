Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920F3C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA9820848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUmZ9t+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA9820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSg7E-0002kW-Eg
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSg5E-0001FD-89
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSg58-0007Jd-OW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602679237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WMzLPs/AsJtR7K/FaS5FuQ9ZPcohwRT+b5bXRL2aEe0=;
 b=HUmZ9t+Eu2/JDcuW360c+Y7W2C9LLN59b2xuSB9j643N4h+n8gHrywooBkVyUvVgkE/xv4
 pDw7/2QIM3fCxEhX/1uwLouihJZNdVdvPj8ke79Q53Nv+Bxxrc8gsS8lBV/GpHW9V9habV
 IgpcbuLo/usgbQ8WqW/Sro859BAOY/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-Gljg43HLPG6sigAUT4Yneg-1; Wed, 14 Oct 2020 08:40:33 -0400
X-MC-Unique: Gljg43HLPG6sigAUT4Yneg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3FC3835BB8;
 Wed, 14 Oct 2020 12:40:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FA2419C4F;
 Wed, 14 Oct 2020 12:40:22 +0000 (UTC)
Subject: Re: [PATCH v11 08/13] copy-on-read: add support for BDRV_REQ_PREFETCH
 to COR-filter
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-9-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <14b5dbdb-2ee7-bc27-3757-00f49ce6e530@redhat.com>
Date: Wed, 14 Oct 2020 14:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-9-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wIkYO5ypS0fwJMz0rknKmunR5PgnTOJTS"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIkYO5ypS0fwJMz0rknKmunR5PgnTOJTS
Content-Type: multipart/mixed; boundary="LmTMuJAXCTNYwHUKDuVyXKvTfbEdLrzkF"

--LmTMuJAXCTNYwHUKDuVyXKvTfbEdLrzkF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> Add support for the BDRV_REQ_PREFETCH flag to the supported_write_flags

s/write/read/

> of the COR-filter.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/copy-on-read.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index dfbd6ad..b136895 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -50,6 +50,7 @@ static int cor_open(BlockDriverState *bs, QDict *option=
s, int flags,
>          return -EINVAL;
>      }
> =20
> +    bs->supported_read_flags =3D BDRV_REQ_PREFETCH;
>      bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
>          (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);

Then we mustn=E2=80=99t let cor_co_preadv_part() pass the flag on to
bdrv_co_preadv_part() unless BDRV_REQ_COPY_ON_READ is set, too.  I
suspect the following patch is going to do that, but in the meantime the
code is wrong.

Perhaps just swap both patches?

And by the way, I=E2=80=99m also missing a patch that makes the block layer
evaluate supported_read_flags and e.g. strip BDRV_REQ_PREFETCH if it
isn=E2=80=99t supported, before it gets passed to such a block driver.

Max


--LmTMuJAXCTNYwHUKDuVyXKvTfbEdLrzkF--

--wIkYO5ypS0fwJMz0rknKmunR5PgnTOJTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+G8bQACgkQ9AfbAGHV
z0APvgf9GEFngSS1GzYwGcNCWmexO/jji88uuYgDwvfTHb8jN76QJbLiz09qsLmk
yHGxvGoO2NAxLbX21sC3/QPcHuqWEM+eIbN1Oi2u30vzew+tNQZ/v+RvFZvmUWxw
rMa97JYTZXpGXqvyAU3QHpVDVCFyuGLCEVahDEKX8AiUcUHtV+GGUuPw57OepLPZ
/bmgV47VKuT2HR+lo/43ezTdI2KIDryO87/x6nDT0UtKBTQdkTLkE6r8KOA8/1AS
89PAAHYOvIp3LbQKhHpxoUHz1UHaun0rl5cXEjYXWQyQT59AHi13po3ApzPykR3F
y3d9cPZD00pZYbvsWBFYdXH86RzI/w==
=O7NZ
-----END PGP SIGNATURE-----

--wIkYO5ypS0fwJMz0rknKmunR5PgnTOJTS--


