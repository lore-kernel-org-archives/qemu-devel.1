Received: from eggs.gnu.org ([2001:4830:134:3::10]:55988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRDRR-0002og-5M
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRDRM-00030m-W2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:12:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fRDRM-00030D-PZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:12:12 -0400
Date: Fri, 8 Jun 2018 17:11:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180608091154.GF7736@xz-mi>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
	<87a7s5snce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7s5snce.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 08, 2018 at 10:18:25AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Fri, Jun 08, 2018 at 12:42:35PM +0800, Peter Xu wrote:
> >> On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
> >> > Peter Xu <peterx@redhat.com> writes:
> >> >=20
> >> > > Previously we cleanup the queues when we got CLOSED event.  It w=
as used
> >> >=20
> >> > we clean up
> >> >=20
> >> > > to make sure we won't leftover replies/events of a old client to=
 a new
> >> >=20
> >> > we won't send leftover replies/events of an old client
> >> >=20
> >> > > client.  Now this patch postpones that until OPENED.
> >> >=20
> >> > What if OPENED never comes?
> >>=20
> >> Then we clean that up until destruction of the monitor.  IMHO it's
> >> fine, but I'm not sure whether that's an overall acceptable approach=
.
> >
> > I think this patch fixes the problem at the wrong level.  Marc-Andr=C3=
=A9's
> > fix seemed like a cleaner solution.

Actually I like Marc-Andre's solution too.

However I left a comment there, I'm not sure whether that's workable.
My feeling is that currently our chardev can't really work very nicely
when the chardev backend is composed by two different channels, say,
when IN and OUT are different fds underneath.

Btw, I just noticed that fd_chr_add_watch() will only add a watch to
the ioc_out object, I'm not sure why (see that we have both ioc_in and
ioc_out for fd chardev):

static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
{
    FDChardev *s =3D FD_CHARDEV(chr);
    return qio_channel_create_watch(s->ioc_out, cond);
}

(this is not related to current problem at all, it's a pure question;
 feel free to ignore)

>=20
> Is it the right solution?
>=20
> I proposed another one:
>=20
> [...]
> >> > Here's what I think we should do on such EOF:
> >> >=20
> >> > 1. Shut down input
> >> >=20
> >> >    Stop reading input.  If input has its own file descriptor (as o=
pposed
> >> >    to a read/write fd shared with output), close it.
> >> >=20
> >> > 2. Flush output
> >> >=20
> >> >    Continue to write output until the queue becomes empty or we ru=
n into
> >> >    an error (such as EPIPE, telling us the output's consumer went =
away).
> >> >    Works exactly as before, except we proceed to step 3 when the q=
ueue
>=20
> exactly as before EOF

Yeah this seems reasonable.

I did a quick test with below change and it fixes the problem too:

diff --git a/monitor.c b/monitor.c
index 5eb4630215..b76cab5022 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4366,6 +4366,8 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
+        /* Force flush all events */
+        monitor_qmp_bh_responder(NULL);
         monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);

(Though maybe I can do it a bit "prettier" when I post a formal
 patch... for example, only flush the response queue for that specific
 monitor)

Frankly speaking I think this might be an ideal fix as well.  For
example what if we are executing the dispatcher of a command when we
received the CLOSED event?  If so, the dispatcher will put the
response onto the response queue after the CLOSED event, and ideally
we'd better also deliver that to the filter_output process.

>=20
> >> >    becomes empty.
> >> >=20
> >> > 3. Shut down output
> >> >=20
> >> >    Close the output file descriptor.

For this one I don't know whether it'll be necessary.  That's managed
by chardev backends now, I think it now won't be closed until QEMU
quits (for our bash pipelne scenario).

Regards,

--=20
Peter Xu
