Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsqY2-0003lD-MK
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsqXv-0007qY-OH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:25:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsqXu-0007iJ-VB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:25:11 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com> (Manish
	Jaggi's message of "Thu, 23 Aug 2018 11:18:37 +0000")
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
Reply-To: quintela@redhat.com
Date: Thu, 23 Aug 2018 16:29:31 +0200
Message-ID: <87k1ohxik4.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

"Jaggi, Manish" <Manish.Jaggi@cavium.com> wrote:
> Hi,

Hi

[Note that I was confused about what do you mean with problems with
processorID.  There is no processorID on the migration stream, so I
didn't understood what you were talking about.  Until I realized that
you were trying to migrate from different cpu types]

> Posting again with my cavium ID and CCing relevant folks

It will be good to give What architecture are we talking about?  MIPS,
ARM, anything else?

Why?  Because we do this continously on x86_64 world.  How do we do
this?  We emulate the _processor_ capabilities, so "in general" you can
always migrate from a processor to another with a superset of the
features.  If you look at the ouput of:

     qemu-system-x86_64 -cpu ?

You can see that we have lots of cpu types that we emulate and cpuid
(features really).  Migration intel<->amd is tricky.  But from "intel
with less features" to "intel with more features" (or the same with AMD)
it is a common thing to do.  Once told that, it is a lot of work, simple
things like that processors run at different clock speeds imply that you
need to be careful during migration with timers and anything that
depends on frequencies.

I don't know enough about other architectures to know how to do it, or
how feasible is.

> Live Migration between machines with different processorIds
>
> VM Migration between machines with different processorId values throws
> error in qemu/kvm. Though this check is appropriate but is overkill where
> two machines are of same SoC/arch family and have same core/gic but
> delta could be in other parts of Soc which have no effect on VM
> operation.

Then you need to do the whole process of:

Lets call both processors A1 and A2.  You need to do the whole process
of:

a- defining cpu A1
b- make sure that when you run qemu/kvm on processor A2, the
   features/behaviours that the guest sees.  This is not trivial at
   all.
c- when migration comes, you can see that you need to adjust to whatever
   is the architecture of the destination.

> There could be two ways to address this issue by ignoring the
> comparison of processorIDs and so need feedback from the
> community on this.
>
> a) Maintain a whitelist in qemu:
>
> This will be a set of all processorIds which are compatible and migration=
 can
> happen between any of the machines with the Ids from this set. This set c=
an
> be statically built within qemu binary.

In general, I preffer whitelists over blacklists.

> b) Provide an extra option with migrate command
>
>    migrate tcp:<ip>:<port>:<dest_processor_id>
>
> This is to fake the src_processor_id as dest_processor_id, so the qemu ru=
nning
> on destination machine will not complain. The overhead with this approach=
 is
> that the destination machines Id need to be known beforehand.

Please, don't even think about this:
a- migration commands are architecture agnostic
b- in general it is _much_, _much_ easier to fix things on destination
   that on source.

> If there is some better way=E2=80=A6 please suggest.

Look at how it is done on x86_64.  But be aware that "doing it right"
takes a lot of work.  To give you one idea:
- upstream, i.e. qemu, "warantee" that migration of:
  qemu-X -M machine-type-X -> qemu-Y -M machine-type-X
  works when X < Y.

- downstream (i.e. redhat on my case, but I am sure that others also
  "suffer" this)  allow also:

  qemu-Y -M machine-type-X -> qemu-X -M machine-type-X (Y > X)

  in general it is a very complicated problem, so we limit _what_ you
  can do.  Basically we only support our machine-types, do a lot of
  testing, and are very careful when we add new features.  I.e. be
  preparred to do a lot of testing and a lot of fixing.

I am sorry to not be able to tell you that this is an easy problem.

Later, Juan.
