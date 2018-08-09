Received: from eggs.gnu.org ([2001:4830:134:3::10]:52763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fnrZH-0005Ds-Qy
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fnrZE-0005zg-Lp
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fnrZE-0005yR-FA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 16:29:56 -0400
Date: Thu, 9 Aug 2018 21:29:52 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180809202952.GH16293@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
	<20180625222524.382-10-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625222524.382-10-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 09/12] i386: Allow TOPOEXT to be enabled on
 older kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 25, 2018 at 07:25:21PM -0300, Eduardo Habkost wrote:
> From: Babu Moger <babu.moger@amd.com>
> 
> Enabling TOPOEXT feature might cause compatibility issues if
> older kernels does not set this feature. Lets set this feature
> unconditionally.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Message-Id: <1528939107-17193-2-git-send-email-babu.moger@amd.com>
> [ehabkost: rewrite comment and commit message]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 445e0e0b11..2d174f3a91 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -372,6 +372,13 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          if (host_tsx_blacklisted()) {
>              ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>          }
> +    } else if (function == 0x80000001 && reg == R_ECX) {
> +        /*
> +         * It's safe to enable TOPOEXT even if it's not returned by
> +         * GET_SUPPORTED_CPUID.  Unconditionally enabling TOPOEXT here allows
> +         * us to keep CPU models including TOPOEXT runnable on older kernels.
> +         */
> +        ret |= CPUID_EXT3_TOPOEXT;
>      } else if (function == 0x80000001 && reg == R_EDX) {
>          /* On Intel, kvm returns cpuid according to the Intel spec,
>           * so add missing bits according to the AMD spec:

This commit breaks KVM (not TCG) with -cpu host on:

  AMD Phenom(tm) 9600B Quad-Core Processor

More details including full qemu command line etc in this bug:

  https://bugzilla.redhat.com/show_bug.cgi?id=1613277

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
