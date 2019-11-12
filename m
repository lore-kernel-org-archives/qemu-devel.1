Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89AC20818
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 12:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDgoTv+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89AC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUq1-0006eJ-Oy
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 07:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUUp0-0006BG-St
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUUoz-0001Aj-Ms
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:58:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41957
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUUoz-0001AX-IK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573559936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qTKuLy8lrsYzS47gswxl5d7WwDxZSn31Ry4PNOpaFYA=;
 b=IDgoTv+gN6LPdyLFbFVfdPI2VdAgD0DX0TsS0pgqCbvL+JOb7+XfFfmVinQVPhQFXK9Mcm
 HRGjRNr4f1PhZwYMOXK0FzrUG7JIqoNHqaXO5HEmTcwkHS1DBbZBvilvYV8+cDFMrzC/nV
 1wS970AGSKqInGaq+X30Mf/qCHGbAy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-3J_xdbdcPOK9g_iS-76Tsw-1; Tue, 12 Nov 2019 06:58:55 -0500
X-MC-Unique: 3J_xdbdcPOK9g_iS-76Tsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 894C28017E0;
 Tue, 12 Nov 2019 11:58:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD374100EBAC;
 Tue, 12 Nov 2019 11:58:49 +0000 (UTC)
Subject: Re: [PATCH v2 00/11] RFC crypto/luks: encryption key managment using
 amend interface
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <fb2cd2e0-2718-215f-d6af-59b64b229b4f@redhat.com>
 <adcb2b6e5a28573c762f8b0d73541ae12d16fc0d.camel@redhat.com>
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
Message-ID: <86918b16-a3c1-4b1e-7e21-1b8e84411065@redhat.com>
Date: Tue, 12 Nov 2019 12:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <adcb2b6e5a28573c762f8b0d73541ae12d16fc0d.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NIQgfktbjuQiwkCVPuckWgUxJtwx2QJwj"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NIQgfktbjuQiwkCVPuckWgUxJtwx2QJwj
Content-Type: multipart/mixed; boundary="TEIZDJU0IhHXDNrAVF6BRjaD4qW2R2fbp"

--TEIZDJU0IhHXDNrAVF6BRjaD4qW2R2fbp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 16:07, Maxim Levitsky wrote:
> On Fri, 2019-10-04 at 21:10 +0200, Max Reitz wrote:
>> On 13.09.19 00:30, Maxim Levitsky wrote:
>>> This patch series is continuation of my work to add encryption
>>> key managment to luks/qcow2 with luks.
>>>
>>> This is second version of this patch set.
>>> The changes are mostly addressing the review feedback,
>>> plus I tested (and fixed sadly) the somewhat ugly code
>>> that allows to still write share a raw luks device,
>>> while preveting the key managment from happening in this case,
>>> as it is unsafe.
>>> I added a new iotest dedicated to that as well.
>>>
>>> Best regards,
>>> =09Maxim Levitsky
>>
>> At least for an RFC looks good from my perspective.  I didn=E2=80=99t lo=
ok at
>> the crypto things very closely (assuming Dan would do so), and I didn=E2=
=80=99t
>> check the iotests in detail.  (But it definitely doesn=E2=80=99t look li=
ke they
>> lack in breadth.  Maybe I=E2=80=99d like to see a test that you cannot h=
ave
>> other useful nodes attached to the LUKS or qcow2 node while the
>> amendment process is ongoing (because CONSISTENT_READ is unshared).  But
>> that=E2=80=99s the only thing I can think of.)
> Could you elaborate on this?=20
>=20
> Inside the same process several users can access that luks node at the sa=
me
> time while one of them changes encryption keys, since this doesn't affect=
 IO of the data.
>=20
> Two users in same process I was *I think* told that can't do the amend in=
 the same time
> since qmp is protected with a lock. However since I use a block job (to b=
e consistent with blockdev-create)
> I wonder if several qmp amend commands couldn't race one with another. Th=
ese jobs is running
> on the block device AIO context (I changed this recently after a review),=
 but stil I am not sure
> there can't be a race.
>=20
> And when there is access to the same image from multiple processes, I do =
have a test that
> checks that as long as more that one process has the image open, noone ca=
n change the encryption keys
> (this is only relevant for raw luks format, since for qcow2 this is forbi=
dden anyway).

Yes, sorry, I don=E2=80=99t remember/know where I got the qcow2 part from. =
 (I
probably just forgot during after reviewing that only LUKS=E2=80=99s permis=
sions
are changed by this series.)

But for LUKS, those changed permissions do apply.  If you can=E2=80=99t do
something between two different qemu instances, you can=E2=80=99t do it in =
a
single one: The file locks are equivalent to the internal permission mask.

So if you can=E2=80=99t change the encryption keys while another process ha=
s the
image open, you can=E2=80=99t change the encryption keys while another node=
 uses
the file node in the same process.  For example, you can=E2=80=99t attach t=
wo
LUKS nodes to a single file node and then change the keys on one of the
nodes.

Max


--TEIZDJU0IhHXDNrAVF6BRjaD4qW2R2fbp--

--NIQgfktbjuQiwkCVPuckWgUxJtwx2QJwj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3KnngACgkQ9AfbAGHV
z0C6cAf+M4mENvObCDeoN+ANH0+etDYtBrAnbqHCFa3dub+8NMliV1gMaMgeL6zm
jDHXGio6zRhPjpq/Ive4rbIpyHiqzsST4GLB9Lb4LOBqIRxtz43JZrsDAQ36Rg3/
XvNN4XEEfRFKyWYm4z02sLs7gAJFcUlpPmUFgTgPZ2GP/4rkbHIEaz3qwSO3bqbp
gRbAQJslpY/XZN0yiPgbYvpAGYnBRR1Il/7UaXLjIW2aKzvoLLOJMtfCWNkbuAl0
lTNfHHFd8DR1UZaOOszbsIrlGDK16ERdnuVC4Mf6/17duLm1rLmRwii3nDMFQ629
6lOIeHf+sbV6RWyMF8Xi2Xxejt+GMw==
=sTE9
-----END PGP SIGNATURE-----

--NIQgfktbjuQiwkCVPuckWgUxJtwx2QJwj--


