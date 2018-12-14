Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gXje0-0002oi-3h
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gXjdv-0006jF-IA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:20:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:50303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gXjdv-0006eH-4i
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:20:23 -0500
References: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <f9e27fd6-94da-bbdc-b383-daa115d3e6bf@linux.intel.com>
Date: Fri, 14 Dec 2018 17:17:21 +0800
MIME-Version: 1.0
In-Reply-To: <1544619939-18102-1-git-send-email-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Sorry, any comments for this series? Thanks. :)


B.R.

Yu

On 12/12/2018 9:05 PM, Yu Zhang wrote:
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
>    patch in this version.
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
> ---
>
> Yu Zhang (2):
>    intel-iommu: differentiate host address width from IOVA address width.
>    intel-iommu: extend VTD emulation to allow 57-bit IOVA address width.
>
>   hw/i386/acpi-build.c           |  2 +-
>   hw/i386/intel_iommu.c          | 96 +++++++++++++++++++++++++++++-------------
>   hw/i386/intel_iommu_internal.h | 10 ++++-
>   include/hw/i386/intel_iommu.h  | 10 +++--
>   4 files changed, 81 insertions(+), 37 deletions(-)
>
