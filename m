Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43AC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40EE20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNP5o1YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40EE20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzQo-0003lG-Ey
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNzPu-0002se-Dj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kNzPr-0007Gs-UI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601561918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JiIm316CXm7TJNcJXFVzRosBJ5WcxDhBm4d337O1ezI=;
 b=XNP5o1YEjirnxrB1npVdmgJHJuxLex8KCvDNN5Ijuy4wHcLfBSrfVsUDIo1N814vR+DAi0
 3AWIH8s8PcavXaGImhHCoFl4KuUlQ1CQBVD8E2ZfcfTpfhKEs2B3vbVnqlmbIhNfdumhkz
 9ze8BnyeQvOPgOtaMPV99jmzn22pqAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-cuJ1gj4ENx-YqWo5ZFgarA-1; Thu, 01 Oct 2020 10:18:36 -0400
X-MC-Unique: cuJ1gj4ENx-YqWo5ZFgarA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93B61074664;
 Thu,  1 Oct 2020 14:18:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-181.ams2.redhat.com
 [10.36.113.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96D5978806;
 Thu,  1 Oct 2020 14:18:32 +0000 (UTC)
Subject: Re: [PATCH qemu 1/4] drive-mirror: add support for sync=bitmap
 mode=never
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
 <20200922091418.53562-2-f.gruenbichler@proxmox.com>
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
Message-ID: <408ee1bb-9932-c724-ca43-6ab9a9014a0e@redhat.com>
Date: Thu, 1 Oct 2020 16:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922091418.53562-2-f.gruenbichler@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="myLzpRLFoyaqjfhx0pw0btyeIU7MODDLE"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Ma Haocong <mahaocong@didichuxing.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--myLzpRLFoyaqjfhx0pw0btyeIU7MODDLE
Content-Type: multipart/mixed; boundary="O72jMQwYIXwUprHn06KUuXOFhhJqMm8Lh"

--O72jMQwYIXwUprHn06KUuXOFhhJqMm8Lh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.09.20 11:14, Fabian Gr=C3=BCnbichler wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> This patch adds support for the "BITMAP" sync mode to drive-mirror and
> blockdev-mirror. It adds support only for the BitmapSyncMode "never,"
> because it's the simplest mode.
>=20
> This mode simply uses a user-provided bitmap as an initial copy
> manifest, and then does not clear any bits in the bitmap at the
> conclusion of the operation.
>=20
> Any new writes dirtied during the operation are copied out, in contrast
> to backup. Note that whether these writes are reflected in the bitmap
> at the conclusion of the operation depends on whether that bitmap is
> actually recording!
>=20
> This patch was originally based on one by Ma Haocong, but it has since
> been modified pretty heavily.
>=20
> Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
> ---
>  include/block/block_int.h   |  4 +-
>  block/mirror.c              | 98 ++++++++++++++++++++++++++++++-------
>  blockdev.c                  | 39 +++++++++++++--
>  tests/test-block-iothread.c |  4 +-
>  qapi/block-core.json        | 29 +++++++++--
>  5 files changed, 145 insertions(+), 29 deletions(-)

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2d94873ca0..dac5497084 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -2270,10 +2281,19 @@
>  #        (all the disk, only the sectors allocated in the topmost image,=
 or
>  #        only new I/O).
>  #
> +# @bitmap: The name of a bitmap to use for sync=3Dbitmap mode. This argu=
ment must
> +#          be present for bitmap mode and absent otherwise. The bitmap's
> +#          granularity is used instead of @granularity (since 5.2).
> +#
> +# @bitmap-mode: Specifies the type of data the bitmap should contain aft=
er
> +#               the operation concludes. Must be present if sync is "bit=
map".
> +#               Must NOT be present otherwise. (Since 5.2)
> +#
>  # @granularity: granularity of the dirty bitmap, default is 64K
>  #               if the image format doesn't have clusters, 4K if the clu=
sters
>  #               are smaller than that, else the cluster size.  Must be a
> -#               power of 2 between 512 and 64M
> +#               power of 2 between 512 and 64M . Must not be specified i=
f

s/ \./\./

(What a cheerful-looking regex.)

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +#               @bitmap is present.
>  #
>  # @buf-size: maximum amount of data in flight from source to
>  #            target


--O72jMQwYIXwUprHn06KUuXOFhhJqMm8Lh--

--myLzpRLFoyaqjfhx0pw0btyeIU7MODDLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl915TYACgkQ9AfbAGHV
z0DgtggAjp9fYLn0Bs6YtauELsoXNNAc4wpbWjOhkgl6HoHYqwDb4iGMVm39QfOJ
aVhJcFfvcRysx/CWo4nyeLLv+7ERUiPlNX/M4uEBacu10k6EtENJ579iCYvHzsoD
N2+OCFGiCbK7+WHENNJw22mQsmprnmrcqx1hgquMeLhhxu+twjOxyttGh968fxBT
mrQBEv8DYowZxPla8z9CujmkMwnVeiY9lmsb7dg8/8OFAg7WlLlnV2dT4LZDpCGX
P5ILKP0Z+/th0eH/wce50RgP76/rwLi7ez38wbkokORQyOiWZtbzsgX/dbcakxtr
kiLxk5aafjoAdjtDBWKNiyeT/6Z/yQ==
=Xoaq
-----END PGP SIGNATURE-----

--myLzpRLFoyaqjfhx0pw0btyeIU7MODDLE--


