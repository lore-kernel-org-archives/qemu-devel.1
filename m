Received: from eggs.gnu.org ([209.51.188.92]:47499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyKEY-0008KG-2A
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyKEW-0003I5-Q5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:40:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gyKEW-0003GN-Fg
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:40:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CF5930BADA2
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 17:40:03 +0000 (UTC)
Date: Mon, 25 Feb 2019 17:40:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225174001.GI379@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <20190225092846.GA4757@angien.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
> On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >=20
> > > QMP clients can usually detect the presence of features via schema
> > > introspection.  There are rare features that do not involve schema
> > > changes and are therefore impossible to detect with schema
> > > introspection.
> > >
> > > This patch adds the query-qemu-capabilities command.  It returns a li=
st
> > > of capabilities that this QEMU supports.
> >=20
> > The name "capabilities" could be confusing, because we already have QMP
> > capabilities, complete with command qmp_capabilities.  Would "features"
> > work?
> >=20
> > > The decision to make this a command rather than something statically
> > > defined in the schema is intentional.  It allows QEMU to decide which
> > > capabilities are available at runtime, if necessary.
> > >
> > > This new interface is necessary so that QMP clients can discover that
> > > migrating disk image files is safe with cache.direct=3Doff on Linux.
> > > There is no other way to detect whether or not QEMU supports this.
> >=20
> > I think what's unsaid here is that we don't want to make a completely
> > arbitrary schema change just to carry this bit of information.  We
> > could, but we don't want to.  Correct?
>=20
> One example of such 'unrelated' change was a recent query- command which
> is used by libvirt just to detect presence of the feature but the
> queried result is never used and not very useful.
>=20
> > > Cc: Markus Armbruster <armbru@redhat.com>
> > > Cc: Peter Krempa <pkrempa@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  qmp.c          | 18 ++++++++++++++++++
> > >  2 files changed, 60 insertions(+)
>=20
> [...]
>=20
> > > +QemuCapabilities *qmp_query_qemu_capabilities(Error **errp)
> > > +{
> > > +    QemuCapabilities *caps =3D g_new0(QemuCapabilities, 1);
> > > +    QemuCapabilityList **prev =3D &caps->capabilities;
> > > +    QemuCapability cap_val;
> > > +
> > > +    /* Add all QemuCapability enum values defined in the schema */
> > > +    for (cap_val =3D 0; cap_val < QEMU_CAPABILITY__MAX; cap_val++) {
> > > +        QemuCapabilityList *cap =3D g_new0(QemuCapabilityList, 1);
> > > +
> > > +        cap->value =3D cap_val;
> > > +        *prev =3D cap;
> > > +        prev =3D &cap->next;
> > > +    }
> > > +
> > > +    return caps;
> > > +}
> >=20
> > All capabilities known to this build of QEMU are always present.  Okay;
> > no need to complicate things until we need to.  I just didn't expect it
> > to be this simple after the commit message's "It allows QEMU to decide
> > which capabilities are available at runtime, if necessary."
>=20
> I'm slightly worried of misuse of the possibility to change the behavior
> on runtime. In libvirt we cache the capabilities to prevent a "chicken
> and egg" problem where we need to know what qemu is able to do when
> generating the command line which is obviously prior to starting qemu.
> This means that we will want to cache even information determined by
> interpreting results of this API.
>=20
> If any further addition is not as simple as this one it may be
> challenging to be able to interpret the result correctly and be able to
> cache it.
>=20
> Libvirt's use of capabilities is split to pre-startup steps and runtime
> usage. For the pre-startup case [A]  we obviously want to use the cached
> capabilities which are obtained by running same qemu with a different
> configuration that will be used later. After qemu is started we use
> QMP to interact [B] with it also depending to the capabilities
> determined from the cache. Scenario [B] also allows us to re-probe some
> things but they need to be strictly usable only with QMP afterwards.
>=20
> The proposed API with the 'runtime' behaviour allows for these 3
> scenarios for a capability:
> 1) Static capability (as this patch shows)
>     This is easy to cache and also supports both [A] and [B]
>=20
> 2) Capability depending on configuration
>     [A] is out of the window but if QMP only use is necessary we can
>     adapt.

Does "configuration" mean "QEMU command-line"?  The result of the query
command should not depend on command-line arguments.

> 3) Capability depending on host state.
>     Same commandline might not result in same behaviour. Obviously can't
>     be cached at all, but libvirt would not do it anyways. [B] is
>     possible, but it's unpleasant.

Say the kernel or a library dependency is updated, and this enables a
feature that QEMU was capable of but couldn't advertise before.  I guess
this might happen and this is why I noted that the features could be
selected at runtime.

> I propose that the docs for the function filling the result (and perhaps
> also the documentation for the QMP interface) clarify and/or guide devs
> to avoid situations 2) and 3) if possible and motivate them to document
> the limitations on when the capability is detactable.
>=20
> Additionally a new field could be added that e.g. pledges that the given
> capability is of type 1) as described above and thus can be easily
> cached. That way we can make sure programatically that we pre-cache only
> the 'good' capabilities.
>=20
> Other than the above, this is a welcome improvement as I've personally
> ran into scenarios where a feature in qemu was fixed but it was
> impossible to detect whether given qemu version contains the fix as it
> did not have any influence on the QMP schema.

I'd like to make things as simpler as possible, but no simpler :).

The simplest option is that the advertised features are set in stone at
build time (e.g. selected with #ifdef if necessary).  But then we have
no way of selecting features at runtime (e.g. based on kernel features).

What do you think?

Stefan

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdChxAAoJEJykq7OBq3PIHZcH/3FPG96LhLKIJFwM2oEkCZz6
vizvUsig29gw1VDkGrxXcT7CP4tXspNRYYVpTtA6P3YUuDgCQhtBHWE2SOY9SGFO
COpiEMFUiEwSX0S5xDiY+4QmeN/iDPPa9VVrBiJ+Qik+BYLwlgYwXjCJJ2piY3dn
UIBqMuo4/PKAhggzZBCdYBt2WQ0ORhyHrF4YhwhbSr3EvEaCOE5FopXgYt9yFlXc
wVruXcJQi7LXoJ0c+KNQWnCtrMbDQCRz0MqrRkacOVhIMiFufJT4wPN4APB8fofT
umfrz74yLJ+sRj4eFDzRnLm1c9nPb7F7oKT6EqTrA+OcNVQYU4mmpXtwMcHkDho=
=xwae
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
