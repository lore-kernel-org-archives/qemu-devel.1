Received: from eggs.gnu.org ([2001:4830:134:3::10]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dshep-0006C6-WF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dshem-0002wF-U6
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dshem-0002vw-Nm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:08 -0400
Date: Fri, 15 Sep 2017 11:50:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915035057.GM3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914151911.GB7370@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170914151911.GB7370@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > There should be a limit in the number of requests the thread can
> > queue. Before the patch, the limit was enforced by system socket
> > buffering I think. Now, should oob commands still be processed even i=
f
> > the queue is full? If so, the thread can't be suspended.
>=20
> I agree.
>=20
> Memory usage must be bounded.  The number of requests is less important
> than the amount of memory consumed by them.
>=20
> Existing QMP clients that send multiple QMP commands without waiting fo=
r
> replies need to rethink their strategy because OOB commands cannot be
> processed if queued non-OOB commands consume too much memory.

Thanks for pointing out this.  Yes the memory usage problem is valid,
as Markus pointed out as well in previous discussions (in "Flow
Control" section of that long reply).  Hopefully this series basically
can work from design prospective, then I'll add this flow control in
next version.

Regarding to what we should do if the limit is reached: Markus
provided a few options, but the one I prefer most is that we don't
respond, but send an event showing that a command is dropped.
However, I would like it not queued, but a direct reply (after all,
it's an event, and we should not need to care much on ordering of it).
Then we can get rid of the babysitting of those "to be failed"
requests asap, meanwhile we don't lose anything IMHO.

I think I also missed at least a unit test for this new interface.
Again, I'll add it after the whole idea is proved solid.  Thanks,

--=20
Peter Xu
