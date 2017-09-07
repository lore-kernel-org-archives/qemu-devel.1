Received: from eggs.gnu.org ([2001:4830:134:3::10]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptjg-0006Q7-0v
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dptja-0004l6-LN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dptja-0004kX-Db
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:08:30 -0400
Date: Thu, 7 Sep 2017 11:08:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907100817.GI30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170829110357.GG3783@redhat.com> <20170906094846.GA2215@work-vm>
	<20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com> <20170907100402.GG2098@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907100402.GG2098@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Sep 07, 2017 at 11:04:02AM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > This does imply that you need a separate monitor I/O processing, =
from the
> > > > command execution thread, but I see no need for all commands to s=
uddenly
> > > > become async. Just allowing interleaved replies is sufficient fro=
m the
> > > > POV of the protocol definition. This interleaving is easy to hand=
le from
> > > > the client POV - just requires a unique 'serial' in the request b=
y the
> > > > client, that is copied into the reply by QEMU.
> > >=20
> > > OK, so for that we can just take Marc-Andr=C3=A9's syntax and call =
it 'id':
> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.ht=
ml
> > >=20
> > > then it's upto the caller to ensure those id's are unique.
> >=20
> > Libvirt has in fact generated a unique 'id' for every monitor command
> > since day 1 of supporting QMP.
> >=20
> > > I do worry about two things:
> > >   a) With this the caller doesn't really know which commands could =
be
> > >   in parallel - for example if we've got a recovery command that's
> > >   executed by this non-locking thread that's OK, we expect that
> > >   to be doable in parallel.  If in the future though we do
> > >   what you initially suggested and have a bunch of commands get
> > >   routed to the migration thread (say) then those would suddenly
> > >   operate in parallel with other commands that we're previously
> > >   synchronous.
> >=20
> > We could still have an opt-in for async commands. eg default to execu=
ting
> > all commands in the main thread, unless the client issues an explicit
> > "make it async" command, to switch to allowing the migration thread t=
o
> > process it async.
> >=20
> >  { "execute": "qmp_allow_async",
> >    "data": { "commands": [
> >        "migrate_cancel",
> >    ] } }
> >=20
> >=20
> >  { "return": { "commands": [
> >        "migrate_cancel",
> >    ] } }
> >=20
> > The server response contains the subset of commands from the request
> > for which async is supported.
> >=20
> > That gives good negotiation ability going forward as we incrementally
> > support async on more commands.
>=20
> Is that 'qmp_allow_async' a command purely to query whether a command
> is async or is it a wrapper to cause that command to be executed async?

The former.

It merely used by the client to tell QEMU that it wants the command(s)
listed to have async processing enabled. QEMU reports back which commands
it has actually enabled async for.

IOW, before executing this, everything is still processed synchronously,
even if QEMU has support for async. This ensures back compat as we enable
support for async per command. After executing this command, then future
usage of 'migrate_cancel' would be run async.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
