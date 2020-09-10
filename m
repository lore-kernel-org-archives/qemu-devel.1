Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EAFC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E51207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0zTs4LP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E51207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMat-0004Oa-5m
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGMXa-0000gZ-7I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:23:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39206
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGMXX-0007Sf-PH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599744179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONk7VdPCl0n6d3w73d6TSEsM6wa7ZQWv5vPCKT5Grwk=;
 b=U0zTs4LPZsKtrdq0/d1VuSQRUqctLfIsi4dmvt3KEqUc9XLlXhAOAFDGdBPdWqyczW7ZX0
 91AYpJXIm6u2Cy0xqyIA+h9LU4VqU8X5Ogt25EvvDerq9uJer89GXedTMNG2VvHgjQHlB6
 lP3OFJEHbmb2czJzxYQEgxSfbrekuZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-lOcK2XGmMzqYSfchHR5LOQ-1; Thu, 10 Sep 2020 09:22:57 -0400
X-MC-Unique: lOcK2XGmMzqYSfchHR5LOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D3331800D41;
 Thu, 10 Sep 2020 13:22:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8065571775;
 Thu, 10 Sep 2020 13:22:55 +0000 (UTC)
Subject: Re: [PATCH 17/29] block/export: Add blk_exp_close_all(_type)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-18-kwolf@redhat.com>
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
Message-ID: <b7fb8549-7e97-dc50-0d6a-ba8c3979c4d4@redhat.com>
Date: Thu, 10 Sep 2020 15:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-18-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="grCgyaSQsKuPTMbq39RIOhgQfVoIdpf3X"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
--grCgyaSQsKuPTMbq39RIOhgQfVoIdpf3X
Content-Type: multipart/mixed; boundary="dH5dDc5nMrWk8VtAPY6c9ajQOINUdWeZy"

--dH5dDc5nMrWk8VtAPY6c9ajQOINUdWeZy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:19, Kevin Wolf wrote:
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
>  include/block/export.h | 15 ++++++++
>  include/block/nbd.h    |  2 --
>  block.c                |  2 +-
>  block/export/export.c  | 79 ++++++++++++++++++++++++++++++++++++++++--
>  blockdev-nbd.c         |  2 +-
>  nbd/server.c           | 34 +++---------------
>  qemu-nbd.c             |  2 +-
>  7 files changed, 100 insertions(+), 36 deletions(-)

[...]

>  /* Callers must hold exp->ctx lock */
>  void blk_exp_unref(BlockExport *exp)
>  {
>      assert(exp->refcount > 0);
>      if (--exp->refcount =3D=3D 0) {
> -        exp->drv->delete(exp);
> -        g_free(exp);
> +        /* Touch the block_exports list only in the main thread */
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(), blk_exp_delete_b=
h,
> +                                exp);

Looks safe.

Reviewed-by: Max Reitz <mreitz@redhat.com>

(The effort of special-casing this to delete the export immediately if
we already run in the main thread doesn=E2=80=99t look worth it.)


--dH5dDc5nMrWk8VtAPY6c9ajQOINUdWeZy--

--grCgyaSQsKuPTMbq39RIOhgQfVoIdpf3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aKK4ACgkQ9AfbAGHV
z0C8MQf/VB0dx3bOFIyMAsfWdwWaflfEYEaxf4GSt9OuEHdeSxi7AkXVya1mngEn
yXzi8olOYp7fmMc4Tehn1FVyJMU2khqGEmC8eZhOJnTGgTo2/NbAcarelsX9f0S9
7u898RKeX4PMFEn1LRlPHUeAfXjgG/6zqykUY7nCB0qQirDTRRam7TNUA+IWrQgQ
jwk3l3O1G+h6kJPPaCyK6JPK+hMCw6Jw8mxDZt28PbNySepCPPs+tS6StUlTzEAi
oZruI7wasn31J5iUYAJ6/zZ0WAEWoMm4uy2fcUV5Rwgeb6H/sYcUmExKAMjJnNdv
AsdfDeghOc10sBmrUhKTLw7AMJeUaw==
=sOc+
-----END PGP SIGNATURE-----

--grCgyaSQsKuPTMbq39RIOhgQfVoIdpf3X--


