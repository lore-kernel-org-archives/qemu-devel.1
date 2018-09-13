Received: from eggs.gnu.org ([2001:4830:134:3::10]:32819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZT1-00036i-EQ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZSp-0004WJ-KL
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:47:56 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-13-kwolf@redhat.com>
	<9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Message-ID: <f281f1af-3bad-7744-969f-16d5d0928e87@redhat.com>
Date: Thu, 13 Sep 2018 23:43:00 +0200
MIME-Version: 1.0
In-Reply-To: <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Nzx6GX8gwsBR8z08Tgc0rtEeMoIHcevn"
Subject: Re: [Qemu-devel] [PATCH v2 12/17] mirror: Fix potential
 use-after-free in active commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Nzx6GX8gwsBR8z08Tgc0rtEeMoIHcevn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f281f1af-3bad-7744-969f-16d5d0928e87@redhat.com>
Subject: Re: [PATCH v2 12/17] mirror: Fix potential use-after-free in active
 commit
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-13-kwolf@redhat.com>
 <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
In-Reply-To: <9f51d49d-0159-3382-b561-1f33335a2dfd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 22:55, Max Reitz wrote:
> On 13.09.18 14:52, Kevin Wolf wrote:
>> When starting an active commit job, other callbacks can run before
>> mirror_start_job() calls bdrv_ref() where needed and cause the nodes t=
o
>> go away. Add another pair of bdrv_ref/unref() around it to protect
>> against this case.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block/mirror.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> But...  How?
>=20
> Like...  You mirror to some target (in an iothread), then you give that=

> target a backing file, then you cancel the mirror and immediately commi=
t
> the target?

The only way I got this to work was to allow commit to accept a non-root
BDS as @device.  I can't imagine a way where @device can go away, but
isn't currently in use by something that would make it a non-root BDS.
(Because the only reason someone can make it go away is because that
someone uses it right now.)

But if commit accepts non-root BDSs as @device, I get a segfault even
after this commit...

Max


--2Nzx6GX8gwsBR8z08Tgc0rtEeMoIHcevn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlua2eUACgkQ9AfbAGHV
z0D3XggAsnVTpyNasZfJs74rQVYR5/QJXaTOwuDG+JzlegbJiEdJa32VHOmlQCuh
7TCHcYtrywPQGCrl6mOqAbf7cEedjim2YbAPSa8hBlqIbBbhOPRBiBfwCQ+wEVJz
yQAies5XhYoroTR3jEcZ1C+xwg8ssf1MH812Len3nlSr4hSML4IL1cTHURTjQj2W
5JFmCeQxns9+hgMCp1f/xsOH9uAe6/pST+hS4fPNlAOSkaL+KAhrBQYItLS5sY8u
Gd+IQddpvoWqDI1OFYtBmf3WEPHM+wup1xjKLhfyAP7iCywT8r5wR2LeMNTrHHeY
kV0+fQKTs7/ID3hwj3vrS7RmQVE9Qw==
=3ZwL
-----END PGP SIGNATURE-----

--2Nzx6GX8gwsBR8z08Tgc0rtEeMoIHcevn--
