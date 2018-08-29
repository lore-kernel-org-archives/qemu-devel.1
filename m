Received: from eggs.gnu.org ([2001:4830:134:3::10]:42287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fv0LL-0003Az-Jv
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fv0LI-0006sR-8s
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:17:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fv0LI-0006sB-1o
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:17:04 -0400
Date: Wed, 29 Aug 2018 15:16:53 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Auger Eric <eric.auger@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Liguori <aliguori@us.ibm.com>

On Wed, Aug 29, 2018 at 12:40:08PM +0000, Jaggi, Manish wrote:
>=20
>=20
> > On 28-Aug-2018, at 10:57 PM, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
> >=20
> > External Email
> >=20
> > (Cc'ing in Eric, Drew, and Peter for ARM stuff)
> >=20
> Thanks,
> > * Jaggi, Manish (Manish.Jaggi@cavium.com) wrote:
> >>=20
> >>=20
> >>> On 23-Aug-2018, at 7:59 PM, Juan Quintela <quintela@redhat.com> wro=
te:
> >>>=20
> >>> External Email
> >>>=20
> >>> "Jaggi, Manish" <Manish.Jaggi@cavium.com> wrote:
> >>>> Hi,
> >>>=20
> >>> Hi
> >>>=20
> >>> [Note that I was confused about what do you mean with problems with
> >>> processorID.  There is no processorID on the migration stream, so I
> >>> didn't understood what you were talking about.  Until I realized th=
at
> >>> you were trying to migrate from different cpu types]
> >>>=20
> >>>> Posting again with my cavium ID and CCing relevant folks
> >>>=20
> >>> It will be good to give What architecture are we talking about?  MI=
PS,
> >>> ARM, anything else?
> >>>=20
> >> arm64
> >>=20
> >>> Why?  Because we do this continously on x86_64 world.  How do we do
> >>> this?  We emulate the _processor_ capabilities, so "in general" you=
 can
> >>> always migrate from a processor to another with a superset of the
> >>> features.  If you look at the ouput of:
> >>>=20
> >>>   qemu-system-x86_64 -cpu ?
> >>>=20
> >>> You can see that we have lots of cpu types that we emulate and cpui=
d
> >>> (features really).  Migration intel<->amd is tricky.  But from "int=
el
> >>> with less features" to "intel with more features" (or the same with=
 AMD)
> >>> it is a common thing to do.  Once told that, it is a lot of work, s=
imple
> >>> things like that processors run at different clock speeds imply tha=
t you
> >>> need to be careful during migration with timers and anything that
> >>> depends on frequencies.
> >>>=20
> >>> I don't know enough about other architectures to know how to do it,=
 or
> >>> how feasible is.
> >>=20
> >> For arm64 qemu/kvm throws an error when processorID does not match.
> >>>=20
> >>>> Live Migration between machines with different processorIds
> >>>>=20
> >>>> VM Migration between machines with different processorId values th=
rows
> >>>> error in qemu/kvm. Though this check is appropriate but is overkil=
l where
> >>>> two machines are of same SoC/arch family and have same core/gic bu=
t
> >>>> delta could be in other parts of Soc which have no effect on VM
> >>>> operation.
> >>>=20
> >>> Then you need to do the whole process of:
> >>>=20
> >>> Lets call both processors A1 and A2.  You need to do the whole proc=
ess
> >>> of:
> >>>=20
> >>> a- defining cpu A1
> >>> b- make sure that when you run qemu/kvm on processor A2, the
> >>> features/behaviours that the guest sees.  This is not trivial at
> >>> all.
> >>> c- when migration comes, you can see that you need to adjust to wha=
tever
> >>> is the architecture of the destination.
> >>>=20
> >>>> There could be two ways to address this issue by ignoring the
> >>>> comparison of processorIDs and so need feedback from the
> >>>> community on this.
> >>>>=20
> >>>> a) Maintain a whitelist in qemu:
> >>>>=20
> >>>> This will be a set of all processorIds which are compatible and mi=
gration can
> >>>> happen between any of the machines with the Ids from this set. Thi=
s set can
> >>>> be statically built within qemu binary.
> >>>=20
> >>> In general, I preffer whitelists over blacklists.
> >>>=20
> >>>> b) Provide an extra option with migrate command
> >>>>=20
> >>>> migrate tcp:<ip>:<port>:<dest_processor_id>
> >>>>=20
> >>>> This is to fake the src_processor_id as dest_processor_id, so the =
qemu running
> >>>> on destination machine will not complain. The overhead with this a=
pproach is
> >>>> that the destination machines Id need to be known beforehand.
> >>>=20
> >>> Please, don't even think about this:
> >>> a- migration commands are architecture agnostic
> >>> b- in general it is _much_, _much_ easier to fix things on destinat=
ion
> >>> that on source.
> >>>=20
> >>>> If there is some better way=E2=80=A6 please suggest.
> >>>=20
> >>> Look at how it is done on x86_64.  But be aware that "doing it righ=
t"
> >>> takes a lot of work.  To give you one idea:
> >>> - upstream, i.e. qemu, "warantee" that migration of:
> >>> qemu-X -M machine-type-X -> qemu-Y -M machine-type-X
> >>> works when X < Y.
> >>>=20
> >>> - downstream (i.e. redhat on my case, but I am sure that others als=
o
> >>> "suffer" this)  allow also:
> >>>=20
> >>> qemu-Y -M machine-type-X -> qemu-X -M machine-type-X (Y > X)
> >>>=20
> >>> in general it is a very complicated problem, so we limit _what_ you
> >>> can do.  Basically we only support our machine-types, do a lot of
> >>> testing, and are very careful when we add new features.  I.e. be
> >>> preparred to do a lot of testing and a lot of fixing.
> >>=20
> >> At this point I am targeting a simpler case where Machine A1 and A2 =
has a core from the same SoC family.
> >> For example Cavium ThunderX2 Core incremental versions which has ide=
ntical core and GIC and may have some errata fixes.

