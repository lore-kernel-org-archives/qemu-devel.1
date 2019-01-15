Received: from eggs.gnu.org ([209.51.188.92]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFw1-0004Mq-2L
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 23:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFvz-0002HC-T3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 23:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjFvz-0002DV-JS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 23:02:39 -0500
Date: Mon, 14 Jan 2019 23:02:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114230131-mutt-send-email-mst@kernel.org>
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] intel-iommu: add support for
 5-level virtual IOMMU.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>

On Wed, Dec 12, 2018 at 09:05:37PM +0800, Yu Zhang wrote:
> Intel's upcoming processors will extend maximum linear address width to
> 57 bits, and introduce 5-level paging for CPU. Meanwhile, the platform
> will also extend the maximum guest address width for IOMMU to 57 bits,
> thus introducing the 5-level paging for 2nd level translation(See chapter
> 3 in Intel Virtualization Technology for Directed I/O). 
> 
> This patch series extends the current logic to support a wider address width.
> A 5-level paging capable IOMMU(for 2nd level translation) can be rendered
> with configuration "device intel-iommu,x-aw-bits=57".
> 
> Also, kvm-unit-tests were updated to verify this patch series. Patch for
> the test was sent out at: https://www.spinics.net/lists/kvm/msg177425.html.
> 
> Note: this patch series checks the existance of 5-level paging in the host
> and in the guest, and rejects configurations for 57-bit IOVA if either check
> fails(VTD-d hardware shall not support 57-bit IOVA on platforms without CPU
> 5-level paging). However, current vIOMMU implementation still lacks logic to
> check against the physical IOMMU capability, future enhancements are expected
> to do this.
> 
> Changes in V3: 
> - Address comments from Peter Xu: squash the 3rd patch in v2 into the 2nd
>   patch in this version.
> - Added "Reviewed-by: Peter Xu <peterx@redhat.com>"
> 
> Changes in V2: 
> - Address comments from Peter Xu: add haw member in vtd_page_walk_info.
> - Address comments from Peter Xu: only searches for 4K/2M/1G mappings in
> iotlb are meaningful. 
> - Address comments from Peter Xu: cover letter changes(e.g. mention the test
> patch in kvm-unit-tests).
> - Coding style changes.
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com> 
> Cc: Igor Mammedov <imammedo@redhat.com> 
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com> 
> Cc: Richard Henderson <rth@twiddle.net> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>


OK is this going anywhere?
How about dropping cpu flags probing for now, you can
always revisit it later.
Will make it maybe a bit less user friendly but OTOH
uncontriversial...

> ---
> 
> Yu Zhang (2):
>   intel-iommu: differentiate host address width from IOVA address width.
>   intel-iommu: extend VTD emulation to allow 57-bit IOVA address width.
> 
>  hw/i386/acpi-build.c           |  2 +-
>  hw/i386/intel_iommu.c          | 96 +++++++++++++++++++++++++++++-------------
>  hw/i386/intel_iommu_internal.h | 10 ++++-
>  include/hw/i386/intel_iommu.h  | 10 +++--
>  4 files changed, 81 insertions(+), 37 deletions(-)
> 
> -- 
> 1.9.1
