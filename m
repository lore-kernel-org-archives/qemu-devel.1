Received: from eggs.gnu.org ([209.51.188.92]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hAvw7-00077J-ER
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hAvw5-0007VD-MN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:21:11 -0400
Date: Mon, 1 Apr 2019 14:20:54 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190401122054.GA2686@andariel.pipo.sk>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190328182810.21497-2-kwolf@redhat.com>
	<2fc10494-0f79-8d18-610d-be21cfc6c30b@redhat.com>
	<87ftr5iy8i.fsf@dusky.pond.sub.org>
	<c233c2b4-5257-2df7-3c1a-06bcf269d657@redhat.com>
	<20190329170439.GK5081@localhost.localdomain>
	<87o95sa40r.fsf@dusky.pond.sub.org>
	<87y34v42z0.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <87y34v42z0.fsf_-_@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Options for 4.0 (was: [PATCH 1/2] qmp: Add
 query-qemu-features)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2019 at 14:56:19 +0200, Markus Armbruster wrote:
> Let's review our options for 4.0.
>=20
> Please note my analysis is handicapped by incomplete information, in
> particular on libvirt's needs.

Libvirt's needs are "simple" we need to do block-commit. It has a few
caveats though. The selinux labels for backing images don't allow write
operation when starting qemu. When doing block-commit libvirt relabels
the backing chain prior to using block-commit.

That works with -drive as qemu reopens the files internally, but does
not work when using -blockdev.

Since we need to keep the images RO until doing  the blockjob there
needs to be a way when either qemu automagically does what libvirt needs
even if the image did not have the write permission originally.

auto-read-only was a naive impl when qemu attempted to keep the storage
access nodes RW. At the point when I was testing it I didn't enable
s-virt as it's a hassle when you want to run git versions of libvirt and
qemu and thus didn't see the problem with missing permissions.

The dynamic version attempts to fix that. That is still the automagic
approach. I don't really mind also doing a hands-on approach where we'd
need to tell qemu to reopen given nodes.

I'm not sure what ends up being less work.

> Terminology:
>=20
> * "Hard read-write" semantics: open read/write.
>=20
> * "Hard read-only" semantics: open read-only.
>=20
> * "Dynamic read-only" semantics: open read-only, reopen read/write when
>   a writer attaches, reopen read-only when the last writer detaches.
>=20
> * "Fallback read-only" semantics:. try to open read/write, fall back to
>   read-only.
>=20
> We have a use case for dynamic read-only: libvirt.  I'm not aware of a
> use case for fallback read-only.
>=20
> Behavior before 3.1:
>=20
> * read-only=3Don: hard read-only
>=20
> * read-only=3Doff: hard read-write
>=20
> Behavior in 3.1: new parameter auto-read-only, default off.
>=20
> * read-only=3Don: hard read-only (no change)
>=20
> * read-only=3Don,auto-read-only=3Don: hard read-only (auto-read-only=3Don
>   silently ignored)
>=20
> * read-only=3Doff: hard read-write
>=20
> * read-only=3Doff,auto-read-only=3Don: depends on the driver
>=20
>   - file-posix.c's drivers: fallback read-only
>   - some other drivers: fallback read-only
>   - remaining drivers: hard read/write
>=20
> Behavior in 4.0 so far:
>=20
> * read-only=3Don: hard read-only (no change)
>=20
> * read-only=3Don,auto-read-only=3Don: hard read-only (no change)
>=20
> * read-only=3Doff: hard read-write (no change)
>=20
> * read-only=3Doff,auto-read-only=3Don: depends on the driver
>=20
>   - file-posix.c's drivers: dynamic read-only
>   - some other drivers: fallback read-only (no change)
>   - remaining drivers: hard read/write (no change)
>=20
>=20
> Option 1: Rename @auto-read-only.
>=20
> Rationale: we released auto-read-only in v3.1 with unproven fallback
> read-only semantics.  It turned out not to be useful.  Admit the
> mistake, retract it.  Release our next attempt in 4.0 under a suitable
> new name with fallback read-only semantics.

I concur. Nobody probably uses this. Setting up selinux and blockdev is
not a trivial excercise.

> CON:
>=20
> * Compatibility break.  No-go if there are users.  Users seem quite
>   unlikely, though.
>=20
> * Still unproven, albeit less so: this time we have some unreleased
>   (unfinished?) libvirt code.

unfinished and thus also unreleased.

>=20
> * Semantics are still largely left to drivers, and the schema can't tell
>   which one does what.  Awkward.
>=20
> * Unless we're fairly confident we won't upgrade drivers from "hard" to
>   "fallback" to "dynamic", this merely kicks the can down the road:
>   we'll face the exact same "how can libvirt find out" problem on every
>   upgrade.
>=20
> PRO:
>=20
> * When libvirt sees the new name, it can rely on file-posix.c's drivers
>   providing dynamic read-only semantics.
>=20
>=20
> Option 2: Add query-qemu-features command, return
> file-dynamic-auto-read-only #ifdef CONFIG_POSIX.
>=20
> Rationale: we released auto-read-only in v3.1 with unproven fallback
> read-only semantics.  It turned out not to be useful.  Admit the
> mistake, and patch it up in 4.0.  Libirt needs to know whether it's
> patche up, and this is a simple way to tell it.
>=20
> CON:
>=20
> * All of option 1's, except for the compatibility break
>=20
> * Uses query-qemu-features to expose a property of the build.  I
>   consider that a mistake.
>=20
> PRO
>=20
> * Libvirt can use either query-qmp-schema or query-qemu-features to find
>   out whether it can can rely on file-posix.c's drivers providing
>   dynamic read-only semantics.  To make query-qemu-features usable, we
>   need to promise query-qemu-features never returns false for it.  To
>   make query-qemu-features usable, we need to promise the value will
>   remain valid for the remainder of the QEMU run (defeats caching) or
>   for any future run of the same QEMU binary (enables caching).
>=20
>=20
> Option 3: Add @dynamic-read-only to the drivers that provide dynamic
> read-only, default to value of auto-read-only, promise we'll never add
> it to drivers that don't.
>=20
> Rationale: give users explicit control over dynamic vs. fallback for all
> drivers that can provide dynamic.  This makes some sense as an
> interface, as long as you ignore the fact that no driver implements both
> dynamic and fallback.  I can't see why a driver couldn't implement both.
> It also makes dynamic support visible in the schema.
>=20
> Behavior (three bools -> eight cases):
>=20
> * read-only=3Don: hard read-only (no change)
>=20
>   Shorthand for read-only=3Don,auto-read-only=3Doff,dynamic-read-only=3Do=
ff
>=20
> * read-only=3Don,auto-read-only=3Don: hard read-only (no change)
>=20
>   Shorthand for read-only=3Don,auto-read-only=3Don,dynamic-read-only=3Don
>=20
> * read-only=3Doff: hard read-write (no change)
>=20
>   Shorthand for read-only=3Doff,auto-read-only=3Doff,dynamic-read-only=3D=
off
>=20
> * read-only=3Doff,auto-read-only=3Don:
>=20
>   Shorthand for read-only=3Doff,auto-read-only=3Don,dynamic-read-only=3Don
>=20
>   - file-posix.c's drivers: dynamic read-only (no change,
>     dynamic-read-only=3Don is the default)
>   - some other drivers: fallback read-only (no change)
>   - remaining drivers: hard read/write (no change)
>=20
> * read-only=3Doff,auto-read-only=3Don,dynamic-read-only=3Doff
>=20
>   - file-posix.c's drivers: error
>   - all other drivers: N/A
>=20
> * read-only=3Doff,auto-read-only=3Doff,dynamic-read-only=3Don
>=20
>   - file-posix.c's drivers: error
>   - all other drivers: N/A
>=20
> * read-only=3Don,dynamic-read-only=3Don
>=20
>   Shorthand for read-only=3Don,auto-read-only=3Doff,dynamic-read-only=3Don
>=20
>   - file-posix.c's drivers: error
>   - all other drivers: N/A
>=20
> * read-only=3Don,auto-read-only=3Don,dynamic-read-only=3Doff
>=20
>   Shorthand for read-only=3Don,auto-read-only=3Don,dynamic-read-only=3Doff
>=20
>   - file-posix.c's drivers: error
>   - all other drivers: N/A
>=20
> CON:
>=20
> * Two bools (read-only and auto-read-only) to select from three choices
>   was already ugly.  Three bools (the same plus dynamic-read-only) to
>   select from four choices is even uglier.
>=20
> * The explicit control is just a facade so far: since only the default
>   setting is implemented, it doesn't actually control anything.
>=20
> PRO:
>=20
> * When libvirt sees a driver providing a dynamic-read-only parameter, it
>   knows it can rely on the driver providing dynamic read-only semantics.
>=20
> * Adding dynamic read-only capability to drivers creates no
>   introspection problems: we simply add dynamic-read-only to their
>   parameters.

