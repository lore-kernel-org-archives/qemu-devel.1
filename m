Received: from eggs.gnu.org ([2001:4830:134:3::10]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evl4T-0003Bu-6a
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evl4P-0002ji-7V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:38:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1evl4P-0002jU-3F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:38:29 -0400
References: <20180228201837.26629.3346.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <63020f50-b780-3623-800b-379521e8583a@redhat.com>
Date: Tue, 13 Mar 2018 15:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180228201837.26629.3346.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] vfio/quirks: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com

Hi Alex,
On 28/02/18 21:45, Alex Williamson wrote:
> This is the QEMU counterpart to https://lkml.org/lkml/2018/2/28/1222
> 
> As described in the third patch, we have a use case for taking
> advantage of existing KVM ioeventfd support for accelerating the
> MSI-ACK behavior of NVIDIA GPUs.  This series adds generic
> infrastructure within vfio quirks for making use of ioeventfds and
> specifically enables it for this purpose.  The first three patches
> provide a performance improvement on their own and do not depend on
> the additional acceleration added by the remainder of the patches to
> be worthwhile.  The Linux header update in patch 4 is not intended
> to be a full refresh, the kernel API is not yet upstream, this is for
> testing and review purposes.  The intention would be to commit the
> series in separate chunks, 1-3 once we have review consensus, 4-5 as
> RFC until the kernel API is upstream.
> 
> RFC->v1:
>  * Cap the number of dynamically added ioeventfds to 10 such that
>    pathological driver behavior cannot consume too many file handles.
>  * Added a reset hook and cleanup mechanism to drop dynamically added
>    ioeventfds on device reset.
>  * Additional comments and removed info_report.
>  * Folded ioeventfd infrastructure patch into usage patch, fail to
>    stand on its own without setup, which requires consumers.
> 
> Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (5):
>       vfio/quirks: Add common quirk alloc helper
>       vfio/quirks: Add quirk reset callback
>       vfio/quirks: ioeventfd quirk acceleration
>       vfio: Update linux header
>       vfio/quirks: Enable ioeventfd quirks to be handled by vfio directly
> 
> 
>  hw/vfio/pci-quirks.c       |  255 +++++++++++++++++++++++++++++++++++++++-----
>  hw/vfio/pci.c              |    2 
>  hw/vfio/pci.h              |   17 +++
>  linux-headers/linux/vfio.h |   27 +++++
>  4 files changed, 272 insertions(+), 29 deletions(-)
> 
For all patches except the yet partial linux header update,

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
