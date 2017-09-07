Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dptyw-0003Hc-JD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dptyt-0004AF-E0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dptyt-00049P-4y
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:24:19 -0400
Date: Thu, 7 Sep 2017 18:24:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170907102410.GD23040@pxdev.xzpeter.org>
References: <20170906104603.GK15510@redhat.com> <20170906104850.GB2215@work-vm>
	<20170906105414.GL15510@redhat.com> <20170906105704.GC2215@work-vm>
	<20170906110629.GM15510@redhat.com> <20170906113157.GD2215@work-vm>
	<20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<CAJSP0QUcfEtb2PWJH-zH8qBCUGk6i_8bBQwbZcF+G3QwjmZMbg@mail.gmail.com>
	<20170907091815.GB2098@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907091815.GB2098@work-vm>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 07, 2017 at 10:18:16AM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> > On Thu, Sep 7, 2017 at 9:13 AM, Peter Xu <peterx@redhat.com> wrote:
> > > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
> > >> On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert w=
rote:
> > >> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > >> > > This does imply that you need a separate monitor I/O processin=
g, from the
> > >> > > command execution thread, but I see no need for all commands t=
o suddenly
> > >> > > become async. Just allowing interleaved replies is sufficient =
from the
> > >> > > POV of the protocol definition. This interleaving is easy to h=
andle from
> > >> > > the client POV - just requires a unique 'serial' in the reques=
t by the
> > >> > > client, that is copied into the reply by QEMU.
> > >> >
> > >> > OK, so for that we can just take Marc-Andr=C3=A9's syntax and ca=
ll it 'id':
> > >> >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634=
.html
> > >> >
> > >> > then it's upto the caller to ensure those id's are unique.
> > >>
> > >> Libvirt has in fact generated a unique 'id' for every monitor comm=
and
> > >> since day 1 of supporting QMP.
> > >>
> > >> > I do worry about two things:
> > >> >   a) With this the caller doesn't really know which commands cou=
ld be
> > >> >   in parallel - for example if we've got a recovery command that=
's
> > >> >   executed by this non-locking thread that's OK, we expect that
> > >> >   to be doable in parallel.  If in the future though we do
> > >> >   what you initially suggested and have a bunch of commands get
> > >> >   routed to the migration thread (say) then those would suddenly
> > >> >   operate in parallel with other commands that we're previously
> > >> >   synchronous.
> > >>
> > >> We could still have an opt-in for async commands. eg default to ex=
ecuting
> > >> all commands in the main thread, unless the client issues an expli=
cit
> > >> "make it async" command, to switch to allowing the migration threa=
d to
> > >> process it async.
> > >>
> > >>  { "execute": "qmp_allow_async",
> > >>    "data": { "commands": [
> > >>        "migrate_cancel",
> > >>    ] } }
> > >>
> > >>
> > >>  { "return": { "commands": [
> > >>        "migrate_cancel",
> > >>    ] } }
> > >>
> > >> The server response contains the subset of commands from the reque=
st
> > >> for which async is supported.
> > >>
> > >> That gives good negotiation ability going forward as we incrementa=
lly
> > >> support async on more commands.
> > >
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
> > Please don't rush in a hack, they often introduce new bugs that we
> > have to support long-term when they are part of the QMP API.

Sorry, I wasn't meant to push anything.  I was trying to see what
would be the best way to go.

> >=20
> > In your original email you mentioned "info cpus".  Have you considere=
d
> > modifying this command so it does not sync the CPU?  I'm not sure
> > callers really need to sync the CPU, typically they just want to know
> > the vcpu numbers, thread IDs, and current state (halted, running,
> > etc).
>=20
> But it has the pc as well, so that's actual state.

Yes.  Even if we don't need to sync pc regs for this single "info
cpus" command, I do feel slightly awkward if we don't allow things
like syncing CPU to happen in any command.  IMHO we just need to make
sure these commands may block.

>=20
> Dave
>=20
> > The next step after that would be to audit other monitor commands for
> > unnecessary vcpu synchronization.

It's really hard to do this for every single command, at least to me.

Comparing to this, I think now I more prefer what Dan has suggested in
the other reply to have an extra way to request async commands while
keep the rest of commands compatible (though obviously I misunderstood
the email when I was writting up previous reply...).

Thanks,

--=20
Peter Xu
