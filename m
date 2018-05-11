Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHFmq-00037p-Gp
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHFmp-0005jb-Is
	for qemu-devel@nongnu.org; Fri, 11 May 2018 17:41:12 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-11-mreitz@redhat.com>
	<0fa62186-3ff3-f3e2-02bd-777fda2030c5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b674d614-6081-2356-6057-2c301323c5a5@redhat.com>
Date: Fri, 11 May 2018 23:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <0fa62186-3ff3-f3e2-02bd-777fda2030c5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d9PBhZyWX6cbAGXWVK23tSdTgWMZ22VJk"
Subject: Re: [Qemu-devel] [PATCH 10/13] tests: Add QDict clone-flatten test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d9PBhZyWX6cbAGXWVK23tSdTgWMZ22VJk
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <b674d614-6081-2356-6057-2c301323c5a5@redhat.com>
Subject: Re: [PATCH 10/13] tests: Add QDict clone-flatten test
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-11-mreitz@redhat.com>
 <0fa62186-3ff3-f3e2-02bd-777fda2030c5@redhat.com>
In-Reply-To: <0fa62186-3ff3-f3e2-02bd-777fda2030c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-11 20:46, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> This new test verifies that qdict_flatten() does not modify a shallow
>> clone of the given QDict.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/check-qdict.c | 33 +++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 33 insertions(+)
>>
>=20
> I'm not sure I even want to know how long it took you to debug the cras=
h
> that you obviously hit before adding the fix in 9/13 plus this test ;)

Thank you very much, I made myself forget about that trauma already.

In short, I wondered why the whole thing worked for null-co directly:

driver=3Dnull-co,size=3D512
=3D> {"driver": "null-co", "size": 512}

But not for null-co through raw:

driver=3Draw,file.driver=3Dnull-co,file.size=3D512
=3D> {"file": {}}

(Or something like that, I don't remember exactly.)

With some debugging sprinkled into block.c, I could see that the correct
options were there on the null-co level...  But for some reason they
disappeared one level above.

Then I recalled that dict cloning is just a shallow cloning and looked
for the culprit...

Of course, in reality, much more cursing was involved.

Max


--d9PBhZyWX6cbAGXWVK23tSdTgWMZ22VJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2De0ACgkQ9AfbAGHV
z0A1HQf+ObsMMgSS503ZyS76HjL+qLituTrBusAgR9tcCJf2y0GoU7hv6EIvnjFz
dyiJGZMMsOD4wyFJ3xUJ/TiwqyEd+sUBo1F3BjGp15N9B3eC4yNwveMLy3XGSsfd
8KrZrt1jV5If4YKaaZ9UUPAS1S5ArJCy6gLkafgFq7Sb8SZAdW4RxW8IqbJbT10X
UF1SS/JpsLmI16B+En5v9a3bEngTSWuoLOc2n+bSLs3Q8iJl9VGlcCRk7I2xyQ9C
GMh+aEGb+E0MCfEZ7R1bqb2csvFZhd2Hy865kocWZ3s/sfM1jvzfi4DUAlI67aP1
+swe6y22GZIAc/fp5yvuSpfeaM4Nrg==
=jcgD
-----END PGP SIGNATURE-----

--d9PBhZyWX6cbAGXWVK23tSdTgWMZ22VJk--
