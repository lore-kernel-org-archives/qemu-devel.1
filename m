Received: from eggs.gnu.org ([2001:4830:134:3::10]:58661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMKf-0007g3-Qs
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMKc-00030I-JO
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBMKc-000300-Ay
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:23:10 -0400
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
	<149399504137.29022.4985100698645275511.stgit@bahia.lan>
	<3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
	<20170509112305.439c4d85@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7698aca3-0ba9-9a7a-f2c5-8e459384842d@redhat.com>
Date: Thu, 18 May 2017 09:23:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170509112305.439c4d85@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M6aWQR0csg8Wpk9UAfglQRPd7Wta0fq3V"
Subject: Re: [Qemu-devel] [PATCH 3/5] 9pfs: local: simplify file opening
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M6aWQR0csg8Wpk9UAfglQRPd7Wta0fq3V
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?L=c3=a9o_Gaspard?= <leo@gaspard.io>
Message-ID: <7698aca3-0ba9-9a7a-f2c5-8e459384842d@redhat.com>
Subject: Re: [PATCH 3/5] 9pfs: local: simplify file opening
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
 <149399504137.29022.4985100698645275511.stgit@bahia.lan>
 <3c8abd95-b490-1b71-b467-4f00d6ce121d@redhat.com>
 <20170509112305.439c4d85@bahia>
In-Reply-To: <20170509112305.439c4d85@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 04:23 AM, Greg Kurz wrote:
> On Fri, 5 May 2017 12:01:55 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
>> On 05/05/2017 09:37 AM, Greg Kurz wrote:
>>> All paths in the virtfs directory now start with "./" (except the vir=
tfs
>>> root itself which is exactly ".").
>>>
>>> We hence don't need to skip leading '/' characters anymore, nor to ha=
ndle
>>> the empty path case. Also, since virtfs will only ever be supported o=
n
>>> linux+glibc hosts, we can use strchrnul() and come up with a much sim=
plier
>>> code to walk through the path elements. And we don't need to dup() th=
e
>>> passed directory fd.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/9pfs/9p-local.c |    5 -----
>>>  hw/9pfs/9p-util.c  |   26 ++++++++++----------------
>>>  2 files changed, 10 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>>> index 92262f3c3e37..bb6e296df317 100644
>>> --- a/hw/9pfs/9p-local.c
>>> +++ b/hw/9pfs/9p-local.c
>>> @@ -54,11 +54,6 @@ int local_open_nofollow(FsContext *fs_ctx, const c=
har *path, int flags,
>>>  {
>>>      LocalData *data =3D fs_ctx->private;
>>> =20
>>> -    /* All paths are relative to the path data->mountfd points to */=

>>> -    while (*path =3D=3D '/') {
>>> -        path++;
>>> -    } =20
>>
>> Is it worth adding any assert()s in place of the deleted code?
>>
>=20
> The assert() added by this patch ensures that we never pass an empty
> string to relative_openat_nofollow(), which isn't related to this
> hunk of deleted code... so I'm not sure I understand the question :-\

I was thinking if it is worth replacing the deleted while() loop with an

assert(*path !=3D '/');

to prove that we have already taken care of ensuring a relative path.
You're right that you added another assert(*path) elsewhere in the
patch, and that one looked fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--M6aWQR0csg8Wpk9UAfglQRPd7Wta0fq3V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHa5LAAoJEKeha0olJ0NqZKgH/2rKlUwcyoYH/sncybnVyty2
ad+PesyJbV8fg9tY1Y//e1wZ/aZWVYo+vP9lCkx4dt/Tl3zc5AVTg/RI6wqfNglU
DHuXWtecdXZn/kvkGwd7/mcOb9B87Gg+nhlG4qObLLPn9peN8GKK1BCwjsLvbpw2
1Ng3yUFBdB7kNpTMsO9w8M56ww6+h0lGEpArfTlAZOSqQ1b9bSKqm0YDM9pIpxsU
fyhrj3+ObTPazcjAuHlsPh/+xfVd1+2DelKGA9x5gRNkyglTS4cCzgzk1Gchfh+E
0jOZ0atEQR9lgyM9TD/oM2JhDuuSqY+u6cGTyMIqHgOQZdQsuqt99ZsdPHRQPiE=
=H9Nj
-----END PGP SIGNATURE-----

--M6aWQR0csg8Wpk9UAfglQRPd7Wta0fq3V--
