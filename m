Received: from eggs.gnu.org ([209.51.188.92]:59917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gyXQ1-0000b4-0J
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gyXPy-0004l6-Ns
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:44:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gyXPy-0004kq-Co
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:44:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C521308FED2
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 07:44:45 +0000 (UTC)
Date: Tue, 26 Feb 2019 08:44:38 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190226074438.GD2370@andariel.pipo.sk>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20190225174001.GI379@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 17:40:01 +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 25, 2019 at 10:28:46AM +0100, Peter Krempa wrote:
> > On Mon, Feb 25, 2019 at 09:50:26 +0100, Markus Armbruster wrote:

[...]

> > I'm slightly worried of misuse of the possibility to change the behavior
> > on runtime. In libvirt we cache the capabilities to prevent a "chicken
> > and egg" problem where we need to know what qemu is able to do when
> > generating the command line which is obviously prior to starting qemu.
> > This means that we will want to cache even information determined by
> > interpreting results of this API.
> >=20
> > If any further addition is not as simple as this one it may be
> > challenging to be able to interpret the result correctly and be able to
> > cache it.
> >=20
> > Libvirt's use of capabilities is split to pre-startup steps and runtime
> > usage. For the pre-startup case [A]  we obviously want to use the cached
> > capabilities which are obtained by running same qemu with a different
> > configuration that will be used later. After qemu is started we use
> > QMP to interact [B] with it also depending to the capabilities
> > determined from the cache. Scenario [B] also allows us to re-probe some
> > things but they need to be strictly usable only with QMP afterwards.
> >=20
> > The proposed API with the 'runtime' behaviour allows for these 3
> > scenarios for a capability:
> > 1) Static capability (as this patch shows)
> >     This is easy to cache and also supports both [A] and [B]
> >=20
> > 2) Capability depending on configuration
> >     [A] is out of the window but if QMP only use is necessary we can
> >     adapt.
>=20
> Does "configuration" mean "QEMU command-line"?  The result of the query
> command should not depend on command-line arguments.

Yes exactly. There probably is possibility that something would be
detectable only after a shared library load which in turn would depend
on the command line ...

>=20
> > 3) Capability depending on host state.
> >     Same commandline might not result in same behaviour. Obviously can't
> >     be cached at all, but libvirt would not do it anyways. [B] is
> >     possible, but it's unpleasant.
>=20
> Say the kernel or a library dependency is updated, and this enables a
> feature that QEMU was capable of but couldn't advertise before.  I guess
> this might happen and this is why I noted that the features could be
> selected at runtime.

Yeah, such scenario is really breaking our caching even now. I don't
want to say it's bad. It may even be necessary in some scenarios. Both
this and the above scenario may be necessary eventually. Libvirt
certainly can make use of the detection for QMP use if there is such a
thing.

> > I propose that the docs for the function filling the result (and perhaps
> > also the documentation for the QMP interface) clarify and/or guide devs
> > to avoid situations 2) and 3) if possible and motivate them to document
> > the limitations on when the capability is detactable.
> >=20
> > Additionally a new field could be added that e.g. pledges that the given
> > capability is of type 1) as described above and thus can be easily
> > cached. That way we can make sure programatically that we pre-cache only
> > the 'good' capabilities.
> >=20
> > Other than the above, this is a welcome improvement as I've personally
> > ran into scenarios where a feature in qemu was fixed but it was
> > impossible to detect whether given qemu version contains the fix as it
> > did not have any influence on the QMP schema.
>=20
> I'd like to make things as simpler as possible, but no simpler :).
>=20
> The simplest option is that the advertised features are set in stone at
> build time (e.g. selected with #ifdef if necessary).  But then we have
> no way of selecting features at runtime (e.g. based on kernel features).
>=20
> What do you think?

I really don't want to limit the possibilities for the API. My goal is
only that it's obvious both from the docs and preferably also from the
returned data (so that we can filter what to cache to prevent mistakes)
that a given capability bit is static or dynamic.

I think adding the field to the returned data which will be set
according to how the capability was detected should be simple enough,
but I will be okay with just documenting any caveats along with the
inidividual capabilities. In that case an comment should encourage those
coming after you to document it properly.

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlx07mMACgkQHGwCByjY
1GpJYxAAl0Y+RSCKlX1LpH0zXpo6u5JFcnI3XcPwpidRItCGVpQnACrwIp0VqLeM
iDGH8i4zD06eSpXCvTARoVVnCiY/BgilsWuJ5Mw8qttl8vpOQLrMsBhIG5prebTX
Jzn6KT5Wmo+GCjr2/2Q0Llfn2q3lhNBGWqZXO7hyHN2T1TUByjjokKqABLRW0sHS
FyyvKLuqUT7xwjMy3sgVUI8qfCIf1LFhzBaxZPQIgL1M0oKbfXsGMxw8NqiO7pem
zvJnVXF8zYkDEtsHLiN80wyO6/OL+TFpylrthKLvBVWAj0N5lVcI3seE77QmlsYL
iI6uwvCJhCprZ7CgciJvGUm4pxoHRPXn0XOzMkttNm7lWd6zjnW3WXVSTKCXRzcf
3HXaH4benKWkxw+YlMujVaDW1O7iYfEv1uBMFSO5pHJGsLSg3ksxyYCPJQZfjkxR
A56Lbr3RYKD+F07gtyQD4gfZhv2Z6xZSs+dksve9mZfJlGj8+whP7vp7ioMuFaOG
eJn+Os41sgjkWey1kGRD5kjJZhBC+GuWaLvmdwgwQXJdLAcPDjsTSPzTA37PXP8u
q7V31Deq73liMpdsbjotMxiUw8Wgex4NRshRaEfPJqpE/QuvgA+w7IauakDc/b/S
JarUiUCgcpj+N40M14IKM0tqmAWwoU8ndtRWTDXKJqznivZETlk=
=9//L
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
