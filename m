Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL502-0003db-Sj
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4zz-0004Or-Tl
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4zz-0004OZ-Mz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:58:35 -0400
Received: by mail-wr0-x241.google.com with SMTP id k5-v6so7260105wrn.3
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:58:35 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-10-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-10-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:58:33 +0100
Message-ID: <87d0xoufc6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/27] Make flatview_access_valid() take a
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
> add MemTxAttrs as an argument to flatview_access_valid().
> Its callers now all have an attrs value to hand, so we can
> correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index b58eb0fedd..9229fb4058 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2697,7 +2697,7 @@ static MemTxResult flatview_read(FlatView *fv, hwad=
dr addr,
>  static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs =
attrs,
>                                    const uint8_t *buf, int len);
>  static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
> -                                  bool is_write);
> +                                  bool is_write, MemTxAttrs attrs);
>
>  static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *dat=
a,
>                                  unsigned len, MemTxAttrs attrs)
> @@ -2773,7 +2773,7 @@ static bool subpage_accepts(void *opaque, hwaddr ad=
dr,
>  #endif
>
>      return flatview_access_valid(subpage->fv, addr + subpage->base,
> -                                 len, is_write);
> +                                 len, is_write, attrs);
>  }
>
>  static const MemoryRegionOps subpage_ops =3D {
> @@ -3461,7 +3461,7 @@ static void cpu_notify_map_clients(void)
>  }
>
>  static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
> -                                  bool is_write)
> +                                  bool is_write, MemTxAttrs attrs)
>  {
>      MemoryRegion *mr;
>      hwaddr l, xlat;
> @@ -3472,8 +3472,7 @@ static bool flatview_access_valid(FlatView *fv, hwa=
ddr addr, int len,
>          if (!memory_access_is_direct(mr, is_write)) {
>              l =3D memory_access_size(mr, l, addr);
>              /* When our callers all have attrs we'll pass them through h=
ere */
> -            if (!memory_region_access_valid(mr, xlat, l, is_write,
> -                                            MEMTXATTRS_UNSPECIFIED)) {
> +            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs=
)) {
>                  return false;
>              }
>          }
> @@ -3493,7 +3492,7 @@ bool address_space_access_valid(AddressSpace *as, h=
waddr addr,
>
>      rcu_read_lock();
>      fv =3D address_space_to_flatview(as);
> -    result =3D flatview_access_valid(fv, addr, len, is_write);
> +    result =3D flatview_access_valid(fv, addr, len, is_write, attrs);
>      rcu_read_unlock();
>      return result;
>  }


--
Alex Benn=C3=A9e
