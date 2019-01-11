Received: from eggs.gnu.org ([209.51.188.92]:52675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghxsV-0001yn-EW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghxsU-0002wU-5L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:33:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghxsT-0002vj-SY
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:33:42 -0500
Date: Fri, 11 Jan 2019 15:33:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111143321.GJ5010@dhcp-200-186.str.redhat.com>
References: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box>
	<20190110114113.GC2589@work-vm>
	<dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.01.2019 um 14:22 hat Max Reitz geschrieben:
> On 10.01.19 12:41, Dr. David Alan Gilbert wrote:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> >> Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
> >>> On 1/9/19 12:51 PM, Kevin Wolf wrote:
> >>>
> >>>>> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
> >>>>> human-monitor-command, since there is no QMP counterpart for intern=
al
> >>>>> snapshot.  Even though lately we consistently tell people that inte=
rnal
> >>>>> snapshots are underdeveloped and you should use external snapshots,=
 it
> >>>>> does not get away from the fact that libvirt has been using 'savevm=
' to
> >>>>> drive internal snapshots for years now, and that we MUST consider
> >>>>> back-compat and/or add an introspectible QMP interface before making
> >>>>> changes that would break libvirt.
> >>>>
> >>>> Okay, so what does libvirt do when you request a snapshot with a
> >>>> numerical name? Without having looked at the code, the best case I w=
ould
> >>>> expect that it forbids them, and more realistically I suspect that we
> >>>> may actually fix a bug for libvirt by changing the semantics.
> >>>>
> >>>> Or does libvirt really use snapshot IDs rather than names?
> >>>
> >>> At the moment, libvirt does not place any restriction on internal
> >>> snapshot names, but passes the user's name through without thought of
> >>> whether it is an id or a name.
> >>>
> >>> So yes, arguably tightening the semantics fixes a libvirt bug for
> >>> libvirt having allowed internal snapshots to get into an inconsistent
> >>> state.
> >>
> >> So there are two scenarios to consider with respect to breaking
> >> backwards compatibility:
> >>
> >> 1. There may be code out there that relies on numeric arguments being
> >>    interpreted as IDs. This code will break if we make this change and
> >>    numeric snapshot names exist. That such code exists is speculation
> >>    (even though plausible) and we don't know how widespread it is.
> >>
> >> 2. There may be code out there that blindly assumes that whatever it
> >>    passes is interpreted as a name. Nobody considered that with a
> >>    numeric snapshot name, it maybe misinterpreted as an ID. We know th=
at
> >>    this is true for libvirt, the single most used management tool for
> >>    QEMU. More code like this may (and probably does) exist.
> >>
> >> Essentially the same two categories exist for human users: those who
> >> somehow found out that QEMU accepts IDs as monitor command arguments a=
nd
> >> are using those (mitigated by not displaying IDs any more), and those
> >> who are trapped because they wanted to access a numeric name, but
> >> surprisingly got it interpreted as an ID. Both are speculation to some
> >> degree, but my guess is that the latter group is larger.
> >>
> >> Given all this, this is a no-brainer for me. We simplify the interface,
> >> we simplify the code, we make things less confusing for manual users a=
nd
> >> we fix the management tool that everybody uses. How could we not make
> >> this change?
>=20
> So you're trying to make a bug fix out of this now to get around
> deprecation?  To me, changing behavior in qemu to fix a bug in libvirt
> doesn't equate to fixing a bug in qemu.  So let's try to find a real bug
> in qemu.

I'm not making this a bug fix, but a interface cleanup that fixes a bug
as a side effect, which makes it only more appealing. I'm also not sure
what exactly you mean by "get around deprecation".

If you mean the formal two releases deprecation period that is required
by our deprecation policy, it doesn't apply because this is HMP and not
a stable interface.

If you mean deprecation not because we must but because we're
considering actual users, then I have described how making the change
fixes things for more users than it could potentially break things. In
addition, I pointed out how a deprecation period is useless for
user-facing changes. I'm concluding that a "voluntary" deprecation for
two releases isn't helpful at all.

> >>> But again, it falls in the category of "properly fixing this
> >>> requires a lot of auditing, time, mental power, and unit tests", which
> >>> makes it a rather daunting task to state for certain.
> >>
> >> Fix the world before we can fix anything?
> >=20
> > Can't we break this loop for the savevm command fairly easily; it's
> > currently documnted as:
> >=20
> > savevm [tag|id]
>=20
> The bug starts here.
> [... snipped long description of how horrible everything is ...]

Yes, it's horrible. Let's radically simplify the interface (and with it
the code) by throwing away the useless ID stuff. Which happens to be
exactly what this series was getting at.

There is no point in spending time for changing the current interface to
make a little more sense while keeping its fundamental insanity
unaddressed, then deprecate it, and then change it again to _actually_
make sense. Let's convert it directly to something that makes sense.

> So, yes, there are bugs in qemu, but to fix them, we would need to
> switch the comparison order in bdrv_snapshot_find() and fix
> bdrv_snapshot_delete_by_id_or_name() to always invoke
> bdrv_snapshot_delete() for both cases (ID and tag).  And we should
> probably remove the special code path in savevm for overwriting an
> existing snapshot.
>=20
> This would also alleviate the bug in libvirt (because the tag then
> always takes precedence, like the interface description suggests).

Yes, at least tools which don't use IDs wouldn't be broken any more. But
you removed none of the insanity. The same way addressing by tag was
broken before, addressing by ID is broken now (previously, you need to
check first that no ID exists while you want to address a tag; now, you
need to check first that no tag exists while you want to address an ID).

In fact, if you're willing to go there, you break exactly the same users
that would be broken if we dropped IDs from the interface completely. So
why not do the full thing instead of stopping halfway? You're taking the
potential problems without the advantages you could get.

> Sure, this series would fix the bugs as well, but it does more than
> that.  It really isn't just a bug fix.

It was never meant to be a bug fix (unless, of course, you consider
insane interfaces a bug). But that it fixes a bug as a side effect
contributes to the fact that breaking compatibility has not only
downsides and that a deprecation period would be useless or even
counterproductive.

Kevin

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcOKkwAAoJEH8JsnLIjy/W77YQAL0ulumHRUqutp1ERSIKzKLc
cd/yco6lJ0Mg5RfY+N/v37ZQgSqhRF09+esnCYT17WPi3odBBhzd3nMwKk5MgY3M
vmSdCpci9rNaXCox//TJwuDPbkWHwqRbttsUkHORB1wFkU9socFUSWVBNSFm0IDP
2jNSkzPejyHwy8DDrq8/O4FF3cSmAumhkgG9aBch01EUvq2VEwstOhdmWlx9lywm
j8dnQ/3OkMazGdekzZ9o5C5sEFthMt+T3AkL6URIl39smCR2MvMRMH89RvZjwy8m
c8qByrpIoHjPhtj4ixd7oKZqq07t+NaPTuis9os6kLWBbv+3eR/N06QJ8bflrRo2
vj2y3NSUv72B+dywayK6GS8Jwi3ARvjcTjSCWriUh4egxAa1dSa5J4xiPC+QZW9+
id6MK/7/jCqm3Ng3EJiszSaWN0GPbKoH98iSEln6hN7s6QYLqqhvdFepDk1Vbrt8
J7+b0ZgfPLt/Eu7tz83WjIcT5lRuNUm0YtO9j+jvxgd2fBnputdRBr6E4oM9mDNe
/eAEvE/MJSAU9zbX3zDoeKHKqntbqw/NMrzs9I1fhILO+t3/+pW4ZlZvIpiWxJmR
SM4+XhZKQWmke1NKMw4jLLKHV7JOs/Q9rZGoa4DaI8lk/oC9Zr9wAiCF7211daHh
qPBipQd7qObXDW6WVPqQ
=92aI
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
