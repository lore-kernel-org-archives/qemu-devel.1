Received: from eggs.gnu.org ([2001:4830:134:3::10]:51685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cla4W-00059b-Ps
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cla4V-0001lU-SS
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:48:00 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cla4V-0001jk-JF
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:47:59 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v186so112659771wmd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 03:47:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308105409.18183-1-dgilbert@redhat.com>
References: <20170308105409.18183-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 12:47:37 +0100
Message-ID: <CAFEAcA9=1c36hkJWycFWUCs5=XOATmadc=xZun7txKgJtk0NPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 8 March 2017 at 11:54, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The 'name' parameter to memory_region_init_* had been marked as debug
> only, however vmstate_region_ram uses it as a parameter to
> qemu_ram_set_idstr to set RAMBlock names and these form part of the
> migration stream.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/exec/memory.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6911023..de8f69e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -307,7 +307,7 @@ struct MemoryRegionSection {
>   *
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream

...for RAM-backend MRs only, presumably? Also, what are the
uniqueness constraints?

>   * @size: size of the region; any subregions beyond this size will be clipped
>   */
>  void memory_region_init(MemoryRegion *mr,
> @@ -355,7 +355,7 @@ void memory_region_unref(MemoryRegion *mr);
>   * @ops: a structure containing read and write callbacks to be used when
>   *       I/O is performed on the region.
>   * @opaque: passed to the read and write callbacks of the @ops structure.
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream

ditto.

>   * @size: size of the region.
>   */
>  void memory_region_init_io(MemoryRegion *mr,
> @@ -474,7 +474,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>   *
>   * @mr: the #MemoryRegion to be initialized.
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @orig: the region to be referenced; @mr will be equivalent to
>   *        @orig between @offset and @offset + @size - 1.
>   * @offset: start of the section in @orig to be referenced.

The diff here is rather lacking in context, but this comment change
is for memory_region_init_alias(). Aliases presumably don't get
migrated (the thing they alias into will be migrated if it's RAM),
so the comment seems out of place here.

> @@ -537,7 +537,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>   *
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region.
>   */
>  static inline void memory_region_init_reservation(MemoryRegion *mr,

Similarly, a reservation MR isn't RAM-backed.

> @@ -558,7 +558,7 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
>   * @mr: the #MemoryRegion to be initialized
>   * @owner: the object that tracks the region's reference count
>   * @ops: a function that translates addresses into the @target region
> - * @name: used for debugging; not visible to the user or ABI
> + * @name: Region name, becomes part of RAMBlock name used in migration stream
>   * @size: size of the region.
>   */
>  void memory_region_init_iommu(MemoryRegion *mr,

...and nor is an IOMMU MR.

> --
> 2.9.3
>


thanks
-- PMM

-- 
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8
