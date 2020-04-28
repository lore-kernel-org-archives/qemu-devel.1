Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AEBC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0EF206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ3GGoFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0EF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNGH-0006Uy-OQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTNFC-0005i0-Fx
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTNF4-0000rj-Fy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:13:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTNF3-0000r3-Vs
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588068806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9IqRuFTPjjlqQTY4CFikMPZOZsVDqydWP8/1X508sjA=;
 b=gZ3GGoFdgTnDzoC3Uu53QQagyTo48I96r6lAqEQl96uck/2zdqZqE+y8aEYulwgbo+WYB5
 og2HBak7PwZxyCFxlYzahBOtMTJ/06AVQrTJ1LrwYAGzkmxHmM1ekPPf2EIE2Hb+QUxpgf
 e6qIl5mBiS1e+KzPMlsUsFY6nU3bgsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-qskIFepHP1yuRwo8IWn6cQ-1; Tue, 28 Apr 2020 06:13:23 -0400
X-MC-Unique: qskIFepHP1yuRwo8IWn6cQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4EC462
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 10:13:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 694FB28542;
 Tue, 28 Apr 2020 10:13:15 +0000 (UTC)
Subject: Re: [PATCH] virtiofsd: Show submounts
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
 <8aa9aea2-cc5d-f9b5-5cdb-b5e596ef89aa@redhat.com>
 <20200428095935.GA2794@work-vm>
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
Message-ID: <537eb3fe-d930-1d8e-1597-1b73831d0623@redhat.com>
Date: Tue, 28 Apr 2020 12:13:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428095935.GA2794@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZSsyBjZKdka6iJkrHCtJc6NPPhvKrYh2D"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZSsyBjZKdka6iJkrHCtJc6NPPhvKrYh2D
Content-Type: multipart/mixed; boundary="sGOz0g6p87dklTrbhaM7lkcYZN6yEs9fj"

--sGOz0g6p87dklTrbhaM7lkcYZN6yEs9fj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 11:59, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 27.04.20 19:59, Dr. David Alan Gilbert wrote:
>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>> Currently, setup_mounts() bind-mounts the shared directory without
>>>> MS_REC.  This makes all submounts disappear.
>>>>
>>>> Pass MS_REC so that the guest can see submounts again.
>>>
>>> Thanks!
>>>
>>>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>>>
>>> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>>
>> Well, I bisected it and landed at 3ca8a2b1.  So while the problematic
>> line may have been introduced by 5baa3b8e, it wasn=E2=80=99t used until =
3ca8a2b1.
>=20
> OK, I'd rather stick with the Fixes: for the patch that was actually
> wrong.

Why not both? :)

>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tools/virtiofsd/passthrough_ll.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passth=
rough_ll.c
>>>> index 4c35c95b25..9d7f863e66 100644
>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
>>>>      int oldroot;
>>>>      int newroot;
>>>> =20
>>>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
>>>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>>>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source=
, source);
>>>>          exit(1);
>>>>      }
>>>
>>> Do we want MS_SLAVE to pick up future mounts that might happenf rom the
>>> host?
>>
>> Hm.  So first it looks to me from the man page like one shouldn=E2=80=99=
t give
>> MS_SLAVE on the first mount() call but kind of only use it for remounts
>> (in the list at the start, =E2=80=9CCreate a bind mount=E2=80=9D is sepa=
rate from
>> =E2=80=9CChange the propagation type of an existing mount=E2=80=9D, and =
the man page
>> later says =E2=80=9CThe only other flags that can be specified while cha=
nging
>> the propagation type are MS_REC (described below) and MS_SILENT (which
>> is ignored).=E2=80=9D).
>>
>> Second, even if I do change the propagation type to MS_SLAVE in a second
>> call, mounts done after qemu has been started don=E2=80=99t show up in t=
he guest
>> (for me).
>>
>> So while it sounds correct, I can=E2=80=99t see it having an effect, act=
ually.
>=20
> That's unfortunate; but I guess we can debug that separately
>=20
>>> What's the interaction between this and the MS_REC|MS_SLAVE that we hav=
e
>>> a few lines above for / ?
>>
>> Good question.  It would seem to me that there isn=E2=80=99t any.  That =
previous
>> mount call just sets MS_REC | MS_SLAVE for the whole mount namespace,
>> and then we do a new mount here (by default from / to /) that needs its
>> own flags.
>>
>> (More interesting is perhaps why we have that other mount() call below,
>> which again sets MS_REC | MS_SLAVE for the old (not-yet-bind-mounted) /.
>>  I can=E2=80=99t imagine that to have any effect.)
>=20
> Is that just trying to be careful before the umount2 so it doesn't try
> to unmount something useful?

Perhaps, but still, it shouldn=E2=80=99t matter.  I rather suspect that
setup_namespaces() and setup_mounts() were developed (or taken from
elsewhere) independently, so they both have to work independently, and
thus they do overlapping stuff.

Max


--sGOz0g6p87dklTrbhaM7lkcYZN6yEs9fj--

--ZSsyBjZKdka6iJkrHCtJc6NPPhvKrYh2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oAboACgkQ9AfbAGHV
z0CVhAf+IuToXHK0o9w6hHjFtn1Lhg+/OO+5TZYh1wZIHI7gKBHmgW6dvJ05ya6o
d+NpukoaT/KY5E7n/T/Z/OfBdsYGHbJAEF/HSWLgA7wg2ydPc7+lxO6ETzdwUlDq
wL4W9cyZYcjQ7DlhPlBX5yxbclPhhih2ZqXgm3yIk6qiGmLhw7+8IG9Gt5LNr5xR
7AvA0h4hXpTdggb6UzFJW1zaAz7VF1rqWYB0jOKqPO/EkP35rc7FDvrdvkcwmnrH
CqkZbaApc98HavdMO5oNk3ZbqrwTl2BKUjPT4yWxUY1ifHCx8Fz7wWt+a7x8b8TO
ykAU8yhFzhetHgadA3t0qcrqXyvlxg==
=qz4M
-----END PGP SIGNATURE-----

--ZSsyBjZKdka6iJkrHCtJc6NPPhvKrYh2D--


