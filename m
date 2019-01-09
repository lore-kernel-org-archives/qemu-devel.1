Received: from eggs.gnu.org ([209.51.188.92]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghHWv-00086w-0a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghHWp-00025R-No
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghHWp-00023n-DH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:20:31 -0500
Date: Wed, 9 Jan 2019 18:20:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109172023.GK4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
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


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 18:05 hat Max Reitz geschrieben:
> On 09.01.19 17:57, Daniel Henrique Barboza wrote:
> >=20
> >=20
> > On 1/9/19 12:10 PM, Max Reitz wrote:
> >> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> >>> changes in v2:
> >>> - removed the "RFC" marker;
> >>> - added a new patch (patch 2) that removes
> >>> bdrv_snapshot_delete_by_id_or_name from the code;
> >>> - made changes in patch 1 as suggested by Murilo;
> >>> - previous patch set link:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
> >>>
> >>>
> >>> It is not uncommon to see bugs being opened by testers that attempt to
> >>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> >>> common snapshot names and they trigger a lot of bugs. I gave an examp=
le
> >>> in the commit message of patch 1, but to sum up here: QEMU treats the
> >>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. =
It
> >>> is documented as such, but this can lead to strange situations.
> >>>
> >>> Given that it is strange for an API to consider a parameter to be 2
> >>> fields
> >>> at the same time, and inadvently treating them as one or the other, a=
nd
> >>> that removing the ID field is too drastic, my idea here is to keep the
> >>> ID field for internal control, but do not let the user set it.
> >>>
> >>> I guess there's room for discussion about considering this change an =
API
> >>> change or not. It doesn't affect users of HMP and it doesn't affect
> >>> Libvirt,
> >>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
> >> (Yes, very late reply, I'm sorry...)
> >>
> >> I do think it affects users of HMP, because right now you can delete
> >> snapshots with their ID, and after this series you cannot.
> >=20
> > That's true. My idea here was simple: the user can't reliably exclude
> > via snapshot ID today
> > because we're hiding the ID field in info snapshots:
> >=20
> >=20
> > =A0=A0=A0 (qemu) savevm 0
> > =A0=A0=A0 (qemu) info snapshots
> > =A0=A0=A0 List of snapshots present on all disks:
> > =A0=A0=A0 ID=A0=A0=A0=A0=A0=A0=A0 TAG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 VM SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DATE V=
M CLOCK
> > =A0=A0=A0 --=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 741M 2018-07-31 13:39:56 00:41:25.313
> >=20
> >=20
> > Thus, what will end up happening is that the user will be forced to use=
 the
> > TAG of the snapshot since this is the only available information.
>=20
> But you can get it through e.g. qemu-img info.
>=20
> Snapshot list:
> ID        TAG                 VM SIZE                DATE       VM CLOCK
> 1         0                      1.6M 2019-01-09 18:01:21   00:00:02.657
>=20
> So it's not impossible to get.

Is there a reason why we should display the ID at all when you can't use
it any more to identify snapshots?

> >> I think we had a short discussion about just disallowing numeric
> >> snapshot names.=A0 How bad would that be?
> >=20
> >=20
> > This was my first idea when evaluating what to do in this case. I gave
> > it up because
> > I found it to be too extreme. People would start complaining "I was able
> > to do
> > savevm 0 and now I can't".
>=20
> True.  But it wouldn't be impossible to do, we'd need to deprecate
> numeric names, print a warning for two releases, and then we can make it
> an error.

This. Is. HMP.

Not a stable ABI, no deprecation period of two releases.

> Hm...  If we had a proper deprecation warning in this series, I suppose
> it wouldn't be dangerous anymore.  Can we just print a warning whenever
> the user specified an ID?  (i.e. if some snapshot's ID matches the
> string given by the user and the snapshot's name does not)

How is it less of a problem when a user gets QEMU from the distro and
skips five releases? They will never see the warning. This is different
=66rom QMP where things are fixed in libvirt, which is tested with every
single QEMU release.

Kevin

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNi1XAAoJEH8JsnLIjy/WhDcP/jpYP3JYmyYXl0Helv3KrK7B
YkMt43XRhlk9Isw1xaIFX5uZXk7wvJSdA76fSqjPlGEFOTfgkVN2oV6a+6S+mOUX
uWMIY7sq1WnqaLtYxd06Z8CKDBKKZfQHAwlWhhypkkHbbSaP4xSNLMNnZIPAoMD5
ZKQ83uiCBGozZZ1lg+Or1reQ318i6rp+2dlXLs0tlq4V1/poKiuDS/zTGWjrI+y9
F0jWT6thMR7KD6PJ0NFhHW74p5uIirtoRI8M5DeGOamEOkswi1HS1cRqti2KY7G7
Bgg8beaS3jMY7XXS7meOTJ2Wq7FI2P4WFDcRY9UO2PYZycQJbbRihVBD390Ak4JP
ZMdktLm9HSFnYW3HpUUR9DKNhStZFzKDbIJq2PI2+pUNG4ms2IfTJy1Y2Gb+vy6u
9nOnou8J1Cf7s9WhbkFJhjQd93/6mFpYNrSO9Az5qsHBiKBTbkGBWArW4u8MsXwa
jAiHJZewxn9RHz3i7SSUngrd9xtQebvW9DMjxYLzwEHfdbfm1+62L0lO+M4MYXU1
3UxUvRUfQLKmYNXEa8fUYBIubGQcwNfWvFIa2VDHE6AxLHrnA/hVcmhd4BhjVBHa
5ha6vZscc6HyYv/Z/nP43addv9c2fxu4vFyFQKt/VU0Hr7SjJQSen/Z+o5g/x9KZ
s5KpuWjxpL+6WGv8BZTy
=L3lO
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
