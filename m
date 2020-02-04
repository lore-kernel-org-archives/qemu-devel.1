Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A7C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2252084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxAt7amf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2252084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2Ot-0005gt-TV
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz2OH-0004n4-3P
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz2OF-0000tC-Kb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:53:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz2OF-0000ou-FQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580838815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kURUGdOpD7Ps4pareka7Ki6PKRWwLaKO7Txlsez8nTE=;
 b=JxAt7amfr/mKYlkNtchFbJW+S4OIWFsRWIt6N/nqg8ej3pNL5K+EeJQaxSsw3Z1hQHjfFT
 sJMcVYBXoNAOWTvuJLoh0erqdUIw4usvkazXtEWfUtuJ0U5vCqW1PwBv+naAnluwHduMCL
 uFM/OFUDyAwJJadtC3tdpRyZtoqQ9O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-rCwmObF7NYyRSOL6tEgjJQ-1; Tue, 04 Feb 2020 12:53:19 -0500
X-MC-Unique: rCwmObF7NYyRSOL6tEgjJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C991800D5C;
 Tue,  4 Feb 2020 17:53:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA14F5D9C5;
 Tue,  4 Feb 2020 17:53:07 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
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
Message-ID: <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
Date: Tue, 4 Feb 2020 18:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-10-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mcNtRbTJyxEzFFgvTzhjAfvdlfnBmckts"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mcNtRbTJyxEzFFgvTzhjAfvdlfnBmckts
Content-Type: multipart/mixed; boundary="pEyBuylh0h0sgqhMuUuyxYgD8QUbA3PtC"

--pEyBuylh0h0sgqhMuUuyxYgD8QUbA3PtC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.01.20 18:44, Eric Blake wrote:
> Having two slightly-different function names for related purposes is
> unwieldy, especially since I envision adding yet another notion of
> zero support in an upcoming patch.  It doesn't help that
> bdrv_has_zero_init() is a misleading name (I originally thought that a
> driver could only return 1 when opening an already-existing image
> known to be all zeroes; but in reality many drivers always return 1
> because it only applies to a just-created image).

I don=E2=80=99t find it misleading, I just find it meaningless, which then =
makes
it open to interpretation (or maybe rather s/interpretation/wishful
thinking/).

> Refactor all uses
> to instead have a single function that returns multiple bits of
> information, with better naming and documentation.

It doesn=E2=80=99t make sense to me.  How exactly is it unwieldy?  In the s=
ense
that we have to deal with multiple rather small implementation functions
rather than a big one per driver?  Actually, multiple small functions
sounds better to me =E2=80=93 unless the three implementations share common=
 code.

As for the callers, they only want a single flag out of the three, don=E2=
=80=99t
they?  If so, it doesn=E2=80=99t really matter for them.

In fact, I can imagine that drivers can trivially return
BDRV_ZERO_TRUNCATE information (because the preallocation mode is
fixed), whereas BDRV_ZERO_CREATE can be a bit more involved, and
BDRV_ZERO_OPEN could take even more time because some (constant-time)
inquiries have to be done.

And thus callers which just want the trivially obtainable
BDRV_ZERO_TRUNCATE info have to wait for the BDRV_ZERO_OPEN inquiry,
even though they don=E2=80=99t care about that flag.

So I=E2=80=99d leave it as separate functions so drivers can feel free to h=
ave
implementations for BDRV_ZERO_OPEN that take more than mere microseconds
but that are more accurate.

(Or maybe if you really want it to be a single functions, callers could
pass the mask of flags they care about.  If all flags are trivially
obtainable, the implementations would then simply create their result
mask and & it with the caller-given mask.  For implementations where
some branches could take a bit more time, those branches are only taken
when the caller cares about the given flag.  But again, I don=E2=80=99t
necessarily think having a single function is more easily handleable
than three smaller ones.)

Max


--pEyBuylh0h0sgqhMuUuyxYgD8QUbA3PtC--

--mcNtRbTJyxEzFFgvTzhjAfvdlfnBmckts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl45r4IACgkQ9AfbAGHV
z0Ayewf/fjWttivEx39XPnxIRUgyyuaP0zku08KhfqqJptr6FjrKLFYlhPlWo92Z
zti356HSIC4YyY+bxWYvealh+YONBqVR960wJy0fRybq0k4Oi4M4VYTLj6AjF2BW
kFDfoPsBToyrdpQOyb+6EWC+hTZtKyTHUiJZSjJJGHZjjvNX7h/Oo/sr+2D8pJmO
5NIcKbbKe9HvpSta2XqsxaSapM6Sm1vSEYxjWIeiCtr9utYS4qcHQ8foTE8u8nU/
0vmOYWfhvyCMKcOYgWnoe0vY+gIhJ3JoxP8xpDIe1uTE0hx/KUq+n8C+qW63LZ4f
xTL7mvfYZTe5f/oemFGeTBwkv0oxJA==
=ADGL
-----END PGP SIGNATURE-----

--mcNtRbTJyxEzFFgvTzhjAfvdlfnBmckts--


