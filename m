Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzxBc-0000x6-I7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 00:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzx8w-0001Dl-DZ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 00:52:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fzx8w-0001DW-7d
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 00:52:46 -0400
Date: Wed, 12 Sep 2018 12:52:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180912045233.GE3829@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] x86_iommu/amd: Enable Guest virtual
 APIC support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 11, 2018 at 11:49:49AM -0500, Brijesh Singh wrote:
> Now that amd-iommu support interrupt remapping, enable the GASup in IVRS
> table and GASup in extended feature register to indicate that IOMMU
> support guest virtual APIC mode.
> 
> Note that the GAMSup is set to zero to indicate that  Guest Virtual
> APIC does not support advanced interrupt features (i.e virtualized
> interrupts using the guest virtual APIC).
> 
> See Table 21 from IOMMU spec for interrupt virtualization controls
> 
> IOMMU spec: https://support.amd.com/TechDocs/48882_IOMMU.pdf
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  hw/i386/acpi-build.c | 3 ++-
>  hw/i386/amd_iommu.h  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5c2c638..1cbc8ba 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2565,7 +2565,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>      build_append_int_noprefix(table_data,
>                               (48UL << 30) | /* HATS   */
>                               (48UL << 28) | /* GATS   */
> -                             (1UL << 2),    /* GTSup  */
> +                             (1UL << 2)   | /* GTSup  */
> +                             (1UL << 6),    /* GASup  */

Sorry if I misunderstood - is this for nested?

I'm a bit confused here... IIUC in your previous patches you didn't
really implement guest_mode==1 case in IRTEs.  So if you have this set
then the guest should be able to setup IRTEs with guest_mode==1?  How
did it work?

Thanks,

-- 
Peter Xu
