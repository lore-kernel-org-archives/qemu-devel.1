Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTHtU-000161-5T
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTHtR-0003St-2p
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTHtQ-0003Sf-S6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:21:45 -0400
Date: Wed, 13 Jun 2018 23:21:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180614022139.GS7451@localhost.localdomain>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528939107-17193-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v14 1/6] i386: Set TOPOEXT unconditionally
 for comapatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Wed, Jun 13, 2018 at 09:18:22PM -0400, Babu Moger wrote:
> Enabling TOPOEXT feature might cause compatibility issues if
> older kernels does not set this feature. Lets set this feature
> unconditionally.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 445e0e0..6f2cca7 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -372,6 +372,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          if (host_tsx_blacklisted()) {
>              ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
>          }
> +    } else if (function == 0x80000001 && reg == R_ECX) {
> +        /* Enabling topoext feature might cause compatibility issues if
> +         * older kernel does not set this feature. Lets set this feature
> +         * unconditionally.
> +         */

Thanks.  I will apply and rewrite the comment as:

        /*
         * It's safe to enable TOPOEXT even if it's not returned
         * by GET_SUPPORTED_CPUID.  Unconditionally enabling
         * TOPOEXT here let us keep CPU models runnable on
         * older kernels even when TOPOEXT is enabled.
         */

> +        ret |= CPUID_EXT3_TOPOEXT;
>      } else if (function == 0x80000001 && reg == R_EDX) {
>          /* On Intel, kvm returns cpuid according to the Intel spec,
>           * so add missing bits according to the AMD spec:
> -- 
> 1.8.3.1
> 

-- 
Eduardo
