Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL50L-0003sE-Tm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL50K-0004UV-Ph
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:58 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL50K-0004UE-GC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:56 -0400
Received: by mail-wm0-x244.google.com with SMTP id f8-v6so32337385wmc.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:58:56 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-11-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-11-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:58:53 +0100
Message-ID: <87bmd8ufbm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/27] Make flatview_translate() take a
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
> add MemTxAttrs as an argument to flatview_translate(); all its
> callers now have attrs available.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h |  7 ++++---
>  exec.c                | 17 +++++++++--------
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 444fceac55..3980ab47ed 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1913,7 +1913,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(Address=
Space *as, hwaddr addr,
>   */
>  MemoryRegion *flatview_translate(FlatView *fv,
>                                   hwaddr addr, hwaddr *xlat,
> -                                 hwaddr *len, bool is_write);
> +                                 hwaddr *len, bool is_write,
> +                                 MemTxAttrs attrs);
>
>  static inline MemoryRegion *address_space_translate(AddressSpace *as,
>                                                      hwaddr addr, hwaddr =
*xlat,
> @@ -1921,7 +1922,7 @@ static inline MemoryRegion *address_space_translate=
(AddressSpace *as,
>                                                      MemTxAttrs attrs)
>  {
>      return flatview_translate(address_space_to_flatview(as),
> -                              addr, xlat, len, is_write);
> +                              addr, xlat, len, is_write, attrs);
>  }
>
>  /* address_space_access_valid: check for validity of accessing an address
> @@ -2030,7 +2031,7 @@ MemTxResult address_space_read(AddressSpace *as, hw=
addr addr,
>              rcu_read_lock();
>              fv =3D address_space_to_flatview(as);
>              l =3D len;
> -            mr =3D flatview_translate(fv, addr, &addr1, &l, false);
> +            mr =3D flatview_translate(fv, addr, &addr1, &l, false, attrs=
);
>              if (len =3D=3D l && memory_access_is_direct(mr, false)) {
>                  ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
>                  memcpy(buf, ptr, len);
> diff --git a/exec.c b/exec.c
> index 9229fb4058..b818ba87f4 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -618,7 +618,8 @@ iotlb_fail:
>
>  /* Called from RCU critical section */
>  MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
> -                                 hwaddr *plen, bool is_write)
> +                                 hwaddr *plen, bool is_write,
> +                                 MemTxAttrs attrs)
>  {
>      MemoryRegion *mr;
>      MemoryRegionSection section;
> @@ -3152,7 +3153,7 @@ static MemTxResult flatview_write_continue(FlatView=
 *fv, hwaddr addr,
>          }
>
>          l =3D len;
> -        mr =3D flatview_translate(fv, addr, &addr1, &l, true);
> +        mr =3D flatview_translate(fv, addr, &addr1, &l, true, attrs);
>      }
>
>      return result;
> @@ -3168,7 +3169,7 @@ static MemTxResult flatview_write(FlatView *fv, hwa=
ddr addr, MemTxAttrs attrs,
>      MemTxResult result =3D MEMTX_OK;
>
>      l =3D len;
> -    mr =3D flatview_translate(fv, addr, &addr1, &l, true);
> +    mr =3D flatview_translate(fv, addr, &addr1, &l, true, attrs);
>      result =3D flatview_write_continue(fv, addr, attrs, buf, len,
>                                       addr1, l, mr);
>
> @@ -3239,7 +3240,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hw=
addr addr,
>          }
>
>          l =3D len;
> -        mr =3D flatview_translate(fv, addr, &addr1, &l, false);
> +        mr =3D flatview_translate(fv, addr, &addr1, &l, false, attrs);
>      }
>
>      return result;
> @@ -3254,7 +3255,7 @@ static MemTxResult flatview_read(FlatView *fv, hwad=
dr addr,
>      MemoryRegion *mr;
>
>      l =3D len;
> -    mr =3D flatview_translate(fv, addr, &addr1, &l, false);
> +    mr =3D flatview_translate(fv, addr, &addr1, &l, false, attrs);
>      return flatview_read_continue(fv, addr, attrs, buf, len,
>                                    addr1, l, mr);
>  }
> @@ -3468,7 +3469,7 @@ static bool flatview_access_valid(FlatView *fv, hwa=
ddr addr, int len,
>
>      while (len > 0) {
>          l =3D len;
> -        mr =3D flatview_translate(fv, addr, &xlat, &l, is_write);
> +        mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>          if (!memory_access_is_direct(mr, is_write)) {
>              l =3D memory_access_size(mr, l, addr);
>              /* When our callers all have attrs we'll pass them through h=
ere */
> @@ -3517,7 +3518,7 @@ flatview_extend_translation(FlatView *fv, hwaddr ad=
dr,
>
>          len =3D target_len;
>          this_mr =3D flatview_translate(fv, addr, &xlat,
> -                                                   &len, is_write);
> +                                     &len, is_write, attrs);
>          if (this_mr !=3D mr || xlat !=3D base + done) {
>              return done;
>          }
> @@ -3550,7 +3551,7 @@ void *address_space_map(AddressSpace *as,
>      l =3D len;
>      rcu_read_lock();
>      fv =3D address_space_to_flatview(as);
> -    mr =3D flatview_translate(fv, addr, &xlat, &l, is_write);
> +    mr =3D flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {


--
Alex Benn=C3=A9e
