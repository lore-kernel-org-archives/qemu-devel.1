Received: from eggs.gnu.org ([2001:4830:134:3::10]:50633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJiwg-0001JN-Ll
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJiwc-0003rE-9V
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJiwb-0003c7-Qh
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:45:45 -0500
Date: Mon, 5 Nov 2018 12:45:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105124309-mutt-send-email-mst@kernel.org>
References: <20181105140327.8363-1-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105140327.8363-1-v.mayatskih@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/1 resend] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>

On Mon, Nov 05, 2018 at 02:03:26PM +0000, Vitaly Mayatskikh wrote:
> This driver moves virtio-blk host-side processing to kernel (via new
> vhost_blk kernel driver). It accelerates virtual disk performance
> close to bare metal levels, especially for parellel loads.
> 
> For example, fio numjobs=16 gets 101k randread IOPS using virtio-blk
> and 1202k IOPS using vhost-blk, close to 1480k of raw disk performance.
> 
> See the IOPS numbers below.
> 
> The kernel part if you want to try:
> - vhost_blk: https://lkml.org/lkml/2018/11/2/648
> - vhost num-queues scalability fix: https://lkml.org/lkml/2018/11/2/550
> 
> # fio num-jobs
> # A: bare metal over block
> # B: bare metal over file
> # C: virtio-blk over block
> # D: virtio-blk over file
> # E: vhost-blk over block
> # F: vhost-blk over file
> #
> #  A     B     C    D    E     F
> 
> 1  171k  151k  148k 151k 187k  175k
> 2  328k  302k  249k 241k 334k  296k
> 3  479k  437k  179k 174k 464k  404k
> 4  622k  568k  143k 183k 580k  492k
> 5  755k  697k  136k 128k 693k  579k
> 6  887k  808k  131k 120k 782k  640k
> 7  1004k 926k  126k 131k 863k  693k
> 8  1099k 1015k 117k 115k 931k  712k
> 9  1194k 1119k 115k 111k 991k  711k
> 10 1278k 1207k 109k 114k 1046k 695k
> 11 1345k 1280k 110k 108k 1091k 663k
> 12 1411k 1356k 104k 106k 1142k 629k
> 13 1466k 1423k 106k 106k 1170k 607k
> 14 1517k 1486k 103k 106k 1179k 589k
> 15 1552k 1543k 102k 102k 1191k 571k
> 16 1480k 1506k 101k 102k 1202k 566k
> 
> Vitaly Mayatskikh (1):
>   Add vhost-pci-blk driver
> 
>  configure                  | 10 +++++++
>  default-configs/virtio.mak |  1 +
>  hw/block/Makefile.objs     |  1 +
>  hw/virtio/virtio-pci.c     | 60 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.h     | 19 ++++++++++++
>  5 files changed, 91 insertions(+)

I think you should Cc more widely to get meaningful
review. At least virtio-blk and block layer core people.

> -- 
> 2.17.1
