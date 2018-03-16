Received: from eggs.gnu.org ([2001:4830:134:3::10]:58260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boqun.feng@intel.com>) id 1eweuN-00034t-Mf
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boqun.feng@intel.com>) id 1eweuK-0008DV-GR
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:15:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:40922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <boqun.feng@intel.com>)
	id 1eweuK-0007gA-5j
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:15:48 -0400
Date: Fri, 16 Mar 2018 10:11:57 +0800
From: Boqun Feng <boqun.feng@intel.com>
Message-ID: <20180316021157.GB3734@dragonstone.sh.intel.com>
References: <20180314073000.3701-1-boqun.feng@intel.com>
	<20180314130130.GH17603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180314130130.GH17603@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: add KNM cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Mar 14, 2018 at 01:01:30PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 14, 2018 at 03:29:59PM +0800, Boqun Feng wrote:
> > A new cpu model called "KNM" is added to model Knights Mill processors.
> 
> Why the obscure acryonym? Can't we just call it KnightsMill so it is
> obvious what it is to everyone, as we've done for all other Intel
> CPU model names in the past.
> 

Ah.. my bad, good point! I will rename to "KnightsMill" in the next
version.

> > Compared to "Skylake-Server" cpu model, the following features are
> > added:
> > 
> > 	avx512_4vnniw avx512_4fmaps avx512pf avx512er avx512_vpopcntdq
> > 
> > and the following features are removed:
> > 
> > 	pcid invpcid clflushopt avx512dq avx512bw axv512cd clwb smap rtm
> > 	mpx xsavec xgetbv1 hle
> 
> "pcid" was one of the features critical to mitigate performance
> downside of the Meltdown bug fix in guests. Will Knights Mill have
> a fix for Meltdown in hardware, to avoid the need for split table
> pages and thus avoid the perf hit in guests ?
> 

I got the confirmation the Knights Mill doesn't have PCID at all. For
the alternative fix for Meltdown in hardware, I will ask around and info
you if I get something.

Regards,
Boqun

> > 
> > Signed-off-by: Boqun Feng <boqun.feng@intel.com>
> > ---
> >  target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2c04645ceac9..215a9ee6026a 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1795,6 +1795,48 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >          .xlevel = 0x80000008,
> >          .model_id = "Intel Xeon Processor (Skylake, IBRS)",
> >      },
> > +    {
> > +        .name = "KNM",
> > +        .level = 0xd,
> > +        .vendor = CPUID_VENDOR_INTEL,
> > +        .family = 6,
> > +        .model = 133,
> > +        .stepping = 0,
> > +        .features[FEAT_1_EDX] =
> > +            CPUID_VME | CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |
> > +            CPUID_MMX | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
> > +            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
> > +            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
> > +            CPUID_PSE | CPUID_DE | CPUID_FP87,
> > +        .features[FEAT_1_ECX] =
> > +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> > +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> > +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> > +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> > +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
> > +            CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> > +        .features[FEAT_8000_0001_EDX] =
> > +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> > +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> > +        .features[FEAT_8000_0001_ECX] =
> > +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
> > +        .features[FEAT_7_0_EBX] =
> > +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
> > +            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
> > +            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_AVX512F |
> > +            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_AVX512PF |
> > +            CPUID_7_0_EBX_AVX512ER,
> > +        .features[FEAT_7_0_ECX] =
> > +            CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
> > +        .features[FEAT_7_0_EDX] =
> > +            CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS,
> > +        .features[FEAT_XSAVE] =
> > +            CPUID_XSAVE_XSAVEOPT,
> > +        .features[FEAT_6_EAX] =
> > +            CPUID_6_EAX_ARAT,
> > +        .xlevel = 0x80000008,
> > +        .model_id = "Intel Xeon Phi Processor (Knights Mill)",
> > +    },
> >      {
> >          .name = "Opteron_G1",
> >          .level = 5,
> > -- 
> > 2.16.1
> > 
> > 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
