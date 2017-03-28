Received: from eggs.gnu.org ([2001:4830:134:3::10]:54105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1csmBx-0000jz-JA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1csmBs-0007rw-Ks
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:09:25 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1csmBs-0007rb-FF
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:09:20 -0400
Received: by mail-wr0-x244.google.com with SMTP id w43so17301761wrb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 01:09:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170325111424.21752-1-herongguang.he@huawei.com>
	<58D8BD6D.8080404@huawei.com>
	<4c9e0c46-ac81-a455-e2ed-530ad916ff71@redhat.com>
	<58D9B791.2000905@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13d644c8-2a3b-e699-d6b5-8ec44afdba2e@redhat.com>
Date: Tue, 28 Mar 2017 10:09:17 +0200
MIME-Version: 1.0
In-Reply-To: <58D9B791.2000905@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] KVM: pci-assign: do not map smm memory
 slot pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>, rkrcmar@redhat.com, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com



On 28/03/2017 03:08, Herongguang (Stephen) wrote:
> From 8f5b9d2c2944ea7cd8149e9d3b4088f487217d20 Mon Sep 17 00:00:00 2001
> From: herongguang <herongguang.he@huawei.com>
> Date: Mon, 27 Mar 2017 15:08:59 +0800
> Subject: [PATCH] KVM: pci-assign: do not map smm memory slot pages in vt-d
>  page table
> 
> or VM memory are not put thus leaked in kvm_iommu_unmap_memslots() when
> destroy VM.
> 
> This is consistent with current vfio implementation.
> 
> Signed-off-by: herongguang <herongguang.he@huawei.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 482612b..9018d06 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1052,7 +1052,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>       * changes) is disallowed above, so any other attribute changes
> getting
>       * here can be skipped.
>       */
> -    if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
> +    if ((as_id == 0) && ((change == KVM_MR_CREATE) || (change ==
> KVM_MR_MOVE))) {
>          r = kvm_iommu_map_pages(kvm, &new);
>          return r;
>      }

Thanks!

Paolo
