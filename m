Received: from eggs.gnu.org ([2001:4830:134:3::10]:60398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpt66-00076e-FM
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpt62-0003LH-LH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpt62-0003Kt-C4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:27:38 -0400
Date: Thu, 7 Sep 2017 10:27:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907092729.GD2098@work-vm>
References: <20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<20170907085526.GA30609@redhat.com> <20170907091946.GC2098@work-vm>
	<20170907092235.GC30609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170907092235.GC30609@redhat.com>
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
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Sep 07, 2017 at 10:19:47AM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Thu, Sep 07, 2017 at 04:13:41PM +0800, Peter Xu wrote:
> > > > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrot=
e:
> > > > > On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilber=
t wrote:
> > > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > > This does imply that you need a separate monitor I/O proces=
sing, from the
> > > > > > > command execution thread, but I see no need for all command=
s to suddenly
> > > > > > > become async. Just allowing interleaved replies is sufficie=
nt from the
> > > > > > > POV of the protocol definition. This interleaving is easy t=
o handle from
> > > > > > > the client POV - just requires a unique 'serial' in the req=
uest by the
> > > > > > > client, that is copied into the reply by QEMU.
> > > > > >=20
> > > > > > OK, so for that we can just take Marc-Andr=E9's syntax and ca=
ll it 'id':
> > > > > >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03=
634.html
> > > > > >=20
> > > > > > then it's upto the caller to ensure those id's are unique.
> > > > >=20
> > > > > Libvirt has in fact generated a unique 'id' for every monitor c=
ommand
> > > > > since day 1 of supporting QMP.
> > > > >=20
> > > > > > I do worry about two things:
> > > > > >   a) With this the caller doesn't really know which commands =
could be
> > > > > >   in parallel - for example if we've got a recovery command t=
hat's
> > > > > >   executed by this non-locking thread that's OK, we expect th=
at
> > > > > >   to be doable in parallel.  If in the future though we do
> > > > > >   what you initially suggested and have a bunch of commands g=
et
> > > > > >   routed to the migration thread (say) then those would sudde=
nly
> > > > > >   operate in parallel with other commands that we're previous=
ly
> > > > > >   synchronous.
> > > > >=20
> > > > > We could still have an opt-in for async commands. eg default to=
 executing
> > > > > all commands in the main thread, unless the client issues an ex=
plicit
> > > > > "make it async" command, to switch to allowing the migration th=
read to
> > > > > process it async.
> > > > >=20
> > > > >  { "execute": "qmp_allow_async",
> > > > >    "data": { "commands": [
> > > > >        "migrate_cancel",
> > > > >    ] } }
> > > > >=20
> > > > >=20
> > > > >  { "return": { "commands": [
> > > > >        "migrate_cancel",
> > > > >    ] } }
> > > > >=20
> > > > > The server response contains the subset of commands from the re=
quest
> > > > > for which async is supported.
> > > > >=20
> > > > > That gives good negotiation ability going forward as we increme=
ntally
> > > > > support async on more commands.
> > > >=20
> > > > I think this goes back to the discussion on which design we'd lik=
e to
> > > > choose.  IMHO the whole async idea plus the per-command-id is ind=
eed
> > > > cleaner and nicer, and I believe that can benefit not only libvir=
t,
> > > > but also other QMP users.  The problem is, I have no idea how lon=
g
> > > > it'll take to let us have such a feature - I believe that will in=
clude
> > > > QEMU and Libvirt to both support that.  And it'll be a pity if th=
e
> > > > postcopy recovery cannot work only because we cannot guarantee a
> > > > stable monitor.
> > >=20
> > > This is not a blocker for having postcopy recovery feature merged.
> > > It merely means that in a situation where the mainloop is blocked,
> > > then we can't recover, in other situations we'll be able to recover
> > > fine. Sure it would be nice to fix that problem too, but I don't
> > > see it as a block.
> >=20
> > It's probably OK to merge the recovery code before the monitor code;
> > but I don't think it's something you'd want to tell users about -
> > a 'postcopy recovery that only works rarely' isn't much use.
>=20
> I dunno. Compared to today where there's zero post-copy recovery,
> I think even an incremental improvement is useful. Its a choice
> between "your VM is dead" and "you've a 50/50 chance of life".

There's a chunk of people who wont use postcopy because they regard
it as dangerous; they need something that works in most cases before
they'll use it.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
