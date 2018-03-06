Received: from eggs.gnu.org ([2001:4830:134:3::10]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1etGnx-0006iX-IV
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1etGnu-0002UM-Ao
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:55:13 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:39484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1etGnu-0002OP-1n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:55:10 -0500
Received: from player711.ha.ovh.net (unknown [10.109.105.221])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4F14411BFDE
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 18:54:59 +0100 (CET)
Date: Tue, 6 Mar 2018 18:54:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180306185446.0ec5e448@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <4e7dd0a0-ca7e-8df7-e966-95e39d34d106@redhat.com>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
	<818fe50b-c3b8-30c5-5452-2009762142c1@ilande.co.uk>
	<4e7dd0a0-ca7e-8df7-e966-95e39d34d106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 6 Mar 2018 18:47:47 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 06.03.2018 18:28, Mark Cave-Ayland wrote:
> > On 06/03/18 16:48, Thomas Huth wrote:
> >  =20
> >> Something in the recent commits introduced a new way to cause unexpect=
ed
> >> aborts of QEMU:
> >>
> >> $ ppc64-softmmu/qemu-system-ppc64 -monitor stdio
> >> QEMU 2.11.50 monitor - type 'help' for more information
> >> (qemu) device_add macio-newworld
> >> Unexpected error in qemu_chr_fe_init() at
> >> /home/thuth/devel/qemu/chardev/char-fe.c:222:
> >> Device 'serial0' is in use
> >> Aborted (core dumped)
> >>
> >> Of course it does not make sense to add a macio-newworld device on the
> >> pseries machine, but QEMU should not abort in this case - it should ju=
st
> >> print an error message and continue afterwards. Any ideas how to fix
> >> this? =20
> >=20
> > So the backtrace from git master looks like this:
> >=20
> > Thread 1 "qemu-system-ppc" received signal SIGABRT, Aborted.
> > __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:=
51
> >=20
> >=20
> > 51=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ../sysdeps/unix/sysv/linux/raise.c: No=
 such file or directory.
> >=20
> >=20
> > (gdb) bt
> >=20
> >=20
> > #0=C2=A0 __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux=
/raise.c:51
> >=20
> > #1=C2=A0 0x00007fffdbd6e3fa in __GI_abort () at abort.c:89
> >=20
> >=20
> > #2=C2=A0 0x0000555555de6d86 in error_handle_fatal (errp=3D0x555556bdfb90
> > <error_abort>, err=3D0x555556ef5a00) at util/error.c:38
> >=20
> > #3=C2=A0 0x0000555555de6eb6 in error_setv (errp=3D0x555556bdfb90 <error=
_abort>,
> > src=3D0x555556031ad0 "chardev/char-fe.c", line=3D222, func=3D0x55555603=
1c50
> > <__func__.18713> "qemu_chr_fe_init", err_class=3DERROR_CLASS_GENERIC_ER=
ROR,
> > =C2=A0=C2=A0=C2=A0 fmt=3D0x555556031b50 "Device '%s' is in use", ap=3D0=
x7fffffffd010,
> > suffix=3D0x0) at util/error.c:71
> >=20
> > #4=C2=A0 0x0000555555de7097 in error_setg_internal (errp=3D0x555556bdfb=
90
> > <error_abort>, src=3D0x555556031ad0 "chardev/char-fe.c", line=3D222,
> > func=3D0x555556031c50 <__func__.18713> "qemu_chr_fe_init",
> > =C2=A0=C2=A0=C2=A0 fmt=3D0x555556031b50 "Device '%s' is in use") at uti=
l/error.c:95
> >=20
> >=20
> > #5=C2=A0 0x0000555555d673fc in qemu_chr_fe_init (b=3D0x555557aef590,
> > s=3D0x555556de2290, errp=3D0x555556bdfb90 <error_abort>) at
> > chardev/char-fe.c:222
> > #6=C2=A0 0x0000555555af5467 in set_chr (obj=3D0x555557aeef80, v=3D0x555=
557960c20,
> > name=3D0x555555f65fc5 "chrA", opaque=3D0x555556658410 <escc_properties+=
432>,
> > errp=3D0x555556bdfb90 <error_abort>) at hw/core/qdev-properties-system.=
c:216
> > #7=C2=A0 0x0000555555cb326a in object_property_set (obj=3D0x555557aeef8=
0,
> > v=3D0x555557960c20, name=3D0x555555f65fc5 "chrA", errp=3D0x555556bdfb90
> > <error_abort>) at qom/object.c:1109
> > #8=C2=A0 0x0000555555cb6232 in object_property_set_qobject
> > (obj=3D0x555557aeef80, value=3D0x555557960bf0, name=3D0x555555f65fc5 "c=
hrA",
> > errp=3D0x555556bdfb90 <error_abort>) at qom/qom-qobject.c:27
> > #9=C2=A0 0x0000555555cb32af in object_property_set_str (obj=3D0x555557a=
eef80,
> > value=3D0x555556de23c0 "serial0", name=3D0x555555f65fc5 "chrA",
> > errp=3D0x555556bdfb90 <error_abort>) at qom/object.c:1117
> > #10 0x0000555555af5d94 in qdev_prop_set_chr (dev=3D0x555557aeef80,
> > name=3D0x555555f65fc5 "chrA", value=3D0x555556de2290) at
> > hw/core/qdev-properties-system.c:427
> > #11 0x0000555555b350a8 in macio_instance_init (obj=3D0x555557aec3c0) at
> > hw/misc/macio/macio.c:347
> >=20
> >=20
> > It seems that the error is being raised when setting the property rather
> > than during realize so I'm not sure what I can do to handle this. Any
> > thoughts? =20
>=20
> Does the device need to be hot-pluggable or even user_creatable at all?

FWIW, the crash also happens when the device is passed on the command line:

$ ppc64-softmmu/qemu-system-ppc64 -device macio-newworld
Unexpected error in qemu_chr_fe_init() at /home/greg/Work/qemu/qemu-spapr/c=
hardev/char-fe.c:222:
qemu-system-ppc64: -device macio-newworld: Device 'serial0' is in use
Aborted (core dumped)

> It seems like it is also using serial_hds[] directly, so that is a good
> indication that it is *not* user creatable. So maybe the easiest fix is
> to simply set
>=20
> 	dc->user_creatable =3D false;
>=20
> in macio_class_init() ?
>=20
>  Thomas
>=20
>=20
