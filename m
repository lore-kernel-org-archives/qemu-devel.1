Received: from eggs.gnu.org ([2001:4830:134:3::10]:56966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXS4j-0000Jr-CM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXS4f-0005bo-2a
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:34:53 -0500
Date: Thu, 13 Dec 2018 15:34:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213143434.GF5427@linux.fritz.box>
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
	<20181213140513.GD5427@linux.fritz.box>
	<675b2641-a082-eeba-7584-602c16c7c259@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <675b2641-a082-eeba-7584-602c16c7c259@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 13.12.2018 um 15:23 hat Eric Blake geschrieben:
> On 12/13/18 8:05 AM, Kevin Wolf wrote:
> > Am 13.12.2018 um 11:47 hat Daniel P. Berrang=E9 geschrieben:
> > > On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
> > > > On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> w=
rote:
> > > > >=20
> > > > > When a qemu-io command fails, it's best if the failure message
> > > > > goes to stderr rather than stdout.
> > > >=20
> > > > This makes sense, but it will break users like this:
> > > >=20
> > > > https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002=
161a81f044/tests/storage/qemuio.py#L45
> > > >=20
> > > > We need a way to detect qemu-io verification failures, maybe a sp=
ecial
> > > > exit code?
> > > >=20
> > > > 0 - verification succeeded
> > > > 1 - verification failed
> > > > 2 - other error (e.g no such file)
> > >=20
> > > This makes sense. We should *never* expect applications to parse th=
e
> > > messages on stdout/err, because we reserve the right to change text
> > > arbitrarily at any time. So we need to use exit status IMHO.
> >=20
> > qemu-io processes more than just a single command. What would the exi=
t
> > code be if one of the commands succeeds, one gets an I/O error, and t=
he
> > third one succeeds for I/O, but fails pattern verification?
> >=20
> > The things is, qemu-io was never meant to be used by other
> > applications that need to process the results, it's a tool for testin=
g
> > and debugging. If we had meant it to be used by other programs, we wo=
uld
> > have given it a machine-friendly interface.
> >=20
> > The machine-friendly interface to the QEMU block layer is qemu-nbd.
> >=20
> > > > Or, if qemu-io had a way to read data and write it to stdout, we =
could
> > > > compare the data and avoid the need for special exit code.
> > >=20
> > > That should be trivial to do, and quite desirable too IMHO - libvir=
t would
> > > in fact quite like such a feature, as it would let us support forma=
t
> > > conversions when using our upload/download APIs, without having to =
create
> > > intermediate files.  Alternatively 'qemu-img convert' could allow f=
or
> > > /dev/stdin and /dev/stdout as raw files, but that looks considerabl=
y
> > > harder to implement.
> > >=20
> > > For your usecase that feels rather inefficient as you're introducin=
g
> > > multiple data copies, which will be bad for large images. Much bett=
er
> > > if we just make qemu-io set good exit codes.
> >=20
> > 'read -v' produces a hex dump on stdout, but you still need to separa=
te
> > it from the other output and then parse the hexdump.
> >=20
> > The human interface of qemu-io is honestly just not the right tool fo=
r
> > the job, and adding one-off tweaks to make it a little bit less horri=
ble
> > to use for machines isn't the right approach because it's still not a
> > proper machine protocol.
>=20
> I actually agree with that sentiment - qemu-io is NOT a program where w=
e
> promise backwards compatibility (we're not going to break it without re=
ason,
> because we DO have to keep iotests running, but outside of iotests, we =
are
> less concerned if other uses break).
>=20
> But it DOES sound like teaching 'qemu-img convert' to optionally conver=
t
> only a subset of a file may be useful (I already tried once to make
> 'qemu-img dd' smarter, and the conclusion at the time is that it would =
be
> better to just make qemu-img dd be syntactic sugar for a full-featured
> qemu-img convert, which means making convert take an offset and range l=
imit
> to the source, as well as a separate offset into the destination, for e=
asily
> extracting portions of one file into portions of another).  And I also =
agree
> that qemu-nbd already has offset and range support.

Can't you actually already achieve this with --image-opts and a raw
filter that has the offset/size options set?

It's not as nice as with a separate option, but it should do the job.

Kevin
