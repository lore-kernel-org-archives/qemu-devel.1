Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FD4206B7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFEPEVM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FD4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0vO-0003em-Rn
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0tr-0002i4-H1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:13:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0tm-0002ci-Ny
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593702793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U/qx6MQA3oLEvjtq2c2TG1a1kqdSG6auK+a2/vIa+fI=;
 b=JFEPEVM5ONWV/3Udnt/OtK6z+cVKs0Jg48yy+niCgN47z4cI8HGDvuVJnUM87L6vF/Q/QX
 xD8ct/aOsf8Tka1B0Zj7f35iFpxiYHQQGbSlpSdfWdp+QXblQig3FbgX3hoXawKwtNxYYC
 3PClnYh/YyEJIWnqVycr9HWOF7Ito+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-DsmeU3FSMI2oKMgDMZe-HQ-1; Thu, 02 Jul 2020 11:13:09 -0400
X-MC-Unique: DsmeU3FSMI2oKMgDMZe-HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 349058CA8B8;
 Thu,  2 Jul 2020 15:13:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CD101001268;
 Thu,  2 Jul 2020 15:13:04 +0000 (UTC)
Subject: Re: [PATCH v9 31/34] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <d9c3047a4b19769e4167af7b4416d02bce806444.1593342067.git.berto@igalia.com>
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
Message-ID: <6c0edc36-8e44-61d2-e2e5-de33c4b84bde@redhat.com>
Date: Thu, 2 Jul 2020 17:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d9c3047a4b19769e4167af7b4416d02bce806444.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ebV87lvcAiu06V8TjV9d5RNNTY2QhTk89"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ebV87lvcAiu06V8TjV9d5RNNTY2QhTk89
Content-Type: multipart/mixed; boundary="7UYEyya57T94IMC15e2LyzqEvGnNpYkWi"

--7UYEyya57T94IMC15e2LyzqEvGnNpYkWi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> Now that the implementation of subclusters is complete we can finally
> add the necessary options to create and read images with this feature,
> which we call "extended L2 entries".
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json             |   7 +++
>  block/qcow2.h                    |   8 ++-
>  include/block/block_int.h        |   1 +
>  block/qcow2.c                    |  74 ++++++++++++++++++++--
>  tests/qemu-iotests/031.out       |   8 +--
>  tests/qemu-iotests/036.out       |   4 +-
>  tests/qemu-iotests/049.out       | 102 +++++++++++++++----------------
>  tests/qemu-iotests/060.out       |   1 +
>  tests/qemu-iotests/061.out       |  20 +++---
>  tests/qemu-iotests/065           |  12 ++--
>  tests/qemu-iotests/082.out       |  48 ++++++++++++---
>  tests/qemu-iotests/085.out       |  38 ++++++------
>  tests/qemu-iotests/144.out       |   4 +-
>  tests/qemu-iotests/182.out       |   2 +-
>  tests/qemu-iotests/185.out       |   8 +--
>  tests/qemu-iotests/198.out       |   2 +
>  tests/qemu-iotests/206.out       |   4 ++
>  tests/qemu-iotests/242.out       |   5 ++
>  tests/qemu-iotests/255.out       |   8 +--
>  tests/qemu-iotests/274.out       |  49 ++++++++-------
>  tests/qemu-iotests/280.out       |   2 +-
>  tests/qemu-iotests/291.out       |   6 +-
>  tests/qemu-iotests/common.filter |   1 +
>  23 files changed, 272 insertions(+), 142 deletions(-)

Looks OK.

Reviewed-by: Max Reitz <mreitz@redhat.com>

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 003f166024..37bfae823c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -5491,6 +5539,14 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
>                                   "is not supported");
>                  return -ENOTSUP;
>              }
> +        } else if (!strcmp(desc->name, BLOCK_OPT_EXTL2)) {
> +            bool extended_l2 =3D qemu_opt_get_bool(opts, BLOCK_OPT_EXTL2=
,
> +                                                 has_subclusters(s));
> +            if (extended_l2 !=3D has_subclusters(s)) {
> +                error_setg(errp, "Toggling extended L2 entries "
> +                           "is not supported");
> +                return -EINVAL;

Just a note: I think ENOTSUP would fit better.

(Then again, Maxim=E2=80=99s =E2=80=9Cblock/amend: refactor qcow2 amend opt=
ions=E2=80=9D removes
all of this code anyway.)


--7UYEyya57T94IMC15e2LyzqEvGnNpYkWi--

--ebV87lvcAiu06V8TjV9d5RNNTY2QhTk89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79+X4ACgkQ9AfbAGHV
z0Aawwf+PoaQt4jB5JfokO9BD9P2xtdhYT4fJo2X3iDVFa+od7QpFevTsERZz232
qtAMofnGndrHwjYwj0V6jtOUAViVTrSsYxW8vCIzGCkTdMc6GM7JURUN+ANJsORz
zv3Y/n470bzTSXcA57Zp3aBBE2g2g+5wTyeWSjObIFHC0nhlKRnxoqSdeXYyp4uI
700YhkW0/on/DND6Wl3dD++SdwAtPCjd4YHiohhzkF13wOOOLfMotVlvObyw52kr
dLXBw1r3pF7VI4QIspuLA6xlv4msdQEG+oaINJAfC+G0QEdpKpkrCziJJyHTT9Tb
irl11Aiq/wCqVZwxAySByQYvhtvvRw==
=JtJA
-----END PGP SIGNATURE-----

--ebV87lvcAiu06V8TjV9d5RNNTY2QhTk89--


