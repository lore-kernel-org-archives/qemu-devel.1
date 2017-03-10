Received: from eggs.gnu.org ([2001:4830:134:3::10]:54534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmG64-0000ao-LO
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmG60-0007NR-Mk
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:40:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmG60-0007NI-GI
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:40:20 -0500
References: <1489153475-14888-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6936cdb-66c8-72a9-9e54-988ac6b77e4c@redhat.com>
Date: Fri, 10 Mar 2017 09:40:17 +0100
MIME-Version: 1.0
In-Reply-To: <1489153475-14888-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com



On 10/03/2017 14:44, Yang Zhong wrote:
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
> index 284894b..6af80e7 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>      AddressSpace *as;
>  
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root == as->root && as->malloced) {
> +        if (root == as->root) {
>              as->ref_count++;
>              return as;
>          }
> 

This has the same problem as v1.

If as->malloced is false, the AddressSpace might be embedded in another
struct.  This other struct could be freed when as->ref_count is still
greater than 0, causing a use-after-free bug.

Paolo
