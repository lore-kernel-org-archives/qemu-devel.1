Received: from eggs.gnu.org ([2001:4830:134:3::10]:42847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL51b-0004u2-Vf
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL51b-0005Em-97
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:16 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL51b-0005Dy-3I
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:00:15 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n10-v6so32195774wmc.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 04:00:14 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-12-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-12-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 12:00:11 +0100
Message-ID: <87a7ssuf9g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/27] Make address_space_get_iotlb_entry()
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
> add MemTxAttrs as an argument to address_space_get_iotlb_entry().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/memory.h | 2 +-
>  exec.c                | 2 +-
>  hw/virtio/vhost.c     | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3980ab47ed..309fdfb89b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1896,7 +1896,7 @@ void address_space_cache_destroy(MemoryRegionCache =
*cache);
>   * entry. Should be called from an RCU critical section.
>   */
>  IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr add=
r,
> -                                            bool is_write);
> +                                            bool is_write, MemTxAttrs at=
trs);
>
>  /* address_space_translate: translate an address range into an address s=
pace
>   * into a MemoryRegion and an address range into that section.  Should be
> diff --git a/exec.c b/exec.c
> index b818ba87f4..84f2c21ecb 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -582,7 +582,7 @@ static MemoryRegionSection flatview_do_translate(Flat=
View *fv,
>
>  /* Called from RCU critical section */
>  IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr add=
r,
> -                                            bool is_write)
> +                                            bool is_write, MemTxAttrs at=
trs)
>  {
>      MemoryRegionSection section;
>      hwaddr xlat, page_mask;
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9d5850a7d7..48f4fd7cc9 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -895,7 +895,8 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, ui=
nt64_t iova, int write)
>      rcu_read_lock();
>
>      iotlb =3D address_space_get_iotlb_entry(dev->vdev->dma_as,
> -                                          iova, write);
> +                                          iova, write,
> +                                          MEMTXATTRS_UNSPECIFIED);
>      if (iotlb.target_as !=3D NULL) {
>          ret =3D vhost_memory_region_lookup(dev, iotlb.translated_addr,
>                                           &uaddr, &len);


--
Alex Benn=C3=A9e
