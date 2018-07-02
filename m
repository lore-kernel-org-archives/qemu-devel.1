Received: from eggs.gnu.org ([2001:4830:134:3::10]:37846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZybe-0003GL-Mo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZybZ-0000mW-NZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:11:02 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fZybZ-0000m7-CI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:10:57 -0400
Received: by mail-wm0-x244.google.com with SMTP id b188-v6so9036656wme.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:10:57 -0700 (PDT)
Date: Mon, 2 Jul 2018 14:10:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702131054.GE2155@stefanha-x1.localdomain>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20180331084500.33313-1-jiangshanlai@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, Peng Tao <bergwolf@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 31, 2018 at 04:45:00PM +0800, Lai Jiangshan wrote:
> a) feature: qemu-local-migration, qemu-live-update
> Set the mem-path on the tmpfs and set share=3Don for it when
> start the vm. example:
> -object \
> memory-backend-file,id=3Dmem,size=3D128M,mem-path=3D/dev/shm/memory,share=
=3Don \
> -numa node,nodeid=3D0,cpus=3D0-7,memdev=3Dmem
>=20
> when you want to migrate the vm locally (after fixed a security bug
> of the qemu-binary, or other reason), you can start a new qemu with
> the same command line and -incoming, then you can migrate the
> vm from the old qemu to the new qemu with the migration capability
> 'bypass-shared-memory' set. The migration will migrate the device-state
> *ONLY*, the memory is the origin memory backed by tmpfs file.

Marcelo, Andrea, Paolo: There was a more complex local migration
approach in 2013 with fd passing and vmsplice.  They specifically
avoided the approach proposed in this patch, but I don't remember why.

The closest to an explanation I've found is this message from Marcelo:

  Another possibility is to use memory that is not anonymous for guest
  RAM, such as hugetlbfs or tmpfs.

  IIRC ksm and thp have limitations wrt tmpfs.

https://www.spinics.net/lists/linux-mm/msg67437.html

Have the limitations been been solved since then?

> c)  feature: vm-template, vm-fast-live-clone
> the template vm is started as 1), and paused when the guest reaches
> the template point(example: the guest app is ready), then the template
> vm is saved. (the qemu process of the template can be killed now, because
> we need only the memory and the device state files (in tmpfs)).
>=20
> Then we can launch one or multiple VMs base on the template vm states,
> the new VMs are started without the =E2=80=9Cshare=3Don=E2=80=9D, all the=
 new VMs share
> the initial memory from the memory file, they save a lot of memory.
> all the new VMs start from the template point, the guest app can go to
> work quickly.
>=20
> The new VM booted from template vm can=E2=80=99t become template again,
> if you need this unusual chained-template feature, you can write
> a cloneable-tmpfs kernel module for it.
>=20
> The libvirt toolkit can=E2=80=99t manage vm-template currently, in the
> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
> =E2=80=9Clibvrit managed template=E2=80=9D feature to libvirt.

This feature has been discussed multiple times in the past and probably
the reason why it's not in libvirt yet is that no one wants it badly
enough that they have solved the security issues.

RAM and disk contain secrets like address-space layout randomization,
random number generator state, cryptographic keys, etc.  Both the kernel
and userspace handle secrets, making it hard to isolate all secrets and
wipe them when cloning.

Risks:
1. If one cloned VM is exploited then all other VMs are more likely to
   be exploitable (e.g. kernel address space layout randomization).
2. If you give VMs cloned from the same template to untrusted users,
   they may be able to determine the secrets other users' VMs.

How are you wiping secrets and re-randomizing cloned VMs?  Security is a
major factor for using Kata, so it's important not to leak secrets
between cloned VMs.

Stefan

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOiReAAoJEJykq7OBq3PINPgH/AuGYfXJA578EY5FiLw4yvFN
wn/D1wUkOg12G2UVPXXESzdLzzxVGFZfg/epNcPg40jTGXVIBgeekvwBOmU9F3oK
R+TzAsLz/dDqvveObAiXOtzAJczGgNM+CVXUGTOcd5n3ydLXvr59iWR6zaLhjyjd
v6/Z4QVJv+3KhU6sPRIaxMSJdx03a/jxka1qdDvw3/oGZ9gBg0DqNmkpDinVw9vd
G6YH2DGtL2x/rt0GQT7o9kXfodcJ+yRIuJwQ5ALkEHwe8AyWGfWKHogbcYvr+Jx8
U1Hn0fAffcsMlgEG2JCt4s8EoZsbeHAz2ugiItieH5OIC6T/VCwqbZyhTY8FzBI=
=PLZq
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
