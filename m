Received: from eggs.gnu.org ([2001:4830:134:3::10]:33910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXOWU-0003tx-E0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXOWT-0005qq-EA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:47:18 -0500
Date: Thu, 13 Dec 2018 10:47:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213104704.GD5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
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
To: Nir Soffer <nsoffer@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
> On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote:
> >
> > When a qemu-io command fails, it's best if the failure message
> > goes to stderr rather than stdout.
> 
> This makes sense, but it will break users like this:
> 
> https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a81f044/tests/storage/qemuio.py#L45
> 
> We need a way to detect qemu-io verification failures, maybe a special
> exit code?
> 
> 0 - verification succeeded
> 1 - verification failed
> 2 - other error (e.g no such file)

This makes sense. We should *never* expect applications to parse the
messages on stdout/err, because we reserve the right to change text
arbitrarily at any time. So we need to use exit status IMHO.

> Or, if qemu-io had a way to read data and write it to stdout, we could
> compare the data and avoid the need for special exit code.

That should be trivial to do, and quite desirable too IMHO - libvirt would
in fact quite like such a feature, as it would let us support format
conversions when using our upload/download APIs, without having to create
intermediate files.  Alternatively 'qemu-img convert' could allow for
/dev/stdin and /dev/stdout as raw files, but that looks considerably
harder to implement.

For your usecase that feels rather inefficient as you're introducing
multiple data copies, which will be bad for large images. Much better
if we just make qemu-io set good exit codes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
