Received: from eggs.gnu.org ([209.51.188.92]:50064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gyCgP-0000f2-Ep
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gyCgO-0003eM-AF
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gyCgN-0003b1-Pm
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 04:36:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29846308ED6D
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 09:28:55 +0000 (UTC)
Date: Mon, 25 Feb 2019 10:28:46 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190225092846.GA4757@angien.pipo.sk>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <87imx8uu99.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > QMP clients can usually detect the presence of features via schema
> > introspection.  There are rare features that do not involve schema
> > changes and are therefore impossible to detect with schema
> > introspection.
> >
> > This patch adds the query-qemu-capabilities command.  It returns a list
> > of capabilities that this QEMU supports.
>=20
> The name "capabilities" could be confusing, because we already have QMP
> capabilities, complete with command qmp_capabilities.  Would "features"
> work?
>=20
> > The decision to make this a command rather than something statically
> > defined in the schema is intentional.  It allows QEMU to decide which
> > capabilities are available at runtime, if necessary.
> >
> > This new interface is necessary so that QMP clients can discover that
> > migrating disk image files is safe with cache.direct=3Doff on Linux.
> > There is no other way to detect whether or not QEMU supports this.
>=20
> I think what's unsaid here is that we don't want to make a completely
> arbitrary schema change just to carry this bit of information.  We
> could, but we don't want to.  Correct?

One example of such 'unrelated' change was a recent query- command which
is used by libvirt just to detect presence of the feature but the
queried result is never used and not very useful.

> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Peter Krempa <pkrempa@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  qmp.c          | 18 ++++++++++++++++++
> >  2 files changed, 60 insertions(+)

[...]

> > +QemuCapabilities *qmp_query_qemu_capabilities(Error **errp)
> > +{
> > +    QemuCapabilities *caps =3D g_new0(QemuCapabilities, 1);
> > +    QemuCapabilityList **prev =3D &caps->capabilities;
> > +    QemuCapability cap_val;
> > +
> > +    /* Add all QemuCapability enum values defined in the schema */
> > +    for (cap_val =3D 0; cap_val < QEMU_CAPABILITY__MAX; cap_val++) {
> > +        QemuCapabilityList *cap =3D g_new0(QemuCapabilityList, 1);
> > +
> > +        cap->value =3D cap_val;
> > +        *prev =3D cap;
> > +        prev =3D &cap->next;
> > +    }
> > +
> > +    return caps;
> > +}
>=20
> All capabilities known to this build of QEMU are always present.  Okay;
> no need to complicate things until we need to.  I just didn't expect it
> to be this simple after the commit message's "It allows QEMU to decide
> which capabilities are available at runtime, if necessary."

I'm slightly worried of misuse of the possibility to change the behavior
on runtime. In libvirt we cache the capabilities to prevent a "chicken
and egg" problem where we need to know what qemu is able to do when
generating the command line which is obviously prior to starting qemu.
This means that we will want to cache even information determined by
interpreting results of this API.

If any further addition is not as simple as this one it may be
challenging to be able to interpret the result correctly and be able to
cache it.

Libvirt's use of capabilities is split to pre-startup steps and runtime
usage. For the pre-startup case [A]  we obviously want to use the cached
capabilities which are obtained by running same qemu with a different
configuration that will be used later. After qemu is started we use
QMP to interact [B] with it also depending to the capabilities
determined from the cache. Scenario [B] also allows us to re-probe some
things but they need to be strictly usable only with QMP afterwards.

The proposed API with the 'runtime' behaviour allows for these 3
scenarios for a capability:
1) Static capability (as this patch shows)
    This is easy to cache and also supports both [A] and [B]

2) Capability depending on configuration
    [A] is out of the window but if QMP only use is necessary we can
    adapt.

3) Capability depending on host state.
    Same commandline might not result in same behaviour. Obviously can't
    be cached at all, but libvirt would not do it anyways. [B] is
    possible, but it's unpleasant.

I propose that the docs for the function filling the result (and perhaps
also the documentation for the QMP interface) clarify and/or guide devs
to avoid situations 2) and 3) if possible and motivate them to document
the limitations on when the capability is detactable.

Additionally a new field could be added that e.g. pledges that the given
capability is of type 1) as described above and thus can be easily
cached. That way we can make sure programatically that we pre-cache only
the 'good' capabilities.

Other than the above, this is a welcome improvement as I've personally
ran into scenarios where a feature in qemu was fixed but it was
impossible to detect whether given qemu version contains the fix as it
did not have any influence on the QMP schema.



--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxztUwACgkQHGwCByjY
1GrDnA/+OpnPZS+TN+9mBtqsZMass9OT7LzSHZzVPlNS4T0DM5jPFf2regLyWDAB
dgKJ177/ajxG5d9mtd8X7UZSSuTMGebL1pGoyzqiH4XFfOOMxn8Xhk2Y8YvxsD4K
2cScc90WlbL4lb6e3iTeZZ/xNrDXZ9T27NhQTv8ISmgm6ojqWXjWbHvP1coiMSGk
ry3HzkdKphc7eNt5wxTCXUMrPhL36fxMu7KlKd2W41aYnb86D2Gev4Mi3m5m7f5m
M6um0p6qq39WkC7oB0zTNx+bc5ZtKxWVsCYRa1sWOk4opj3JAQGWGaeFyc+j1FB0
r/6b2b73cZka9j1D3ZwI5f7+oyJ4eR6TppYCKHCQgbPNEY3jw5yn5q0CDaRAMZiP
tPzi6+hDmW4lQMP+XAfDzkwQywi4HgBOW8R5WqZyXiJQSIBpWz2mXaDre78nnUK4
keu3EsNtNX1HwS0O75YDQlZ6AfgI98o9NkGmkZa5Au9nyJju2zaVpZS/2e9x4/i+
/PNpvg1YJ6tH8HAU0d9iRKRwBkGN9qhfLA9r+ua8Hqd1k6wcsmKS4wB9nEfkX6Al
srSoGYHqpe9sc1tJbQRRSsdYbaYX+1CrQtjUy1vR+1TVvO0N1j39ppwPRScp12Mb
WfWrKvf32Q5ssHI+gfSMWmHOu5S9dQXbljAJuiWZbicp4VUbds8=
=wVNi
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
