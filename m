Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb2x5-00029z-4O
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb2x1-00081J-1V
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fb2x0-0007zy-T9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:01:30 -0400
Date: Thu, 5 Jul 2018 20:01:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180705120125.GB23001@xz-mi>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-5-peterx@redhat.com>
	<87woua9iay.fsf@dusky.pond.sub.org> <20180705094903.GA23001@xz-mi>
	<87sh4y7xcw.fsf@dusky.pond.sub.org>
	<CAJ+F1CL1r034g1eGNtiZE1birByMNvyJLwym8e3Jn058cbbnOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL1r034g1eGNtiZE1birByMNvyJLwym8e3Jn058cbbnOA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] monitor: move need_resume flag into
 monitor struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jul 05, 2018 at 01:32:46PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Jul 5, 2018 at 1:09 PM, Markus Armbruster <armbru@redhat.com> w=
rote:
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Thu, Jul 05, 2018 at 10:51:33AM +0200, Markus Armbruster wrote:
> >>> Peter Xu <peterx@redhat.com> writes:
> >>>
> >>> > It was put into the request object to show whether we'll need to =
resume
> >>> > the monitor after dispatching the command.  Now we move that into=
 the
> >>> > monitor struct so that it might be even used in other places in t=
he
> >>> > future, e.g., out-of-band message flow controls.
> >>> >
> >>> > One thing to mention is that there is no lock needed before when
> >>> > accessing the flag since the request object will always be owned =
by a
> >>> > single thread.  After we move it into monitor struct we need to p=
rotect
> >>> > that flag since it might be accessed by multiple threads now.  Re=
naming
> >>> > the qmp_queue_lock into qmp_lock to protect the flag as well.
> >>> >
> >>> > No functional change.
> >>> >
> >>> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >>>
> >>> Marc-Andr=C3=A9's "[PATCH v3 04/38] monitor: no need to save need_r=
esume" and
> >>> "[PATCH v3 05/38] monitor: further simplify previous patch" also me=
ss
> >>> with need_resume.  Marc-Andr=C3=A9, could you have a look at this p=
atch and
> >>> the next one?
> >>
> >> Sorry I should have looked at those before hand.  I think I must be
> >> waiting for another post to split the patches into two (after
> >> Marc-Andre poked me with that thread) but then I forgot about that.
> >>
> >> So now I suspect we'd better keep that flag since in the next patch
> >> the suspend operation can happen conditionally now.
> >
> > Could you two together figure out how to combine your work?  Would ta=
ke
> > me off this critical path...
> >
>=20
> With Peter patches, the monitor is also suspended when the queue of
> command is too long (when oob-enabled). Thus the variable now covers
> one of two different cases.
>=20
> My patches only covered the first case simplification (legacy /
> !oob-enabled suspend).
>=20
> The second case could probably use a similar simplification, looking
> at the queue length, but at this point I think I'd prefer to keep the
> variable for clarity and sanity state checking.

Thanks for confirming that.

Meanwhile, I'm not 100% sure whether the trick can be played again
here (e.g., resume when queue length is N-1 for either of the queue).
If without the flag, there should be a very tricky condition (when
both queues are with length N-1) that we might resume the monitor
twice while we should only do that once.

Regards,

--=20
Peter Xu
