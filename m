Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFyTN-0005zU-Lx
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFyTK-0003rE-GX
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:32:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFyTK-0003qC-7U
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:32:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so621007wrs.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 02:32:00 -0700 (PDT)
References: <20181022121416.13425-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d10991a-f792-ec37-0f33-bc1292e30757@redhat.com>
Date: Fri, 26 Oct 2018 11:31:57 +0200
MIME-Version: 1.0
In-Reply-To: <20181022121416.13425-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] nvme: check size before memcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Keith Busch <keith.busch@intel.com>, Caihongzhu <caihongzhu@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 22/10/2018 14:14, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While in nvme_mmio_read, memcpy could read past the 'n->bar'
> buffer, if addr offset was pointing towards its tail end.
> Add check to avoid OOB access.
> 
> Reported-by: Caihongzhu <caihongzhu@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index fc7dacb816..87afc19b61 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1059,7 +1059,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>          /* should RAZ, fall through for now */
>      }
>  
> -    if (addr < sizeof(n->bar)) {
> +    if (addr + size <= sizeof(n->bar)) {
>          memcpy(&val, ptr + addr, size);
>      } else {
>          NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
> 

Do you have a reproducer?  In particular, I think this cannot happen
because memory_region_dispatch_read will block accesses beyond 4 bytes,
and earlier code in this function already check that accesses are
aligned to 32 bits.

We could clarify it with

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816..427e69a78d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1167,7 +1167,7 @@ static const MemoryRegionOps nvme_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 2,
-        .max_access_size = 8,
+        .max_access_size = 4,
     },
 };


but if my understanding is right then there is no bug.

Paolo
