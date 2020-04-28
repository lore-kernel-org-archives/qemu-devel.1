Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF555C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C09206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ4IBeDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C09206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPsY-0006vc-Gh
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTPqr-0005Xt-QT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTPpk-0001bx-Ki
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:00:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTPpk-0001bD-76
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588078770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QHglOP72lrJRhgPdjxwbe4rwfPmWtzbs44uBdSaZRLM=;
 b=VJ4IBeDb4MNpLDhzsiWewpMFXok52REW/5qBstK6amzFI5AAUSUb6OlfhXiCNv6ZqAIx4w
 eCxAHwD2K9pbLTWBZX5eqS3tGfZ0dw/6d/j/gzyLrH8ryKnomS0wCUED27qiXL66yc8Ls+
 kskVIPkTpt9Z1ALs7ua3C4t5rnJ1SqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-BjNnJ9B_MEuLei_-074bhg-1; Tue, 28 Apr 2020 08:59:25 -0400
X-MC-Unique: BjNnJ9B_MEuLei_-074bhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74EFE107ACCA;
 Tue, 28 Apr 2020 12:59:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C7E19C4F;
 Tue, 28 Apr 2020 12:59:20 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] qcow2: Allow resize of images with internal
 snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200424190903.522087-1-eblake@redhat.com>
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
Message-ID: <376620d9-353f-e91a-e95e-d542990ba773@redhat.com>
Date: Tue, 28 Apr 2020 14:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424190903.522087-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fqHYcogmHsAuQcbYsTZhu0vEgHw28IRxm"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: stefanha@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fqHYcogmHsAuQcbYsTZhu0vEgHw28IRxm
Content-Type: multipart/mixed; boundary="F6BtzZTSwiLcmNh6O5Pxaz86usnYiR1Nx"

--F6BtzZTSwiLcmNh6O5Pxaz86usnYiR1Nx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 21:09, Eric Blake wrote:
> In v3:
> - patch 1: fix error returns [patchew, Max], R-b dropped
> - patch 2,3: unchanged, so add R-b
>=20
> Eric Blake (3):
>   block: Add blk_new_with_bs() helper
>   qcow2: Allow resize of images with internal snapshots
>   qcow2: Tweak comment about bitmaps vs. resize

Thanks, I=E2=80=99ve squashed the diff into patch 1 and applied the series =
to my
block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--F6BtzZTSwiLcmNh6O5Pxaz86usnYiR1Nx--

--fqHYcogmHsAuQcbYsTZhu0vEgHw28IRxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oKKcACgkQ9AfbAGHV
z0ARZgf9EpyzBGZSYWaQialsELMOwWxfYAyGR/v47M+C+X87mGmw6hHmkZddBZq0
OL7xENFKcwBhLAEoyqVaWjksjEy/U0IMxYhZU3ROPAmOHl99PMGHmb/GbWZWVsgZ
MTEEa37S/W0VwLUiJiHg3/1Yu9X2wd9cKc7NN6AegFVb3ULghGhlD/VEnaCwyavE
eEX3D98pTAimy4O/d8omVak7TwpqjOzg+To2CKuu0PgrEtLE3eoGTwAq+TSWVbSg
8ZNvmHvTB0kgAojhd4SUJJMW40DEI8VEEamM+BMZ+ccxZJE4uwUGJ7cLC0t5Vt9S
hgtcyCr9VAZ2IknMkiBdz2gxULWN5A==
=wDy2
-----END PGP SIGNATURE-----

--fqHYcogmHsAuQcbYsTZhu0vEgHw28IRxm--


