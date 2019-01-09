Received: from eggs.gnu.org ([209.51.188.92]:50894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghFYJ-0007xc-Oc
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghFYI-0005cy-EL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:13:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghFYH-0005bx-Sa
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:13:54 -0500
Date: Wed, 9 Jan 2019 16:13:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109151348.GG4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
	<20190109144818.GE4867@localhost.localdomain>
	<756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <756f6997-cb66-a82b-ae13-babb0e5fa827@redhat.com>
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 15:54 hat Max Reitz geschrieben:
> On 09.01.19 15:48, Kevin Wolf wrote:
> > Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
> >> On 09.01.19 15:21, Kevin Wolf wrote:
> >>> Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
> >>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> >>>>> changes in v2:
> >>>>> - removed the "RFC" marker;
> >>>>> - added a new patch (patch 2) that removes
> >>>>> bdrv_snapshot_delete_by_id_or_name from the code;
> >>>>> - made changes in patch 1 as suggested by Murilo;
> >>>>> - previous patch set link:
> >>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
> >>>>>
> >>>>>
> >>>>> It is not uncommon to see bugs being opened by testers that attempt=
 to
> >>>>> create VM snapshots using HMP. It turns out that "0" and "1" are qu=
ite
> >>>>> common snapshot names and they trigger a lot of bugs. I gave an exa=
mple
> >>>>> in the commit message of patch 1, but to sum up here: QEMU treats t=
he
> >>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'=
=2E It
> >>>>> is documented as such, but this can lead to strange situations.
> >>>>>
> >>>>> Given that it is strange for an API to consider a parameter to be 2=
 fields
> >>>>> at the same time, and inadvently treating them as one or the other,=
 and
> >>>>> that removing the ID field is too drastic, my idea here is to keep =
the
> >>>>> ID field for internal control, but do not let the user set it.
> >>>>>
> >>>>> I guess there's room for discussion about considering this change a=
n API
> >>>>> change or not. It doesn't affect users of HMP and it doesn't affect=
 Libvirt,
> >>>>> but simplifying the meaning of the parameters of savevm/loadvm/delv=
m.
> >>>>
> >>>> (Yes, very late reply, I'm sorry...)
> >>>>
> >>>> I do think it affects users of HMP, because right now you can delete
> >>>> snapshots with their ID, and after this series you cannot.
> >>>
> >>> Can there be snapshots that can't be identified by a snapshot name, b=
ut
> >>> only by their ID?
> >>
> >> I don't know, but what I meant is that if you have scripts to do all
> >> this, you might have to adjust them with this change.
> >=20
> > That's what the H in HMP means.
> >=20
> >>>> I think we had a short discussion about just disallowing numeric
> >>>> snapshot names.  How bad would that be?
> >>>
> >>> It would be incompatible with existing images and result in a more
> >>> complex snapshot identifier resolution. Why would it be any better?
> >>
> >> It wouldn't be incompatible with existing images if we'd just disallow
> >> creating such snapshots.  I don't see how the identifier resolution
> >> would be more complex.
> >>
> >> I don't know if it'd be better.  I'd just find it simpler (for us, that
> >> is -- for users, I'm not sure).
> >=20
> > Identifier resolution A:
> > - Find a snapshot that has the given identifier as a name
> > - If no such snapshot exists, it is an error
> >=20
> > Identifier resolution B:
> > - If the identifier is a number, find a snapshot that has the given
> >   identifier as its ID
> > - If the identifier is not a number, find a snapshot that has the given
> >   identifier as a name
> > - If no such snapshot exists, it is an error
>=20
> No, my idea was to keep the resolution the same as it is; just to forbid
> creating new snapshots with numeric names.  This would prevent users
> from getting into the whole situation.

That's the version with an even more complex resolution method C. :-)

I actually think the current behaviour is more confusing than helpful.
Without looking into the code or trying it out, I couldn't even tell
whether ID or name takes precedence if there is a matching snapshot for
both. Considering your proposal, it's probably the ID, but how should a
user know that? (If against all expectations documentation exists, it
doesn't count because nobody reads that.)

Kevin

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNg+sAAoJEH8JsnLIjy/W5k4QAJGdFGOGNLZJpDqV835hP4L0
RICXoticlC+23ufkHGgsv9GwfxdJz8ziWlxpKKhV4Gf35u+fw5igJt0pk7oA6dFp
khptlrLwPAIqreEYbgEqIn8avFCqWtd2g4CotfbIe4U/EHlt7uS3/zOA0dljwXNc
p5UWFfSSrq5lkaGeA5eIBmXGhs/lYY0a5H5qDktFEJhGNOSm9hko9QW3YSJY3hkI
vN2IWFkfdzEgky+tfLAG/+87Ug+tLAaRVEDf4K270/7xZ5hxzGl/My+Vsgfidrg9
DOLDNQuUIIDjOCC0HlR2LQk91CeirHPSCE0e4iIXdXNCpQgoAFLAiSTyAaqTNxdO
n5int0PtvBfzBZ0bmfrFdKQxlZBHBLN4JiHrm3DffD/5GB9wkpc6ESnr5S5Xk0sO
n/zmT//uLfjPbKEFILOVKgzVnpBhQM1JXFZKVv2vTs16b7lzfBeVoDljidcyapXz
/FZSPvsaWHtcxPAiUrH9eFeBvXfoa2W6ogN+rgdYmMd7Gad4ztsNsdCP/fsar343
N5bCWYidyNiijU5FxJNNqxZI7aYNXGgtJB7MfcqbVpnTlBYkC2saGGRiVF8lwFg4
hWNbo0YAEicmC9lrrhMtjxcAoR1ucU31+4sgocTZRwz0H79YaaHbDxNz+l3CmdOm
B7W2l4+d8IlGN7TWCyRB
=PAoO
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
