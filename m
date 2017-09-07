Received: from eggs.gnu.org ([2001:4830:134:3::10]:59181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpt43-0005E5-NM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpt3y-0001yT-HU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:25:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpt3y-0001yI-95
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:25:30 -0400
Date: Thu, 7 Sep 2017 10:25:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907092507.GD30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906094846.GA2215@work-vm> <20170906104603.GK15510@redhat.com>
	<20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<20170907091508.GA2098@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907091508.GA2098@work-vm>
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

On Thu, Sep 07, 2017 at 10:15:09AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
> > > On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > This does imply that you need a separate monitor I/O processing=
, from the
> > > > > command execution thread, but I see no need for all commands to=
 suddenly
> > > > > become async. Just allowing interleaved replies is sufficient f=
rom the
> > > > > POV of the protocol definition. This interleaving is easy to ha=
ndle from
> > > > > the client POV - just requires a unique 'serial' in the request=
 by the
> > > > > client, that is copied into the reply by QEMU.
> > > >=20
> > > > OK, so for that we can just take Marc-Andr=C3=A9's syntax and cal=
l it 'id':
> > > >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.=
html
> > > >=20
> > > > then it's upto the caller to ensure those id's are unique.
> > >=20
> > > Libvirt has in fact generated a unique 'id' for every monitor comma=
nd
> > > since day 1 of supporting QMP.
> > >=20
> > > > I do worry about two things:
> > > >   a) With this the caller doesn't really know which commands coul=
d be
> > > >   in parallel - for example if we've got a recovery command that'=
s
> > > >   executed by this non-locking thread that's OK, we expect that
> > > >   to be doable in parallel.  If in the future though we do
> > > >   what you initially suggested and have a bunch of commands get
> > > >   routed to the migration thread (say) then those would suddenly
> > > >   operate in parallel with other commands that we're previously
> > > >   synchronous.
> > >=20
> > > We could still have an opt-in for async commands. eg default to exe=
cuting
> > > all commands in the main thread, unless the client issues an explic=
it
> > > "make it async" command, to switch to allowing the migration thread=
 to
> > > process it async.
> > >=20
> > >  { "execute": "qmp_allow_async",
> > >    "data": { "commands": [
> > >        "migrate_cancel",
> > >    ] } }
> > >=20
> > >=20
> > >  { "return": { "commands": [
> > >        "migrate_cancel",
> > >    ] } }
> > >=20
> > > The server response contains the subset of commands from the reques=
t
> > > for which async is supported.
> > >=20
> > > That gives good negotiation ability going forward as we incremental=
ly
> > > support async on more commands.
> >=20
> > I think this goes back to the discussion on which design we'd like to
> > choose.  IMHO the whole async idea plus the per-command-id is indeed
> > cleaner and nicer, and I believe that can benefit not only libvirt,
> > but also other QMP users.  The problem is, I have no idea how long
> > it'll take to let us have such a feature - I believe that will includ=
e
> > QEMU and Libvirt to both support that.  And it'll be a pity if the
> > postcopy recovery cannot work only because we cannot guarantee a
> > stable monitor.
>=20
> libvirt will need changes for postcopy recovery however we do it;
> so we need to do it the way they want.
>=20
> I think Dan's suggestion isn't as hard as it initially sounded;  a firs=
t
> thing to try would be taking all the monitor IO into another thread
> and feeding all commands to the main thread for execution - that sounds
> like the hard part.
> (I'm not sure how multiple monitors interact for this).

Multiple monitors is probably not as hard as it sounds. No matter how
many monitors you have configured today, they'll all serviced by the
main loop so commands from each monitor are strictly serialized.

So if you moved I/O processing to a separate thread, and had a single
queue of commands to be executed by the main thread, you would still
have the exact same serialized processing across multiple monitors.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
