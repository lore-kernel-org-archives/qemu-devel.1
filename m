Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQCa5-0002xM-G0
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQCa2-0004Gb-9J
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:05:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQCa2-0004GE-3c
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:04:58 -0400
Date: Tue, 5 Jun 2018 15:04:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605140453.GL32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<caa3376a-252b-0a85-1a63-d2a6a911739c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caa3376a-252b-0a85-1a63-d2a6a911739c@amd.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, rth@twiddle.net

On Tue, Jun 05, 2018 at 08:31:41AM -0500, Tom Lendacky wrote:
> On 6/4/2018 3:07 PM, Eduardo Habkost wrote:
> > On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wrote:
> >> AMD future CPUs expose _two_ ways to utilize the Intel equivalant
> >> of the Speculative Store Bypass Disable. The first is via
> >> the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
> >> is via the SPEC_CTRL MSR (0x48). The document titled:
> >> 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> >>
> >> gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
> >>
> >> A copy of this document is available at
> >>       https://bugzilla.kernel.org/show_bug.cgi?id=199889
> >>
> >> Anyhow, this means that on future AMD CPUs there will be  _two_ ways to
> >> deal with SSBD.
> > 
> > Does anybody know if there are AMD CPUs where virt-ssbd won't
> > work and would require amd-ssbd to mitigate vulnerabilities?
> 
> The idea behind virt-ssbd was to provide an architectural method for
> a guest to do SSBD when amd-ssbd isn't present.  The amd-ssbd feature
> will use SPEC_CTRL which is intended to not be intercepted and
> will be fast.  The use of virt-ssbd will always be intercepted and
> therefore will not be as fast.  So a guest should be presented with
> amd-ssbd, if available, in preference to virt-ssbd.

Thanks, that's useful info.

Can you say whether amd-ssbd is going to become available for existing
CPUs via microcode updates, or will it only be present in future CPUs ?

> > Also, do we have kernel arch/x86/kvm/cpuid.c patches, already?
> > I prefer to add new CPUID flag names only after the flag name is
> > already agreed upon on the kernel side.
> > 
> > 
> >>
> >> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >> ---
> >>  target/i386/cpu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 52d334a..f91990c 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -490,7 +490,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >>              "ibpb", NULL, NULL, NULL,
> >>              NULL, NULL, NULL, NULL,
> >>              NULL, NULL, NULL, NULL,
> >> -            NULL, "virt-ssbd", NULL, NULL,
> >> +            "amd-ssbd", "virt-ssbd", NULL, NULL,
> >>              NULL, NULL, NULL, NULL,
> >>          },
> >>          .cpuid_eax = 0x80000008,

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
