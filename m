Received: from eggs.gnu.org ([209.51.188.92]:51298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkUSD-0004ZP-Lq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkUSA-00087G-5Q
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:44:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkUS9-00085b-Tf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:44:58 -0500
Date: Fri, 18 Jan 2019 13:44:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118134451.GM20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Mark Mielke <mark.mielke@gmail.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On Fri, Jan 18, 2019 at 01:57:31PM +0100, Paolo Bonzini wrote:
> On 18/01/19 11:21, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Jan 18, 2019 at 10:16:34AM +0000, Dr. David Alan Gilbert wrot=
e:
> >> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >>> On 18/01/19 11:02, Dr. David Alan Gilbert wrote:
> >>>>>
> >>>>> It fails if the flag is set, rather than if any nested virtualiza=
tion has
> >>>>> been used before.
> >>>>>
> >>>>> I'm concerned I will end up with a requirement for *all* guests t=
o be
> >>>>> restarted in order to migrate them to the new hosts, rather than =
just the
> >>>>> ones that would have a problem.
> >>>> I think you should be able to migrate from 2.12->3.1 like this, bu=
t
> >>>> you'd hit the problem when you then try and migrate again between =
your
> >>>> new QEMUs.
> >>>>
> >>>> I guess we could modify it to wire it to machine type, so that
> >>>> older machine types didn't block.
> >>>
> >>> That would also be wrong.  The old machine types _could_ be using K=
VM
> >>> and they have no way to block the live migration.
> >>>
> >>> The solution is to restart the VM using "-cpu host,-vmx".
> >>
> >> The problem as Christian explained in that thread is that it was com=
mon
> >> for them to start VMs with vmx enabled but for people not to use it
> >> on most of the VMs, so we break migration for most VMs even though m=
ost
> >> don't use it.
> >>
> >> It might not be robust, but it worked for a lot of people most of th=
e
> >> time.
>=20
> It's not "not robust" (like, it usually works but sometimes fails
> mysteriously).  It's entirely broken, you just don't notice that it is
> if you're not using the feature.
>=20
> > Yes, this is exactly why I said we should make the migration blocker
> > be conditional on any L2 guest having been started. I vaguely recall
> > someone saying there wasn't any way to detect this situation from
> > QEMU though ?
>=20
> You can check that and give a warning (check that CR4.VMXE=3D1 but no
> other live migration state was transferred).  However, without live
> migration support in the kernel and in QEMU you cannot start VMs *for
> the entire future life of the VM* after a live migration.  So even if w=
e
> implemented that kind of blocker, it would fail even if no VM has been
> started, as long as the kvm_intel module is loaded on migration.  That
> would be no different in practice from what we have now.

Ahh, I was mis-understanding that it only applied to L2 VMs that
existed at the time the migration is performed. Given that it breaks
all future possibility of launching an L2 VM, this strict blocker does
make more sense.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
