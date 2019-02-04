Received: from eggs.gnu.org ([209.51.188.92]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqiXA-0003jn-3c
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqiX8-0003el-W3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gqiX8-0003Yi-Li
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:59:50 -0500
Date: Mon, 4 Feb 2019 10:59:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190204105945.01451a28@w520.home>
In-Reply-To: <20190117215300.29694-3-brijesh.singh@amd.com>
References: <20190117215300.29694-1-brijesh.singh@amd.com>
	<20190117215300.29694-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/i386: sev: Do not pin the ram
 device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 17 Jan 2019 21:53:16 +0000
"Singh, Brijesh" <brijesh.singh@amd.com> wrote:

> The RAM device presents a memory region that should be handled
> as an IO region and should not be pinned.
> 
> In the case of the vfio-pci, RAM device represents a MMIO BAR
> and the memory region is not backed by pages hence
> KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  target/i386/sev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 20b2d325d8..3e9d5c02fa 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -131,6 +131,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
>  {
>      int r;
>      struct kvm_enc_region range;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +
> +    mr = memory_region_from_host(host, &offset);
> +    /*
> +     * The RAM device presents a memory region that should be treated
> +     * as IO region and should not be pinned.
> +     */
> +    if (memory_region_is_ram_device(mr)) {
> +        return;
> +    }
>  
>      range.addr = (__u64)(unsigned long)host;
>      range.size = size;


memory_region_from_host() can return NULL, which would give you a
segfault at memory_region_is_ram_device(), so you might want to test mr
on it's own first and decide which path that would take.  Thanks,

Alex
