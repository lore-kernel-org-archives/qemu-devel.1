Received: from eggs.gnu.org ([2001:4830:134:3::10]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cBO-0007zR-SI
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cBO-0006n0-2t
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:49:38 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:53146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1cBN-0006mi-TQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:49:38 -0400
Received: by mail-wm0-x235.google.com with SMTP id k4so25637589wmc.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:49:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-21-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-21-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:49:16 +0100
Message-ID: <CAFEAcA_bApUy+B5TnZrot0x5okOZyt2F8qhCodHkvgOPhUhMgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 20/20] hw/arm/smmuv3: [not for upstream]
 Add caching-mode option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> In VFIO use cases, the virtual smmu translates IOVA->IPA (stage 1)
> whereas the physical SMMU translates IPA -> host PA (stage 2).
>
> The 2 stages of the physical SMMU are currently not used.
> Instead both stage 1 and stage2 mappings are combined together
> and programmed in a single stage (S1) in the physical SMMU.
>
> The drawback of this approach is each time the IOVA->IPA mapping
> is changed by the guest, the host must be notified to re-program
> the physical SMMU with the combined stages.
>
> So we need to trap into the QEMU device each time the guest alters
> the configuration or TLB data. Unfortunately the SMMU does not
> expose any caching mode as the Intel IOMMU. On Intel, this caching
> mode HW bit informs the OS that each time it updates the remapping
> structures (even on map) it must invalidate the caches. Those
> invalidate commands are used to notify the host that it must
> recompute S1+S2 mappings and reprogram the HW.
>
> As we don't have the HW bit on ARM, we currently rely on a
> a FW quirk on guest smmuv3 driver side. When this FW quirk is
> applied the driver performs TLB invalidations on map and
> sends SMMU_CMD_TLBI_NH_VA_AM commands.
>
> Those TLB invalidations are used to trap changes in the
> translation tables.
>
> We introduced a new implemented defined SMMU_CMD_TLBI_NH_VA_AM
> command since it allows to inavlidate a whole range instead
> of invalidating a single page (native SMMU_CMD_TLBI_NH_VA command).
>
> As a consequence anybody wanting to use virtual smmuv3 in VFIO
> use case must add
> -device smmuv3,caching-mode
> to the option line.

Even more of a NACK on this one. We shouldn't need to do
weird things to be able to use the SMMU in a VM. We need
to figure out how the spec expects us (and the kernel)
to be using the SMMU, and do that.

thanks
-- PMM
