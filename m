Received: from eggs.gnu.org ([2001:4830:134:3::10]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXUai-0003Oe-DC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXUaf-0007Hc-0s
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:16:04 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:33797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gXUae-0007G8-Nf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:16:00 -0500
Received: by mail-vs1-f46.google.com with SMTP id y27so1651676vsi.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 09:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
In-Reply-To: <20181213104704.GD5171@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 13 Dec 2018 19:15:47 +0200
Message-ID: <CAMRbyysU7uykArYdOVkUWoi2+Lm63UCQSjHH3Svub8ydPBqJ_A@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 12:47 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
> > On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote:
> > >
> > > When a qemu-io command fails, it's best if the failure message
> > > goes to stderr rather than stdout.
> >
> > This makes sense, but it will break users like this:
> >
> >
> https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a81f0=
44/tests/storage/qemuio.py#L45
> >
> > We need a way to detect qemu-io verification failures, maybe a special
> > exit code?
> >
> > 0 - verification succeeded
> > 1 - verification failed
> > 2 - other error (e.g no such file)
>
> This makes sense. We should *never* expect applications to parse the
> messages on stdout/err, because we reserve the right to change text
> arbitrarily at any time. So we need to use exit status IMHO.
>
> > Or, if qemu-io had a way to read data and write it to stdout, we could
> > compare the data and avoid the need for special exit code.
>
> That should be trivial to do, and quite desirable too IMHO - libvirt woul=
d
> in fact quite like such a feature, as it would let us support format
> conversions when using our upload/download APIs, without having to create
> intermediate files.  Alternatively 'qemu-img convert' could allow for
> /dev/stdin and /dev/stdout as raw files, but that looks considerably
> harder to implement.
>
> For your usecase that feels rather inefficient as you're introducing
> multiple data copies, which will be bad for large images. Much better
> if we just make qemu-io set good exit codes.
>

We use qemu-io for testing changes to tiny images, so multiple copies are
fine.

Nir
