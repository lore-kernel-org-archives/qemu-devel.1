Received: from eggs.gnu.org ([2001:4830:134:3::10]:37090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXV2m-0003tR-Rj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXV2i-0007Fv-Mh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:45:04 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gXV2i-0007Ep-BP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:45:00 -0500
Received: by mail-vs1-f46.google.com with SMTP id x1so1676589vsc.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 09:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
	<20181213140513.GD5427@linux.fritz.box>
In-Reply-To: <20181213140513.GD5427@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 13 Dec 2018 19:44:47 +0200
Message-ID: <CAMRbyytod-tELpdzmgp_mzwut=AuH4J1JsQ93QiFqz9RORV28g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 4:05 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 13.12.2018 um 11:47 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
> > > On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote=
:
> > > >
> > > > When a qemu-io command fails, it's best if the failure message
> > > > goes to stderr rather than stdout.
> > >
> > > This makes sense, but it will break users like this:
> > >
> > >
> https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a81f0=
44/tests/storage/qemuio.py#L45
> > >
> > > We need a way to detect qemu-io verification failures, maybe a specia=
l
> > > exit code?
> > >
> > > 0 - verification succeeded
> > > 1 - verification failed
> > > 2 - other error (e.g no such file)
> >
> > This makes sense. We should *never* expect applications to parse the
> > messages on stdout/err, because we reserve the right to change text
> > arbitrarily at any time. So we need to use exit status IMHO.
>
> qemu-io processes more than just a single command. What would the exit
> code be if one of the commands succeeds, one gets an I/O error, and the
> third one succeeds for I/O, but fails pattern verification?
>
> The things is, qemu-io was never meant to be used by other
> applications that need to process the results, it's a tool for testing
> and debugging. If we had meant it to be used by other programs, we would
> have given it a machine-friendly interface.
>
> The machine-friendly interface to the QEMU block layer is qemu-nbd.
>

nbd is awesome, but much more complicated to use for testing. You need to:

1. start qemu-nbd
2. wait until it is ready
3. use nbd client (we have one now), or connect the qemu-nbd to /dev/ndbX,
which on
  Fedora 28 leaves stale /dev/nbdX devices after disconnection
  (I reported this few month ago here).
4. finally disconnect and wait until qemu-nbd terminates

qemu-io is so much easier to use, we need to make it more machine friendly.

> > Or, if qemu-io had a way to read data and write it to stdout, we could
> > > compare the data and avoid the need for special exit code.
> >
> > That should be trivial to do, and quite desirable too IMHO - libvirt
> would
> > in fact quite like such a feature, as it would let us support format
> > conversions when using our upload/download APIs, without having to crea=
te
> > intermediate files.  Alternatively 'qemu-img convert' could allow for
> > /dev/stdin and /dev/stdout as raw files, but that looks considerably
> > harder to implement.
> >
> > For your usecase that feels rather inefficient as you're introducing
> > multiple data copies, which will be bad for large images. Much better
> > if we just make qemu-io set good exit codes.
>
> 'read -v' produces a hex dump on stdout, but you still need to separate
> it from the other output and then parse the hexdump.
>

The hex dump is nice for interactive use, but not for automated tests,
unless
you test by comparing the output of the tool to previously recorded output
like
iotests do. We don't use tool output for testing, it is very fragile and
hard to
maintain.


> The human interface of qemu-io is honestly just not the right tool for
> the job, and adding one-off tweaks to make it a little bit less horrible
> to use for machines isn't the right approach because it's still not a
> proper machine protocol.
>

Add --output json?

Nir
