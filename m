Received: from eggs.gnu.org ([2001:4830:134:3::10]:48701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dspOg-0000eX-8d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dspOc-0005b4-6C
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dspOb-0005af-Ty
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:06:58 -0400
Date: Fri, 15 Sep 2017 13:06:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170915120643.GN2170@work-vm>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914151911.GB7370@stefanha-x1.localdomain>
	<20170915035057.GM3617@pxdev.xzpeter.org>
	<20170915104926.GA14994@stefanha-x1.localdomain>
	<20170915113428.GF13610@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170915113428.GF13610@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Fri, Sep 15, 2017 at 11:49:26AM +0100, Stefan Hajnoczi wrote:
> > On Fri, Sep 15, 2017 at 11:50:57AM +0800, Peter Xu wrote:
> > > On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefan Hajnoczi wrote:
> > > > On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=E9 Lureau wro=
te:
> > > > > There should be a limit in the number of requests the thread ca=
n
> > > > > queue. Before the patch, the limit was enforced by system socke=
t
> > > > > buffering I think. Now, should oob commands still be processed =
even if
> > > > > the queue is full? If so, the thread can't be suspended.
> > > >=20
> > > > I agree.
> > > >=20
> > > > Memory usage must be bounded.  The number of requests is less imp=
ortant
> > > > than the amount of memory consumed by them.
> > > >=20
> > > > Existing QMP clients that send multiple QMP commands without wait=
ing for
> > > > replies need to rethink their strategy because OOB commands canno=
t be
> > > > processed if queued non-OOB commands consume too much memory.
> > >=20
> > > Thanks for pointing out this.  Yes the memory usage problem is vali=
d,
> > > as Markus pointed out as well in previous discussions (in "Flow
> > > Control" section of that long reply).  Hopefully this series basica=
lly
> > > can work from design prospective, then I'll add this flow control i=
n
> > > next version.
> > >=20
> > > Regarding to what we should do if the limit is reached: Markus
> > > provided a few options, but the one I prefer most is that we don't
> > > respond, but send an event showing that a command is dropped.
> > > However, I would like it not queued, but a direct reply (after all,
> > > it's an event, and we should not need to care much on ordering of i=
t).
> > > Then we can get rid of the babysitting of those "to be failed"
> > > requests asap, meanwhile we don't lose anything IMHO.
> > >=20
> > > I think I also missed at least a unit test for this new interface.
> > > Again, I'll add it after the whole idea is proved solid.  Thanks,
> >=20
> > Another solution: the server reports available receive buffer space t=
o
> > the client.  The server only guarantees immediate OOB processing when
> > the client stays within the receive buffer size.
> >=20
> > Clients wishing to take advantage of OOB must query the receive buffe=
r
> > size and make sure to leave enough room.
>=20
> I don't think having to query it ahead of time is particularly nice,
> and of course it is inherantly racy.
>=20
> I would just have QEMU emit an event when it pausing processing of the
> incoming commands due to a full queue.  If the event includes the ID
> of the last queued command, the client will know which (if any) of
> its outstanding commands are delayed. Another even can be sent when
> it restarts reading.

Hmm and now we're implementing flow control!

a) What exactly is the current semantics/buffer sizes?
b) When do clients send multiple QMP commands on one channel without
waiting for the response to the previous command?
c) Would one queue entry for each class of commands/channel work
  (Where a class of commands is currently 'normal' and 'oob')

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
