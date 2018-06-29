Received: from eggs.gnu.org ([2001:4830:134:3::10]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYui4-0003Sg-6S
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYuhz-00012H-TK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:49:16 -0400
Date: Fri, 29 Jun 2018 16:49:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180629164903.1630ea28@redhat.com>
In-Reply-To: <20180628121417.1980-3-david@redhat.com>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] util/oslib-win32: indicate
 alignment for qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>

On Thu, 28 Jun 2018 14:14:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's set the alignment just like for the posix variant. This will
> implicitly set the alignment of the underlying memory region and
> therefore make memory_region_get_alignment(mr) return something > 0 for
> all memory backends applicable to PCDIMM/NVDIMM.
> 
> This will allow us to drop special handling in pc.c for
> memory_region_get_alignment(mr) == 0, as we can then assume that it is
> always set (and AFAICS >= getpagesize()).
> 
> For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE == getpagesize(),
> therefore alignment of DIMMs will not change, and therefore also not the
> guest physical memory layout.
why not use QEMU_VMALLOC_ALIGN for consistency (on win => getpagesize())
instead of TARGET_PAGE_SIZE like linux allocator does?

Also looking at FIXME comment it notes that VirtualAlloc might have 64K
alignment (though I haven't found it in VirtualAlloc manual).
If that's true then we might need set *align to it to avoid auto-picked
address overlap with previous allocation (not really sure about it).


> For spapr in spapr_memory_plug(), an alignment of 0 would have been used
note that align == 0 would lead to crash where QEMU_ALIGN_UP() is used,
so we don't care to keep it compatible (the same like in commit 92a37a04d)

> until now. Now getpagesize() is used. But as the size of DIMMs has to be
> multiple of 256MB on spapr, automatic address asignment will not change
> the layout (no memory holes will be created as the alignment change will
> not apply if DIMMs start/end on 256MB boundaries).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/oslib-win32.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index bb5ad28bd3..6e87721419 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -76,6 +76,10 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared)
>         memory is page aligned. */
>      ptr = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
>      trace_qemu_anon_ram_alloc(size, ptr);
> +
> +    if (ptr && align) {
> +        *align = getpagesize();
> +    }
>      return ptr;
>  }
>  
