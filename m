Received: from eggs.gnu.org ([2001:4830:134:3::10]:35815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1w7J-0001QG-IW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1w7D-0008GI-4X
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1w7C-0008Fo-RM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:06:39 -0400
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1726032a-16fb-3eae-1dbf-f711d4e98a5a@redhat.com>
Date: Tue, 10 Oct 2017 10:06:35 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x0xKm0tE3l66nQHJrgIpiT9boAipNw09D"
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0xKm0tE3l66nQHJrgIpiT9boAipNw09D
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <1726032a-16fb-3eae-1dbf-f711d4e98a5a@redhat.com>
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
In-Reply-To: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 09:22 AM, Peter Maydell wrote:
> Hi; we currently have an issue with the u-boot we're using where it
> has a file and a directory that differ only in case (scripts/Kconfig
> and scripts/kconfig/). This means that QEMU's release tarballs won't
> unpack on a case-insensitive filesystem (OSX, Windows).
>=20
> u-boot have now fixed this upstream:
> http://git.denx.de/?p=3Du-boot.git;a=3Dcommitdiff;h=3D610eec7f0593574c0=
34054ba54fc1c934755e208
>=20
> but we need to decide how best to get this fix into QEMU so that
> our tarballs will unpack, both for the upcoming QEMU 2.11 and
> ideally for future point releases based on 2.10.
>=20
> I can see a couple of options:
>  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
>      and move to that
>      [downsides: would be in the middle of QEMU's own release cycle,
>       pretty late to fix any problems with the new version;
>       rather a big change to put into stable]
>  (2) move to u-boot current head-of-unstable
>      [downsides: would mean running some random git commit version,
>       also not really very suitable for stable]
>  (3) backport the upstream fix to sit on top of the u-boot version
>      we're currently using (I think the patch should apply as-is)
>      [downsides: would need to figure out how to get that commit into
>       the mirror of the u-boot repo that we use; would a build of it
>       claim a misleading u-boot version number?]
>  (4) suggest your better idea here!
>=20
> Thoughts?

half-and-half? Use option (1) for 2.11 (that is, wait for November's
release there), but option (3) for 2.10.2 (that is, backport just the
fix onto the u-boot version uses in 2.10.x right now)?  (I'm not sure
I'm a fan of the idea of split maintenance like that, but am throwing it
out as a possible (4) since you asked).

>=20
> (Proposals for automated tests to ensure we don't run into the
> case-sensitivity problem again in future also welcome.)

Would it be as simple as using

LC_ALL=3DC
filelist=3D$(... )
diff <(printf '%s\n' $filelist | sort -f) \
     <(printf '%s\n' $filelist | sort -f -u)

where filelist is determined by 'tar tf tarball' or by some invocation
of 'git ls-files'?  Perhaps something we can even add to checkpatch.pl,
although my perl is not strong enough to write that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--x0xKm0tE3l66nQHJrgIpiT9boAipNw09D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc4fsACgkQp6FrSiUn
Q2pieAf9GeRUaPqdbokSTPE+fpFhtZTOI/DkLjcFQ5658/kMykKP9trBuC4bOt9t
KDMXJrbFR+3d+Z5Pwbnvfqy2JUSfXkjBit6VfJfnLEqcSmxT+3AZk/kKDoSqsbxm
xiz83TcfuTkBqqrW6N1SEp94iM/erasyVZgHvf1ksv60DPlYToZeWRajhOEetjWl
lBMr5v5dC+RJijYGcomIdrqcbons1/NxVOjRmf3FxhV1POntap7YFe+NtbtkeEm6
a6GdBbOmvJkwSTYXa+jsEkq3qgpx3hunWNXYwRSMKqqwPqUY34J0mz0pSb4udMdR
fHoywy9/8JzPPFKgSD0a3U1rOO8UYg==
=9ElZ
-----END PGP SIGNATURE-----

--x0xKm0tE3l66nQHJrgIpiT9boAipNw09D--
