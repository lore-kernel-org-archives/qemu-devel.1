Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXRcL-0000OE-Gv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXRcH-0008L5-IE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:05:33 -0500
Date: Thu, 13 Dec 2018 15:05:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213140513.GD5427@linux.fritz.box>
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181213104704.GD5171@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 13.12.2018 um 11:47 hat Daniel P. Berrang=E9 geschrieben:
> On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
> > On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote=
:
> > >
> > > When a qemu-io command fails, it's best if the failure message
> > > goes to stderr rather than stdout.
> >=20
> > This makes sense, but it will break users like this:
> >=20
> > https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a=
81f044/tests/storage/qemuio.py#L45
> >=20
> > We need a way to detect qemu-io verification failures, maybe a specia=
l
> > exit code?
> >=20
> > 0 - verification succeeded
> > 1 - verification failed
> > 2 - other error (e.g no such file)
>=20
> This makes sense. We should *never* expect applications to parse the
> messages on stdout/err, because we reserve the right to change text
> arbitrarily at any time. So we need to use exit status IMHO.

qemu-io processes more than just a single command. What would the exit
code be if one of the commands succeeds, one gets an I/O error, and the
third one succeeds for I/O, but fails pattern verification?

The things is, qemu-io was never meant to be used by other
applications that need to process the results, it's a tool for testing
and debugging. If we had meant it to be used by other programs, we would
have given it a machine-friendly interface.

The machine-friendly interface to the QEMU block layer is qemu-nbd.

> > Or, if qemu-io had a way to read data and write it to stdout, we coul=
d
> > compare the data and avoid the need for special exit code.
>=20
> That should be trivial to do, and quite desirable too IMHO - libvirt wo=
uld
> in fact quite like such a feature, as it would let us support format
> conversions when using our upload/download APIs, without having to crea=
te
> intermediate files.  Alternatively 'qemu-img convert' could allow for
> /dev/stdin and /dev/stdout as raw files, but that looks considerably
> harder to implement.
>=20
> For your usecase that feels rather inefficient as you're introducing
> multiple data copies, which will be bad for large images. Much better
> if we just make qemu-io set good exit codes.

'read -v' produces a hex dump on stdout, but you still need to separate
it from the other output and then parse the hexdump.

The human interface of qemu-io is honestly just not the right tool for
the job, and adding one-off tweaks to make it a little bit less horrible
to use for machines isn't the right approach because it's still not a
proper machine protocol.

Kevin
