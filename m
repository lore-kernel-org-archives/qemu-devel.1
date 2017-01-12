Received: from eggs.gnu.org ([2001:4830:134:3::10]:57180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfKt-0002Cj-LX
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfKs-0005xM-RU
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRfKs-0005wb-Jn
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:34 -0500
Date: Thu, 12 Jan 2017 11:09:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170112110928.GF4621@stefanha-x1.localdomain>
References: <20170111093630.2088-1-stefanha@redhat.com>
	<1b6e2788-f162-a709-f086-850adf7a70d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <1b6e2788-f162-a709-f086-850adf7a70d3@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix g_array_free() with NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:18:25AM +0800, Xiao Guangrong wrote:
>=20
>=20
> On 01/11/2017 05:36 PM, Stefan Hajnoczi wrote:
> > Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
> > The following error is logged when an nvdimm device is realized:
> >=20
> >   GLib-CRITICAL **: g_array_free: assertion 'array' failed
> >=20
> > Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/acpi/nvdimm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)

NACK

> >=20
> > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> > index 8e7d6ec..8f0a484 100644
> > --- a/hw/acpi/nvdimm.c
> > +++ b/hw/acpi/nvdimm.c
> > @@ -375,7 +375,9 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer =
*fit_buf)
> >=20
> >  static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
> >  {
> > -    g_array_free(fit_buf->fit, true);
> > +    if (fit_buf->fit) {
> > +        g_array_free(fit_buf->fit, true);
> > +    }
>=20
> Er, i do not know why it is NULL as we have init-ed it in nvdimm_init_fit=
_buffer:
>=20
> static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
> {
>     fit_buf->fit =3D g_array_new(false, true /* clear */, 1);
> }
>=20
> And i can not reproduce it on my box, could you share your command line a=
nd the
> based commit id?

Good point, it happens when nvdimm_plug() is called but -M pc,nvdimm is
missing from the command-line.  This means nvdimm_init_acpi_state() was
not called by pc_init1():

  $ x86_64-softmmu/qemu-system-x86_64 \
      -enable-kvm \
      -m 1G,slots=3D2,maxmem=3D16G \
      -drive if=3Dvirtio,file=3Dtest.img,format=3Draw \
      -object memory-backend-file,id=3Dhostmem0,mem-path=3Dmydimm,share=3Do=
n,size=3D8G \
      -device nvdimm,id=3Dnvdimm0,memdev=3Dhostmem0

Do you want to audit the code to check if anything else misbehaves when
-device nvdimm is used without -M pc,nvdimm?

Stefan

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd2PnAAoJEJykq7OBq3PIfqEH/jAYq6wBXOlysv18Dj2UI0Xx
EuMh/ujX/F1AE7dEZIc7L/bgQQmoOXEC7Fvx/7HvfU3LKVnHNZKbbNbv5EPGWV8v
UaeEBsswT0AhsG4qmpxvJ+xnqo/iSWxSDhyORoxWg0oQXVtpa5QCtvRDZWIGv+ll
NBaA7CApHuhD1SgEpk2cpg5GxtmdgIPk1NP0EkIOPfuylG28Q7tPOCNfmOFfzLDx
LL+niktQ+KIBJ8TYEVEDpETN/+iiHAX0cieKfjEoeeeLIIrr3A3pmFs7XlmqUN5N
QPyH7/S/kCFLebHxjlxwwlLuwiLguqWqYG7QD+10FQVmRXKC9K2jgT0S1zlGOl0=
=2apo
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
