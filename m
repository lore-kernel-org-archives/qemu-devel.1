Received: from eggs.gnu.org ([209.51.188.92]:55359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt4zW-0004Pq-VT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt4zU-0008E4-42
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:22:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gt4zT-0007zr-Sl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 01:22:52 -0500
Date: Mon, 11 Feb 2019 14:13:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190211061357.GD1011@xz-x1>
References: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
	<aa77e2fd-d6ac-52a5-0a00-f69c90c27ded@redhat.com>
	<41572c06-75f0-6dab-c544-6e6713824f48@redhat.com>
	<CAJ+F1CL12WZc=JAMdprozM9cTDBNESAbUG7MEigUSQkURBuowA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL12WZc=JAMdprozM9cTDBNESAbUG7MEigUSQkURBuowA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Segfaults in chardev due to races
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Feb 06, 2019 at 07:38:18PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 23, 2019 at 4:39 PM Max Reitz <mreitz@redhat.com> wrote:
> >
> > On 22.12.18 10:17, Paolo Bonzini wrote:
> > > On 21/12/18 23:31, Max Reitz wrote:
> > >> I suppose the issue is that QMP events are sent by one thread, and
> > >> client disconnects are handled by a different one.  So if a QMP ev=
ent is
> > >> sent while a client disconnects concurrently, races may occur; and=
 the
> > >> only protection against concurrent access appears to be the
> > >> chr_write_lock, which I don't think is enough.
> > >
> > > I think disconnection (tcp_chr_disconnect) has to take the
> > > chr_write_lock too.
> >
> > That seems to fix the issue for me (can also be reproduced by running
> > iotest 169 in parallel), but how should this be implemented?  I suppo=
se
> > tcp_chr_disconnect() can't really take the lock itself, because it's
> > called by tcp_chr_write() which is invoked with the lock held.
> >
> > Max
> >
>=20
> Is anybody fixing this? Paolo suggestion seems right in general, but
> not easy to implement correctly for all chardevs. (C isn't helping!)
>=20
> I think this can be treated as a regression from commit
> 8258292e18c39480b64eba9f3551ab772ce29b5d, OOB monitor is now enabled
> by default (on socket chardev).

So far I see that only TCP implemented chr_disconnect, does it mean
it's still doable?

I'm uncertain on whether the response queue idea could help too since
that idea is/was trying to keep all the chardev IO/control paths in
the same thread.  When you wanted (and managed) to remove the response
queue I was uncertain on things like this - because if with the
response queues we're still making the chardev work very like single
thread (we only offload some works that must be done in main thread,
and let the two threads talk only via req/response queues, protected
by mutexes).  Now we're doing it real multi-threading in many places.
So IMHO we either fix all multi-thread safety, or may we fall back?  I
don't know much on chardev enough to say what is required to prove
100% multithread safety just like when I was working on oob, that's
why I chose the response queue and tried to keep safe.  I'm unsure
whether that's still an alternative.

Thanks,

--=20
Peter Xu