In the end libvirt does not care that much if the storage is open read
only or read write. We need the format node or guest frontend to deny
writes if the disk is declared as read-only. We also need to be able to
do blockjobs. The requirement is that images may not be accessible in
R/W mode when qemu is starting but later may become. Then it's expected
that block-commit will succeed.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyiAiQACgkQHGwCByjY
1GrhXQ//dJiSE9sjKqX1Lv761Cmgp510jfZjwKGpqhUV6h+q7kN5ZyOaUkNuCmzv
rPlmKCL/b+6QlvmlKFdMB9Aocc8UXhT/8PIppWIefVvEGvjqKP4gHUtREgKdPN/R
eH8ZjuXoDCJkcgyH3p964u28/fdu93YBUEw3XKuJxE/ejH+pLm6pP8jI25JXEmLT
/xhqU+aQl/CeRs+BbE+5gPo+jmOeTbA+tuOGt6rIrRaJ1zG3ft0IgaQR3S8EUmWz
uhsUbbJyx29f5E8HijDWKedLnzb8j2Zkz8kL6/6vHb12RWvZaYxP0YwoMo2ZQzxb
F+rZWhF1MDBjeW7/QxBIwAd4ukBVPNLrG1kerFs//pTEb2DX7uU30/HvZ9vokWFT
x6/r8QjuargytXnx+sepGMbRGLCWE1BDaYICZDF3CbFglWeTLqxgSlvgmKuRyHHp
ijB28ycKu3YF9GfPMap27xoFpmy/Z1LMG3bs9KCzDw5lT7L13qJ/9yxV+1IElWZW
bo1kkheiUXEyctP8o3teB4H5+p8+ZUJxhuI7zN+ylW9xGovNlvzVX88Gg05dv+vE
JdH81XYzbdU7DrMnea0oCHicKsrwF+sRVr2k4FyfU3248rHzuC6ocKb124bDwkg1
J08DHoI+7igZiw8GWpKxAsjDlj0VdIjcX4HAcuav1ZMCrTCGUcQ=
=Qv4m
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
