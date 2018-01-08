Received: from eggs.gnu.org ([2001:4830:134:3::10]:33979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYemU-0006oe-Lh
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYemR-0006Wh-Nx
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:16:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYemR-0006Vt-GR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:16:27 -0500
Date: Mon, 8 Jan 2018 19:16:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180108211623.GJ6646@localhost.localdomain>
References: <20180108205052.24385-1-vincent@bernat.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108205052.24385-1-vincent@bernat.im>
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Mon, Jan 08, 2018 at 09:50:52PM +0100, Vincent Bernat wrote:
> PCID has been introduced in Sandy Bridge and, currently, KVM doesn't
> object exposing it to VM as long as it is present on the host. Update
> CPU model for both Sandy Bridge and Ivy Bridge accordingly.
> 
> Signed-off-by: Vincent Bernat <vincent@bernat.im>

Thanks for your patch.

We need two things, though:

First, confirming that all hosts where the SandyBridge and
IvyBridge CPU models are runnable will support exposing PCID to
guests (otherwise updating QEMU can make a runnable VM
configuration suddenly stop being runnable).  This can happen if
the host kernel is too old.

One possible way to work around this problem is to declare that
QEMU 2.12 with KVM will require Linux v3.6 and newer (because we
need Linux kernel commit ad756a1603c5 "KVM: VMX: Implement
PCID/INVPCID for guests with EPT").  I have proposed something
similar to allow us to enable kvm_pv_eoi by default, some time
ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html
("qemu-doc: Document minimum kernel version for KVM in x86_64").

Second, we need compatibility entries setting pcid=off on
PC_COMPAT_2_10 so we don't break compatibility on older
machine-types.


> ---
>  target/i386/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3818d7283158..bb2b4bd1b4fe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1109,7 +1109,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
>              CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
>              CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
> -            CPUID_EXT_SSE3,
> +            CPUID_EXT_SSE3 | CPUID_EXT_PCID,
>          .features[FEAT_8000_0001_EDX] =
>              CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
>              CPUID_EXT2_SYSCALL,
> @@ -1140,7 +1140,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_POPCNT |
>              CPUID_EXT_X2APIC | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
>              CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
> -            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> +            CPUID_EXT_SSE3 | CPUID_EXT_F16C | CPUID_EXT_RDRAND |
> +            CPUID_EXT_PCID,
>          .features[FEAT_7_0_EBX] =
>              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_SMEP |
>              CPUID_7_0_EBX_ERMS,
> -- 
> 2.15.1
> 

-- 
Eduardo
