Received: from eggs.gnu.org ([2001:4830:134:3::10]:56218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRTi9-0003s1-DK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gRTi6-0004HF-9z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:06:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:49499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gRTi6-0004Ga-0f
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 22:06:50 -0500
Message-ID: <5BFCB5F1.1070300@intel.com>
Date: Tue, 27 Nov 2018 11:11:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/8] virtio-balloon: free page hint
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 11/15/2018 06:07 PM, Wei Wang wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not sent by the migration thread to the destination.
>
> *Tests
> 1 Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 400ms
>
> 2 Test Results (results are averaged over several repeated runs)
>      2.1 Guest setup: 8G RAM, 4 vCPU
>          2.1.1 Idle guest live migration time
>              Optimization v.s. Legacy = 620ms vs 2970ms
>              --> ~79% reduction
>          2.1.2 Guest live migration with Linux compilation workload
>            (i.e. make bzImage -j4) running
>            1) Live Migration Time:
>               Optimization v.s. Legacy = 2273ms v.s. 4502ms
>               --> ~50% reduction
>            2) Linux Compilation Time:
>               Optimization v.s. Legacy = 8min42s v.s. 8min43s
>               --> no obvious difference
>
>      2.2 Guest setup: 128G RAM, 4 vCPU
>          2.2.1 Idle guest live migration time
>              Optimization v.s. Legacy = 5294ms vs 41651ms
>              --> ~87% reduction
>          2.2.2 Guest live migration with Linux compilation workload
>            1) Live Migration Time:
>              Optimization v.s. Legacy = 8816ms v.s. 54201ms
>              --> 84% reduction
>            2) Linux Compilation Time:
>               Optimization v.s. Legacy = 8min30s v.s. 8min36s
>               --> no obvious difference
>
> ChangeLog:
> v8->v9:
> bitmap:
>      - fix bitmap_count_one to handle the nbits=0 case
> migration:
>      - replace the ram save notifier chain with a more general precopy
>        notifier chain, which is similar to the postcopy notifier chain.
>      - Avoid exposing the RAMState struct, and add a function,
>        precopy_disable_bulk_stage, to let the virtio-balloon notifier
>        callback to disable the bulk stage flag.

Hi Dave and Peter,

Could you continue to review the patches? Thanks!

Best,
Wei
