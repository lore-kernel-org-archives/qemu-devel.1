Received: from eggs.gnu.org ([2001:4830:134:3::10]:36612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxCpC-0004H6-Mu
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxCp9-0006qj-UF
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:01:02 -0400
Date: Tue, 4 Sep 2018 17:00:42 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180904150042.GE3803@andariel.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <w515zzll3xy.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 16:42:17 +0200, Alberto Garcia wrote:
> On Tue 04 Sep 2018 04:17:30 PM CEST, Peter Krempa wrote:
> >> >> libvirt-3-format is read-write and all other node names are
> >> >> readonly in the above example.
> >> >>=20
> >> >> The same also happens when using filenames:
> >> >>=20
> >> >> {"execute":"block-commit",
> >> >>  "arguments" : {"device":"libvirt-3-format",
> >> >>                 "job-id":"libvirt-3-format",
> >> >>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
> >> >>                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
> >> >>                 "auto-finalize":true,
> >> >>                 "auto-dismiss":false},
> >> >>  "id":"libvirt-13"}
> >> >>=20
> >> >> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block no=
de is read-only"}}
> >> >
> >> > I see what's happening here. So we have a graph like this:
> >> >
> >> >      guest device
> >> >           |
> >> >           v
> >> >     overlay-format -------> backing-format
> >> >     [read-only=3Doff]         [read-only=3Don]
> >> >           |                        |
> >> >           v                        v
> >> >     overlay-proto           backing-proto
> >> >     [read-only=3Doff]         [read-only=3Don]
> >> >
> >> > The difference between your -blockdev use and -drive is that you
> >> > explicitly specify the read-only option for backing-proto (and you u=
se
> >> > a separate -blockdev option anyway), so it doesn't just inherit it
> >> > from backing-format.
> >>=20
> >> Are these format and protocol block devices opened with four separate
> >> -blockdev parameters? Is that how libvirt does it?
> >
> > Yes. This goes along with the fact that for 'blockdev-create' you need
> > to blockdev-add the file which you want to format, but the formatted
> > file is not automatically added.
> >
> > If we'd use the approach where the protocol layer is opened as part of
> > the format layer it would complicate the snapshot code where we need
> > to add a file and then format it to qcow2. It would mean that we'd
> > have to blockdev-add a file, format it via blockdev-create, then
> > blockdev-del it and open it together with the format layer. Otherwise
> > the disk hot-unplug code would be plain crazy.
>=20
> Do you need to add the protocol layer in order to format it, though? :-?
>=20
> (I'm just trying to understand how this works, I'm not too familiar with
> blockdev-create)
>=20
> {'execute': 'blockdev-create',
>  'arguments': {'job-id': 'job0',
>                'options': {'driver': 'file',
>                            'filename': 'test.qcow2',
>                            'size': 0}}}
> {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
>=20
> {'execute': 'blockdev-create',
>  'arguments': {'job-id': 'job1',
>                'options': { 'driver': 'qcow2',
>                             'size': 1048576,
>                             'file': {'driver': 'file',
>                                      'filename': 'test.qcow2'}}}}
> {'execute': 'job-dismiss', 'arguments': {'id': 'job1'}}

Honestly I've reused the existing approach and did not try without
actually adding the protocol layer.

I remember being told some time ago to specify both layers explicitly.
Since it's not yet enabled in libvirt we theoretically could change to
one -blockdev for format+protocol but in that case we need some kind
of guarantee that every (even new) feature will work with it.

Switching between those approaches once we enable it upstream will not
be possible without adding a lot of compatibility code.

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluOnhcACgkQHGwCByjY
1GqUdw//Rli4VQLoxe95tCi7Qag1LUEjUVxJEJsQ1pjjOf/POWD2gSWmC1sY5HHU
s1XAGyAX4d11d4PCC/7Iea69QX15oTmbE+IZ424fb+3oY4fLSBoLlBBpwHVqKEdF
Sqx+WtVWPkfH5yTdDdlVKk1MZMg1cclBXqoIduico2jv5ejQDSXsodT5UspeLiwM
mrj2mKhZOZ4flW5yA+VifcXwmuTxqSmau278FN4zuMt/4IdHHvo4QWP0cq0lffpo
Pl2nbyQSxLDj1jxAs5t4XZJa7ersO/6tn73bUqFrSwWfLWdhIdQzdUQVc+4e8p6S
F6WB4rQAG1nTBCJkWsNAIgaXm+t5lA/F2vMhzmJNnXBq7K5OZeNfXiE38uN9utUZ
lk197t9h9Nyaz/S2jCwDk2mDUrk0OFR90dC8TxY6weLHrX+NOS/52mYo8bIiqg4P
rWBW2GVzRc4RiDQeCscRHko+OJoqiW5VQWM3BUccWZvtqv3W/UvgjRnPa1ACzw6Y
UQyU9Q5aGULHpt7l0mFB5IiFuo1ewcLEb4q5vtR8s0llU/e5cUqq2M7LlE7GEJdT
DhGQLVcpm1wXqrNytEfGZlcYCQsvRAXrcU0h1PIzEgrqJ8AlIUaD/qWO67c8FmrS
75ysNh4LLQaFX3w0FllsJDM/c4NPMirl5JcAG0vZVxDuTi8zRaQ=
=h2gc
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
