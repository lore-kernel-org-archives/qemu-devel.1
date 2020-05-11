Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A698C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C9E2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzeFaC3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C9E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5WE-0007JB-EE
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY5VV-0006Kd-Ea
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:17:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37289
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jY5VU-0002JQ-BR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589192274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QVVJcVvXGcG6REnWHGZTD3ybeEb2OkA6wusQxJak6tQ=;
 b=NzeFaC3dG8lEK1XnRoMQV5lPHoliA0Lydbze14BBBpd5p44+YWcjHKweBULZJ5xDwOCyxW
 2CMUeASAkFhuhqOnUCy1butpNm1gPUuUAApEHx318jzppXGqJ4oFWhkgRDepO4wzNhXtXh
 BSxcdopGfnS/kBPzxMzNLNYv5kgQIyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-_Bblr_rXPMOukF4ze_fx2A-1; Mon, 11 May 2020 06:17:52 -0400
X-MC-Unique: _Bblr_rXPMOukF4ze_fx2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91399872FE1;
 Mon, 11 May 2020 10:17:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-247.ams2.redhat.com
 [10.36.113.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E665B60C05;
 Mon, 11 May 2020 10:17:41 +0000 (UTC)
Subject: Re: [PATCH v3 5/9] blockdev: Split off basic bitmap operations for
 qemu-img
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-6-eblake@redhat.com>
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
Message-ID: <9505957e-b94f-65b5-1c28-95aceeec041e@redhat.com>
Date: Mon, 11 May 2020 12:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508180340.675712-6-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kebNkxGfYQYqhBWUADmj19MqSMa3TxEav"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kebNkxGfYQYqhBWUADmj19MqSMa3TxEav
Content-Type: multipart/mixed; boundary="M4dUuv52baF6fk1JHcya3SwEbKBD8zskr"

--M4dUuv52baF6fk1JHcya3SwEbKBD8zskr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.05.20 20:03, Eric Blake wrote:
> Upcoming patches want to add some basic bitmap manipulation abilities
> to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
> (among other things, it would drag in block jobs and transaction
> support - qemu-img does offline manipulation, where atomicity is less
> important because there are no concurrent modifications to compete
> with), so it's time to split off the bare bones of what we will need
> into a new file block/monitor/bitmap-qmp-cmds.o.
>=20
> This is sufficient to expose 6 QMP commands for use by qemu-img (add,
> remove, clear, enable, disable, merge), as well as move the three
> helper functions touched in the previous patch.  Regarding
> MAINTAINERS, the new file is automatically part of block core, but
> also makes sense as related to other dirty bitmap files.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  Makefile.objs                   |   3 +-
>  block/monitor/bitmap-qmp-cmds.c | 323 ++++++++++++++++++++++++++++++++
>  blockdev.c                      | 284 ----------------------------
>  MAINTAINERS                     |   1 +
>  block/monitor/Makefile.objs     |   1 +
>  5 files changed, 326 insertions(+), 286 deletions(-)
>  create mode 100644 block/monitor/bitmap-qmp-cmds.c
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index a7c967633acf..99774cfd2545 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -13,9 +13,8 @@ chardev-obj-y =3D chardev/
>=20
>  authz-obj-y =3D authz/
>=20
> -block-obj-y =3D nbd/
> +block-obj-y =3D block/ block/monitor/ nbd/ scsi/

This reads weird because it=E2=80=99s precisely the monitor that we don=E2=
=80=99t want
in qemu-img.

But I suppose block/monitor is the natural place for block functions
that are to be used by the monitor (and maybe other parties like
qemu-img).  And the monitor itself would never be placed under block/.
So I suppose it does make sense and I have no better suggestion.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--M4dUuv52baF6fk1JHcya3SwEbKBD8zskr--

--kebNkxGfYQYqhBWUADmj19MqSMa3TxEav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl65Jj8ACgkQ9AfbAGHV
z0CLLwgAjkY6Pu5hJzV1WuLaJIiT5k8Wyu6uT566ZUsqc2jv2kQMgE9jUX7f1p4E
/nuD9u/BRpyOKmcep4aIyqVlbbz0wADBAOLJ9lrv4KxHYkG4Se8G3FDaC9K1scEz
v+7ORer6tm8bsrKOlb92OcW5g+dLO9BlzG1pWRlZZemMRclT4OtmDrlWc7B7+Esf
k3kby+k0A32AXJsU3/NlAOE6tX6ZJJuqLUvEavbORmxzjcAnV78ofq2y7WBIHPB2
JAsddlLevCRxUtUkj5iaHRw/pD1VACwH2s7FFn+Sj+I0kgYPqYLqIa0Ih3XHuWWe
TM9vG8/kDtW5M8sk79tEyQJouPUb/Q==
=/9fC
-----END PGP SIGNATURE-----

--kebNkxGfYQYqhBWUADmj19MqSMa3TxEav--


