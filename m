Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dptue-0001OJ-OT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dptud-0001dU-E7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:19:56 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dptud-0001cw-4E
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:19:55 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f199so854373wme.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 03:19:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907091815.GB2098@work-vm>
References: <20170906094846.GA2215@work-vm> <20170906104603.GK15510@redhat.com>
	<20170906104850.GB2215@work-vm> <20170906105414.GL15510@redhat.com>
	<20170906105704.GC2215@work-vm> <20170906110629.GM15510@redhat.com>
	<20170906113157.GD2215@work-vm> <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<CAJSP0QUcfEtb2PWJH-zH8qBCUGk6i_8bBQwbZcF+G3QwjmZMbg@mail.gmail.com>
	<20170907091815.GB2098@work-vm>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Sep 2017 11:19:53 +0100
Message-ID: <CAJSP0QUJ3coQ_x-gycR010-1DE4zcqmFBD09_kEU1np-cHN65Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Peter Xu <peterx@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 7, 2017 at 10:18 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
>> On Thu, Sep 7, 2017 at 9:13 AM, Peter Xu <peterx@redhat.com> wrote:
>> > On Wed, Sep 06, 2017 at 12:54:28PM +0100, Daniel P. Berrange wrote:
>> >> On Wed, Sep 06, 2017 at 12:31:58PM +0100, Dr. David Alan Gilbert wrot=
e:
>> >> > * Daniel P. Berrange (berrange@redhat.com) wrote:
>> >> > > This does imply that you need a separate monitor I/O processing, =
from the
>> >> > > command execution thread, but I see no need for all commands to s=
uddenly
>> >> > > become async. Just allowing interleaved replies is sufficient fro=
m the
>> >> > > POV of the protocol definition. This interleaving is easy to hand=
le from
>> >> > > the client POV - just requires a unique 'serial' in the request b=
y the
>> >> > > client, that is copied into the reply by QEMU.
>> >> >
>> >> > OK, so for that we can just take Marc-Andr=C3=A9's syntax and call =
it 'id':
>> >> >   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03634.ht=
ml
>> >> >
>> >> > then it's upto the caller to ensure those id's are unique.
>> >>
>> >> Libvirt has in fact generated a unique 'id' for every monitor command
>> >> since day 1 of supporting QMP.
>> >>
>> >> > I do worry about two things:
>> >> >   a) With this the caller doesn't really know which commands could =
be
>> >> >   in parallel - for example if we've got a recovery command that's
>> >> >   executed by this non-locking thread that's OK, we expect that
>> >> >   to be doable in parallel.  If in the future though we do
>> >> >   what you initially suggested and have a bunch of commands get
>> >> >   routed to the migration thread (say) then those would suddenly
>> >> >   operate in parallel with other commands that we're previously
>> >> >   synchronous.
>> >>
>> >> We could still have an opt-in for async commands. eg default to execu=
ting
>> >> all commands in the main thread, unless the client issues an explicit
>> >> "make it async" command, to switch to allowing the migration thread t=
o
>> >> process it async.
>> >>
>> >>  { "execute": "qmp_allow_async",
>> >>    "data": { "commands": [
>> >>        "migrate_cancel",
>> >>    ] } }
>> >>
>> >>
>> >>  { "return": { "commands": [
>> >>        "migrate_cancel",
>> >>    ] } }
>> >>
>> >> The server response contains the subset of commands from the request
>> >> for which async is supported.
>> >>
>> >> That gives good negotiation ability going forward as we incrementally
>> >> support async on more commands.
>> >
>> > I think this goes back to the discussion on which design we'd like to
>> > choose.  IMHO the whole async idea plus the per-command-id is indeed
>> > cleaner and nicer, and I believe that can benefit not only libvirt,
>> > but also other QMP users.  The problem is, I have no idea how long
>> > it'll take to let us have such a feature - I believe that will include
>> > QEMU and Libvirt to both support that.  And it'll be a pity if the
>> > postcopy recovery cannot work only because we cannot guarantee a
>> > stable monitor.
>>
>> Please don't rush in a hack, they often introduce new bugs that we
>> have to support long-term when they are part of the QMP API.
>>
>> In your original email you mentioned "info cpus".  Have you considered
>> modifying this command so it does not sync the CPU?  I'm not sure
>> callers really need to sync the CPU, typically they just want to know
>> the vcpu numbers, thread IDs, and current state (halted, running,
>> etc).
>
> But it has the pc as well, so that's actual state.

In what circumstances is the pc useful?

If the client just wants the vcpu -> thread ID mapping, it doesn't
matter at all.

If the CPU is halted, then the PC is already accurate and
synchronization isn't a problem.

If the CPU is running, then an accurate PC is meaningless since it
will have changed the moment the monitor command completes.  We might
as well just keep a copy of the last PC when entering QEMU in a vcpu
thread.

So I think we can offer a perfectly useful PC value without syncing.

Stefan
