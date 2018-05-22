Received: from eggs.gnu.org ([2001:4830:134:3::10]:42143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4yG-0002US-6D
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL4yD-0003cx-77
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:56:48 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL4yD-0003cI-0v
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:56:45 -0400
Received: by mail-wm0-x242.google.com with SMTP id t11-v6so30768921wmt.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:56:44 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-7-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-7-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:56:41 +0100
Message-ID: <87h8n0uffa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/27] Make flatview_extend_translation()
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
> add MemTxAttrs as an argument to flatview_extend_translation().
> Its callers either have an attrs value to hand, or don't care
> and can use MEMTXATTRS_UNSPECIFIED.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 22af4e8cb9..718b33921b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3495,9 +3495,9 @@ bool address_space_access_valid(AddressSpace *as, h=
waddr addr,
>
>  static hwaddr
>  flatview_extend_translation(FlatView *fv, hwaddr addr,
> -                                 hwaddr target_len,
> -                                 MemoryRegion *mr, hwaddr base, hwaddr l=
en,
> -                                 bool is_write)
> +                            hwaddr target_len,
> +                            MemoryRegion *mr, hwaddr base, hwaddr len,
> +                            bool is_write, MemTxAttrs attrs)
>  {
>      hwaddr done =3D 0;
>      hwaddr xlat;
> @@ -3574,7 +3574,7 @@ void *address_space_map(AddressSpace *as,
>
>      memory_region_ref(mr);
>      *plen =3D flatview_extend_translation(fv, addr, len, mr, xlat,
> -                                             l, is_write);
> +                                        l, is_write, attrs);
>      ptr =3D qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
>      rcu_read_unlock();
>
> @@ -3659,8 +3659,13 @@ int64_t address_space_cache_init(MemoryRegionCache=
 *cache,
>      mr =3D cache->mrs.mr;
>      memory_region_ref(mr);
>      if (memory_access_is_direct(mr, is_write)) {
> +        /* We don't care about the memory attributes here as we're only
> +         * doing this if we found actual RAM, which behaves the same
> +         * regardless of attributes; so UNSPECIFIED is fine.
> +         */
>          l =3D flatview_extend_translation(cache->fv, addr, len, mr,
> -                                        cache->xlat, l, is_write);
> +                                        cache->xlat, l, is_write,
> +                                        MEMTXATTRS_UNSPECIFIED);
>          cache->ptr =3D qemu_ram_ptr_length(mr->ram_block, cache->xlat, &=
l, true);
>      } else {
>          cache->ptr =3D NULL;


--
Alex Benn=C3=A9e
