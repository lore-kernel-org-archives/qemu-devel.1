Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785BC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C7A206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnjjUcmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C7A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01Hy-0000OL-Pk
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j01HE-0008LG-NH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j01HD-00006f-QY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:54:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j01HD-0008Vf-N5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581072860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2zVMgPQL96PLqkPo9ra8mrSJkczSgnDm4agY9ZBksds=;
 b=BnjjUcmw51Um7mhwyEDwWRKJhoh5KaJ5thghbcvcbN/4faXBj6peOnowKZhilcM/uCTEXL
 EKBYsNOExXinK3pygqahDpB9th8LipQ+OdybwodmRn4A/4AVa2hytwgOTonVAd9PY5h4Ls
 EHAIJ9zTIDyusuAC5YgmRSjPRKsVh/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-XyqWxS7QN1aE0KbFDBYdDQ-1; Fri, 07 Feb 2020 05:54:12 -0500
X-MC-Unique: XyqWxS7QN1aE0KbFDBYdDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA16C1005513;
 Fri,  7 Feb 2020 10:54:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-88.ams2.redhat.com
 [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B712C5DA7C;
 Fri,  7 Feb 2020 10:54:10 +0000 (UTC)
Subject: Re: [PATCH v4 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200205110248.2009589-1-david.edmondson@oracle.com>
 <20200205110248.2009589-2-david.edmondson@oracle.com>
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
Message-ID: <6d7dde80-dca8-7d09-c3d8-fde4af1f3ef0@redhat.com>
Date: Fri, 7 Feb 2020 11:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205110248.2009589-2-david.edmondson@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="au1CWXuuTQzFcGdep76JxAaXKV3Vl2FV6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--au1CWXuuTQzFcGdep76JxAaXKV3Vl2FV6
Content-Type: multipart/mixed; boundary="Ac2VBxvt8giiHdgOQ1G3BCOS0W4J0WFOf"

--Ac2VBxvt8giiHdgOQ1G3BCOS0W4J0WFOf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 12:02, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (reads as zero). In this situation
> there is no requirement for qemu-img to wastefully zero out the entire
> device.
>=20
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device will return zeros for all reads.
>=20
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  docs/interop/qemu-img.rst |  9 ++++++++-
>  qemu-img-cmds.hx          |  4 ++--
>  qemu-img.c                | 26 +++++++++++++++++++++++---
>  3 files changed, 33 insertions(+), 6 deletions(-)

Thanks, I=E2=80=99ve applied the patch to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--Ac2VBxvt8giiHdgOQ1G3BCOS0W4J0WFOf--

--au1CWXuuTQzFcGdep76JxAaXKV3Vl2FV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49QdEACgkQ9AfbAGHV
z0ANJAf+LfrRHIrlGJfoTogLYC0dR5I0VNIw7ID4X1qJwucQeyYX2FmYgso4Bte0
ZZuG+l9lXm/8TkPjSDHwkLtAFjOEH9SwQyfOirFiEezrm3zJfFezxhub47jGVXwN
48wsdyuRSRJg5NPME9RaMZW2wuaiisP+khCphPQfIh0w5t0FzLxAceSnRA1kdZ7L
+/b5WQooTiYU/07Dq1lWrN3LU8GgecfgnCDZpDACVQGTfQw9AN25m/fsAKGu/WIq
vjssZJRqAfMQNYUNJDMvvcgJaXED4myZJXY329SsZ6keUBolzrp7rmaAkN/mRSM8
O0U/+VeLjPYVM1pVcr+6Np2ozETSPw==
=Yo5x
-----END PGP SIGNATURE-----

--au1CWXuuTQzFcGdep76JxAaXKV3Vl2FV6--


