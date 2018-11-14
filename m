Received: from eggs.gnu.org ([2001:4830:134:3::10]:34258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gMyu4-0004DH-NS
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gMytx-0005vq-LZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:24:35 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
Date: Wed, 14 Nov 2018 18:24:10 +0100
MIME-Version: 1.0
In-Reply-To: <w511s7p9fkk.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2d6aeaDDfuRk3QLAWsG1ZWaES3fAjziyV"
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2d6aeaDDfuRk3QLAWsG1ZWaES3fAjziyV
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
Subject: Re: KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <w511s7p9fkk.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s7p9fkk.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.11.18 16:12, Alberto Garcia wrote:
> On Sun 11 Nov 2018 11:25:00 PM CET, Max Reitz wrote:
>=20
>> Permission system
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> GRAPH_MOD
>> ---------
>>
>> We need some way for the commit job to prevent graph changes on its
>> chain while it is running.  Our current blocker doesn=E2=80=99t do the=
 job,
>> however.  What to do?
>>
>> - We have no idea how to make a *permission* work.  Maybe the biggest
>>   problem is that it just doesn=E2=80=99t work as a permission, becaus=
e the
>>   commit job doesn=E2=80=99t own the BdrvChildren that would need to b=
e
>>   blocked (namely the @backing BdrvChild).
>=20
> What I'm doing at the moment in my blockdev-reopen series is check
> whether all parents of the node I want to change share the GRAPH_MOD
> permission. If any of them doesn't then the operation fails.
>=20
> This can be checked by calling bdrv_get_cumulative_perm() or simply
> bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).

Sure.

> It solves the problem because e.g. the stream block job only allows
> BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
> modifications allowed.

But the problem is that the commit job needs to unshare the permission
on all backing links between base and top, so none of the backing links
can be broken.  But it cannot do that because those backing links do not
belong to it (but to the respective overlay nodes).

>>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=80=
=9D or
>>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed to=
 mean.  Figuring
>>   that out always took like half an our in any face-to-face meeting,
>>   and then we decided it was pretty much useless for any case we had
>>   at hand.)
>=20
> Yeah it's a bit unclear. It can mean "none of this node's children can
> be replaced / removed", which is what I'm using it for at the moment.

Yes, but that's just not useful.  I don't think we have any case where
something would be annoyed by having its immediate child replaced (other
than the visible data changing, potentially).  Usually when we say
something (e.g. a block job) wants to prevent graph modification, it's
about changing edges that exist independently of the job (such as a
backing chain).

>> Reopen
>> ------
>>
>> How should permissions be handled while the reopen is under way?
>> Maybe we should take the union of @perm before and after, and the
>> intersection of @shared before and after?
>=20
> Do you have an example of a case in which you're reopening a node and
> the change of permissions causes a problem?

I do not.  So currently we switch from the permissions before to the
ones after, right?  Which should be safe because that switch is a
transaction that is integrated into reopen.

However, I suppose it's possible the protocol layer gives us some issues
again.  It cannot switch the locks before commit, but committing may
fail.  What to do then?

It would be safer if we took the union/intersection in
bdrv_reopen_prepare() and then released the unnecessary flags in
bdrv_reopen_commit().  We can still get errors (as discussed), but those
can be safely ignored.  (They're just annoying, but not harmful.)

>> - Is it possible that changing an option may require taking an
>>   intermediate permission that is required neither before nor after
>>   the reopen process?
>>   Changing a child link comes to mind (like changing a child from one
>>   BDS to another, where the visible data changes, which would mean we
>>   may want to e.g. unshare CONSISTENT_READ during the reopen).
>>   However:
>>   1. It is unfeasible to unshare that for all child changes.
>>      Effectively everything requires CONSISTENT_READ, and for good
>>      reason.
>>   2. Why would a user even change a BDS to something of a different
>>      content?
>>   3. Anything that currently allows you to change a child node assumes=

>>      that the user always changes it to something of the same content
>>      (some take extra care to verify this, like mirror, which makes
>>      sure that @replaces and the target are connected, and there are
>>      only filter nodes in between).
>=20
> I don't think the user wants to change a BDS to something of a differen=
t
> content, but it may happen that QEMU doesn't have a way to verify
> whether the content is the same or not.
>=20
> I think we have one such case already with 'blockdev-snapshot', in whic=
h
> you add a BDS with blockdev-add and then add its contents on top of an
> existing BDS.

Yeah.  The new overlay is expected to be empty so when you replace the
now-snapshot with it, the parent nodes don't see any change.  If it's
not empty...  Well, your problem.

Max


--2d6aeaDDfuRk3QLAWsG1ZWaES3fAjziyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvsWjsACgkQ9AfbAGHV
z0Au8ggAu02EDTgj+5W+iV/44UnnEXdePcykMzqdm1vaQ0IE0uwPa9THln8U0ram
QcvAYcjWCv7/mRz1FgChlJRqoNpDiErSpLLm5JbEx2ZwSt6cxHOCfxkuuslvWoEP
5ieTlI1BaLOsDVCKahqYeUFHjhjT5S0dz+opC2ISltUL5HrIMKLbTUj4PzamhSJm
FJNTEPgaXx5mxUWO9wbMBawFZjEWn/a8p1Yc4TlGAwd/m9yAGqiaCkfSH9uqTvM/
YlP63MkF7Xr3linptIMprLepKvComFYnYytsvwwxQxCF9Bt5rD3qfmOgtZyV4h3e
/6vU36XEIL9EayqcggRwBzSBY6AMVg==
=AsO1
-----END PGP SIGNATURE-----

--2d6aeaDDfuRk3QLAWsG1ZWaES3fAjziyV--
