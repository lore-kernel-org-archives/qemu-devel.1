Received: from eggs.gnu.org ([2001:4830:134:3::10]:56721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cVcmf-0006nA-1F
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cVcmb-0004pH-QZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:27:37 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cVcmb-0004n9-IJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:27:33 -0500
Date: Mon, 23 Jan 2017 06:27:29 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170123105502.GH29186@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

Hi

----- Original Message -----
> On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
>=20
> CCing Jeff Cody and John Snow, who have been working on generalizing
> Block Job APIs to generic background jobs.  There is some overlap
> between async commands and background jobs.

If you say so :) Did I miss a proposal or a discussion for async qmp comman=
ds?

> > One of initial design goals of QMP was to have "asynchronous command
> > completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
> > goal was not fully achieved, and some broken bits left were removed
> > progressively until commit 65207c59d that removed async command
> > support.
> >=20
> > Note that qmp events are asynchronous messages, and must be handled
> > appropriately by the client: dispatch both reply and events after a
> > command is sent for example.
> >=20
> > The benefits of async commands that can be trade-off depending on the
> > requirements are:
> >=20
> > 1) allow the command handler to re-enter the main loop if the command
> > cannot be handled synchronously, or if it is long-lasting. This is
> > currently not possible and make some bugs such as rhbz#1230527 tricky
> > (see below) to solve.  Furthermore, many QMP commands do IO and could
> > be considered 'slow' and blocking today.
> >=20
> > 2) allow concurrent commands and events. This mainly implies hanlding
> > concurrency in qemu and out-of-order replies for the client. As noted
> > earlier, a good qmp client already has to handle dispatching of
> > received messages (reply and events).
> >=20
> > The traditional approach to solving the above in qemu is the following
> > scheme:
> > -> { "execute": "do-foo" }
> > <- { "return": {} }
> > <- { "event": "FOO_DONE" }
> >=20
> > It has several flaws:
> > - FOO_DONE event has no semantic link with do-foo in the qapi
> >   schema. It is not simple to generalize that pattern when writing
> >   qmp clients. It makes documentation and usage harder.
> > - the FOO_DONE event has no clear association with the command that
> >   triggered it: commands/events have to come up with additional
> >   specific association schemes (ids, path etc)
> > - FOO_DONE is broadcasted to all clients, but they may have no way to
> >   interprete it or interest in it, or worse it may conflict with their
> >   own commands.
> > - the arguably useless empty reply return
> >=20
> > For some cases, it makes sense to use that scheme, or a more complete
> > one: to have an "handler" associated with an on-going operation, that
> > can be queried, modified, cancelled etc (block jobs etc). Also, some
> > operations have a global side-effect, in which case that cmd+event
> > scheme is right, as all clients are listening for global events.
> >=20
> > However, for the simple case where a client want to perform a "local
> > context" operation (dump, query etc), QAPI can easily do better
> > without resorting to this pattern: it can send the reply when the
> > operation is done. That would make QAPI schema, usage and
> > documentation more obvious.
> >=20
> > The following series implements an async solution, by introducing a
> > context associated with a command, it can:
> > - defer the return
> > - return only to the caller (no broadcasted event)
>=20
> As long as replies/events have ids then clients can discard messages for
> ids they do not own. =20

There is no guarantee about id conflict between clients, the id is generate=
d by the client, usually with a simple increment. Although we could check f=
or id conflicts in qemu, I think it is unnecessary and costly (for both cli=
ent & server)

> Let's err on the side of broadcasting so that
> clients can receive events after reconnecting to the monitor.

Sorry, what do you mean?

> Is there a specific case where broadcasting causes problems?

Fortunately, it seems all events today are global state change events, and =
not command replies (otherwise we could have reply conflicts). It was sugge=
sted to me to use the do-foo/FOO_DONE pattern, but it is not suitable for a=
sync command replies (see flaws above).
