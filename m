Received: from eggs.gnu.org ([2001:4830:134:3::10]:50175)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dp0fr-0007Zx-AT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dp0fm-0000LQ-7y
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:20:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:58609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dp0fl-0000Jk-T6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:20:54 -0400
References: <20170903163455.15132-1-n54@gmx.com>
	<20170904172500.26513-1-n54@gmx.com>
	<CAFEAcA8ojJteWAuwxhQPVTVvFh5b-S4zWoyCssM0ZxWt5tt4GQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <53cd29e6-0bd7-339a-96b8-a285e15ffee8@gmx.com>
Date: Tue, 5 Sep 2017 01:22:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ojJteWAuwxhQPVTVvFh5b-S4zWoyCssM0ZxWt5tt4GQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nEcvb0Bw7QWf7leihsc3dBITkxpajKmVh"
Subject: Re: [Qemu-devel] [PATCH v2] usb-mtp: Add fallback definition of
 NAME_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jonathan Perkin <jperkin@joyent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nEcvb0Bw7QWf7leihsc3dBITkxpajKmVh
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Jonathan Perkin <jperkin@joyent.com>
Message-ID: <53cd29e6-0bd7-339a-96b8-a285e15ffee8@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb-mtp: Add fallback definition of
 NAME_MAX
References: <20170903163455.15132-1-n54@gmx.com>
 <20170904172500.26513-1-n54@gmx.com>
 <CAFEAcA8ojJteWAuwxhQPVTVvFh5b-S4zWoyCssM0ZxWt5tt4GQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8ojJteWAuwxhQPVTVvFh5b-S4zWoyCssM0ZxWt5tt4GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 19:50, Peter Maydell wrote:
> On 4 September 2017 at 18:25, Kamil Rytarowski <n54@gmx.com> wrote:
>> This fixes build on SmartOS (Joyent).
>>
>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  include/qemu/osdep.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 6855b94bbf..5d3860f80e 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -306,6 +306,11 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>>  #endif
>>  #endif
>>
>> +/* Required by SmartOS (SunOS) */
>> +#ifndef NAME_MAX
>> +#define NAME_MAX 255
>> +#endif
>=20
> So in hw/usb/dev-mtp.c we're using NAME_MAX in
>     char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
>=20
> because the Linux implementation of inotify documents in inotify(7)
> that this is guaranteed to be sufficient to read at least one event:
>   http://man7.org/linux/man-pages/man7/inotify.7.html
> Looking at the SmartOS manpage
>   https://smartos.org/man/5/inotify
> there doesn't seem to be any equivalent language.
>=20
> What is the SmartOS requirement on the buffer size to be
> guaranteed to read at least one complete event ?
> Defining NAME_MAX to 255 seems like it shuts up the compiler
> error but does it give us the correct behaviour?
>=20
According to my understanding SmartOS has the same logic. It tries to
read at least one element, and NAME_MAX guarantees that it will be
available.

https://github.com/joyent/illumos-joyent/blob/master/usr/src/uts/common/i=
o/inotify.c#L1193

I've gathered some overall details about the patches.

1. The inotify linux-compat interface is only SmartOS specific, it
hasn't been upstreamed so far to other Illumos distributions.

2. Upstream Illumos implemented NAME_MAX
https://github.com/illumos/illumos-gate/commit/9c0752ac0dc05794d2f8a8b452=
1d55e2b3f63247

It's not available in SmartOS.

3. Proprietary Solaris is out of scope of this work.

Looking at their userland we can assume no qemu support:

https://github.com/oracle/solaris-userland

https://github.com/oracle/solaris-userland/commit/9c78c7b45a5d3dbd64afb45=
5d278d2ca277e2b95#diff-94df904ebca88ee0ff038eaedb063ad6R61

++        if platform.system() =3D=3D 'SunOS':
++            # No QEMU support on Solaris now.
++            qemu_img =3D False

We can stop pretending to support it now.

4. SmartOS forked qemu for its hypervisor part and uses qemu-kvm with
the Linux kvm interface (yes, there is Linux kernel kvm port to SmartOS)
- upstreaming the hypervisor's fork is out of scope.

https://github.com/joyent/illumos-kvm-cmd

5. SmartOS ships with virtual machine guests, they host pkgsrc and qemu
from pkgsrc.

6. Jonathan mentioned that preparing a SmartOS tutorial and image will
be tricky, as SmartOS is a hypervisor. I will focus on upstreaming
SmartOS-guest support for qemu, where there is pkgsrc. There is an
option to prepare another Illumos distribution tutorial and testbot,
hopefully it will be fully compatible with SmartOS patches.

> thanks
> -- PMM
>=20



--nEcvb0Bw7QWf7leihsc3dBITkxpajKmVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZreBUAAoJEEuzCOmwLnZsCqcP/1phwKOxgSJtWmaXQcFiIDAc
bgotHBIuUOJWSuE1lo9MDYNMq7Z+EKyGXMuG2KrXeXjF4mutfYjHjl7CxQ+hGmRr
UFcDkfjYAkBoKyUQe5pp3xF4CCM2zfYPK6/x80EXhnE/UZxFYbIKYmf8m+FIapYt
DtMiaWhren3NNoWCCehwdS4sFyAus5+/DCiOwTP//wB9JtiV/27upHzC78K+2zKi
G9uSETctenwn4CHPxEAZIqNGYXidh0FbemKd8+iJT+VI81vNTcqI1YUbK1NxsNnp
+hVFXcPI5uTE6Qz8T89vZMb3KUGscy28XoLLvORWtzLtRNoJtNFsNDm9mp4OWT2E
iVkJKEqNKrOgKsLG4M/DmdXZNlbxy6Uql3CyYanmUsu1f4e7d7yAlb54hs8aIoX6
ZNFXzwtPfVCzrYkbd40lnmeESvYb5m1Vkj5GxTPNClCRSoFIAcjFKD4ks3G7YmpY
G0XL7nLomt1LeowBIvLj1uQ5XsM+0WsDudcyNPWP++6bH7/qrE9NQeWR9//m4/AI
KeuapgO8a53rDp74fXmymXUBwTHubZjPiIQW6WGenHKRshEd+mbmgF1Tn7qKcYSf
+DOULRonBy9UCOLzC5079Ev46/UtNkbW5OrK6evrb8z0XBQcKU+vrLZ+b2F4wKrv
QJ7Hu88rED9btbVngbM1
=Gu+m
-----END PGP SIGNATURE-----

--nEcvb0Bw7QWf7leihsc3dBITkxpajKmVh--
