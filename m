Received: from eggs.gnu.org ([2001:4830:134:3::10]:58474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fui2A-0005Kc-RU
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fuhmM-0000zB-N0
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:27:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fuhmM-0000vy-AM
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:27:46 -0400
Date: Tue, 28 Aug 2018 18:27:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180828172739.GA10175@work-vm>
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
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
Cc: Juan Quintela <quintela@redhat.com>, eric.auger@redhat.com, drjones@redhat.com, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Liguori <aliguori@us.ibm.com>

(Cc'ing in Eric, Drew, and Peter for ARM stuff)

* Jaggi, Manish (Manish.Jaggi@cavium.com) wrote:
>=20
>=20
> > On 23-Aug-2018, at 7:59 PM, Juan Quintela <quintela@redhat.com> wrote=
:
> >=20
> > External Email
> >=20
> > "Jaggi, Manish" <Manish.Jaggi@cavium.com> wrote:
> >> Hi,
> >=20
> > Hi
> >=20
> > [Note that I was confused about what do you mean with problems with
> > processorID.  There is no processorID on the migration stream, so I
> > didn't understood what you were talking about.  Until I realized that
> > you were trying to migrate from different cpu types]
> >=20
> >> Posting again with my cavium ID and CCing relevant folks
> >=20
> > It will be good to give What architecture are we talking about?  MIPS=
,
> > ARM, anything else?
> >=20
> arm64
>=20
> > Why?  Because we do this continously on x86_64 world.  How do we do
> > this?  We emulate the _processor_ capabilities, so "in general" you c=
an
> > always migrate from a processor to another with a superset of the
> > features.  If you look at the ouput of:
> >=20
> >    qemu-system-x86_64 -cpu ?
> >=20
> > You can see that we have lots of cpu types that we emulate and cpuid
> > (features really).  Migration intel<->amd is tricky.  But from "intel
> > with less features" to "intel with more features" (or the same with A=
MD)
> > it is a common thing to do.  Once told that, it is a lot of work, sim=
ple
> > things like that processors run at different clock speeds imply that =
you
> > need to be careful during migration with timers and anything that
> > depends on frequencies.
> >=20
> > I don't know enough about other architectures to know how to do it, o=
r
> > how feasible is.
>=20
> For arm64 qemu/kvm throws an error when processorID does not match.=20
> >=20
> >> Live Migration between machines with different processorIds
> >>=20
> >> VM Migration between machines with different processorId values thro=
ws
> >> error in qemu/kvm. Though this check is appropriate but is overkill =
where
> >> two machines are of same SoC/arch family and have same core/gic but
> >> delta could be in other parts of Soc which have no effect on VM
> >> operation.
> >=20
> > Then you need to do the whole process of:
> >=20
> > Lets call both processors A1 and A2.  You need to do the whole proces=
s
> > of:
> >=20
> > a- defining cpu A1
> > b- make sure that when you run qemu/kvm on processor A2, the
> >  features/behaviours that the guest sees.  This is not trivial at
> >  all.
> > c- when migration comes, you can see that you need to adjust to whate=
ver
> >  is the architecture of the destination.
> >=20
> >> There could be two ways to address this issue by ignoring the
> >> comparison of processorIDs and so need feedback from the
> >> community on this.
> >>=20
> >> a) Maintain a whitelist in qemu:
> >>=20
> >> This will be a set of all processorIds which are compatible and migr=
ation can
> >> happen between any of the machines with the Ids from this set. This =
set can
> >> be statically built within qemu binary.
> >=20
> > In general, I preffer whitelists over blacklists.
> >=20
> >> b) Provide an extra option with migrate command
> >>=20
> >>  migrate tcp:<ip>:<port>:<dest_processor_id>
> >>=20
> >> This is to fake the src_processor_id as dest_processor_id, so the qe=
mu running
> >> on destination machine will not complain. The overhead with this app=
roach is
> >> that the destination machines Id need to be known beforehand.
> >=20
> > Please, don't even think about this:
> > a- migration commands are architecture agnostic
> > b- in general it is _much_, _much_ easier to fix things on destinatio=
n
> >  that on source.
> >=20
> >> If there is some better way=E2=80=A6 please suggest.
> >=20
> > Look at how it is done on x86_64.  But be aware that "doing it right"
> > takes a lot of work.  To give you one idea:
> > - upstream, i.e. qemu, "warantee" that migration of:
> > qemu-X -M machine-type-X -> qemu-Y -M machine-type-X
> > works when X < Y.
> >=20
> > - downstream (i.e. redhat on my case, but I am sure that others also
> > "suffer" this)  allow also:
> >=20
> > qemu-Y -M machine-type-X -> qemu-X -M machine-type-X (Y > X)
> >=20
> > in general it is a very complicated problem, so we limit _what_ you
> > can do.  Basically we only support our machine-types, do a lot of
> > testing, and are very careful when we add new features.  I.e. be
> > preparred to do a lot of testing and a lot of fixing.
>=20
> At this point I am targeting a simpler case where Machine A1 and A2 has=
 a core from the same SoC family.
> For example Cavium ThunderX2 Core incremental versions which has identi=
cal core and GIC and may have some errata fixes.
> In that case Y=3DX since migration only takes care of PV devices.
>=20
> In that case a whitelist could be an easier option?
>=20
> How to provide the whitelist to qemu in a platform agnostic way?
> - I will look into intel model as you have suggested, does intel keeps =
a whitelist or masks off some bits of processorID
> How does intel does it

Purely based on features rather than IDs.

If it's an Intel processor and it's got that set of CPU features
migration to it will normally work.
(There are some gotcha's that we hit from time to time, but
the basic idea holds)

Dave
> - is providing a -mirate-compat-whitelist <file> option for arm only lo=
oks good?
> this option can be added in A1/A2 qemu command, so it would be upstream=
 / downstream agnostic.

> >=20
> > I am sorry to not be able to tell you that this is an easy problem.
> >=20
> > Later, Juan.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