That may or may not be a simple case. What happens when the minor
revision that contains an erratum fix not only stops requiring a
guest kernel workaround to be used, but actually causes the guest
kernel to break when that workaround is attempted?

> >> In that case Y=3DX since migration only takes care of PV devices.
> >>=20
> >> In that case a whitelist could be an easier option?
> >>=20
> >> How to provide the whitelist to qemu in a platform agnostic way?
> >> - I will look into intel model as you have suggested, does intel kee=
ps a whitelist or masks off some bits of processorID
> >> How does intel does it
> >=20
> > Purely based on features rather than IDs.

x86 processors have a stable core, i.e. it's pretty rare to have an
erratum in a new processor that can't easily be dealt with by turning
off its corresponding feature, i.e. masking off some CPUID feature bits.
AArch64 processors have ID registers (similar to CPUID feature leaves),
so if there was an erratum in one of the features advertised by its ID
registers, then that erratum could be dealt with the same way. However,
AArch64 processors also have plenty of errata in their core. The only
way to detect when those errata require workarounds is by MIDR.

> >=20
> > If it's an Intel processor and it's got that set of CPU features
> > migration to it will normally work.
> > (There are some gotcha's that we hit from time to time, but
> > the basic idea holds)
> >=20
>=20
> Just to add what happens in ARM64 case, qemu running on Machine A sends=
 cpu state information to Machine B.
> This state contains MIDR value, and so Processor ID value is compared i=
n KVM and not in qemu (correcting myself).
>=20
> IIRC, Peter/Eric please point if there is something incorrect in the be=
low flow...
>=20
> (Machine B)
> target/arm/machine.c: cpu_post_load()
> 		- updates cpu->cpreg_values[i] : which includes MIDR (processor ID re=
gister)
>=20
> 		- calls write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)
>=20
> 				target/arm/kvm.c: write_list_to_kvmstate
> 				- calls =3D> kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
>=20
> 					=3D> and it eventually lands up IIRC in Linux code in=20
>=20
> 							=3D> arch/arm64/kvm/sys_regs.c : set_invariant_sys_reg(u64 id, v=
oid __user *uaddr)
> 							 	/* This is what we mean by invariant: you can't change it. */
> 								if (r->val !=3D val)
> 									return -EINVAL;
> 								Note: MIDR_EL1 is invariant register.
> result: Migration fails on Machine B.
>=20
> A few points:
> - qemu on arm64 is invoked with -machine virt and -cpu as host. So we d=
on't explicitly define which cpu.=20
>=20
> - In case Machine A and Machine B have almost same Core and the delta m=
ay-not have any effect on qemu operation, migration should work by just l=
ooking into whitelist.
> whitelist can be given as a parameter for qemu on machine B.
>=20
> qemu-system-aarch64 -whitelist <ids separated by commas>
>=20
> (This is my proposal)
>=20
> - So in cpu_post_load (Machine B) qemu can lookup whitelist and replace=
 the MIDR with the one at Machine B.=20
> Sounds good?

It shouldn't be necessary. With '-cpu host' QEMU should probably just rea=
d
all the ID registers from the host first, updating the guest's copy to
match the destination host's registers (we're using '-cpu host', the
registers should match the host - including MIDR.) If a user chooses to
migrate a guest that is using '-cpu host', then they need to know what
they are doing. If a whitelist of close-enough processors is possible to
create, then that whitelist should be managed and used at a higher layer
in the virt stack, not down in QEMU. For example, openstack can determine
destination candidates using whatever policy it wants, including a close-
enough processor whitelist.

So, I propose blindly updating all invariant registers when migrating
a '-cpu host' guest and leaving it to the user to do these migrations
at their own risk (when migrating to a truly identical host, the blind
update will not change anything. So it would be no worse than what we
do today.) One side note is that we're starting to give QEMU control
over what optional processor features are available to the guest, e.g.
SVE. So before blindly updating all ID registers we'd want to inform
KVM of the guest configuration in order for KVM to return appropriate
ID register values.

Thanks,
drew

>=20
> - Juan raised a point about clock speed, I am not sure it will have any=
 effect on arm since qemu is run with -cpu host param.
> I could be wrong here, Peter/Eric can you please correct me...
>=20
> -Thanks
> Manish
>=20
>=20
>=20
> > Dave
> >> - is providing a -mirate-compat-whitelist <file> option for arm only=
 looks good?
> >> this option can be added in A1/A2 qemu command, so it would be upstr=
eam / downstream agnostic.
> >=20
> >>>=20
> >>> I am sorry to not be able to tell you that this is an easy problem.
> >>>=20
> >>> Later, Juan.
> >>=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
