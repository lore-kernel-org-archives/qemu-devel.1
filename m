Received: from eggs.gnu.org ([2001:4830:134:3::10]:42913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL520-0005CD-KC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL51x-0005SQ-Lv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:40 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL51x-0005S2-51
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id t11-v6so30798119wmt.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 04:00:36 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-13-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-13-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 12:00:33 +0100
Message-ID: <878t8cuf8u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/27] Make flatview_do_translate() take a
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
> add MemTxAttrs as an argument to flatview_do_translate().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 84f2c21ecb..af2b82d154 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -541,6 +541,7 @@ unassigned:
>   * @is_write: whether the translation operation is for write
>   * @is_mmio: whether this can be MMIO, set true if it can
>   * @target_as: the address space targeted by the IOMMU
> + * @attrs: memory transaction attributes
>   *
>   * This function is called from RCU critical section
>   */
> @@ -551,7 +552,8 @@ static MemoryRegionSection flatview_do_translate(Flat=
View *fv,
>                                                   hwaddr *page_mask_out,
>                                                   bool is_write,
>                                                   bool is_mmio,
> -                                                 AddressSpace **target_a=
s)
> +                                                 AddressSpace **target_a=
s,
> +                                                 MemTxAttrs attrs)
>  {
>      MemoryRegionSection *section;
>      IOMMUMemoryRegion *iommu_mr;
> @@ -592,7 +594,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSp=
ace *as, hwaddr addr,
>       * but page mask.
>       */
>      section =3D flatview_do_translate(address_space_to_flatview(as), add=
r, &xlat,
> -                                    NULL, &page_mask, is_write, false, &=
as);
> +                                    NULL, &page_mask, is_write, false, &=
as,
> +                                    attrs);
>
>      /* Illegal translation */
>      if (section.mr =3D=3D &io_mem_unassigned) {
> @@ -627,7 +630,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr=
 addr, hwaddr *xlat,
>
>      /* This can be MMIO, so setup MMIO bit. */
>      section =3D flatview_do_translate(fv, addr, xlat, plen, NULL,
> -                                    is_write, true, &as);
> +                                    is_write, true, &as, attrs);
>      mr =3D section.mr;
>
>      if (xen_enabled() && memory_access_is_direct(mr, is_write)) {


--
Alex Benn=C3=A9e
