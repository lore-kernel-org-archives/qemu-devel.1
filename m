Received: from eggs.gnu.org ([2001:4830:134:3::10]:46071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gICko-0003fQ-Gb
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gICkj-000252-2x
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gICke-0001u8-J2
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:11:11 -0400
Date: Thu, 1 Nov 2018 13:10:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181101131059.GB2726@work-vm>
References: <20180916124631.39016-1-liran.alon@oracle.com>
	<EFF8C049-EE78-4035-A38E-6A91EA219878@oracle.com>
	<80DAB33E-A982-4903-AEBA-F71AB2E8AFC3@oracle.com>
	<5F34DE35-D1EE-441A-87A1-379C7A04AFE7@oracle.com>
	<20181031181759.GR3902@habkost.net>
	<a5b6cdf7-6ff9-7bd8-d591-3e2669b4f802@redhat.com>
	<B34C4E8C-748D-4D78-807F-3F51C80EA5B2@oracle.com>
	<20181031185930.GC2403@work-vm>
	<5FA867F7-3520-4903-BC2F-B55227A04FED@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5FA867F7-3520-4903-BC2F-B55227A04FED@oracle.com>
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
To: Liran Alon <liran.alon@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, jmattson@google.com

* Liran Alon (liran.alon@oracle.com) wrote:
>=20
>=20
> > On 31 Oct 2018, at 20:59, Dr. David Alan Gilbert <dgilbert@redhat.com=
> wrote:
> >=20
> > * Liran Alon (liran.alon@oracle.com) wrote:
> >>=20
> >>=20
> >>> On 31 Oct 2018, at 20:19, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >>>=20
> >>> On 31/10/2018 19:17, Eduardo Habkost wrote:
> >>>> On Wed, Oct 31, 2018 at 03:03:34AM +0200, Liran Alon wrote:
> >>>>> Ping.
> >>>>> Patch was submitted almost two months ago and I haven=E2=80=99t s=
een any respond for the v2 of this series.
> >>>> Sorry for the long delay.  This was on my queue of patches to be
> >>>> reviewed, but I'm failing to keep up to the rate of incoming
> >>>> patches.  I will try to review the series next week.
> >>>=20
> >>> I have already reviewed it; unfortunately I have missed the soft fr=
eeze
> >>> for posting the version I had also been working on when Liran poste=
d
> >>> these patches.
> >>>=20
> >>> Paolo
> >>=20
> >> Paolo, note that this is v2 of this patch series. It=E2=80=99s not t=
he one you have already reviewed.
> >> It now correctly handles the case you mentioned in review of v1 of m=
igrating with various nested_state buffer sizes.
> >> The following scenarios were tested:
> >> (a) src and dest have same nested state size.
> >> 	=3D=3D> Migration succeeds.
> >> (b) src don't have nested state while dest do.
> >> 	=3D=3D> Migration succeed and src don't send it's nested state.
> >> (c) src have nested state while dest don't.
> >> 	=3D=3D> Migration fails as it cannot restore nested state.
> >> (d) dest have bigger max nested state size than src
> >> 	=3D=3D> Migration succeeds.
> >> (e) dest have smaller max nested state size than src but enough to s=
tore it's saved nested state
> >> 	=3D=3D> Migration succeeds
> >> (f) dest have smaller max nested state size than src but not enough =
to store it's saved nested state
> >> 	=3D=3D> Migration fails
> >=20
> > Is it possible to tell these limits before the start of the migration=
,
> > or do we only find out that a nested migration won't work by trying i=
t?
> >=20
> > Dave
>=20
> It is possible for the destination host to query what is it=E2=80=99s m=
ax nested state size.
> (This is what is returned from "kvm_check_extension(s, KVM_CAP_NESTED_S=
TATE);=E2=80=9D See kvm_init() code)

Is this max size a function of:
  a) The host CPU
  b) The host kernel
  c) Some configuration

or all of those?

What about the maximum size that will be sent?

> However, I didn=E2=80=99t find any suitable mechanism in QEMU Live-Migr=
ation code to negotiate
> this destination host information with source prior to migration. Which=
 kinda makes sense as
> this code is also used to my understanding in standard suspend/resume f=
low. In that scenario,
> there is no other side to negotiate with.

At the moment, if the user has appropriately configured their QEMU and
their are no IO errors, the migration should not fail; and the
management layer can responsible for configuring the QEMU and checking
compatibilities -=20

> So currently what happens in my patch is that source prepares the neste=
d state buffer and sends it to destination as part of VMState,
> and destination attempts to load this nested state in it=E2=80=99s nest=
ed_state_post_load() function.
> If destination kernel cannot handle loading the nested state it has rec=
eived from source, it fails the migration by returning
> failure from nested_state_post_load().

That's minimally OK, but ideally we'd have a way of knowing before we
start the migration if it was going to work, that way the management
layer can refuse it before it spends ages transferring data and then
trying to switch over - recovery from a failed migration can be a bit
tricky/risky.

I can't see it being much use in a cloud environment if the migration
will sometimes fail without the cloud admin being able to do something
about it.

> Do you have a better suggestion?

I'll need to understand a bit more about the nested state.

Dave

> -Liran
>=20
> >=20
> >> -Liran
> >>=20
> >>=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
