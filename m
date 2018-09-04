Received: from eggs.gnu.org ([2001:4830:134:3::10]:48687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxDLo-0001wD-S6
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxDLn-00065K-Sg
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 11:34:44 -0400
Date: Tue, 4 Sep 2018 17:34:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180904153436.GC4371@localhost.localdomain>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
	<20180904150042.GE3803@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20180904150042.GE3803@andariel.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.09.2018 um 17:00 hat Peter Krempa geschrieben:
> On Tue, Sep 04, 2018 at 16:42:17 +0200, Alberto Garcia wrote:
> > On Tue 04 Sep 2018 04:17:30 PM CEST, Peter Krempa wrote:
> > >> >> libvirt-3-format is read-write and all other node names are
> > >> >> readonly in the above example.
> > >> >>=20
> > >> >> The same also happens when using filenames:
> > >> >>=20
> > >> >> {"execute":"block-commit",
> > >> >>  "arguments" : {"device":"libvirt-3-format",
> > >> >>                 "job-id":"libvirt-3-format",
> > >> >>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252=
",
> > >> >>                 "base":"/var/lib/libvirt/images/rhel7.3.148360592=
4",
> > >> >>                 "auto-finalize":true,
> > >> >>                 "auto-dismiss":false},
> > >> >>  "id":"libvirt-13"}
> > >> >>=20
> > >> >> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block =
node is read-only"}}
> > >> >
> > >> > I see what's happening here. So we have a graph like this:
> > >> >
> > >> >      guest device
> > >> >           |
> > >> >           v
> > >> >     overlay-format -------> backing-format
> > >> >     [read-only=3Doff]         [read-only=3Don]
> > >> >           |                        |
> > >> >           v                        v
> > >> >     overlay-proto           backing-proto
> > >> >     [read-only=3Doff]         [read-only=3Don]
> > >> >
> > >> > The difference between your -blockdev use and -drive is that you
> > >> > explicitly specify the read-only option for backing-proto (and you=
 use
> > >> > a separate -blockdev option anyway), so it doesn't just inherit it
> > >> > from backing-format.
> > >>=20
> > >> Are these format and protocol block devices opened with four separate
> > >> -blockdev parameters? Is that how libvirt does it?
> > >
> > > Yes. This goes along with the fact that for 'blockdev-create' you need
> > > to blockdev-add the file which you want to format, but the formatted
> > > file is not automatically added.
> > >
> > > If we'd use the approach where the protocol layer is opened as part of
> > > the format layer it would complicate the snapshot code where we need
> > > to add a file and then format it to qcow2. It would mean that we'd
> > > have to blockdev-add a file, format it via blockdev-create, then
> > > blockdev-del it and open it together with the format layer. Otherwise
> > > the disk hot-unplug code would be plain crazy.
> >=20
> > Do you need to add the protocol layer in order to format it, though? :-?
> >=20
> > (I'm just trying to understand how this works, I'm not too familiar with
> > blockdev-create)
> >=20
> > {'execute': 'blockdev-create',
> >  'arguments': {'job-id': 'job0',
> >                'options': {'driver': 'file',
> >                            'filename': 'test.qcow2',
> >                            'size': 0}}}
> > {'execute': 'job-dismiss', 'arguments': {'id': 'job0'}}
> >=20
> > {'execute': 'blockdev-create',
> >  'arguments': {'job-id': 'job1',
> >                'options': { 'driver': 'qcow2',
> >                             'size': 1048576,
> >                             'file': {'driver': 'file',
> >                                      'filename': 'test.qcow2'}}}}
> > {'execute': 'job-dismiss', 'arguments': {'id': 'job1'}}
>=20
> Honestly I've reused the existing approach and did not try without
> actually adding the protocol layer.
>=20
> I remember being told some time ago to specify both layers explicitly.
> Since it's not yet enabled in libvirt we theoretically could change to
> one -blockdev for format+protocol but in that case we need some kind
> of guarantee that every (even new) feature will work with it.
>=20
> Switching between those approaches once we enable it upstream will not
> be possible without adding a lot of compatibility code.

Yeah, I think specifying both layers explicitly is cleaner. This should
probably be solved some way inside QEMU.

The read-only option for the backend isn't that useful anyway. Maybe we
should do away with it, at least for its current purpose, and just rely
on write permissions taken by parents. We could then either silently
ignore (and deprecate) the read-only backend option or we could change
its semantics to mean "never allow a writer on this node".

Kevin

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbjqYMAAoJEH8JsnLIjy/W13kQAKdBwlFdxnNKwZQeoFfSJUW+
/0X8oXyDlneYbuH/SHtFwJrDNWHgiOTq5SJeKCQZKh2LTMn59rmsvo8Kp84czL2P
UOMxCtgHvt9lsw/miVXDgVkA4GVh+jploAc0n0UaPihsEEQLj0UquIXXdGsglV3A
hz/xJIoy7k5hnyI/4TkDsae08gd/VyvdDaU03PiRDmKc2F2D8bJT4rID8GTqghhI
/bMGXqaiVoa/y4LE29MzznWYum6XJp/BSnxIHpafOgz8s+E2U59uCcHpBTttAUcf
Og1E2ZpaZN1ngVH4b9m51RKR3Pn9Rju/ko0FY7w+qSi1nEeW8XP6ZYvil95lHwDC
g+q680dWpfiruovU9P5EcAApNhNKpXMvtPMNGKCfPIKHu0y/JDoHCmKg4bSg+mL3
/8ux28GERkrl4N7MV8PC+XDVqiFn2t5ivBQAHwZaamuL1zhHIz0gUUyS6Ba/+7Kb
exJDwJOGm6v6caaOJ+cpdQZasEGd3Hj99JOJX1ASiWxT426DF1GeuGOmZnbS3y1U
b4rGZd9QZu2eShiijRdZZ/F61GGyjNuEUYmegVif6Tj/tubUvY9vqaBCT5yZ63Ea
bGA39xnXZIrRUg4zWBtJCTNEvh73DE0cCQHQ2d79tzDOdTcN4MG5L7r4s9sVsg62
nh/gaMfVh82bDtdoIFnd
=hBcr
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
