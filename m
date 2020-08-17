Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BD0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9E52067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/EmqRFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9E52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7g7c-0005vG-1B
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7g6s-0005MW-HX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7g6q-0004om-A7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597674454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=urVCxjs10+/XFWNaF0By+yjQxKzJRcyzRbMiPcPQbU8=;
 b=H/EmqRFszVzbaZDxphD9nFa/ZXz8zENm4YO786oEYhZOZrV6zOyZcDAgHqf85RiZpXsRl0
 tKBEvOzT0mBSKoRjPN0Hh0te/EOmJMGspQ+ntt69+Qdfhj9ZxJNRg6U3lTme78TOQ8Yl48
 NgHpvaGawbgUteqVATVlUdx+tGy3SHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-7lOEknSON76rnfS5hkQdIw-1; Mon, 17 Aug 2020 10:27:32 -0400
X-MC-Unique: 7lOEknSON76rnfS5hkQdIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47F511015DC6;
 Mon, 17 Aug 2020 14:27:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AA1F54596;
 Mon, 17 Aug 2020 14:27:27 +0000 (UTC)
Subject: Re: [RFC PATCH 11/22] qemu-nbd: Use blk_exp_add() to create the export
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-12-kwolf@redhat.com>
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
Message-ID: <d9d9ce92-291b-7e25-bc32-c0d899e73842@redhat.com>
Date: Mon, 17 Aug 2020 16:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-12-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="szEf7fFD2Sy8aH5EO2HwvCl01RNKtq8Tg"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--szEf7fFD2Sy8aH5EO2HwvCl01RNKtq8Tg
Content-Type: multipart/mixed; boundary="jYVn8bGlKMA5AqKos4lA6vQUNavywJtSB"

--jYVn8bGlKMA5AqKos4lA6vQUNavywJtSB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> With this change, NBD exports are only created through the BlockExport
> interface any more. This allows us finally to move things from the NBD
> layer to the BlockExport layer if they make sense for other export
> types, too.

I see.

> blk_exp_add() returns only a weak reference, so the explicit
> nbd_export_put() goes away.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h |  2 ++
>  include/block/nbd.h    |  1 +
>  block/export/export.c  |  2 +-
>  blockdev-nbd.c         |  8 +++++++-
>  qemu-nbd.c             | 28 ++++++++++++++++++++++------
>  5 files changed, 33 insertions(+), 8 deletions(-)

[...]

> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index d5b084acc2..8dd127af52 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c

[...]

> @@ -176,7 +182,7 @@ BlockExport *nbd_export_create(BlockExportOptions *ex=
p_args, Error **errp)
> =20
>      assert(exp_args->type =3D=3D BLOCK_EXPORT_TYPE_NBD);
> =20
> -    if (!nbd_server) {
> +    if (!nbd_server && !is_qemu_nbd) {

(This begs the question of how difficult it would be to let qemu-nbd use
QMP=E2=80=99s nbd-server-start, but I will not ask it, for I fear the answe=
r.)

>          error_setg(errp, "NBD server not running");
>          return NULL;
>      }
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 48aa8a9d46..d967b8fcb9 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c

[...]

> @@ -1050,9 +1050,27 @@ int main(int argc, char **argv)
> =20
>      bs->detect_zeroes =3D detect_zeroes;
> =20
> -    export =3D nbd_export_new(bs, export_name,
> -                            export_description, bitmap, readonly, shared=
 > 1,
> -                            writethrough, &error_fatal);
> +    nbd_server_is_qemu_nbd(true);
> +
> +    export_opts =3D g_new(BlockExportOptions, 1);
> +    *export_opts =3D (BlockExportOptions) {
> +        .type               =3D BLOCK_EXPORT_TYPE_NBD,
> +        .has_writethrough   =3D true,
> +        .writethrough       =3D writethrough,
> +        .u.nbd =3D {
> +            .device             =3D g_strdup(bdrv_get_node_name(bs)),
> +            .has_name           =3D true,
> +            .name               =3D g_strdup(export_name),
> +            .has_description    =3D !!export_description,
> +            .description        =3D g_strdup(export_description),
> +            .has_writable       =3D true,
> +            .writable           =3D !readonly,
> +            .has_bitmap         =3D !!bitmap,
> +            .bitmap             =3D g_strdup(bitmap),
> +        },
> +    };
> +    blk_exp_add(export_opts, &error_fatal);

Why not use the already-global qmp_block_export_add(), if we don=E2=80=99t =
need
the return value here?  (Will we require it at some point?)

Max

> +    qapi_free_BlockExportOptions(export_opts);
> =20
>      if (device) {
>  #if HAVE_NBD_DEVICE


--jYVn8bGlKMA5AqKos4lA6vQUNavywJtSB--

--szEf7fFD2Sy8aH5EO2HwvCl01RNKtq8Tg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86k84ACgkQ9AfbAGHV
z0BlXgf/eI+714lYO5BXwQ9pTJTG5rjB3WmjECl/r17YEQM132iT5OmZFmwJZjmR
+6dolhwUW2v28Vs8eZZE06nN01uZurB9XmBl6H7wX2VJs7mkRCojOL5YdmX6XJj2
VBU+LagKOTscuHoPuxYiL2g/EtQvjvGVOObOnOr8zO1C6JYssfEhd7ua3PlbTjI7
t/7Ss7CKqNFTiAtDBtd0qTL/pzLb5PMWPEKKWEJis5XpSubE7Y+6z7KSUZvtPJ+w
1tEUYdYWxjNMEMDs2cmNsTzIg1cbgTANtKeAJlgOIzzD1Cqho1Nv3oeMss9dr84Q
cEH8n2Ep/XTBopu6GKMIx+ea/fQDmQ==
=lVFo
-----END PGP SIGNATURE-----

--szEf7fFD2Sy8aH5EO2HwvCl01RNKtq8Tg--


