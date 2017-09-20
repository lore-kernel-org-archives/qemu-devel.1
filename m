Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duWs6-0005wp-Ox
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duWs2-0003TJ-RT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duWs2-0003PU-J6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:44:22 -0400
Date: Wed, 20 Sep 2017 12:44:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920044412.GS3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-2-git-send-email-peterx@redhat.com>
	<810ee791-fecd-c0b7-fefd-66a78c2de925@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <810ee791-fecd-c0b7-fefd-66a78c2de925@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 01/15] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 19, 2017 at 02:59:37PM -0500, Eric Blake wrote:
> On 09/14/2017 02:50 AM, Peter Xu wrote:
> > This is not a problem if we are only having one single loop thread li=
ke
> > before.  However, after per-monitor thread is introduced, this is not
> > true any more, and the race can happen.
> >=20
> > The race can be triggered with "make check -j8" sometimes:
> >=20
> >   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
> >   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
> >=20
> > This patch keeps the reference for the watch object when creating in
> > io_add_watch_poll(), so that the object will never be released in the
> > context main loop, especially when the context loop is running in
> > another standalone thread.  Meanwhile, when we want to remove the wat=
ch
> > object, we always first detach the watch object from its owner contex=
t,
> > then we continue with the cleanup.
> >=20
> > Without this patch, calling io_remove_watch_poll() in main loop threa=
d
> > is not thread-safe, since the other per-monitor thread may be modifyi=
ng
> > the watch object at the same time.
> >=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
>=20
> > +     * Let's blame the glib bug mentioned in commit 2b3167 (again) f=
or
>=20
> That 6-char commit id may become ambiguous soon (it's still rare to see
> ambiguity with an 8-char id, although I've seen it more in recent times
> than in the past; and git itself has moved from a 7-char default
> abbreviation length in the 2.0 days to what is now a 10-char default
> abbreviation in 2.13.5).

Thanks for noticing this.  I'll use 10 chars in next post.

--=20
Peter Xu
