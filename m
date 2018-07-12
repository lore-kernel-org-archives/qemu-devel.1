Received: from eggs.gnu.org ([2001:4830:134:3::10]:48895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fdcZW-0000PW-Ki
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fdcZT-0007Oi-Gu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fdcZT-0007OG-BL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:51 -0400
Date: Thu, 12 Jul 2018 22:27:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180712142745.GB11068@xz-mi>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-5-marcandre.lureau@redhat.com>
	<87wou0lhod.fsf@dusky.pond.sub.org>
	<CAJ+F1CK9gUGfLRimTTHVGep-KwwO7NPP4dTPXmYBEpKeapiqkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK9gUGfLRimTTHVGep-KwwO7NPP4dTPXmYBEpKeapiqkA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] Revert "qmp: isolate responses into
 io thread"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Thu, Jul 12, 2018 at 03:32:51PM +0200, Marc-Andr=C3=A9 Lureau wrote:

[...]

> >
> > However, Peter has argued for keeping the response queue:
> >
> >   For my own opinion, I'll see it a bit awkward (as I mentioned) to
> >   revert the response queue part.  Again, it's mostly working well
> >   there, we just fix things up when needed.  It's not really a big pa=
rt
> >   of code to maintain, and it still looks sane to me to have such an
> >   isolation so that we can have the dispatcher totally separate from =
the
> >   chardev IO path (I'd say if I design a QMP interface from scratch,
> >   I'll do that from the first day).  So I am not against reverting th=
at
> >   part at all, I just don't see much gain from that as well, especial=
ly
> >   if we want to make QMP more modular in the future.
> >
> > The argument worth considering here is "isolating the dispatcher from
> > the chardev IO path".  Opinions?
>=20
> Imho, this is extra unneeded work. The queue is necessary on the
> receive side, to dispatch between iothread and main loop, but there
> isn't such need for sending the response stream.
>=20
> Also, there is already a sending "buffer queue": it's "outbuf". To me,
> they are duplicating the response buffering, thus making things
> unnecessarily more complicated.

Yeah actually this reminded me about the fact that we are still using
unlimited buffer size for the out_buf.  IMHO we should make it a
limited size after 3.0, then AFAICT if without current qmp response
queue we'll need to introduce some similar thing to cache responses
then when the out_buf is full.

IMHO the response queue looks more like the correct place that we
should do the flow control, and the out_buf could be majorly used to
do the JSON->string convertion (so basically IMHO the out_buf
limitation should be the size of the maximum JSON object that we'll
have).

>=20
> If we needed, we could modify monitor_flush_locked() to add a sending
> watch only. This would have mostly the same effect as scheduling the
> bh for processing the qmp_responses queue. But since chardev sending
> is thread-safe, it's not a problem to save the watch handler switch,
> and try sending directly from the iothread.

Actually this worries me a bit on complexity - if we remove the
response queue then the response IO can be run either in main thread
or in iothread (e.g., after we add a watch).  For me, it's not really
as straightforward as we just only run IOs only in the iothread
always.  Again, we'd better do enough testings to make sure it's
always working well.  I just hope we can just avoid bothering with it.

>=20
> it's not critical, so we can delay this cleanup to 3.1. (I wish it
> would have been merged early during this cycle, like most of my
> pending series, but hey, we have more important things to do ;)

Fully agree on this.

Thanks!

--=20
Peter Xu
