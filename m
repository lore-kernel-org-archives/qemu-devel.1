Received: from eggs.gnu.org ([2001:4830:134:3::10]:32842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g04fu-0006qF-6c
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g04fs-0007GD-J0
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:18 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g04fr-0007AU-O3
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:55:16 -0400
Received: by mail-oi0-x244.google.com with SMTP id x197-v6so3435253oix.5
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 05:55:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Sep 2018 13:54:50 +0100
Message-ID: <CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory region: check the old.mmio.read
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2018 at 13:32, Li Qiang <liq3ea@gmail.com> wrote:
> To avoid NULL-deref for the devices without read callbacks
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/memory.c b/memory.c
> index 9b73892768..48d025426b 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -406,6 +406,10 @@ static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
>  {
>      uint64_t tmp;
>
> +    if (!mr->ops->old_mmio.read[ctz32(size)]) {
> +        return MEMTX_DECODE_ERROR;
> +    }
> +
>      tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
> --
> 2.11.0
>

There's patches on-list which drop the old_mmio field from the MemoryRegion
struct entirely, so I think this patch as it stands is obsolete.

Currently our semantics are "you must provide both read and write, even
if one of them just always returns 0 / does nothing / returns an error".
We could probably reasonably assert this at the point when the
MemoryRegionOps is registered.

thanks
-- PMM
