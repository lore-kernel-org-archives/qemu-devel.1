Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZBrt-0001L9-Q6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZBrp-0002EL-Hi
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:40:49 -0500
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:41879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gZBrp-00020z-7Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:40:45 -0500
Received: from player787.ha.ovh.net (unknown [10.109.160.46])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 06A2C43B98
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 10:40:42 +0100 (CET)
Date: Tue, 18 Dec 2018 10:40:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181218104033.5d619c1b@bahia.lan>
In-Reply-To: <c7e3ab4b-adbf-5a26-f057-c64eedfc6c0b@ozlabs.ru>
References: <20181214015520.20467-1-aik@ozlabs.ru>
	<20181217062133.GK5597@umbus.fritz.box>
	<20181218020924.GB23604@umbus.fritz.box>
	<1e2449a7-d89b-3ca5-db66-7da34ff59a35@ozlabs.ru>
	<20181218034910.GF23604@umbus.fritz.box>
	<cae378d2-29c8-556b-8833-713fa95db3da@ozlabs.ru>
	<c7e3ab4b-adbf-5a26-f057-c64eedfc6c0b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, gkurz@linux.ibm.com

On Tue, 18 Dec 2018 18:54:33 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 18/12/2018 15:30, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 18/12/2018 14:49, David Gibson wrote: =20
> >> On Tue, Dec 18, 2018 at 02:04:54PM +1100, Alexey Kardashevskiy wrote: =
=20
> >>>
> >>>
> >>> On 18/12/2018 13:09, David Gibson wrote: =20
> >>>> On Mon, Dec 17, 2018 at 05:21:33PM +1100, David Gibson wrote: =20
> >>>>> On Fri, Dec 14, 2018 at 12:55:20PM +1100, Alexey Kardashevskiy wrot=
e: =20
> >>>>>> SLOF receives a device tree and updates it with various properties
> >>>>>> before switching to the guest kernel and QEMU is not aware of any =
changes
> >>>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it=
 makes
> >>>>>> sense to pass the SLOF final device tree to QEMU to let it impleme=
nt
> >>>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
> >>>>>>
> >>>>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >>>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmwa=
re
> >>>>>> assisted NMI - FWNMI).
> >>>>>>
> >>>>>> This stores the initial DT blob in the sPAPR machine and replaces =
it
> >>>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>>>>>
> >>>>>> This adds an @update_dt_enabled machine property to allow backward
> >>>>>> migration.
> >>>>>>
> >>>>>> SLOF already has a hypercall since
> >>>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >>>>>>
> >>>>>> This makes use of the new fdt_check_full() helper. In order to all=
ow
> >>>>>> the configure script to pick the correct DTC version, this adjusts
> >>>>>> the DTC presense test.
> >>>>>>
> >>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
> >>>>>
> >>>>> Applied, thanks. =20
> >>>>
> >>>> And now, unapplied.
> >>>>
> >>>> I don't know quite how, but somehow this patch is causing aarch64
> >>>> tests to SEGV. =20
> >>>
> >>>
> >>> /home/aik/p/qemu/configure --target-list=3Daarch64-softmmu
> >>> --source-path=3D/home/aik/p/qemu/ --disable-git-update --with-git=3Df=
alse
> >>>    --enable-trace-backend=3Dlog
> >>>
> >>> and
> >>>
> >>> make -C /home/aik/pbuild/qemu-localhost-aarch64-rel/ -j24 check
> >>>
> >>> did not produce segv. I am running this all on a power8 box + ubuntu
> >>> 1804, what is your config? =20
> >>
> >> Hm, curious.  I'm using Fedora 29 on an x86 host. =20
> >=20
> >=20
> > Fedora 27 on x86_64 is all right too :-/ Let's upgrade... =20
>=20
> Upgraded, bad experience - usb ethernet module did not load, and now it
> does not remember the screen configuration - when the external monitor
> is detached - all windows jump to the laptop screen and never come back
> to the external one when reattached :(
>=20
>=20
> Aaaaand the latest QEMU does not compile with gcc 8.2.1 from fc28:
>=20
> /home/aik/p/qemu-dwg/util/memfd.c:38:12: error: static declaration of
> =E2=80=98memfd_create=E2=80=99 follows non-static declaration
>  static int memfd_create(const char *name, unsigned int flags)
>             ^~~~~~~~~~~~
> In file included from /usr/include/bits/mman-linux.h:117,
>                  from /usr/include/bits/mman.h:49,
>                  from /usr/include/sys/mman.h:41,
>                  from /home/aik/p/qemu-dwg/include/sysemu/os-posix.h:29,
>                  from /home/aik/p/qemu-dwg/include/qemu/osdep.h:119,
>                  from /home/aik/p/qemu-dwg/util/memfd.c:28:
> /usr/include/bits/mman-shared.h:46:5: note: previous declaration of
> =E2=80=98memfd_create=E2=80=99 was here
>  int memfd_create (const char *__name, unsigned int __flags) __THROW;
>      ^~~~~~~~~~~~
>=20
>=20
> /home/aik/p/qemu-dwg/block/file-posix.c:1585:14: error: static
> declaration of =E2=80=98copy_file_range=E2=80=99 follows non-static decla=
ration
>  static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>               ^~~~~~~~~~~~~~~
> In file included from /home/aik/p/qemu-dwg/include/qemu/osdep.h:90,
>                  from /home/aik/p/qemu-dwg/block/file-posix.c:25:
> /usr/include/unistd.h:1107:9: note: previous declaration of
> =E2=80=98copy_file_range=E2=80=99 was here
>  ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
>          ^~~~~~~~~~~~~~~
>=20
>=20
> after fixing these, there is still no segv anyway. Hm :(
>=20
>=20

Weird... Unlike you, no compile problems for me with gcc-8.2.1-5.fc28.x86_6=
4, but
same as you, no segv...
