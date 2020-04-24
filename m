Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C6FC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B520736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjfcU39u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B520736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzHm-0002ot-Uo
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRzGo-0001vS-Ku
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRzGn-0004Iz-3F
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:25:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRzGm-0004Gl-Jw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587738331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aXb/GLxgsNM+XCM6IYzEOkyAb+WKIPgCxYP4UbBFNDA=;
 b=FjfcU39u2Bgb4QqBI0Z+X2hUpsqL3V1KBrdxaN74+rvphOnAsy8+0XTwldhaDFj19d2MCz
 ONgAakA1hdMboIkpsS3eGH5+ya2hnBdOnGzBDHLandiAiGoYz/u4jOec3O5vcxY0K1mkJI
 Apjyq30hOfDLZGOjMJS+94GvjqNbKqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-62oaRqEBNj2xCdHKX5reGw-1; Fri, 24 Apr 2020 10:25:28 -0400
X-MC-Unique: 62oaRqEBNj2xCdHKX5reGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8AAC462;
 Fri, 24 Apr 2020 14:25:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0449A5C1D6;
 Fri, 24 Apr 2020 14:25:20 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-2-eblake@redhat.com>
 <307f7619-5e4a-10c1-7d49-8ee6bb8d650c@redhat.com>
 <f3808938-8b27-3af0-c2da-996459a5c921@redhat.com>
 <b8d91b29-67ea-3a50-864c-03ae907e092e@redhat.com>
 <9d1d05f0-2e28-7912-b00b-93d2654d8373@redhat.com>
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
Message-ID: <39df248e-cc1a-6a16-7ff2-0443d7548bc3@redhat.com>
Date: Fri, 24 Apr 2020 16:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9d1d05f0-2e28-7912-b00b-93d2654d8373@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f10VZzGgDQVcDrpltggjZX14WzoCMPtmY"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f10VZzGgDQVcDrpltggjZX14WzoCMPtmY
Content-Type: multipart/mixed; boundary="FK9aRc7OeQHH4KXcSoKlC8rAB8ZloMd4e"

--FK9aRc7OeQHH4KXcSoKlC8rAB8ZloMd4e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 16:18, Eric Blake wrote:
> On 4/24/20 5:02 AM, Max Reitz wrote:
>=20
>>> (With the Patchew warning fixed, of course (i.e., we should set ret to
>>> -EPERM or something in qcow.c))
>>
>> Er, well, maybe I should have looked into more places.=C2=A0 The compile=
r
>> only warns about that single one because it=E2=80=99s the only place whe=
re @ret
>> is really uninitialized, but there are many more where we need to set
>> it: crypto.c, parallels.c, qcow.c, qcow2.c (both hunks), qed.c,
>> sheepdog.c, vdi.c, vhdx.c, and vpc.c.
>>
>> (So basically everywhere but vmdk.c, blockdev.c, and blockjob.c.)
>=20
> Urgh - so it's even less of a win in terms of reduced lines of code.

True, but I still consider it a win in terms of reduced complexity.
Before, we have two function calls with two variable assignments from
their return values (@blk and @ret).  Afterwards, we=E2=80=99ll have a sing=
le
function all with one variable assignment from its return value (@blk),
and one stand-alone variable assignment with a constant value (=E2=80=9Cret=
 =3D
-EPERM=E2=80=9D or similar). :)

Max


--FK9aRc7OeQHH4KXcSoKlC8rAB8ZloMd4e--

--f10VZzGgDQVcDrpltggjZX14WzoCMPtmY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6i9s8ACgkQ9AfbAGHV
z0D4qggAjBUtln1UmZgPlGphHc6EqOoUZ7RUc72E6OQ6PKbuts00/i1eHlNWaCsb
lyOxLCP+KuflV4OCaBLSznbkwG7wZM4EW8ulSgmvNlTQ64uFN10nDliAmDFZCiXh
yuhs8aHt2xZtJv/KftOjbfl7qgYahAIKFPhhrhpyBeCjVEaGa79P8owezZHOyM+j
QbFQWgZDcqlB6edvtlUVztM5KV+rUKZ+HSzohQfO4Fea34JaxwlKGC2HXYKuZM/t
N8GtLVZClcgjkgZAJEbwUTyT+oigBR48f4arXdkwmu418f9DruMTgb5MavbS7cdc
m48QWNBLMd42esF5Yh156nhckLXcRw==
=ELCy
-----END PGP SIGNATURE-----

--f10VZzGgDQVcDrpltggjZX14WzoCMPtmY--


