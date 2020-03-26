Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CACE2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRtOg+5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CACE2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSkR-0002Px-7h
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHSiO-0007pF-Tr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHSiN-0000dE-8O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:38:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHSiN-0000cz-39
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6XvtRCgBgAUpkCXGe2lYZCv7zyO5Rb+6Zpofh16gD48=;
 b=LRtOg+5RO/Ho3xBnVDqniL1W28ERrtoHQa7ZWePf+0g1cUmYbRiggE/dvcHf9/qEFIj8wt
 sS3+v9K7H0t7+R7rhx2z/VBNdESbgdrXpCMHcKnXL2fRp4+YNiGEdGzu6EmImAal1K4Or3
 H9GntVtGQz3fJXKeBuCYqkyRlgo7sS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-RSt-RuVkOI2BhNiDoyyD0g-1; Thu, 26 Mar 2020 09:38:28 -0400
X-MC-Unique: RSt-RuVkOI2BhNiDoyyD0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F199DB60;
 Thu, 26 Mar 2020 13:38:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B2F60BF7;
 Thu, 26 Mar 2020 13:38:15 +0000 (UTC)
Subject: Re: [PATCH 0/2] Fix the generic image creation code
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <e5855331-05a9-c828-5bdd-e2d06e0352a9@redhat.com>
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
Message-ID: <3f1e924d-7f52-87f2-8363-4658fdf833d8@redhat.com>
Date: Thu, 26 Mar 2020 14:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e5855331-05a9-c828-5bdd-e2d06e0352a9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aUtO7wyu74Q5Lgbk8QAkGX9au4vyGG7Yx"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aUtO7wyu74Q5Lgbk8QAkGX9au4vyGG7Yx
Content-Type: multipart/mixed; boundary="aQbpX0eoFeVa3MdtORWcBueJjKE1pSTRj"

--aQbpX0eoFeVa3MdtORWcBueJjKE1pSTRj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.03.20 13:23, Max Reitz wrote:
> On 26.03.20 02:12, Maxim Levitsky wrote:
>> The recent patches from Max Reitz allowed some block drivers to not
>> provide the .bdrv_co_create_opts and still allow qemu-img to
>> create/format images as long as the image is already existing
>> (that is the case with various block storage drivers like nbd/iscsi/nvme=
, etc)
>>
>> However it was found out that some places in the code depend on the
>> .bdrv_co_create_opts/.create_opts to be !=3D NULL to decide if to allow
>> image creation.
>>
>> To avoid adding failback code to all these places, just make generic fai=
lback
>> code be used by the drivers that need it, so that for outside user, ther=
e
>> is no diffirence if failback was used or not.
>>
>> Best regards,
>> =09Maxim Levitsky
>>
>> Maxim Levitsky (2):
>>   block: pass BlockDriver reference to the .bdrv_co_create
>>   block: trickle down the fallback image creation function use to the
>>     block drivers
>=20
> Thanks, fixed the function parameter alignment, moved the declarations
> from block.h into block_int.h, and applied the series to my block branch:

(And the spelling fixes suggested by Eric)

> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20
> Max
>=20



--aQbpX0eoFeVa3MdtORWcBueJjKE1pSTRj--

--aUtO7wyu74Q5Lgbk8QAkGX9au4vyGG7Yx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl58sEUACgkQ9AfbAGHV
z0D0kgf/U/hhcSo5l3+bnG27VrLEbLPh3ITIZASp0GfDP2sto6DOkNFvWQpeFuPe
ynoBQOp9RnALQ9kn1jepGczVCcscQ+UJVql9c6DoxX4GQ2aHENdknWljRhgyIcHB
fxzxrQqWX/mQ++AOHZyoVi+It/EvMyFDNq0XlYF6VRuusdl2W6e65n84TQ3z0qZ0
e+mA+hQ9el8dfDTNVtq8ehR9evAZCshIZkQFjCy3cSqztkHKFstAG/uX5wQqVWQM
03bvoa5hbo/uERsfsciIsE6rargDyRcGpJo7/lOZ4qxV9v5BOyrUtWKaWmjjzZse
f3KFDpg5GStHBCbO0l7BwvzKi7CSpQ==
=JKl6
-----END PGP SIGNATURE-----

--aUtO7wyu74Q5Lgbk8QAkGX9au4vyGG7Yx--


