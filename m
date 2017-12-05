Received: from eggs.gnu.org ([2001:4830:134:3::10]:47920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDOI-0003AU-7y
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMDOC-00020S-Ho
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMDOC-0001zR-8S
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:36:00 -0500
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
Date: Tue, 5 Dec 2017 14:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171205120623.GB31150@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3CHhvF1VGqv3pRDer6af0HaTu5kDDxJAi"
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3CHhvF1VGqv3pRDer6af0HaTu5kDDxJAi
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Message-ID: <5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
Subject: Re: About the light VM solution!
References: <20171205063313.GB4102@yangzhon-Virtual>
 <20171205120623.GB31150@stefanha-x1.localdomain>
In-Reply-To: <20171205120623.GB31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/12/2017 13:06, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
>> As you know, AWS has decided to switch to KVM in their clouds. This ne=
ws make almost all
>> china CSPs(clouds service provider) pay more attention on KVM/Qemu, es=
pecially light VM
>> solution.
>>
>> Below are intel solution for light VM, qemu-lite.
>> http://events.linuxfoundation.org/sites/events/files/slides/Light%20we=
ight%20virtualization%20with%20QEMU%26KVM_0.pdf
>>
>> My question is whether community has some plan to implement light VM o=
r alternative solutions? If no, whether our=20
>> qemu-lite solution is suitable for upstream again? Many thanks!
>=20
> What caused a lot of discussion and held back progress was the approach=

> that was taken.  The basic philosophy seems to be bypassing or
> special-casing components in order to avoid slow operations.  This
> requires special QEMU, firmware, and/or guest kernel binaries and cause=
s
> extra work for the management stack, distributions, and testers.

I think having a special firmware (be it qboot or a special-purpose
SeaBIOS) is acceptable.

So is having a special QEMU binary with fewer runtime dependencies,
though that should only be a stopgap measure; the real solution is to
modularize e.g. the UI and audio subsystems to remove runtime
dependencies from the QEMU binary itself.

I agree with Stefan however that there should be no special machine
types or kernels.

Referring to your slides, the remaining points for fast boot are:

* parallelize VCPU initialization: do you have patches? :)

* q35-lite: any other machine options that have not been merged yet?

* SeaBIOS+Option ROM: can you take new numbers with DMA-based option
ROM, or with qboot?

* guest kernel: my proposal to make Linux a multiboot kernel has been
nacked upstream, but Oracle is working on supporting Xen PVH binaries in
QEMU.  These are very similar to multiboot and in particular they're
uncompressed.

For memory consumption, 2.11 should have improved things already thanks
to shared FlatViews.  Your malloc_trim patch should also be merged in 2.1=
2.

So are things really that bad?  Almost all "qemu-lite" patches that have
been proposed upstream have been accepted.

Only mmap-ing the kernel into the guest is not going to be accepted, but
maybe you can look into replacing stdio with open+mmap in load_linux and
load_multiboot, for both the kernel and the initrd.  This should save a
few milliseconds too.

Paolo


--3CHhvF1VGqv3pRDer6af0HaTu5kDDxJAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlomoLEACgkQv/vSX3jH
roOXAAgAhuzHnphCfvV/yyZYC1BONrvE8dK8/Gd6rIkeqqH26KYKXCffDiQPDxC2
rRBHDpKq61wcecjQ+cXjPQJ5ebJMhd3hpjlMepOyse8lEMMDyPCMpOBGMwXdpOQy
BWf36DpZ/SgVeqvkLpDw+zt0j1/DXZBe2EDWj1Xx4GEjV4eKdE5poXbM0FxjbWFD
N8bxmbO2JZ3PvRZQRNOJxP3iBivhBMEGZKmfuqLBe6o/rq5dYnXmgg1z8HVrwMUK
8AZo7/G69kUBx/trIE3eVbgCMy4LsER210BeU0g+OAMLz6FC5ECuA4QMOSCxTi0N
UEJC5qECivtJK8uXWDCk1PQi2ZfYeg==
=yUIq
-----END PGP SIGNATURE-----

--3CHhvF1VGqv3pRDer6af0HaTu5kDDxJAi--
