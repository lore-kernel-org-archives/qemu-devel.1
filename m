Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24304C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAB02075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP6UN9y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAB02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hNM-0003Mn-Rt
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gYZ-0006NT-5g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:56:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gYW-0008RF-6F
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597676171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=68M1q3xpatrlIuP5bSkjwuOWH1t8rT/rj4VGDxjMZ00=;
 b=MP6UN9y+TsTL5Z5XYrEbiDWAEavDHfQ9vpFBSBAhMCE5HfJu67NvZCq8FcYvkCZVUT616s
 zJDb8fo9BaKXotGB4ecbXr9qeR21jAM8O9U7ooOHT0fLKB+UTOUDeKgk51hlE18qGtNXUu
 0HoGL5gzmePQRTMcbKqZAZ3ETJArGuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-RqumkDavPyaV4QLAERY3mw-1; Mon, 17 Aug 2020 10:56:06 -0400
X-MC-Unique: RqumkDavPyaV4QLAERY3mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4A41DDE9;
 Mon, 17 Aug 2020 14:56:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D98756B0;
 Mon, 17 Aug 2020 14:56:04 +0000 (UTC)
Subject: Re: [RFC PATCH 14/22] block/export: Move AioContext from NBDExport to
 BlockExport
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-15-kwolf@redhat.com>
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
Message-ID: <2851aef1-176c-1b81-4941-dc4b08b6bfec@redhat.com>
Date: Mon, 17 Aug 2020 16:56:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-15-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uEjF9QCh1UREmWuHnhj2YqpzDygr21bYn"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--uEjF9QCh1UREmWuHnhj2YqpzDygr21bYn
Content-Type: multipart/mixed; boundary="5NxxFSkyTiAizKGQx7smyH6CZPC0mld7l"

--5NxxFSkyTiAizKGQx7smyH6CZPC0mld7l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h |  6 ++++++
>  nbd/server.c           | 26 +++++++++++++-------------
>  2 files changed, 19 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/include/block/export.h b/include/block/export.h
> index f44290a4a2..5459f79469 100644
> --- a/include/block/export.h
> +++ b/include/block/export.h
> @@ -33,6 +33,12 @@ struct BlockExport {
>       * the export.
>       */
>      int refcount;
> +
> +    /*
> +     * The AioContex whose lock needs to be held while calling

*AioContext

> +     * BlockExportDriver callbacks.

Hm.  But other blk_exp_* functions (i.e. the refcount manipulation
functions) are fair game?

> +     */
> +    AioContext *ctx;
>  };
> =20
>  extern const BlockExportDriver blk_exp_nbd;
> diff --git a/nbd/server.c b/nbd/server.c
> index 2bf30bb731..b735a68429 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c

[...]

> @@ -1466,7 +1464,7 @@ static void blk_aio_attached(AioContext *ctx, void =
*opaque)
> =20
>      trace_nbd_blk_aio_attached(exp->name, ctx);
> =20
> -    exp->ctx =3D ctx;
> +    exp->common.ctx =3D ctx;

(Not sure if I=CD=84=E2=80=99m missing anything to that regard), but perhap=
s after
patch 21 we can move this part to the common block export code, and
maybe make it call a BlockExportDriver callback (that handles the rest
of this function).

>      QTAILQ_FOREACH(client, &exp->clients, next) {
>          qio_channel_attach_aio_context(client->ioc, ctx);
> @@ -1484,13 +1482,13 @@ static void blk_aio_detach(void *opaque)
>      NBDExport *exp =3D opaque;
>      NBDClient *client;
> =20
> -    trace_nbd_blk_aio_detach(exp->name, exp->ctx);
> +    trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
> =20
>      QTAILQ_FOREACH(client, &exp->clients, next) {
>          qio_channel_detach_aio_context(client->ioc);
>      }
> =20
> -    exp->ctx =3D NULL;
> +    exp->common.ctx =3D NULL;

(same here)

Max


--5NxxFSkyTiAizKGQx7smyH6CZPC0mld7l--

--uEjF9QCh1UREmWuHnhj2YqpzDygr21bYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86moIACgkQ9AfbAGHV
z0DYkAf/X2qFnyzBqEAlMNV6zjS3NxLMYe4JoyvGO2FWEtAiPcr/49LPQ4PLhaDO
ECA1eSq0lFEfqYrxsJfZFIM9ly4SugTTQTaJXX/waBDePrQrTQukfmcYfoc7gnGM
kOoOq4qRkOz2Tuy+KTxMwhICfn6cnwTNaee50skXD0GZeSRjhEkeHvqFCLi3UZDF
bUEVN1V+mzWNUutjy1JMVMGLK/YsUOfuLB+Qi6YpuceHzbEaX24HG1a8gBsxLs+c
S/6y3D9S0sDFp+XUItOL2WxmUoxwVM4oaCwpjwxR8piMvupvklVNyPKKjUdyBXvn
NzFpq4VrNZsvc6LKN6V8WgXtJs4wxw==
=SDTL
-----END PGP SIGNATURE-----

--uEjF9QCh1UREmWuHnhj2YqpzDygr21bYn--


