Received: from eggs.gnu.org ([2001:4830:134:3::10]:35762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eosXy-0008Pi-T4
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eosXx-0004sw-Qu
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:12:34 -0500
Date: Thu, 22 Feb 2018 16:12:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222151210.GK4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2018 um 15:55 hat Max Reitz geschrieben:
> On 2018-02-22 14:39, Kevin Wolf wrote:
> > Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
> >> If the backing file is overridden, this most probably does change the
> >> guest-visible data of a BDS. Therefore, we will need to consider this =
in
> >> bdrv_refresh_filename().
> >>
> >> Adding a new field to the BDS is not nice, but it is very simple and
> >> exactly keeps track of whether the backing file has been overridden.
> >=20
> > ...as long as we manage to actually keep it up to date all the time.
> >=20
> > First of all, what I'm missing here (or in fact in the comment in the
> > code) is a definition what "overridden" really means. "specified by the
> > user" is kind of vague: You consider the backing file relationship for
> > snapshot=3Don as user specified, even though the user wasn't explicit
> > about this. On the other hand, creating a live snapshot results in a
> > node that isn't user specified.
> >=20
> > Isn't the real question to ask whether the default backing file (taken
> > from the image header) would result in the same tree? The answer to this
> > changes after more operations, like qmp_change_backing_file().
>=20
> With you so far.
>=20
> > Considering that there are so many ways to change the answer, I think
> > the simplest reliable option isn't a new BDS field that needs to updated
> > everywhere, but looking at the current value of bs->options and
> > bs->backing_file and see if they match.
>=20
> I don't see how that is simple.  First, bs->options does not necessarily
> reflect the "current options", those would be bs->full_open_options.
> And for generating that, we need a way to determine whether the backing
> file has been overridden or not, so whether we need to put the backing
> options into it or whether we do not.

For the purpose of this comparison, we need a set of options that
contains the backing file options unconditionally.

> (I am right that bs->backing_file is what the image header says, right?
> So we need to compare it against something that reflects the runtime stat=
e.)

I think so, yes.

> What I could see would be comparing bs->backing_file to
> bs->backing->bs->filename.  But this sounds very hacky to me.
>=20
> One thing the comes to mind is that it can break whenever
> bdrv_refresh_filename() is clever.  So you specify
> 'json:{"driver":"null-co"}' in the image header, and
> bdrv_refresh_filename() optimizes that to "null-co://".  Now the
> filenames differ even though it's still the original filename.  So this
> wouldn't work very well either.

On the other hand, the problem with your current approach is that it
results in a JSON filename even if you override the backing file and
specify the same file name as we already have in the image header.

In the future, libvirt is going to manually build the graph, so we will
always have the backing file overridden according to the logic in this
patch. I don't think we want to get JSON filenames for all libvirt
managed VMs, so can we realistically do without any kind of comparison?

Kevin

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJajt3JAAoJEH8JsnLIjy/WoIAP/i1MGZ1P9ntLvjeIemp06pNO
5T6g51Azx96shxUix2IjK6qngSHnKktfZzdsoO115B/KxwB77FP2FOJdLxPYaEAo
xgB8lCDAqByuv8uJK+utbr2sTJo8dVQtdYhjxtI9FitWl/16iFI5YrPRCtjvR2jR
1GkE671lpiXZE75nNjlv/9yEfJZkwiDqFGYnPGBCLKnWoXsEJ5ymGmwTywqflGf0
WIXQGdCUoN6V7n2MRJA+iBixZrGNXKIbswuv5reLM+Q97Mg5nUwgsXT0gXh2t8rt
lQADdVIjaQnc+6v5WvcU3cefcdialYEktMmM/vVg6giP/9k/mngvU0Z68+MNmtEy
HJZHau3VwZzKKIQuSnw+LBgMANMVmV0/x+r0qyMSMcMCwspT7YqAVvxJ4RZFIodJ
CmKpqVfVMkDn5eUjsQUOEk69zmCSWnJcDk2CGaOjEFFnTncQcB84Q5iHFwmGUjWs
hDZljalZohFdsp6gNn7dU9v8JAJcTKoFYaOz+iGCQLQqWmcP851ckP/nhnqclAEG
Odk7/nhk6MhKQgigYHmVWqyewrVaPICQ2eMOHLQ3yk81FBB1kgj5SkSkBH52nfor
l/nGfWBRu4YSNoK6KtibQ+aoXVFmf6k2IhVN48kFLA5rQOVprbXtKzi1aOw9dUSa
AHOD1sSW7eIXXJUbgSry
=KRuw
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
