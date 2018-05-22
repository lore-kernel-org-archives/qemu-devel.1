Received: from eggs.gnu.org ([2001:4830:134:3::10]:42277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4yk-0002ma-Nv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4yh-0003s8-NJ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:57:18 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4yh-0003rp-DO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:57:15 -0400
Received: by mail-wm0-x242.google.com with SMTP id t11-v6so30772621wmt.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:57:15 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-8-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-8-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:57:12 +0100
Message-ID: <87fu2kufef.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/27] Make memory_region_access_valid()
 take a MemTxAttrs argument
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
> add MemTxAttrs as an argument to memory_region_access_valid().
> Its callers either have an attrs value to hand, or don't care
> and can use MEMTXATTRS_UNSPECIFIED.
>
> The callsite in flatview_access_valid() is part of a recursive
> loop flatview_access_valid() -> memory_region_access_valid() ->
>  subpage_accepts() -> flatview_access_valid(); we make it pass
> MEMTXATTRS_UNSPECIFIED for now, until the next several commits
> have plumbed an attrs parameter through the rest of the loop
> and we can add an attrs parameter to flatview_access_valid().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory-internal.h | 3 ++-
>  exec.c                         | 4 +++-
>  hw/s390x/s390-pci-inst.c       | 3 ++-
>  memory.c                       | 7 ++++---
>  4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-interna=
l.h
> index 58399b9318..56c25c0ef7 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -37,7 +37,8 @@ void flatview_unref(FlatView *view);
>  extern const MemoryRegionOps unassigned_mem_ops;
>
>  bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
> -                                unsigned size, bool is_write);
> +                                unsigned size, bool is_write,
> +                                MemTxAttrs attrs);
>
>  void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section=
);
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
> diff --git a/exec.c b/exec.c
> index 718b33921b..6cf97b5d28 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3468,7 +3468,9 @@ static bool flatview_access_valid(FlatView *fv, hwa=
ddr addr, int len,
>          mr =3D flatview_translate(fv, addr, &xlat, &l, is_write);
>          if (!memory_access_is_direct(mr, is_write)) {
>              l =3D memory_access_size(mr, l, addr);
> -            if (!memory_region_access_valid(mr, xlat, l, is_write)) {
> +            /* When our callers all have attrs we'll pass them through h=
ere */
> +            if (!memory_region_access_valid(mr, xlat, l, is_write,
> +                                            MEMTXATTRS_UNSPECIFIED)) {
>                  return false;
>              }
>          }
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 02a815fd31..d1a5f79678 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -762,7 +762,8 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uin=
t8_t r3, uint64_t gaddr,
>      mr =3D s390_get_subregion(mr, offset, len);
>      offset -=3D mr->addr;
>
> -    if (!memory_region_access_valid(mr, offset, len, true)) {
> +    if (!memory_region_access_valid(mr, offset, len, true,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
>          s390_program_interrupt(env, PGM_OPERAND, 6, ra);
>          return 0;
>      }
> diff --git a/memory.c b/memory.c
> index fc7f9b782b..279f7c9b4a 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1347,7 +1347,8 @@ static const MemoryRegionOps ram_device_mem_ops =3D=
 {
>  bool memory_region_access_valid(MemoryRegion *mr,
>                                  hwaddr addr,
>                                  unsigned size,
> -                                bool is_write)
> +                                bool is_write,
> +                                MemTxAttrs attrs)
>  {
>      int access_size_min, access_size_max;
>      int access_size, i;
> @@ -1416,7 +1417,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegio=
n *mr,
>  {
>      MemTxResult r;
>
> -    if (!memory_region_access_valid(mr, addr, size, false)) {
> +    if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
>          *pval =3D unassigned_mem_read(mr, addr, size);
>          return MEMTX_DECODE_ERROR;
>      }
> @@ -1458,7 +1459,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegi=
on *mr,
>                                           unsigned size,
>                                           MemTxAttrs attrs)
>  {
> -    if (!memory_region_access_valid(mr, addr, size, true)) {
> +    if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
>          unassigned_mem_write(mr, addr, data, size);
>          return MEMTX_DECODE_ERROR;
>      }


--
Alex Benn=C3=A9e
