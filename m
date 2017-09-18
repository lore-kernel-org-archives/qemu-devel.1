Received: from eggs.gnu.org ([2001:4830:134:3::10]:42124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtwh1-0007nE-4b
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtwgx-0005bU-Tl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:06:35 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dtwgx-0005ar-Jd
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:06:31 -0400
Received: by mail-pf0-x241.google.com with SMTP id g65so234497pfe.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:06:31 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-8-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cdc396c4-f09e-baf3-6da8-8a30122bac4e@ozlabs.ru>
Date: Tue, 19 Sep 2017 00:06:21 +1000
MIME-Version: 1.0
In-Reply-To: <20170918101709.30421-8-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 07/13] memory: Switch memory from
 using AddressSpace to FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 18/09/17 20:17, Alexey Kardashevskiy wrote:
> FlatView's will be shared between AddressSpace's and subpage_t
> and MemoryRegionSection cannot store AS anymore, hence this change.
> 
> In particular, for:
> 
>  typedef struct subpage_t {
>      MemoryRegion iomem;
> -    AddressSpace *as;
> +    FlatView *fv;
>      hwaddr base;
>      uint16_t sub_section[];
>  } subpage_t;
> 
>   struct MemoryRegionSection {
>      MemoryRegion *mr;
> -    AddressSpace *address_space;
> +    FlatView *fv;
>      hwaddr offset_within_region;
>      Int128 size;
>      hwaddr offset_within_address_space;
>      bool readonly;
>  };
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/exec/memory-internal.h |   2 +-
>  include/exec/memory.h          |  51 ++++++++----
>  exec.c                         | 180 ++++++++++++++++++++++++-----------------
>  hw/intc/openpic_kvm.c          |   2 +-
>  memory.c                       |  28 ++++---
>  5 files changed, 157 insertions(+), 106 deletions(-)
> 
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
> index 6e08eda256..1cf8ad9869 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -27,7 +27,7 @@ extern const MemoryRegionOps unassigned_mem_ops;
>  bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
>                                  unsigned size, bool is_write);
>  
> -void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section);
> +void mem_add(FlatView *fv, MemoryRegionSection *section);
>  AddressSpaceDispatch *mem_begin(AddressSpace *as);
>  void mem_commit(AddressSpaceDispatch *d);
>  
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 2346f8b863..7816e5d655 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -48,6 +48,7 @@
>  
>  typedef struct MemoryRegionOps MemoryRegionOps;
>  typedef struct MemoryRegionMmio MemoryRegionMmio;
> +typedef struct FlatView FlatView;
>  

This is missing, apparently. My gcc did not catch it :-/


diff --git a/memory.c b/memory.c
index 69f3334c9b..21e1a6f38f 100644
--- a/memory.c
+++ b/memory.c
@@ -209,7 +209,6 @@ static bool
memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
 }

 typedef struct FlatRange FlatRange;
-typedef struct FlatView FlatView;



-- 
Alexey
