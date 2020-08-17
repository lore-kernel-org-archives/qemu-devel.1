Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4994320882
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Atrzb8MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4994320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hSh-0008NR-9K
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gpc-0001EX-GK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:13:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7gpY-0003Ex-Rd
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xouZVVvkvtw7GYQjzK/jALR4YICopmed5fs9NEN1JLk=;
 b=Atrzb8MV5o/P1VB0TAjgLv2CRyNknUlI2rlThXE2p+NGYJiYTYRC2DJ8K6zEz7bPkWEFT0
 fkzFhcdThsa5b8jp88bTRI9FejSFo6XDtFcJRW7IgEJyLhk1BnhFnZO/m+PU4Xw+YSBMdI
 eGeubXml6Kk8G20Ef+XTWO8W8psW9rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-13mbac7ZPW262m-JQuGAkw-1; Mon, 17 Aug 2020 11:13:41 -0400
X-MC-Unique: 13mbac7ZPW262m-JQuGAkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461D91DDEE;
 Mon, 17 Aug 2020 15:13:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35251614F9;
 Mon, 17 Aug 2020 15:13:39 +0000 (UTC)
Subject: Re: [RFC PATCH 15/22] block/export: Move device to BlockExportOptions
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-16-kwolf@redhat.com>
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
Message-ID: <a163c834-bfc8-897a-c91f-8458b50dfdb6@redhat.com>
Date: Mon, 17 Aug 2020 17:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-16-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GKYcCbXKuXlpjd0QzZnS4nLoP4vKgiujC"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
--GKYcCbXKuXlpjd0QzZnS4nLoP4vKgiujC
Content-Type: multipart/mixed; boundary="4BicOJuUKiPFRTRl3GVjQ234XomHfZ0qr"

--4BicOJuUKiPFRTRl3GVjQ234XomHfZ0qr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> Every block export needs a block node to export, so move the 'device'
> option from BlockExportOptionsNbd to BlockExportOptions.
>=20
> To maintain compatibility in nbd-server-add, BlockExportOptionsNbd needs
> to be wrapped by a new type NbdServerAddOptions that adds 'device' back
> because nbd-server-add doesn't use the BlockExportOptions base type.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json         | 27 +++++++++++++++++++++------
>  block/export/export.c          | 26 ++++++++++++++++++++------
>  block/monitor/block-hmp-cmds.c |  6 +++---
>  blockdev-nbd.c                 |  4 ++--
>  qemu-nbd.c                     |  2 +-
>  5 files changed, 47 insertions(+), 18 deletions(-)

(Code diff looks good, just a question on the interface:)

> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index 4ce163411f..d68f3bf87e 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json

[...]

> @@ -167,6 +179,8 @@
>  # Describes a block export, i.e. how single node should be exported on a=
n
>  # external interface.
>  #
> +# @device: The device name or node name of the node to be exported
> +#

Wouldn=E2=80=99t it be better to restrict ourselves to a node name here?
(Bluntly ignoring the fact that doing so would make this patch an
incompatible change, which would require some reordering in this series,
unless we decide to just ignore that intra-series incompatibility.)

OTOH...  What does =E2=80=9Cbetter=E2=80=9D mean.  It won=E2=80=99t hurt an=
yone to keep this as
@device.  It=E2=80=99s just that I feel like if we had no legacy burden and=
 did
this all from scratch, we would just make it @node-name.

Did you deliberately decide against @node-name?

Max


--4BicOJuUKiPFRTRl3GVjQ234XomHfZ0qr--

--GKYcCbXKuXlpjd0QzZnS4nLoP4vKgiujC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86nqEACgkQ9AfbAGHV
z0B+hwf+MZC5OV6KldaoUZRKbIDGutnYYPCWQfKHgmPdP5hW3WhcUyHWzHh1LArj
1UuQeq8HPs6RuFZ620KEeywFs04k3oiD1weGwZHjK3LuZXV8M05+rd2/G18PATe9
Ia90p5OHMuvUX22HOu39SB0Ci+SJ0um/9AEwiubuNE/iaAleCF0CG7qYwJmHII1A
MMGsyoy76MbgYrjsXEoGzS8MyENTGY4prj9pEWhW5E8QjJjHokZtBAxD368PhXjk
vJwd6L4F5ivEsn+DvEdcd4kxuDQR8H4a8PMGVKa3ucbFvtqVdlFf/pZz7TvUj//4
RKarKyN4UEv3jvRWcob6Vo/JywK53Q==
=AV0v
-----END PGP SIGNATURE-----

--GKYcCbXKuXlpjd0QzZnS4nLoP4vKgiujC--


