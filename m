Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38CAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942DD20786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcNnHGtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942DD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83db-0006V8-Or
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k835z-0002sz-46
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:00:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k835v-0005OK-7O
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597762809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l2Bc+l4F7DXJeUeALKfLL+jqNnv6Ip7cUvzBDx5+Mlo=;
 b=UcNnHGtwfHhJyIkpNrY30syf8iNij7CrrFgvbd4vcZzjMfB0cq0Qj0a/WAbt2uODjzoK0v
 n36r0mxaEVi67UjR86IUFhXRqZiaQ1Ln6XOJjEuWjchWAi7s33Uw77142CH4Q6+YN11a2i
 A6Fiz/HiSeUnu0awHiOqbdi+98+XdGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-xQVHpjceNECXVPDKZ7cKGw-1; Tue, 18 Aug 2020 11:00:07 -0400
X-MC-Unique: xQVHpjceNECXVPDKZ7cKGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5712E807335;
 Tue, 18 Aug 2020 15:00:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-119.ams2.redhat.com
 [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4039026323;
 Tue, 18 Aug 2020 15:00:02 +0000 (UTC)
Subject: Re: [RFC PATCH 17/22] block/export: Add blk_exp_close_all(_type)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-18-kwolf@redhat.com>
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
Message-ID: <706438d2-2c7d-4f5f-0149-d5e881205bf0@redhat.com>
Date: Tue, 18 Aug 2020 17:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-18-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OTJ3Ll3D4SRd5YQr4aW5e54Ip9bVlx2zZ"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--OTJ3Ll3D4SRd5YQr4aW5e54Ip9bVlx2zZ
Content-Type: multipart/mixed; boundary="tJInkF5xKkWZTHt7h1BLrU1vqyNngVJCa"

--tJInkF5xKkWZTHt7h1BLrU1vqyNngVJCa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> This adds a function to shut down all block exports, and another one to
> shut down the block exports of a single type. The latter is used for now
> when stopping the NBD server. As soon as we implement support for
> multiple NBD servers, we'll need a per-server list of exports and it
> will be replaced by a function using that.
>=20
> As a side effect, the BlockExport layer has a list tracking all existing
> exports now. closed_exports loses its only user and can go away.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h |  8 +++++++
>  include/block/nbd.h    |  2 --
>  block.c                |  2 +-
>  block/export/export.c  | 52 ++++++++++++++++++++++++++++++++++++++++++
>  blockdev-nbd.c         |  2 +-
>  nbd/server.c           | 34 ++++-----------------------
>  qemu-nbd.c             |  2 +-
>  7 files changed, 68 insertions(+), 34 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/export/export.c b/block/export/export.c
> index 9de108cbc1..675db9a8b9 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c

[...]

> +/* type =3D=3D BLOCK_EXPORT_TYPE__MAX for all types */
> +void blk_exp_close_all_type(BlockExportType type)
> +{
> +    BlockExport *exp, *next;
> +
> +    QLIST_FOREACH_SAFE(exp, &block_exports, next, next) {
> +        if (type !=3D BLOCK_EXPORT_TYPE__MAX && exp->drv->type !=3D type=
) {
> +            continue;
> +        }
> +        blk_exp_request_shutdown(exp);
> +    }
> +
> +    AIO_WAIT_WHILE(NULL, blk_exp_has_type(type));
> +}
> +
> +void blk_exp_close_all(void)
> +{
> +    blk_exp_close_all_type(BLOCK_EXPORT_TYPE__MAX);

What=E2=80=99s interesting about this is that I saw from the header file th=
at
you added both this and the type-specific function and wondered =E2=80=9CWh=
y not
just pass __MAX to close_all_type() to close all?=E2=80=9D  And then I thou=
ght
=E2=80=9CBecause that would be stupid as an external interface=E2=80=9D.

So I see you had the same thinking.


--tJInkF5xKkWZTHt7h1BLrU1vqyNngVJCa--

--OTJ3Ll3D4SRd5YQr4aW5e54Ip9bVlx2zZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl877PAACgkQ9AfbAGHV
z0CxIQgAnHqFtvZXg3CrZ5d1uORmza+mcWnijvNPEuqFUU+zMCJ75atC9phC92f8
jP/wzIKjjn/qx4DI9yhM0a5kwI8Igevoqngf3gzQIH7vPNU3tW6ZJvsMHc8qXGu+
Z9hrChnIVnkF4H22wxiIKqvYfj1QGfEyThtLgsNDULJopTohGIrZFLKnMtiuZIBn
PJHjz3YezrTej50YvD4bF/2pXrAJDUyISgJLUiBe5WE4WKZ+wjjBhIWyYtPpgq2b
wLR6CC+/pb++AgyzwzlpcyGFUr1fEl1EawUx7KuSYX7TpqtD04VhCuqncrUF3Pd0
YnXYRy0CowmJRNBr4reHXPq1ix4qrQ==
=lDdS
-----END PGP SIGNATURE-----

--OTJ3Ll3D4SRd5YQr4aW5e54Ip9bVlx2zZ--


