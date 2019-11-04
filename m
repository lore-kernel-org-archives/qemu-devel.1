Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702A4217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS6oa9Fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702A4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRaXY-0000L1-Ii
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 06:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRaWj-0008KF-9z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRaWg-0002X7-7T
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:28:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRaWg-0002TH-2j
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572866881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F4P0LGLVOPr5BnjGeujldXFIXidK8a8/yDk0Gbsb2fo=;
 b=PS6oa9Flt6yJAZwiTWiIe948Fz/6a2ld1e8ClyzZKg1sbD0yi/E9iS9yiTDsud1FjMhIBO
 Jh1QWFSoc1xAHZA07jG0QO/dnPSZ+6mkmWFoHRcaF6Uz+E7HoYDwN8kPtKCICgS03W9N35
 B2oVGQYIUWxoydk6dQZmo9I+MRjiL4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Wswo9QmSNG2bYIyMC9vN0w-1; Mon, 04 Nov 2019 06:27:59 -0500
X-MC-Unique: Wswo9QmSNG2bYIyMC9vN0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 992201005500;
 Mon,  4 Nov 2019 11:27:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-85.ams2.redhat.com
 [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C4955D6C5;
 Mon,  4 Nov 2019 11:27:54 +0000 (UTC)
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
 <f9611252-ee6a-c966-e625-1295bc7fe11e@redhat.com>
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
Message-ID: <5a31f1aa-dd8d-0fda-b20f-938e52243ce3@redhat.com>
Date: Mon, 4 Nov 2019 12:27:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f9611252-ee6a-c966-e625-1295bc7fe11e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GxiqB1u3IdqJ0JtaUtBfrKk0bTqFGarVT"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GxiqB1u3IdqJ0JtaUtBfrKk0bTqFGarVT
Content-Type: multipart/mixed; boundary="zRXLhKtNLChsQTF4eW1gVgzn9uZBYV6eE"

--zRXLhKtNLChsQTF4eW1gVgzn9uZBYV6eE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 12:21, Max Reitz wrote:
> On 01.11.19 16:42, John Snow wrote:
>> Hi, in one of my infamously unreadable and long status emails, I
>> mentioned possibly wanting to copy allocation data into bitmaps as a way
>> to enable users to create (external) snapshots from outside of the
>> libvirt/qemu context.
>>
>> (That is: to repair checkpoints in libvirt after a user extended the
>> backing chain themselves, you want to restore bitmap information for
>> that node. Conveniently, this information IS the allocation map, so we
>> can do this.)
>>
>> It came up at KVM Forum that we probably do want this, because oVirt
>> likes the idea of being able to manipulate these chains from outside of
>> libvirt/qemu.
>>
>> Denis suggested that instead of a new command, we can create a special
>> name -- maybe "#ALLOCATED" or something similar that can never be
>> allocated as a user-defined bitmap name -- as a special source for the
>> merge command.
>>
>> You'd issue a merge from "#ALLOCATED" to "myBitmap0" to copy the current
>> allocation data into "myBitmap0", for instance.
>=20
> Sounds fun, but is there actually any use for this if the only purpose
> is to work as a source for merge?
>=20
> I mean, it would be interesting if it worked exactly like a perma-RO
> pseudo-bitmap that whenever you try to get data from it performs a
> block-status call.  But as you say, that would probably be too slow, and
> it would take a lot of code modifications, so I wonder if there is
> actually any purpose for this.
>=20
>> Some thoughts:
>>
>> - The only commands where this pseudo-bitmap makes sense is merge.
>> enable/disable/remove/clear/add don't make sense here.
>>
>> - This pseudo bitmap might make sense for backup, but it's not needed;
>> you can just merge into an empty/enabled bitmap and then use that.
>>
>> - Creating an allocation bitmap on-the-fly is probably not possible
>> directly in the merge command, because the disk status calls might take
>> too long...
>>
>> Hm, actually, I'm not sure how to solve that one. Merge would need to
>> become a job (or an async QMP command?) or we'd need to keep an
>> allocation bitmap object around and in-sync. I don't really want to do
>> either, so maybe I'm missing an obvious/better solution.
>=20
> All of what you wrote in this mail makes me think it would make much
> more sense to just add a =E2=80=9Cblock-dirty-bitmap-create-from=E2=80=9D=
 job with an
> enum of targets.  (One of which would be =E2=80=9Callocated-blocks=E2=80=
=9D.)

I forgot to add that of course the advantage of a pseudo-bitmap would be
that it=E2=80=99s always up to date, but as you said, it would be slow to q=
uery
(and it might even yield, which isn=E2=80=99t what callers expect) and at l=
east
for block allocation, it seems unnecessary to me (because writes will
keep the new bitmap created from allocated-blocks up-to-date).

Max


--zRXLhKtNLChsQTF4eW1gVgzn9uZBYV6eE--

--GxiqB1u3IdqJ0JtaUtBfrKk0bTqFGarVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ACzkACgkQ9AfbAGHV
z0DkFggAkgaz0gvJFW+QmJ4WKmQbnb1E95QeJS5Atvb5pQ78hvyE0DmlT9VUpUmK
sUELpG7vYxp96GbEARE5E/MBU/EHtEeHaFur/wOPJRiw8LYrc8t6LwPMbwO9kwZB
Lfgwb21QJJxY8oS3Jez3AF4XAEReIHZelPPFpYycaP+cJXDPsAdL2/bnOpK+oTcw
KL5NJ6V8qA4I/VkOJ9Z1r+w2Qgjx8F7I2kcO8Hm9qGNZ6Y4oVVKuEzhU4DM2dqao
Ay2uOPwFO0ZmyIOKARmRy3Fxob/IKm3RPcT7+g2nnxpG9yuuvD67/X5W2u4jN1f6
dngzMjYjuxYc8aZGS7hOSsR7JokjJw==
=sYKH
-----END PGP SIGNATURE-----

--GxiqB1u3IdqJ0JtaUtBfrKk0bTqFGarVT--


