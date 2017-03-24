Received: from eggs.gnu.org ([2001:4830:134:3::10]:54458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRGH-0002zi-L4
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crRGD-00055F-Mr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:36:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1crRGD-00054N-Fv
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:36:17 -0400
Received: by mail-wr0-x241.google.com with SMTP id u108so946580wrb.2
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:36:17 -0700 (PDT)
Date: Fri, 24 Mar 2017 15:36:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170324153613.GA5849@stefanha-x1.localdomain>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
	<20170323112922.GB12560@stefanha-x1.localdomain>
	<b3cc6807-9cac-968a-0759-60a203102751@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <b3cc6807-9cac-968a-0759-60a203102751@amd.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 02/20] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 01:14:17PM -0500, Brijesh Singh wrote:
> Hi Stefan,
>=20
>=20
> On 03/23/2017 06:29 AM, Stefan Hajnoczi wrote:
> > On Wed, Mar 08, 2017 at 03:51:28PM -0500, Brijesh Singh wrote:
> > > Add a new debug attribute, the attribute should be set when guest mem=
ory
> > > accesses are performed for debug purposes.
> > > The attribute will be used in SEV guest, where we need to distinguish=
 normal
> > > vs debug access to guest memory. In debug mode, we need to use SEV co=
mmands
> > > to access the guest memory.
> > >=20
> > > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > > ---
> > >  include/exec/memattrs.h |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> > > index e601061..b802073 100644
> > > --- a/include/exec/memattrs.h
> > > +++ b/include/exec/memattrs.h
> > > @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
> > >      unsigned int user:1;
> > >      /* Requester ID (for MSI for example) */
> > >      unsigned int requester_id:16;
> > > +    /* Memory access for debug purposes */
> >=20
> > What does "debug purposes" mean?  gdbstub?  Can the guest initiate debug
> > memory accesses or is the purely QEMU-internal?
> >=20
>=20
> What I mean by that is, any access to the guest memory within Qemu intern=
al functions
> (e.g gdbstub, qemu monitor's memory dump, info mem, info tlb etc). I have=
 also introduced
> debug version of ldl_phys, ldq_phys, cpu_physical_memory_* [1] and have u=
pdated hmp monitor
> code to use the debug version api's when accessing the guest memory [2].
>=20
> [1] http://marc.info/?l=3Dqemu-devel&m=3D148900832814697&w=3D2
> [2] http://marc.info/?l=3Dqemu-devel&m=3D148900831414693&w=3D2
>=20
>=20
> Note: SEV debug API's are meant to be used by hypervisor to decrypt/encry=
pt guest memory.
> But when you are inside the guest, the  guest will have access to decrypt=
ed data and does
> not need to call down to hypervisor for debug access.

People reading the code in memattrs.h aren't thinking about AMD SEV, so
"debug purposes" isn't meaningful in this context.

I suggest something like this instead:

  /* Debug memory access for AMD SEV */

That way it's clear this "debug" flag has a very specific meaning in the
context of memory encryption.

Stefan

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1TztAAoJEJykq7OBq3PIfzAH/3z6dBWD/05UmIQWcGcEx5ke
/FROp7dEOxlWdl1HWGumn3JrZzL9nm0D+moo58ZnTcwpPr1EK3VEpn6ChqPX1TtR
5nUJYBSYyLlj5z9LwkW7FbOn0bGRVZ1p2oJda4rLgGlp9GQKoAQfAUvhODdW+E6z
fYg+AhjAPohSqrLTddpsyZU4RCOoYN69Gg0MtMVXKL/PrlUbL/HyJHla0fTSLj0v
6LPrCmnlOwSZG2ag/TDWB0HQM59+XeLAZ9RcTvY1pCpBm8lZrux5njx4+XDMjSll
DYivd6XQM+Uf0l/yOrZwxdsE/dl56udmxUP46aurikh3GgXA6fgF5aocOKPww2Q=
=w0cn
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
