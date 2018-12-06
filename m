Received: from eggs.gnu.org ([2001:4830:134:3::10]:34595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gUr31-0001kn-Cs
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gUr2v-0003LI-7d
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:38:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gUr2u-0002tX-Ub
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:38:17 -0500
Date: Thu, 6 Dec 2018 10:38:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181206103803.GA30262@stefanha-x1.localdomain>
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
	<20181205132041.GB24623@stefanha-x1.localdomain>
	<669ef62d-06e2-3e6d-9f27-9ae8934b5330@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <669ef62d-06e2-3e6d-9f27-9ae8934b5330@oracle.com>
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maran Wilson <maran.wilson@oracle.com>
Cc: qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, Stefano Garzarella <sgarzare@redhat.com>, Liam Merwick <liam.merwick@oracle.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:04:36AM -0800, Maran Wilson wrote:
> On 12/5/2018 5:20 AM, Stefan Hajnoczi wrote:
> > On Tue, Dec 04, 2018 at 02:44:33PM -0800, Maran Wilson wrote:
> > > On 12/3/2018 8:35 AM, Stefano Garzarella wrote:
> > > > On Mon, Dec 3, 2018 at 4:44 PM Rob Bradford <robert.bradford@intel.=
com> wrote:
> > > > > Hi Stefano, thanks for capturing all these numbers,
> > > > >=20
> > > > > On Mon, 2018-12-03 at 15:27 +0100, Stefano Garzarella wrote:
> > > > > > Hi Rob,
> > > > > > I continued to investigate the boot time, and as you suggested I
> > > > > > looked also at qemu-lite 2.11.2
> > > > > > (https://github.com/kata-containers/qemu) and NEMU "virt" machi=
ne. I
> > > > > > did the following tests using the Kata kernel configuration
> > > > > > (
> > > > > > https://github.com/kata-containers/packaging/blob/master/kernel=
/configs/x86_64_kata_kvm_4.14.x
> > > > > > )
> > > > > >=20
> > > > > > To compare the results with qemu-lite direct kernel load, I add=
ed
> > > > > > another tracepoint:
> > > > > > - linux_start_kernel: first entry of the Linux kernel
> > > > > > (start_kernel())
> > > > > >=20
> > > > > Great, do you have a set of patches available that all these trace
> > > > > points. It would be great for reproduction.
> > > > For sure! I'm attaching a set of patches for qboot, seabios, ovmf,
> > > > nemu/qemu/qemu-lite and linux 4.14 whit the tracepoints.
> > > > I'm also sharing a python script that I'm using with perf to extract
> > > > the numbers in this way:
> > > >=20
> > > > $ perf record -a -e kvm:kvm_entry -e kvm:kvm_pio -e
> > > > sched:sched_process_exec -o /tmp/qemu_perf.data &
> > > > $ # start qemu/nemu multiple times
> > > > $ killall perf
> > > > $ perf script -s qemu-perf-script.py -i /tmp/qemu_perf.data
> > > >=20
> > > > > > As you can see, NEMU is faster to jump to the kernel
> > > > > > (linux_start_kernel) than qemu-lite when uses qboot or seabios =
with
> > > > > > virt support, but the time to the user space is strangely high,=
 maybe
> > > > > > the kernel configuration that I used is not the best one.
> > > > > > Do you suggest another kernel configuration?
> > > > > >=20
> > > > > This looks very bad. This isn't the kernel configuration we norma=
lly
> > > > > test with in our automated test system but is definitely one we s=
upport
> > > > > as part of our partnernship with the Kata team. It's a high prior=
ity
> > > > > for me to try and investigate that. Have you saved the kernel mes=
sages
> > > > > as they might be helpful?
> > > > Yes, I'm attaching the dmesg output with nemu and qemu.
> > > >=20
> > > > > > Anyway, I obtained the best boot time with qemu-lite and direct
> > > > > > kernel
> > > > > > load (vmlinux ELF image). I think because the kernel was not
> > > > > > compressed. Indeed, looking to the others test, the kernel
> > > > > > decompression (bzImage) takes about 80 ms (linux_start_kernel -
> > > > > > linux_start_boot). (I'll investigate better)
> > > > > >=20
> > > > > Yup being able to load an uncompressed kernel is one of the big
> > > > > advantages of qemu-lite. I wonder if we could bring that feature =
into
> > > > > qemu itself to supplement the existing firmware based kernel load=
ing.
> > > > I think so, I'll try to understand if we can merge the qemu-lite
> > > > direct kernel loading in qemu.
> > > An attempt was made a long time ago to push the qemu-lite stuff (from=
 the
> > > Intel Clear Containers project) upstream. As I understand it, the main
> > > stumbling block that seemed to derail the effort was that it involved=
 adding
> > > Linux OS specific code to Qemu so that Qemu could do things like crea=
te and
> > > populate the zero page that Linux expects when entering startup_64().
> > >=20
> > > That ends up being a lot of very low-level, operating specific knowle=
dge
> > > about Linux that ends up getting baked into Qemu code. And understand=
ably, a
> > > number of folks saw problems with going down a path like that.
> > >=20
> > > Since then, we have put together an alternative solution that would a=
llow
> > > Qemu to boot an uncompressed Linux binary via the x86/HVM direct boot=
 ABI
> > > (https://xenbits.xen.org/docs/unstable/misc/pvh.html). The solution i=
nvolves
> > > first making changes to both the ABI as well as Linux, and then updat=
ing
> > > Qemu to take advantage of the updated ABI which is already supported =
by both
> > > Linux and Free BSD for booting VMs. As such, Qemu can remain OS agnos=
tic,
> > > and just be programmed to the published ABI.
> > >=20
> > > The canonical definition for the HVM direct boot ABI is in the Xen tr=
ee and
> > > we needed to make some minor changes to the ABI definition to allow K=
VM
> > > guests to also use the same structure and entry point. Those changes =
were
> > > accepted to the Xen tree already:
> > > https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg00057=
=2Ehtml
> > >=20
> > > The corresponding Linux changes that would allow KVM guests to be boo=
ted via
> > > this PVH entry point have already been posted and reviewed:
> > > https://lkml.org/lkml/2018/4/16/1002
> > >=20
> > > The final part is the set of Qemu changes to take advantage of the ab=
ove and
> > > boot a KVM guest via an uncompressed kernel binary using the entry po=
int
> > > defined by the ABI. Liam Merwick will be posting some RFC patches ver=
y soon
> > > to allow this.
> > Cool, thanks for doing this work!
> >=20
> > How do the boot times compare to qemu-lite and Firecracker's
> > (https://github.com/firecracker-microvm/firecracker/) direct vmlinux ELF
> > boot?
>=20
> Boot times compare very favorably to qemu-lite, since the end result is
> basically doing a very similar thing. For now, we are going with a QEMU +
> qboot solution to introduce the PVH entry support in Qemu (meaning we will
> be posting Qemu and qboot patches and you will need both to boot an
> uncompressed kernel binary). As such we have numbers that Liam will inclu=
de
> in the cover letter showing significant boot time improvement over existi=
ng
> QEMU + qboot approaches involving a compressed kernel binary. And as we a=
ll
> know, the existing qboot approach already gets boot times down pretty low.

The first email in this thread contains benchmark results showing that
optimized SeaBIOS is comparable to qboot, so it does not offer anything
unique with respect to boot time.

We're trying to focus on SeaBIOS because it's actively maintained and
already shipped by distros.  Relying on qboot will make it harder to get
PVH into the hands of users because distros have to package and ship
qboot first.  This might also require users to change their QEMU
command-line syntax to benefit from fast kernel booting.

I would strongly recommend looking at the SeaBIOS -kernel approach and
avoiding QEMU command-line changes.  That way -kernel becomes fast for
users as soon as they upgrade their QEMU without requiring configuration
changes.

If you have questions about how the -kernel boot works with SeaBIOS,
Stefano can help explain it and share details of his
development/benchmarking environment (see also earlier mails in this
email thread).

> Once the patches have been posted (soon) it would be great if some other
> folks could pick them up and run your own numbers on various test setups =
and
> comparisons you already have.
>=20
> I haven't tried Firecracker, specifically. It would be good to see a
> comparison just so we know where we stand, but it's not terribly relevant=
 to
> folks who want to continue using Qemu right? Meaning Qemu (and all soluti=
ons
> built on it like kata) still needs a solution for improving boot time
> regardless of what NEMU and Firecracker are doing.

Right.  Collaboration with Firecracker is more in the interest of
avoiding duplication and making it easy for users to fast boot a single
kernel (thanks to a common ABI like PVH) on any hypervisor.

Stefan

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcCPwLAAoJEJykq7OBq3PIe9QIAJwGf/+5VdddSTrlFgHrN1we
eM71/Wj7GVYOpIo+l8Ci/7hRF5S0tzzAfNYy1SIycg0i05ByBKKhnHMGbLognYvb
IJisqUjopzNRDzz4dfQTS9cQ6esLj8yxZrCgcv6X+l/V71rgoZd8dHS7vyO91KXo
NYKwNphi80XUnFzv/qTpyPzKWyerV/Vf0oWke/1Fvb7FuKJ8rlVULA22dYnIDwVB
4i1f1nDCvNv0eZNJFSqtbJk/9NoCIODdDx8uuj/ag0Tjk9XDDn/QDESAXDo/M8qu
/F7EXlcOTCP4outcju9qlJF+yCT2XMfO0Bo7IkLJNE+NBU9cuKnyvoRq1cNtliI=
=fvdw
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
