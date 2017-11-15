Received: from eggs.gnu.org ([2001:4830:134:3::10]:43482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEuJ5-0003E9-IO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eEuJ1-000064-7L
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:48:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eEuJ0-0008Vz-Tj
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:48:27 -0500
Date: Wed, 15 Nov 2017 17:48:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171115094810.GA30426@xz-mi>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-2-peterx@redhat.com>
	<20171113165211.GG27765@stefanha-x1.localdomain>
	<20171114060939.GC6821@xz-mi>
	<20171114103219.GC13015@stefanha-x1.localdomain>
	<20171114113110.GD6821@xz-mi>
	<20171115093740.GB8130@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171115093740.GB8130@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 01/27] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Nov 15, 2017 at 09:37:40AM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 14, 2017 at 07:31:10PM +0800, Peter Xu wrote:
> > On Tue, Nov 14, 2017 at 10:32:19AM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Nov 14, 2017 at 02:09:39PM +0800, Peter Xu wrote:
> > > > On Mon, Nov 13, 2017 at 04:52:11PM +0000, Stefan Hajnoczi wrote:
> > > > > On Mon, Nov 06, 2017 at 05:46:17PM +0800, Peter Xu wrote:
> > > > > > This is not a problem if we are only having one single loop t=
hread like
> > > > > > before.  However, after per-monitor thread is introduced, thi=
s is not
> > > > > > true any more, and the race can happen.
> > > > > >=20
> > > > > > The race can be triggered with "make check -j8" sometimes:
> > > > >=20
> > > > > Please mention a specific test case that fails.
> > > >=20
> > > > It was any of the check-qtest-$(TARGET)s that failed.  I'll menti=
on
> > > > that in next post.
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > >   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
> > > > > >   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' fa=
iled.
> > > > > >=20
> > > > > > This patch keeps the reference for the watch object when crea=
ting in
> > > > > > io_add_watch_poll(), so that the object will never be release=
d in the
> > > > > > context main loop, especially when the context loop is runnin=
g in
> > > > > > another standalone thread.  Meanwhile, when we want to remove=
 the watch
> > > > > > object, we always first detach the watch object from its owne=
r context,
> > > > > > then we continue with the cleanup.
> > > > > >=20
> > > > > > Without this patch, calling io_remove_watch_poll() in main lo=
op thread
> > > > > > is not thread-safe, since the other per-monitor thread may be=
 modifying
> > > > > > the watch object at the same time.
> > > > > >=20
> > > > > > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >  chardev/char-io.c | 16 ++++++++++++++--
> > > > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/chardev/char-io.c b/chardev/char-io.c
> > > > > > index f81052481a..50b5bac704 100644
> > > > > > --- a/chardev/char-io.c
> > > > > > +++ b/chardev/char-io.c
> > > > > > @@ -122,7 +122,6 @@ GSource *io_add_watch_poll(Chardev *chr,
> > > > > >      g_free(name);
> > > > > > =20
> > > > > >      g_source_attach(&iwp->parent, context);
> > > > > > -    g_source_unref(&iwp->parent);
> > > > > >      return (GSource *)iwp;
> > > > > >  }
> > > > > > =20
> > > > > > @@ -131,12 +130,25 @@ static void io_remove_watch_poll(GSourc=
e *source)
> > > > > >      IOWatchPoll *iwp;
> > > > > > =20
> > > > > >      iwp =3D io_watch_poll_from_source(source);
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Here the order of destruction really matters.  We nee=
d to first
> > > > > > +     * detach the IOWatchPoll object from the context (which=
 may still
> > > > > > +     * be running in another loop thread), only after that c=
ould we
> > > > > > +     * continue to operate on iwp->src, or there may be race=
 condition
> > > > > > +     * between current thread and the context loop thread.
> > > > > > +     *
> > > > > > +     * Let's blame the glib bug mentioned in commit 2b316774=
f6
> > > > > > +     * ("qemu-char: do not operate on sources from finalize
> > > > > > +     * callbacks") for this extra complexity.
> > > > >=20
> > > > > I don't understand how this bug is to blame.  Isn't the problem=
 here a
> > > > > race condition between two QEMU threads?
> > > >=20
> > > > Yes, it is.
> > > >=20
> > > > The problem is, we won't have the race condition if glib does not=
 have
> > > > that bug mentioned.  Then the thread running GMainContext will ha=
ve
> > > > full control of iwp->src destruction, and destruction of it would=
 be
> > > > fairly straightforward (unref iwp->src in IOWatchPoll destructor)=
.
> > > > Now IIUC we are doing this in a hacky way, say, we destroy iwp->s=
rc
> > > > explicitly from main thread before quitting (see [1] below, the w=
hole
> > > > if clause).
> > > >=20
> > > > >=20
> > > > > Why are two threads accessing the watch at the same time?
> > > >=20
> > > > Here is how I understand:
> > > >=20
> > > > Firstly we need to tackle with that bug, by an explicit destructi=
on of
> > > > iwp->src below; meanwhile when we are destroying it, the GMainCon=
text
> > > > can still be running somewhere (it's not happening in current ser=
ies
> > > > since I stopped iothread earlier than this point, however it can =
still
> > > > happen if in the future we don't do that), then we possibly want =
this
> > > > patch.
> > > >=20
> > > > Again, without this patch, current series should work; however I =
do
> > > > hope this patch can be in, in case someday we want to provide com=
plete
> > > > thread safety for Chardevs (now it is not really thread-safe).
> > >=20
> > > You said qtests fail with "Assertion `iwp->src =3D=3D NULL' failed"=
 but then
> > > you said "without this patch, current series should work".  How do =
you
> > > reproduce the failure if it doesn't occur?
> >=20
> > Actually it occurs in some old versions, but not in current version.
> > Current version destroys the iothread earlier (as Dan suggested), so
> > it can avoid the issue.  Sorry for not being clear.
> >=20
> > >=20
> > > It looks like remove_fd_in_watch() -> io_remove_watch_poll() caller=
s
> > > fall into two categories: called from within the event loop and cal=
led
> > > when a chardev is destroyed.  Do the thread-safety issues occur whe=
n the
> > > chardev is destroyed by the QEMU main loop thread?  Or did I miss c=
ases
> > > where remove_fd_in_watch() is called from other threads?
> >=20
> > I think this can also be called in monitor iothread?
>=20
> When I say "event loop", I mean any thread that is running an event loo=
p
> including IOThreads and the main loop thread.
>=20
> What do you mean by "monitor iothread"?

Ah, I see.  Yes, then I think it's true - the failure only happens
when remove_fd_in_watch() is called during destruction in main loop
thread.

>=20
> > Even if so, it's
> > pretty safe since if the monitor iothread is calling
> > remove_fd_in_watch() then it must not be using it after all.  The rac=
e
> > can happen when we are destroying the IOWatchPoll while the other
> > event loop thread (which may not be the main thread) is still running=
,
> > just like what I did in my old series.
>=20
> The scenario this patch is trying to address doesn't make a lot of sens=
e
> since there will be further thread-safety problems if two threads are
> modifying a Chardev at the same time.  A lock will probably be required
> to protect the state and this patch might not be necessary then.
>=20
> This patch seems very speculative and it's unclear what concrete
> scenario it addresses.  I suggest dropping the patch from this series s=
o
> it is not a distraction from what you're actually trying to achieve.

Ok, then let me drop it.  Thanks,

--=20
Peter Xu
