Received: from eggs.gnu.org ([2001:4830:134:3::10]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpt1Q-00031V-VL
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpt1L-00010c-UN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpt1L-00010B-LO
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:22:47 -0400
Date: Thu, 7 Sep 2017 10:22:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907092235.GC30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<20170907085526.GA30609@redhat.com> <20170907091946.GC2098@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907091946.GC2098@work-vm>
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

On Thu, Sep 07, 2017 at 10:19:47AM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Thu, Sep 07, 2017 at 04:13:41PM +0800, Peter Xu wrote:
> > > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
> > > > On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > This does imply that you need a separate monitor I/O processi=
ng, from the
> > > > > > command execution thread, but I see no need for all commands =
to suddenly
> > > > > > become async. Just allowing interleaved replies is sufficient=
 from the
> > > > > > POV of the protocol definition. This interleaving is easy to =
handle from
> > > > > > the client POV - just requires a unique 'serial' in the reque=
st by the
> > > > > > client, that is copied into the reply by QEMU.
> > > > >=20
> > > > > OK, so for that we can just take Marc-Andr=C3=A9's syntax and c=
all it 'id':
> > > > >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg0363=
4.html
> > > > >=20
> > > > > then it's upto the caller to ensure those id's are unique.
> > > >=20
> > > > Libvirt has in fact generated a unique 'id' for every monitor com=
mand
> > > > since day 1 of supporting QMP.
> > > >=20
> > > > > I do worry about two things:
> > > > >   a) With this the caller doesn't really know which commands co=
uld be
> > > > >   in parallel - for example if we've got a recovery command tha=
t's
> > > > >   executed by this non-locking thread that's OK, we expect that
> > > > >   to be doable in parallel.  If in the future though we do
> > > > >   what you initially suggested and have a bunch of commands get
> > > > >   routed to the migration thread (say) then those would suddenl=
y
> > > > >   operate in parallel with other commands that we're previously
> > > > >   synchronous.
> > > >=20
> > > > We could still have an opt-in for async commands. eg default to e=
xecuting
> > > > all commands in the main thread, unless the client issues an expl=
icit
> > > > "make it async" command, to switch to allowing the migration thre=
ad to
> > > > process it async.
> > > >=20
> > > >  { "execute": "qmp_allow_async",
> > > >    "data": { "commands": [
> > > >        "migrate_cancel",
> > > >    ] } }
> > > >=20
> > > >=20
> > > >  { "return": { "commands": [
> > > >        "migrate_cancel",
> > > >    ] } }
> > > >=20
> > > > The server response contains the subset of commands from the requ=
est
> > > > for which async is supported.
> > > >=20
> > > > That gives good negotiation ability going forward as we increment=
ally
> > > > support async on more commands.
> > >=20
> > > I think this goes back to the discussion on which design we'd like =
to
> > > choose.  IMHO the whole async idea plus the per-command-id is indee=
d
> > > cleaner and nicer, and I believe that can benefit not only libvirt,
> > > but also other QMP users.  The problem is, I have no idea how long
> > > it'll take to let us have such a feature - I believe that will incl=
ude
> > > QEMU and Libvirt to both support that.  And it'll be a pity if the
> > > postcopy recovery cannot work only because we cannot guarantee a
> > > stable monitor.
> >=20
> > This is not a blocker for having postcopy recovery feature merged.
> > It merely means that in a situation where the mainloop is blocked,
> > then we can't recover, in other situations we'll be able to recover
> > fine. Sure it would be nice to fix that problem too, but I don't
> > see it as a block.
>=20
> It's probably OK to merge the recovery code before the monitor code;
> but I don't think it's something you'd want to tell users about -
> a 'postcopy recovery that only works rarely' isn't much use.

I dunno. Compared to today where there's zero post-copy recovery,
I think even an incremental improvement is useful. Its a choice
between "your VM is dead" and "you've a 50/50 chance of life".


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
