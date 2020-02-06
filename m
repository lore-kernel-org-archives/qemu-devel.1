Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC006C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975E920659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXtsOYQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975E920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfSz-00035a-Pi
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izfPu-00079r-C1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izfPs-0005IV-77
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:33:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izfPs-0005EW-2c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580988831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I/efPccP+Q5r58e3ZU9/hy2hLuGpTpbx+gWLd+DLGzM=;
 b=PXtsOYQzEDN3virpljoXNdL/aUvnUUKStWiartXFUt/MKzEge0H6rY9f1VEeOvpMl2DZ4r
 OCScSEZ7AuGSOMHLJWvHgdv2vHBh1ZtmTvMQWrnyZfhipDr1jVvwHR0vagQ9R39E6iE8mD
 1PGZeErzvzb7bJ2wBhzWCOdpqF1rmoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-sFXtmfBkNbWFv-GTMRniCA-1; Thu, 06 Feb 2020 06:33:47 -0500
X-MC-Unique: sFXtmfBkNbWFv-GTMRniCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A96E41084430;
 Thu,  6 Feb 2020 11:33:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96AB927061;
 Thu,  6 Feb 2020 11:33:45 +0000 (UTC)
Subject: Re: [PATCH v2 22/33] block: Make backing files child_of_bds children
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-23-mreitz@redhat.com>
 <6869d2fe-197a-3bd8-516a-9ae07756a227@redhat.com>
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
Message-ID: <367e84c9-501b-2324-fc7a-575ba10249bd@redhat.com>
Date: Thu, 6 Feb 2020 12:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6869d2fe-197a-3bd8-516a-9ae07756a227@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TzEnwL82fq3P6hDKPFMzHe2DO5sAyAgi0"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TzEnwL82fq3P6hDKPFMzHe2DO5sAyAgi0
Content-Type: multipart/mixed; boundary="AFGjhVPj0Ikg0y9GLQg5BSp4wiKdq5562"

--AFGjhVPj0Ikg0y9GLQg5BSp4wiKdq5562
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 23:45, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Another sparse commit message (a recurring theme of this series). The
> subject line says 'what', and the patch appears to be faithful to that,
> but if a future bisection lands here, even a one-sentence 'why' would be
> handy; maybe:
>=20
> This is part of a larger series of unifying block device relationships
> via child_of_bds.

Sure, works for me.  Or maybe:

Make all parents of backing files pass the appropriate BdrvChildRole.
By doing so, we can switch their BdrvChildClass over to the generic
child_of_bds, which will do the right thing when given a correct
BdrvChildRole.

(Because actually the point of this series is not child_of_bds, but the
BdrvChildRole, which allows the =E2=80=9CDeal with filters=E2=80=9D series =
to implement
the child access functions in a more obvious way.  I hope.)

Max


--AFGjhVPj0Ikg0y9GLQg5BSp4wiKdq5562--

--TzEnwL82fq3P6hDKPFMzHe2DO5sAyAgi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl47+ZgACgkQ9AfbAGHV
z0AphQf9EvVWP5FN7L2HnDaJ5DosqhQDI2gxzUc4zbNSCxoR+EsvQKQcLwZwkyyh
+/xvSlB36TNG07n7Fyu715mQNVsid8EwY9pFE46tSUMiIs9m88T4R7rhWAOiu6+8
tMVrpgcpTSzBlJ5fNlCyEYhcofJaWNVkpEmQqpTwJJxoOo3PvJ0AwAy+S88IE5rx
gCKqs8jTn7hx+ZGzlsCTThFjf9xV2AO/4u7dBltY1dVTBT7muoJn1hi18FG+SYwX
fj+fh4GLbGn+j86xDFPKJEBHX0VW3wR4eml4rkjmFH3Rw5hTDDqpa6QOAdUqA3jC
mzYHuy/rfOczPRhJgCs7DSAYUJ1r5Q==
=aKzm
-----END PGP SIGNATURE-----

--TzEnwL82fq3P6hDKPFMzHe2DO5sAyAgi0--


