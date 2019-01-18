Received: from eggs.gnu.org ([209.51.188.92]:40100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkVRk-0007Xg-1E
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkVRY-00043O-MC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:48:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkVRS-0003uz-9c
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:48:18 -0500
Date: Fri, 18 Jan 2019 14:48:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118144809.GN20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
	<20190118134451.GM20660@redhat.com>
	<CALm7yL2g6a=3P_9ujmi_CbKXp8pisWfH1cD8hHMBhc7hf1aqUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALm7yL2g6a=3P_9ujmi_CbKXp8pisWfH1cD8hHMBhc7hf1aqUQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Mielke <mark.mielke@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 09:09:31AM -0500, Mark Mielke wrote:
> On Fri, Jan 18, 2019 at 8:44 AM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com>
> wrote:
>=20
> > On Fri, Jan 18, 2019 at 01:57:31PM +0100, Paolo Bonzini wrote:
> > > On 18/01/19 11:21, Daniel P. Berrang=C3=A9 wrote:
> > > > Yes, this is exactly why I said we should make the migration bloc=
ker
> > > > be conditional on any L2 guest having been started. I vaguely rec=
all
> > > > someone saying there wasn't any way to detect this situation from
> > > > QEMU though ?
> > > You can check that and give a warning (check that CR4.VMXE=3D1 but =
no
> > > other live migration state was transferred).  However, without live
> > > migration support in the kernel and in QEMU you cannot start VMs *f=
or
> > > the entire future life of the VM* after a live migration.  So even =
if we
> > > implemented that kind of blocker, it would fail even if no VM has b=
een
> > > started, as long as the kvm_intel module is loaded on migration.  T=
hat
> > > would be no different in practice from what we have now.
> > Ahh, I was mis-understanding that it only applied to L2 VMs that
> > existed at the time the migration is performed. Given that it breaks
> > all future possibility of launching an L2 VM, this strict blocker doe=
s
> > make more sense.
> >
>=20
> To explain my use case more fully:
>=20
> Right now all guests are on Linux 4.14.79+ hypervisors, with Qemu 2.12.=
1+.
>=20
> I understand the value of this feature, and I need to get all the guest=
s to
> Linux 4.19.16+ hypervisors, with Qemu 3.2 (once it is available).
>=20
> As documented, and as best as I can read from the source code and this
> mailing list, the recommended solution would be for me to upgrade Linux=
 and
> Qemu on existing hypervisors, and then restart the entire environment.
> After it comes up with the new kernel, and the new qemu, everything wil=
l be
> "correct".

The recommendation depends on whether you actually need to run L2 guests
or not.

For people who don't need L2 guests, the recommendation solution is to
simply disable the vmx flag in the guest CPU model and reboot the affecte=
d
L1 guests.

Only people who need to run L2 guests would need to upgrade the software
stack to get live migration working. That said there is a workaround I'll
mention below...

> The first stage will include introducing new Linux 4.19.16+ hypervisors=
,
> and migrating the guests to these machines carefully and opportunistica=
lly.
> Carefully means that machines that will use L2 guests will need to be
> restarted in discussion with the users(or their hypervisors avoided fro=
m
> this exercise), but most (80%+) of machines that will never launch an L=
2
> guest can migrate live with low risk (at least according to our experie=
nce
> to date). This will allow existing hypervisors to be freed up so that t=
hey
> too can be upgraded to Linux 4.19.16+.
>=20
> The second stage will include upgrading to Qemu 3.2 once it is availabl=
e
> and demonstrated to be stable for our use cases. However, I will need t=
o be
> able to live migrate most (80%+) systems from Qemu 2.12.1+ to Qemu 3.2.=
 We
> would again handle the machines with L2 guests with care.

L1 guests with running L2 guests can not be live migrated from 2.12 no ma=
tter
what as both running guests will fail, and the L1 guest will also be unab=
le
to launch any new guests.

You would need to boot a new L1 guest on a different host, then live migr=
ate
all the L2 guests to this new L1 guest. Since the L1 guest would presumab=
ly
then be empty there'd no longer be a need to live migrate the L1 guest, a=
nd
it can simply be powered off. IOW, this is pretty similar situation to
doing physical hardware replacement of virt hosts.

The serious pain point that I see is for people who have L1 guests which
have VMX enabled, but which were not, and will never be, used for running
L2 VMs. They can't live migrate thir L1 guests, so they'd need to restart
their application workloads which is very unpleasant.

I wonder if there's a case to be made to allow the QEMU migration blocker
to be overridden in this case. Libvirt has a VIR_MIGRATE_UNSAFE flag that
mgmt apps be set to tell libvirt to do the migration even if it believes
the config to be unsafe. Libvirt has some migration restrictions around
valid disk cache modes where this is used if libvirt made the wrong
decision. There's no way for us to plumb it into the QEMU migration block=
er
for VMX though, so it can't currently be used in this scenario

> If Qemu 3.2 will be ready sooner (weeks?), I would wait before migratio=
n,
> and combine the above two steps such the new hypervisors would have bot=
h
> Linux 4.19.16+ and Qemu 3.2. But, if Qemu 3.2 is months away, I would k=
eep
> it as two steps.

NB the next release will be 4.0, as we switched policy to increment the
major release number at the start of each year. QEMU follows a fixed
schedule of 3-releases a year, which gives 4 month gaps. So assuming no
slippage you can expect 4.0 in late April.

> To achieve this, I need a path to live migrate from Qemu 2.12.1+ with V=
MX
> bit set in the guest, to Qemu 3.2. Further complicating things is that =
we
> are using OpenStack, so options for tweaking flags on a case by case ba=
sis
> would be limited or non-existent.
>=20
> I'm totally fine with the understanding that any machine not restarted =
is
> still broken under Qemu 3.2, just as it was broken under Qemu 2.12. New
> machines will be correct, and the broken machines can be fixed
> opportunistically and in discussion with the users.
>=20
> And, we don't need a system-wide restart of the whole cluster to deploy
> Qemu 3.2.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
