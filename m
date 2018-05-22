Received: from eggs.gnu.org ([2001:4830:134:3::10]:40703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4re-0007lO-0P
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4ra-0001Ck-WC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:58 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4ra-0001CR-Pg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:49:54 -0400
Received: by mail-wr0-x243.google.com with SMTP id w18-v6so15547837wrn.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:49:54 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-5-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-5-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:49:51 +0100
Message-ID: <87k1rwufqo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/27] Make address_space_map() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to address_space_map().
> Its callers either have an attrs value to hand, or don't care
> and can use MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h   | 3 ++-
>  include/sysemu/dma.h    | 3 ++-
>  exec.c                  | 6 ++++--
>  target/ppc/mmu-hash64.c | 3 ++-
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9a30a1bb9e..b1bdb376d4 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1952,9 +1952,10 @@ bool address_space_access_valid(AddressSpace *as, =
hwaddr addr, int len, bool is_
>   * @addr: address within that address space
>   * @plen: pointer to length of buffer; updated on return
>   * @is_write: indicates the transfer direction
> + * @attrs: memory attributes
>   */
>  void *address_space_map(AddressSpace *as, hwaddr addr,
> -                        hwaddr *plen, bool is_write);
> +                        hwaddr *plen, bool is_write, MemTxAttrs attrs);
>
>  /* address_space_unmap: Unmaps a memory region previously mapped by addr=
ess_space_map()
>   *
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index c228c66513..0d73902634 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -132,7 +132,8 @@ static inline void *dma_memory_map(AddressSpace *as,
>      hwaddr xlen =3D *len;
>      void *p;
>
> -    p =3D address_space_map(as, addr, &xlen, dir =3D=3D DMA_DIRECTION_FR=
OM_DEVICE);
> +    p =3D address_space_map(as, addr, &xlen, dir =3D=3D DMA_DIRECTION_FR=
OM_DEVICE,
> +                          MEMTXATTRS_UNSPECIFIED);
>      *len =3D xlen;
>      return p;
>  }
> diff --git a/exec.c b/exec.c
> index d314c7cc39..1dc81cfe4a 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3529,7 +3529,8 @@ flatview_extend_translation(FlatView *fv, hwaddr ad=
dr,
>  void *address_space_map(AddressSpace *as,
>                          hwaddr addr,
>                          hwaddr *plen,
> -                        bool is_write)
> +                        bool is_write,
> +                        MemTxAttrs attrs)
>  {
>      hwaddr len =3D *plen;
>      hwaddr l, xlat;
> @@ -3616,7 +3617,8 @@ void *cpu_physical_memory_map(hwaddr addr,
>                                hwaddr *plen,
>                                int is_write)
>  {
> -    return address_space_map(&address_space_memory, addr, plen, is_write=
);
> +    return address_space_map(&address_space_memory, addr, plen, is_write,
> +                             MEMTXATTRS_UNSPECIFIED);
>  }
>
>  void cpu_physical_memory_unmap(void *buffer, hwaddr len,
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index a1db20e3a8..aa200cba4c 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -431,7 +431,8 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCC=
PU *cpu,
>          return NULL;
>      }
>
> -    hptes =3D address_space_map(CPU(cpu)->as, base + pte_offset, &plen, =
false);
> +    hptes =3D address_space_map(CPU(cpu)->as, base + pte_offset, &plen, =
false,
> +                              MEMTXATTRS_UNSPECIFIED);
>      if (plen < (n * HASH_PTE_SIZE_64)) {
>          hw_error("%s: Unable to map all requested HPTEs\n", __func__);
>      }


--
Alex Benn=C3=A9e
