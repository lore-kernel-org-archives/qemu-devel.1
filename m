Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtpj-0003iX-9H
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtpi-0008Ke-9U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTtpi-0008Jd-07
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:15:38 -0500
Date: Wed, 18 Jan 2017 15:15:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118171535.GE3491@thinpad.lan.raisama.net>
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
	<CAAibmn0pYJLSz3wRR4Q4gEK1OG2oYL9h-MoXb01SOzkNWuKP0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAibmn0pYJLSz3wRR4Q4gEK1OG2oYL9h-MoXb01SOzkNWuKP0Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86-KVM: Supply TSC and APIC clock rates
 to guest like VMWare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Wed, Jan 18, 2017 at 05:04:27PM +0100, Phil Dennis-Jordan wrote:
> Thanks for the comments Paulo and Eduardo,
>=20
> On 18 January 2017 at 16:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > > +    DEFINE_PROP_BOOL("vmware-tsc-apic-clocks", X86CPU,
> > vmware_clock_rates, false),
> >
> > Maybe just vmware-cpuid-freq instead?  Whatever the choice, please ma=
ke
> > the bool field in struct X86CPU consistent with the property name (e.=
g.
> > enable_vmware_cpuid_freq).
> >
>=20
> Sounds good, I've fixed this and the page/leaf terminology mixup for th=
e
> next patch iteration.
>=20
> One issue is that the TSC frequency can change, for example on
> > migration.  Telling the guest about the TSC frequency makes little se=
nse
> > if it can change.
> >
>=20
> That makes sense. Darwin can't handle changing TSC frequencies in any c=
ase,
> regardless of cpuid leaf 0x40000010. Do I deduce correctly from the
> following code (lines 967~977) that this bit inhibits migration
> intrinsically, so other than depending on it, I don't need to specifica=
lly
> disable migration for this option?
>=20
> if (c && (c->edx & 1<<8) && invtsc_mig_blocker =3D=3D NULL) {
> =E2=80=A6
>         vmstate_x86_cpu.unmigratable =3D 1;
>=20
> (Likewise, it would appear that the user_tsc_khz case Eduardo suggested
> already has a migration sanity check in cpu_post_load() too.)

user_tsc_khz won't inhibit migration completely, but QEMU will
refuse to start if the host TSC frequency isn't an exact match
and the host doesn't support TSC scaling.

invtsc currently inhibits migration, but I have submitted a
series last week that will allow migration with invtsc if
user_tsc_khz is set.

There are also plans to allow very small TSC frequency mismatches
with tsc_user_khz set, so migration with tsc_user_khz can be
possible when TSC scaling is unavailable.

The discussion is at:
  Subject: [PATCH 0/4] Allow migration with invtsc if there's no frequenc=
y mismatch

--=20
Eduardo
