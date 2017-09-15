Received: from eggs.gnu.org ([2001:4830:134:3::10]:60490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsotU-00014p-5G
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsotQ-0004Om-S3
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dsotQ-0004OL-I1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:34:44 -0400
Date: Fri, 15 Sep 2017 12:34:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170915113428.GF13610@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914151911.GB7370@stefanha-x1.localdomain>
	<20170915035057.GM3617@pxdev.xzpeter.org>
	<20170915104926.GA14994@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915104926.GA14994@stefanha-x1.localdomain>
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
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 15, 2017 at 11:49:26AM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 15, 2017 at 11:50:57AM +0800, Peter Xu wrote:
> > On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=C3=A9 Lureau wr=
ote:
> > > > There should be a limit in the number of requests the thread can
> > > > queue. Before the patch, the limit was enforced by system socket
> > > > buffering I think. Now, should oob commands still be processed ev=
en if
> > > > the queue is full? If so, the thread can't be suspended.
> > >=20
> > > I agree.
> > >=20
> > > Memory usage must be bounded.  The number of requests is less impor=
tant
> > > than the amount of memory consumed by them.
> > >=20
> > > Existing QMP clients that send multiple QMP commands without waitin=
g for
> > > replies need to rethink their strategy because OOB commands cannot =
be
> > > processed if queued non-OOB commands consume too much memory.
> >=20
> > Thanks for pointing out this.  Yes the memory usage problem is valid,
> > as Markus pointed out as well in previous discussions (in "Flow
> > Control" section of that long reply).  Hopefully this series basicall=
y
> > can work from design prospective, then I'll add this flow control in
> > next version.
> >=20
> > Regarding to what we should do if the limit is reached: Markus
> > provided a few options, but the one I prefer most is that we don't
> > respond, but send an event showing that a command is dropped.
> > However, I would like it not queued, but a direct reply (after all,
> > it's an event, and we should not need to care much on ordering of it)=
.
> > Then we can get rid of the babysitting of those "to be failed"
> > requests asap, meanwhile we don't lose anything IMHO.
> >=20
> > I think I also missed at least a unit test for this new interface.
> > Again, I'll add it after the whole idea is proved solid.  Thanks,
>=20
> Another solution: the server reports available receive buffer space to
> the client.  The server only guarantees immediate OOB processing when
> the client stays within the receive buffer size.
>=20
> Clients wishing to take advantage of OOB must query the receive buffer
> size and make sure to leave enough room.

I don't think having to query it ahead of time is particularly nice,
and of course it is inherantly racy.

I would just have QEMU emit an event when it pausing processing of the
incoming commands due to a full queue.  If the event includes the ID
of the last queued command, the client will know which (if any) of
its outstanding commands are delayed. Another even can be sent when
it restarts reading.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
