Received: from eggs.gnu.org ([209.51.188.92]:37127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqmjq-0001cs-Tl
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gqmjp-0005wJ-Vg
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gqmjp-0005vP-Oc
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 17:29:13 -0500
Date: Mon, 4 Feb 2019 15:29:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190204152911.60583c48@w520.home>
In-Reply-To: <20190204222322.26766-3-brijesh.singh@amd.com>
References: <20190204222322.26766-1-brijesh.singh@amd.com>
	<20190204222322.26766-3-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/i386: sev: Do not pin the
 ram device memory region
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

On Mon, 4 Feb 2019 22:23:40 +0000
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
> index 20b2d325d8..cd77f6b5d4 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -131,6 +131,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
>  {
>      int r;
>      struct kvm_enc_region range;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +
> +    /*
> +     * The RAM device presents a memory region that should be treated
> +     * as IO region and should not be pinned.
> +     */
> +    mr = memory_region_from_host(host, &offset);
> +    if (mr && memory_region_is_ram_device(mr)) {
> +        return;
> +    }
>  
>      range.addr = (__u64)(unsigned long)host;
>      range.size = size;

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
