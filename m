Received: from eggs.gnu.org ([2001:4830:134:3::10]:42743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIcmg-0000WH-VV
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIcmZ-0007b3-OZ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:58:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gIcmW-0007XO-6k
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:58:49 -0400
Date: Fri, 2 Nov 2018 16:58:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181102165834.GD2387@work-vm>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181102165409.GF21191@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Nov 02, 2018 at 10:40:35AM +0100, Paolo Bonzini wrote:
> > On 02/11/2018 04:46, Liran Alon wrote:
> > >> On Thu, Nov1, 2018 at 09:45 AM, Jim Mattson <jmattson@google.com> =
wrote:
> > >=20
> > >>> On Thu, Nov 1, 2018 at 8:56 AM, Dr. David Alan Gilbert <dgilbert@=
redhat.com> wrote:
> > >=20
> > >>> So if I have matching host kernels it should always work?
> > >>> What happens if I upgrade the source kernel to increase it's maxi=
mum
> > >>> nested size, can I force it to keep things small for some VMs?
> > >=20
> > >> Any change to the format of the nested state should be gated by a
> > >> KVM_CAP set by userspace. (Unlike, say, how the
> > >> KVM_VCPUEVENT_VALID_SMM flag was added to the saved VCPU events st=
ate
> > >> in commit f077825a8758d.) KVM has traditionally been quite bad abo=
ut
> > >> maintaining backwards compatibility, but I hope the community is m=
ore
> > >> cognizant of the issues now.
> > >=20
> > >> As a cloud provider, one would only enable the new capability from
> > >> userspace once all hosts in the pool have a kernel that supports i=
t.
> > >> During the transition, the capability would not be enabled on the
> > >> hosts with a new kernel, and these hosts would continue to provide
> > >> nested state that could be consumed by hosts running the older ker=
nel.
> > >=20
> > > Hmm this makes sense.
> > >=20
> > > This means though that the patch I have submitted here isn't good e=
nough.
> > > My patch currently assumes that when it attempts to get nested stat=
e from KVM,
> > > QEMU should always set nested_state->size to max size supported by =
KVM as received
> > > from kvm_check_extension(s, KVM_CAP_NESTED_STATE);
> > > (See kvm_get_nested_state() introduced on my patch).
> > > This indeed won't allow migration from host with new KVM to host wi=
th old KVM if
> > > nested_state size was enlarged between these KVM versions.
> > > Which is obviously an issue.
> >=20
> > Actually I think this is okay, because unlike the "new" capability wa=
s
> > enabled, KVM would always reduce nested_state->size to a value that i=
s
> > compatible with current kernels.
> >=20
> > > But on second thought, I'm not sure that this is the right approach=
 as-well.
> > > We don't really want the used version of nested_state to be determi=
ned on kvm_init().
> > > * On source QEMU, we actually want to determine it when preparing f=
or migration based
> > > on to the support given by our destination host. If it's an old hos=
t, we would like to
> > > save an old version nested_state and if it's a new host, we will li=
ke to save our newest
> > > supported nested_state.
> >=20
> > No, that's wrong because it would lead to losing state.  If the sourc=
e
> > QEMU supports more state than the destination QEMU, and the current V=
M
> > state needs to transmit it for migration to be _correct_, then migrat=
ion
> > to that destination QEMU must fail.
> >=20
> > In particular, enabling the new KVM capability needs to be gated by a
> > new machine type and/or -cpu flag, if migration compatibility is need=
ed.
> >  (In particular, this is one reason why I haven't considered this ser=
ies
> > for 3.1.  Right now, migration of nested hypervisors is completely
> > busted but if we make it "almost" work, pre-3.1 machine types would n=
ot
> > ever be able to add support for KVM_CAP_EXCEPTION_PAYLOAD.  Therefore=
,
> > it's better for users if we wait for one release more, and add suppor=
t
> > for KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD at the same ti=
me).
> >=20
> > Personally, I would like to say that, starting from QEMU 3.2, enablin=
g
> > nested VMX requires a 4.20 kernel.  It's a bit bold, but I think it's=
 a
> > good way to keep some sanity.  Any opinions on that?
>=20
> We have usually followed a rule that new machine types must not
> affect runability of a VM on a host. IOW new machine types should
> not introduce dependancies on specific kernels, or hardware features
> such as CPU flags.
>=20
> Anything that requires a new kernel feature thus ought to be an
> opt-in config tunable on the CLI, separate from machine type
> choice.  Alternatively in this case, it could potentially be a
> migration parameter settable via QMP. QEMU on each side could
> advertize whether the migration parameter is available, and
> the mgmt app (which can see both sides of the migration) can
> then decide whether to enable it.

This is a little odd though since it relates to the
contents/size/consistency of the guest state directly.

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
