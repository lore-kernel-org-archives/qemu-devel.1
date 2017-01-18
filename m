Received: from eggs.gnu.org ([2001:4830:134:3::10]:40347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTsoV-00088L-D0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTsoP-0002OQ-Gd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTsoP-0002NG-BS
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:10:13 -0500
References: <1484749457-87117-1-git-send-email-phil@philjordan.eu>
	<aae83060-472d-97fb-9ada-2a78ff3f815f@redhat.com>
	<CAAibmn3SqnaEiM6NED=UyPNGp5j2ymgBxpRygpUzpLCNcL-X8g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df1239e9-e520-3c17-60cd-ec497c19e23b@redhat.com>
Date: Wed, 18 Jan 2017 17:10:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAAibmn3SqnaEiM6NED=UyPNGp5j2ymgBxpRygpUzpLCNcL-X8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org



On 18/01/2017 17:02, Phil Dennis-Jordan wrote:
> 
>     One issue is that the TSC frequency can change, for example on
>     migration.  Telling the guest about the TSC frequency makes little sense
>     if it can change.
> 
> That makes sense. Darwin can't handle changing TSC frequencies in any
> case, regardless of cpuid leaf 0x40000010. Do I deduce correctly from
> the following code (lines 967~977) that this bit inhibits migration
> intrinsically, so other than depending on it, I don't need to
> specifically disable migration for this option?

Correct.

>     So the leaf should be conditional on the INVTSC feature
>     (CPUID[0x80000007].EDX bit 8).  You can enable this unconditionally for
>     new machine types (i.e. making it true here, and turning it off in
>     include/hw/i386/pc.h's PC_COMPAT_2_8 macro), but only expose it if that
>     bit is also set.
> 
> Sorry, you've lost me here. Would you mind explaining in a little more
> detail? What would I be enabling unconditionally? (I'm getting lost on
> what the various 'this'/'that'/'it' are referring to.)

You enable vmware-cpuid-freq unconditionally.  But then you actually
publish 0x40000010 only if INVTSC is set.
> 
>     > +    if (cpu->vmware_clock_rates) {
> 
>     ^^ Here is where you should also check invtsc.
> 
>     > +        if (cpu->expose_kvm
> 
>     I think this should not depend on cpu->expose_kvm.  This is not a KVM
>     leaf, it's a vmware leaf; if it were a KVM leaf, it would obey kvm_base.
>      Of course checking kvm_base is still a good idea, to avoid stomping on
>     Hyper-V's CPUID space.
> 
> Hmm, my thinking here is that leaf 0x40000000 only is published if kvm
> or Hyper-V is exposed. Without 0x40000000, Darwin won't find 0x40000010.

Of course you're right, but please add a comment like this:

	/* Guests depend on 0x40000000 to detect this, so do not expose
	 * it unless that leaf is present.
	 */

Paolo
