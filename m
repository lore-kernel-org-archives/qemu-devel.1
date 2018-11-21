Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPU01-0000oL-OL
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPTzv-0005Gg-N7
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:01:05 -0500
Date: Wed, 21 Nov 2018 16:00:10 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121150009.GH4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-8-sameo@linux.intel.com>
	<20181109143733.76b93da5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109143733.76b93da5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/24] hw: acpi: Generalize AML build
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

Hi Igor,

On Fri, Nov 09, 2018 at 02:37:33PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:30 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > From: Yang Zhong <yang.zhong@intel.com>
> > 
> > Most of the AML build routines under acpi-build are not even
> > architecture specific. They can be moved to the more generic hw/acpi
> > folder where they could be shared across machine types and
> > architectures.
> 
> I'd prefer if won't pull into aml-build PCI specific headers,
> Suggest to create hw/acpi/pci.c and move generic PCI related
> code there, with corresponding header the would export API
> (preferably without PCI dependencies in it)
> 
> 
> Also patch is too big and does too much at a time.
> Here I'd suggest to split it in smaller parts to make it more digestible
> 
> 1. split it in 3 parts
>     * MCFG
>     * CRS
>     * PTR
> 2. mcfg between x86 and ARM look pretty much the same with ARM
>    open codding bus number calculation and missing migration hack
>    * a patch to make bus number calculation in ARM the same as x86
>    * a patch to bring migration hack (dummy MCFG table in case it's disabled)
>      it's questionable if we actually need it in generic,
>      we most likely need it for legacy machines that predate
>      resizable MemeoryRegion, but we probably don't need it for
>      later machines as problem doesn't exists there.
>      So it might be better to push hack out from generic code
>      to a legacy caller and keep generic MCFG clean.
>      (this patch might be better at the beginning of the series as
>       it might affect acpi test results, and might need an update to reference tables
>       I don't really sure)
>    * at this point arm and x86 impl. would be the same so
>      a patch to move mcfg build routine to a generic place and replace
>      x86/arm with a single impl.
>    * a patch to convert mcfg build routine to build_append_int_noprefix() API
>      and drop AcpiTableMcfg structure
Ok, I'll build another patch serie for that one then.

Cheers,
Samuel.
