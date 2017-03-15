Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co42y-0008Nb-3t
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co42u-00024h-4h
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1co42t-00024S-V7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:12:36 -0400
References: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
Date: Wed, 15 Mar 2017 09:12:31 +0100
MIME-Version: 1.0
In-Reply-To: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, Peter Maydell <peter.maydell@linaro.org>



On 15/03/2017 14:39, Yang Zhong wrote:
> Since cpu-memory and memory have same address space,one malloced
> memory is enough. This patch will skip memory malloc for memory
> address space,which will reduce around 3M physical memory in heap.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/memory.c b/memory.c
> index 64b0a60..0003b1e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>      AddressSpace *as;
>  
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root == as->root && as->malloced) {
> +        if (root == as->root && as == &address_space_memory) {

Of course you need to keep the as->malloced check, don't you?

>              as->ref_count++;
>              return as;
>          }
> 

This is not really beautiful, but compared to v1 and v2 it has the
advantage that it works (with the as->malloced check reintroduced).
Peter, you introduced address_space_init_shareable, what do you think?

Paolo
