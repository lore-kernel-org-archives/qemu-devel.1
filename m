Received: from eggs.gnu.org ([2001:4830:134:3::10]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTsh3-0001pM-Es
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTsgx-0006ml-Ob
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:37 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cTsgx-0006mS-G2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:31 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so1560906otj.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:02:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Jan 2017 17:02:10 +0100
Message-ID: <CAAibmn3SqnaEiM6NED=UyPNGp5j2ymgBxpRygpUzpLCNcL-X8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

Thanks for the comments Paulo and Eduardo,

On 18 January 2017 at 16:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> > +    DEFINE_PROP_BOOL("vmware-tsc-apic-clocks", X86CPU,
> vmware_clock_rates, false),
>
> Maybe just vmware-cpuid-freq instead?  Whatever the choice, please make
> the bool field in struct X86CPU consistent with the property name (e.g.
> enable_vmware_cpuid_freq).
>

Sounds good, I've fixed this and the page/leaf terminology mixup for the
next patch iteration.

One issue is that the TSC frequency can change, for example on
> migration.  Telling the guest about the TSC frequency makes little sense
> if it can change.
>

That makes sense. Darwin can't handle changing TSC frequencies in any case,
regardless of cpuid leaf 0x40000010. Do I deduce correctly from the
following code (lines 967~977) that this bit inhibits migration
intrinsically, so other than depending on it, I don't need to specifically
disable migration for this option?

if (c && (c->edx & 1<<8) && invtsc_mig_blocker =3D=3D NULL) {
=E2=80=A6
        vmstate_x86_cpu.unmigratable =3D 1;

(Likewise, it would appear that the user_tsc_khz case Eduardo suggested
already has a migration sanity check in cpu_post_load() too.)

So the leaf should be conditional on the INVTSC feature
> (CPUID[0x80000007].EDX bit 8).  You can enable this unconditionally for
> new machine types (i.e. making it true here, and turning it off in
> include/hw/i386/pc.h's PC_COMPAT_2_8 macro), but only expose it if that
> bit is also set.
>

Sorry, you've lost me here. Would you mind explaining in a little more
detail? What would I be enabling unconditionally? (I'm getting lost on what
the various 'this'/'that'/'it' are referring to.)

> +    if (cpu->vmware_clock_rates) {
>
> ^^ Here is where you should also check invtsc.
>
> > +        if (cpu->expose_kvm
>
> I think this should not depend on cpu->expose_kvm.  This is not a KVM
> leaf, it's a vmware leaf; if it were a KVM leaf, it would obey kvm_base.
>  Of course checking kvm_base is still a good idea, to avoid stomping on
> Hyper-V's CPUID space.
>

Hmm, my thinking here is that leaf 0x40000000 only is published if kvm or
Hyper-V is exposed. Without 0x40000000, Darwin won't find 0x40000010. Like
you say, this option is mutually exclusive with the Hyper-V leaves - so
either we rely on the KVM version of leaf 0x40000000 (my code so far), or
this option will have to explicitly expose 0x40000000. I'm not sure what
signature (ebx-edx) we should give it in the latter case - using VMWare's
seems off as it doesn't replicate any other of their leaves. Given that
exposing KVM is the default, anyone disabling it presumably has a reason
for not wanting page 0x40000000 exposed. Thoughts?
