Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB791CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14FF21872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJe0Jemz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14FF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMs08-0006Gk-Se
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMrz1-0005MR-PL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMrz0-00037o-Ik
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:05:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29720
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMrz0-00037T-E1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571742345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IXqW/1BLExOrlZXTPcGjonQZBYeJIs3e15iqOv/HlOg=;
 b=AJe0JemzmDaSIg/rlHfN9PdaBHQNXs7XTYeVVu1VSGyf8Mi797qviwXlJ6bPPkzHBln6eI
 bygLrkvL4V0Nq9ugrxn3Lwv8oA6xiKQcvMImOfDLTUzYpqy0W+/BqbjCIWPy9htQ2EDxsw
 WIkf3Z4jQnlNcCFRbO4YLlbfGGrt+is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-YAIwOo6YMtSPk4GX14sn4w-1; Tue, 22 Oct 2019 07:05:39 -0400
X-MC-Unique: YAIwOo6YMtSPk4GX14sn4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534DC800D4E;
 Tue, 22 Oct 2019 11:05:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F92194B2;
 Tue, 22 Oct 2019 11:05:36 +0000 (UTC)
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
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
Message-ID: <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
Date: Tue, 22 Oct 2019 13:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KlFkMEd8zpYDgiCj0Tx89ftKYn2ytnl8N"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KlFkMEd8zpYDgiCj0Tx89ftKYn2ytnl8N
Content-Type: multipart/mixed; boundary="49AOaJVLWk4tXli8Tl6Dfg64yAAK4KdbB"

--49AOaJVLWk4tXli8Tl6Dfg64yAAK4KdbB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.10.19 08:50, Denis Plotnikov wrote:
>=20
> On 18.10.2019 18:02, Max Reitz wrote:
>> On 18.10.19 14:09, Denis Plotnikov wrote:
>>> The modification is useful to workaround exclusive file access restrict=
ions,
>>> e.g. to implement VM migration with shared disk stored on a storage wit=
h
>>> the exclusive file opening model: a destination VM is started waiting f=
or
>>> incomming migration with a fake image drive, and later, on the last mig=
ration
>>> phase, the fake image file is replaced with the real one.
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Isn=E2=80=99t this what we would want to use reopen for?
>>
>> Max
>=20
> Could you please explain what is "use reopen"?

I was thinking of using (x-)blockdev-reopen to change the file that is
used by the format node (e.g. from a null-co node to a real file); or to
change the filename of the protocol node.

Kevin has pointed out (on IRC) that this will not allow you to change
the node that is directly attached to the device.  While I don=E2=80=99t kn=
ow
whether that=E2=80=99s really necessary in this case, if it were indeed
necessary, I=E2=80=99d prefer a method to change a guest device=E2=80=99s @=
drive option
because that seems more natural to me.

In contrast, the approach taken in this patch seems not quite right to
me, because it overloads the whole blockdev-change-medium command with a
completely new and different implementation based on whether there=E2=80=99=
s a
removable medium or not.  If the implementation is so different (and the
interface is, too, because in one path you must give @medium whereas the
other doesn=E2=80=99t evaluate it at all), it should be a new command.

I don=E2=80=99t know whether we need a new command at all, though.  On the =
node
level, we have (x-)blockdev-reopen.  So assuming we need something to
change the link between the guest device and the block layer, I wonder
whether there isn=E2=80=99t something similar; specifically, I=E2=80=99d pr=
efer
something to simply change the device=E2=80=99s @drive option.

Kevin has pointed out (on IRC again) that there is indeed one such
command, and that=E2=80=99s qom-set.  Unfortunately, this is what happens i=
f you
try to use it for @drive:

{"error": {"class": "GenericError", "desc": "Attempt to set property
'drive' on anonymous device (type 'virtio-blk-device') after it was
realized"}}

However, Kevin has claimed it would be technically possible to make an
exception for @drive.  Maybe this is worth investigating?


(As for blockdev-change-medium, as I=E2=80=99ve said, I don=E2=80=99t reall=
y think this
fits there.  Furthermore, blockdev-change-medium is kind of a legacy
command because I think every command but blockdev-add that does a
bdrv_open() kind of is a legacy command.  So if anything, it should be a
new command that then takes a node-name.
But OTOH, it would be a bit strange to add a separate command for
something that in theory should be covered by qom-set @drive.)

Max


--49AOaJVLWk4tXli8Tl6Dfg64yAAK4KdbB--

--KlFkMEd8zpYDgiCj0Tx89ftKYn2ytnl8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2u4n8ACgkQ9AfbAGHV
z0BrYQgAnU81Gllx42WDrOhevp1rk8wiByA2YGzcvPjXdDasFRGk2+xrf9rjsk5i
+pb4hmqQzIGILkaV73yqdZxN7IpiIfGFURX6zBKUscuNE0DTBYB4efibPyqg5GD6
82vvCr7/kHzkLXtk8MY1ibdQLp157QYYnDg7DuNHHmcl7DcG9CuR2NKOfAUb+sGp
fzQvaqxKoBGXdH7gvF7zfMYCBjW5XW2WrbDrvwqeUdCtT5Lqm8SdUPwvYfoN+ux0
i5lzCByzNrg6Yhc+PTPLnDlHYbZbiTWrBR3wSzrP55QgyUipuJDzIdgC4LSJH2dU
kVWouJ5fLlOlny+K9JvW+uQTXlJk/A==
=jdAu
-----END PGP SIGNATURE-----

--KlFkMEd8zpYDgiCj0Tx89ftKYn2ytnl8N--


