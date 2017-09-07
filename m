Received: from eggs.gnu.org ([2001:4830:134:3::10]:58076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dprwh-0000SF-Bq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dprwd-0006zo-G9
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dprwd-0006yx-6w
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:13:51 -0400
Date: Thu, 7 Sep 2017 16:13:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170907081341.GA23040@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
	<20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906115428.GP15510@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
> On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > This does imply that you need a separate monitor I/O processing, fr=
om the
> > > command execution thread, but I see no need for all commands to sud=
denly
> > > become async. Just allowing interleaved replies is sufficient from =
the
> > > POV of the protocol definition. This interleaving is easy to handle=
 from
> > > the client POV - just requires a unique 'serial' in the request by =
the
> > > client, that is copied into the reply by QEMU.
> >=20
> > OK, so for that we can just take Marc-Andr=C3=A9's syntax and call it=
 'id':
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.html
> >=20
> > then it's upto the caller to ensure those id's are unique.
>=20
> Libvirt has in fact generated a unique 'id' for every monitor command
> since day 1 of supporting QMP.
>=20
> > I do worry about two things:
> >   a) With this the caller doesn't really know which commands could be
> >   in parallel - for example if we've got a recovery command that's
> >   executed by this non-locking thread that's OK, we expect that
> >   to be doable in parallel.  If in the future though we do
> >   what you initially suggested and have a bunch of commands get
> >   routed to the migration thread (say) then those would suddenly
> >   operate in parallel with other commands that we're previously
> >   synchronous.
>=20
> We could still have an opt-in for async commands. eg default to executi=
ng
> all commands in the main thread, unless the client issues an explicit
> "make it async" command, to switch to allowing the migration thread to
> process it async.
>=20
>  { "execute": "qmp_allow_async",
>    "data": { "commands": [
>        "migrate_cancel",
>    ] } }
>=20
>=20
>  { "return": { "commands": [
>        "migrate_cancel",
>    ] } }
>=20
> The server response contains the subset of commands from the request
> for which async is supported.
>=20
> That gives good negotiation ability going forward as we incrementally
> support async on more commands.

I think this goes back to the discussion on which design we'd like to
choose.  IMHO the whole async idea plus the per-command-id is indeed
cleaner and nicer, and I believe that can benefit not only libvirt,
but also other QMP users.  The problem is, I have no idea how long
it'll take to let us have such a feature - I believe that will include
QEMU and Libvirt to both support that.  And it'll be a pity if the
postcopy recovery cannot work only because we cannot guarantee a
stable monitor.

I'm curious whether there are other requirements (besides postcopy
recovery) that would want an always-alive monitor to run some
lock-free commands?  If there is, I'd be more inclined to first
provide a work-around solution like "-qmp-lockfree", and we can
provide a better solution afterwards until when the whole async QMP
work ready.

>=20
> >   b) I still worry how the various IO channels will behave on another
> >   thread.  But that's more a general feeling rather than anything
> >   specific.
>=20
> The only complexity will be around making sure the Chardev code uses
> the right GMainContext for any watches on the underlying QIOChannel,
> so that we poll() from the custom thread instead of the main thread.
> IOW, as long as all I/O is done from the single thread everything
> should work fine.
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

--=20
Peter Xu
