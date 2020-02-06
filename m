Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E1FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55EA20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkAe5Pl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55EA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izenF-0002A7-0p
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izemW-0001NC-Ir
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izemV-00086B-FE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:53:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izemV-0007xY-9C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580986390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uUnNGxogZxzisRMRmmFW5rBzmzoonBlsYRsk7dCVXnc=;
 b=XkAe5Pl02SAWSGGR3RpzpqWHBaE9tApmeSAhs8gLOcet3ZdNaeZIMfS+GgIzvIASCNEEl0
 gYNS3dQEZ/x5tzRo6PWlgdS1K9zX89ubSob00M+NC6D9/Q2bOJRbbdxNxTNDHUE1wM9u15
 xfd40drGQhntbFoDZGjxExYMx7pdR0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-ggKNeXYSPhuJDHtrZF63ag-1; Thu, 06 Feb 2020 05:53:06 -0500
X-MC-Unique: ggKNeXYSPhuJDHtrZF63ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EBF107B768;
 Thu,  6 Feb 2020 10:53:05 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DF725DA7D;
 Thu,  6 Feb 2020 10:53:03 +0000 (UTC)
Subject: Re: [PATCH v2 04/33] block: Add BdrvChildRole to BdrvChild
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-5-mreitz@redhat.com>
 <3113019f-797f-fe89-abbd-280bbddded31@redhat.com>
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
Message-ID: <61ad1ad4-e118-c92c-bbe2-cdd03d02a8d8@redhat.com>
Date: Thu, 6 Feb 2020 11:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3113019f-797f-fe89-abbd-280bbddded31@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t7lVMFJHsI9fnhDcMjCHzgCnSkRTYJ3x4"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
--t7lVMFJHsI9fnhDcMjCHzgCnSkRTYJ3x4
Content-Type: multipart/mixed; boundary="d5MZuXPrCRgOGL9c5ZOiMuNdOELT9P3el"

--d5MZuXPrCRgOGL9c5ZOiMuNdOELT9P3el
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 16:33, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> For now, it is always set to 0.=C2=A0 Later patches in this series will
>> ensure that all callers pass an appropriate combination of flags.
>=20
> Sneaky - this re-adds the field you dropped as part of a rename in 2/33.
> =C2=A0Anyone doing backport had better be aware that they would need this
> whole series, rather than cherry-picking later patches without the
> earlier ones.=C2=A0 But that observation does not affect the patch validi=
ty.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/block.c
>> @@ -2381,6 +2381,7 @@ static void bdrv_replace_child(BdrvChild *child,
>> BlockDriverState *new_bs)
>> =C2=A0 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char =
*child_name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const BdrvC=
hildClass *child_class,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvChildRole child_=
role,
>=20
> Hmm - C is loose enough to allow the declaration of a parameter as an
> enum type even when its intended usage is to receive a bitwise-or
> derived from that enum but not declared in the enum.=C2=A0 For example, i=
f I
> understand intent correctly, a caller might pass in 0x3
> (BDRV_CHILD_DATA|BDRV_CHILD_METADATA) which does NOT appear in
> BdrvChildRole.=C2=A0 It feels like it might be cleaner to document the
> interface as taking an unsigned int (although then you've lost the
> documentation that the int is derived from BdrvChildRole), than to abuse
> the typesystem to pass values that are not BdrvChildRole through the
> parameter.

I don=E2=80=99t necessarily disagree, but we have pre-existing examples of =
such
abuse, like BdrvRequestFlags.

The advantage of using BdrvChildRole as a type here is to show that we
expect values from that enum.  I personally prefer that.

I mean, we could do something else entirely and name the enum
=E2=80=9CBdrvChildRoleBits=E2=80=9D and add a =E2=80=9Ctypedef unsigned int=
 BdrvChildRole;=E2=80=9D.  I
don=E2=80=99t think we=E2=80=99ve ever done that before but maybe it=E2=80=
=99d be the cleanest way?

Max


--d5MZuXPrCRgOGL9c5ZOiMuNdOELT9P3el--

--t7lVMFJHsI9fnhDcMjCHzgCnSkRTYJ3x4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl478A4ACgkQ9AfbAGHV
z0Ab5QgAuLez/ZdVWt8IJQf0ymciu4cYx13JreSKLVxDtPqWngFeionl93UpcHte
6EUPBUNupA9g/4865S8k2rpfpd7KfTMd2qG3+D8k8mKm89DLoZLQAEnKzV2xNRG5
i7S9DRwfkHQITELKmdIeSSfYdv2LijIDmQRC1kdbLAZJlT1eXAqNrFxlBlewSDNq
FUuAzUdNgKxzEJzQoDvtGLSepIKJJlQKuqMlnwVxy8YCt1LJ/+YNgwnk+Aze2m7O
tWxHND1tIlf/VEi+z8zlnmSB71TJSF+9C+5CHlK3qjaW/ULJpf1Nl5UGQlxA63Gm
U448j9pOdo0WzazIN1xJIHpa+gpeeg==
=j6qT
-----END PGP SIGNATURE-----

--t7lVMFJHsI9fnhDcMjCHzgCnSkRTYJ3x4--


