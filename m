Received: from eggs.gnu.org ([2001:4830:134:3::10]:52096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVuTi-0007q9-Tl
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVuTf-0003L0-0A
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:53:30 -0400
Date: Fri, 14 Jul 2017 16:53:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170714065316.GB17539@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
	<20170713005740.GR4083@umbus.fritz.box>
	<901df6de-ffc8-1b01-3f8d-37e30f852799@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <901df6de-ffc8-1b01-3f8d-37e30f852799@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 0/8] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 07:13:23AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 07/12/2017 09:57 PM, David Gibson wrote:
> > On Wed, Jul 12, 2017 at 10:48:38AM -0300, Daniel Henrique Barboza wrote:
> > > The dreaded Libvirt hotplug-migrate-hotunplug scenario is working nic=
ely.
> > Good to hear.
> >=20
> > > device_add when the machine is in RUN_STATE_PRELAUNCH (-S) still does=
n't
> > > work but it is expected - as discussed in "[RFC drcVI PATCH] spapr: r=
eset
> > > DRCs
> > > on migration pre_load=E2=80=8B", this scenario can't be fixed solely =
by this DRC
> > > cleanup.
> > Hmm.. what's the exact test case you're using here?  The prelaunch
> > case I tried _did_ work (queueing the event during prelaunch, then
> > completing the hotplug sequence once the guest had booted).
>=20
> This is the test case:
>=20
> sudo ./qemu-system-ppc64 -name migrate_qemu -boot strict=3Don --enable-kvm
> -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0xf -device
> spapr-vscsi,id=3Dscsi0,reg=3D0x2000 -smp 1,maxcpus=3D4,sockets=3D4,cores=
=3D1,threads=3D1
> --machine pseries,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m
> 4G,slots=3D32,maxmem=3D32G -drive file=3D/home/danielhb/vm_imgs/ubuntu170=
4.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone
> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> -nographic -S
> QEMU 2.9.50 monitor - type 'help' for more information
> (qemu)
> (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> (qemu) cont
>=20
> (...)
>=20
> After OS boots:
>=20
> danielhb@ubuntu1704:~$ lscpu
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                1
> On-line CPU(s) list:   0
> Thread(s) per core:    1
> Core(s) per socket:    1
> Socket(s):             1
> NUMA node(s):          1
> Model:                 2.1 (pvr 004b 0201)
> Model name:            POWER8E (raw), altivec supported
> Hypervisor vendor:     horizontal
> Virtualization type:   full
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s):     0
> danielhb@ubuntu1704:~$ (qemu)
> (qemu) info cpus
> * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D6134
>   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D6163
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   CPUInstance Properties:
>     core-id: "3"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   CPUInstance Properties:
>     core-id: "2"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   qom_path: "/machine/peripheral/core1"
>   CPUInstance Properties:
>     core-id: "1"
>   type: "host-spapr-cpu-core"
>   vcpus_count: "1"
>   qom_path: "/machine/unattached/device[0]"
>   CPUInstance Properties:
>     core-id: "0"
> (qemu)

Huh.  I tried basically the same thing, and I get the second cpu once
the OS is booted.  My first guess would be that the difference is in
the guest (mine is RHEL 7.3).  Have you double checked that rtas_errd
and drmgr are present in your guest?

> I am not aware of anyone (e.g. Libvirt) using device_add at that point so
> it's not
> urgent to make this work AFAIC. I was just curious of why it
> doesn't.

Hm, I thought libvirt did use device_add here in at least some
circumstances.

I've gone ahead and sent a pull req with the changes, since AFAICT his
is not a regression, so the DRC cleanups still improve matters
overall.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlloaloACgkQbDjKyiDZ
s5ITYw/9GRzeJpFYN1YHmsaiabYnTDwi1MGy++/mHlB/heOJMfozEn8Tkgv5gSE5
iUbhWgK5/4aQExCvjnPvgv/bpUQ3CzDqhJLuRYaa+sKZW+q3Zy/Cuz6tuyd0qyDS
Drr8bf3EA5C9C7Vai9goKY8dPgZ7sv/V78aVFfOqqRJwxii+pqC54q2y+9idPwZi
ookQiYt/n8DXbSiwBaID8PekRt08m6YSX1KSjuCbSZNFoPpbU7QmF2H7+45V7Qrz
lRjD1eT+QykglDqW2PX4tYoE9HOYvHjSNc5HuYG5p1CqUaSKpUjP4mN1Ik8Yk2Wv
X0W+TTAWg7wFgw0rDNVJtCrvkrkMdyTJ3Q3g9JGoGzJYLGLsLkGFyYRTqskfYDA7
o1ph80CHFE+uKNfWxpSPuTrJ20sOFQskal0/KcPthmySExHNvd8vrBabbDpZnazW
RgYcedU0zoPDkGk1zg1KBrQEpe3QAY9ugKuO7hDaPRvl5AUVRvKiaiS5JxDO6yv0
wk09pl5sNWfGLFssnselAAgLl+mpnxWXHddwD6ZbeRa344rj7PAkJA/rOqsBVuag
fhya249zMh+JCGrSHHtgKt8vKZueOyxgfaNyo1K0y0dRItIawUWZe5zDFnRkBhcs
/G+4lj+pkvUnIL7iCD+PxZLXg2Ut4gNC4KYDquaeDiPb7VhkuVo=
=puSG
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
