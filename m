Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52634C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB2520782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i91y/3O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB2520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKLR-0005AW-ED
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrKKW-0004O5-69
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:58:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jrKKT-00069R-DQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593777484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sx/6iAb59Gg53NOUbQuQErDHOqbID0Col+5JOqt7qoE=;
 b=i91y/3O4wKkkaeSmVDM7JBHMENEzitiwPh1hS+/Xw3cSismd7ceoaEPgn+brqoIeRmtQXx
 urdYWRys2QRm4u/LC0NHohswSfJqrvqzcChr8/ivV2YyTOMzqnyfh9C+zjYpVQAM+HxOCg
 kjWVK3/Gp2M8/pT7sKrYFa9oviQG8GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-SEl3SiaVOJqEHGvVZVadrA-1; Fri, 03 Jul 2020 07:57:59 -0400
X-MC-Unique: SEl3SiaVOJqEHGvVZVadrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 165C710059AB;
 Fri,  3 Jul 2020 11:57:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-131.ams2.redhat.com
 [10.36.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D391B1ED;
 Fri,  3 Jul 2020 11:57:56 +0000 (UTC)
Subject: Re: [PATCH 00/19] block: LUKS encryption slot management + iotest
 tweaks
To: qemu-block@nongnu.org
References: <20200625125548.870061-1-mreitz@redhat.com>
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
Message-ID: <4f7fb12e-230a-2ef7-79ff-697793b76294@redhat.com>
Date: Fri, 3 Jul 2020 13:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625125548.870061-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FBGQ9ckYiZumB5cYFSuZB4AZj9JkD7C4h"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FBGQ9ckYiZumB5cYFSuZB4AZj9JkD7C4h
Content-Type: multipart/mixed; boundary="94RtMObfM5o92Qi9CdIrXeeSegkCNGmMA"

--94RtMObfM5o92Qi9CdIrXeeSegkCNGmMA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.06.20 14:55, Max Reitz wrote:
> Hi,
>=20
> This series collects all patches from Maxim=E2=80=99s series =E2=80=9CLUK=
S: encryption
> slot management using amend interface=E2=80=9D, plus iotest patches that =
seem
> useful to have before it.  (And then I modified some of Maxim=E2=80=99s p=
atches
> to take advantage of those patches.)
>=20
> Maxim=E2=80=99s series was here:
> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00330.html
>=20
> I already posted patches 1 and 2 here:
> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00954.html
>=20
> Change from the latter series:
> - Patch 1:
>   - Use $SED instead of plain =E2=80=9Csed=E2=80=9D in one place I missed
>   - Older bash versions do not support readarray=E2=80=99s -d switch, so =
we have
>     to separate the Formatting line by a \n instead of \0.
>     Unfortunately, that means we cannot just split by \0 and be done
>     with it, but we have to ensure we put everything before the line
>     starting by =E2=80=9CFormatting=E2=80=9D into $filename_part, and we =
do that with a
>     loop that iterates over the split array until it finds the
>     =E2=80=9CFormatting=E2=80=9D line.
>   - Use multiple -e for grep instead of '(...|...|...)'
> - Patch 2: Rebase fallout du to grep now using multiple -e parameters

Thanks for reviewing, Maxim; (re-)applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block


--94RtMObfM5o92Qi9CdIrXeeSegkCNGmMA--

--FBGQ9ckYiZumB5cYFSuZB4AZj9JkD7C4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7/HUMACgkQ9AfbAGHV
z0AZRQf/TMJ18ghj06mbr7iYDSA+NNY7gutkW07HFTMWqBJTXHXjUmDgiv4zNjBI
YNrgZTxQohLLZkBXIN9Vw9hsZijiBB/gSiYaWuSqb92WzoHhXsqUnBOEoe5/N2TG
9X1mkNQ2nsFIWbRYvMvqtbIrk9+h0LPHLlutxkvccxyL2F7qyoUmx8uuEo2HYVQ+
2rhkoEHe8nPkGkFq6D01v5XG9xm0doxWtxe4u2lvjeyJbAVDCMT3Fp+QT1UCeHnT
foyJskZcB8a6tZuwGj8cZI673vS44rI2X0w+YjEOETZSU7fCBjGoXhL4xdB3jupQ
6A5i30UM4ET9OeSCXJZ5hfRVa8A3eQ==
=TgKw
-----END PGP SIGNATURE-----

--FBGQ9ckYiZumB5cYFSuZB4AZj9JkD7C4h--


