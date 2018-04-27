Received: from eggs.gnu.org ([2001:4830:134:3::10]:38103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fBvhH-0008B9-Bn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 01:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fBvhD-0003ZJ-D0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 01:13:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fBvhD-0003Wz-8l
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 01:13:23 -0400
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
Date: Fri, 27 Apr 2018 13:13:02 +0800
MIME-Version: 1.0
In-Reply-To: <20180425045129.17449-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> Add a per-iommu big lock to protect IOMMU status.  Currently the only
> thing to be protected is the IOTLB cache, since that can be accessed
> even without BQL, e.g., in IO dataplane.
>
> Note that device page tables should not need any protection.  The safet=
y
> of that should be provided by guest OS.  E.g., when a page entry is
> freed, the guest OS should be responsible to make sure that no device
> will be using that page any more.
>
> Reported-by: Fam Zheng<famz@redhat.com>
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   include/hw/i386/intel_iommu.h |  8 ++++++++
>   hw/i386/intel_iommu.c         | 31 +++++++++++++++++++++++++++++--
>   2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iomm=
u.h
> index 220697253f..1a8ba8e415 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -262,6 +262,14 @@ struct IntelIOMMUState {
>       uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear) bytes *=
/
>       uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns =
0) */
>       uint32_t version;
> +    /*
> +     * Protects IOMMU states in general.  Normally we don't need to
> +     * take this lock when we are with BQL held.  However we have code
> +     * paths that may run even without BQL.  In those cases, we need
> +     * to take the lock when we have access to IOMMU state
> +     * informations, e.g., the IOTLB.
> +     */
> +    QemuMutex iommu_lock;

Some questions:

1) Do we need to protect context cache too?
2) Can we just reuse qemu BQL here?
3) I think the issue is common to all other kinds of IOMMU, so can we=20
simply synchronize before calling ->translate() in memory.c. This seems=20
a more common solution.

Thanks
