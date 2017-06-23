Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOLJI-0000Ud-P8
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 05:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dOLJF-0002Qj-KJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 05:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dOLJF-0002QS-Df
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 05:55:25 -0400
Date: Fri, 23 Jun 2017 10:55:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170623095522.GB12689@stefanha-x1.localdomain>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20170623001313.n6cms5sunwuqnf4h@hz-desktop>
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 08:13:13AM +0800, haozhong.zhang@intel.com wrote:
> On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> > I tried live migrating a guest with NVDIMM on qemu.git/master (edf8bc98=
4):
> >=20
> >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G -cpu ho=
st \
> >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3Dnv=
dimm.dat,size=3D1G \
> > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw
> >=20
> >   $ qemu -M accel=3Dkvm,nvdimm=3Don -m 1G,slots=3D4,maxmem=3D8G -cpu ho=
st \
> >          -object memory-backend-file,id=3Dmem1,share=3Don,mem-path=3Dnv=
dimm.dat,size=3D1G \
> > 	 -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1 \
> > 	 -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
> > 	 -incoming tcp::1234
> >=20
> >   (qemu) migrate tcp:127.0.0.1:1234
> >=20
> > The guest kernel panics or hangs every time on the destination.  It
> > happens as long as the nvdimm device is present - I didn't even mount it
> > inside the guest.
> >=20
> > Is migration expected to work?
>=20
> Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
> have a look at this issue.

Great, thanks!

David Gilbert suggested the following on IRC, it sounds like a good
starting point for debugging:

Launch the destination QEMU with -S (vcpus will be paused) and after
migration has completed, compare the NVDIMM contents on source and
destination.

Stefan

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZTOWKAAoJEJykq7OBq3PISesH/0UM8kf1uVsV9Z7sHHpPvfV5
LMPPVtHM/ClWbyzDSeivLnPPwEb8cJEvJDm80zPTYOYxmTtvVe5/6gPusrHi0EnD
+/3VDDG5msbkEPWO4PRHkhrLjZTfgNp8vmr7Om/1DVAdSsrIFrXnwij9g6Q6SoDj
nnbtsH79FU3TjtzDaMFqX2E65/SeZSd/Vaq8N6ZuQVmLOsSy27BAzKps3Mr6rWxt
dfYGTGsBRI+xhvNIzDGnEP6P5diBY+l87RO4ujq1ehLAvHSawthxtQe9U7AN6CGl
fn9bgC08uyLD3ZpIyinVhn5BAcixuRBd1o2+vc5WcinHTM3dXS98+f0MAqf5ZVA=
=coPB
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
