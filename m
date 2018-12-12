Received: from eggs.gnu.org ([2001:4830:134:3::10]:57391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gX823-0006l8-Hp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gX820-0002Pt-CS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:10:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gX820-0002PC-58
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:10:44 -0500
Received: by mail-wm1-x342.google.com with SMTP id y1so6512245wmi.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:10:43 -0800 (PST)
References: <20181212114726.24060-1-ppandit@redhat.com>
	<20181212114726.24060-3-ppandit@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d10a4009-7d52-bc5f-45e8-8c7ba5bf4055@gmail.com>
Date: Wed, 12 Dec 2018 19:10:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181212114726.24060-3-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 2/6] pvrdma: add uar_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hi Prasad,


On 12/12/18 1:47 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Define skeleton 'uar_read' routine. Avoid NULL dereference.
>
> Reported-by: Li Qiang <liq3ea@163.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 23dc9926e3..8a03ab4669 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -448,6 +448,11 @@ static const MemoryRegionOps regs_ops = {
>       },
>   };
>   
> +static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;

The PCI read operation should fail if the read op is  not implemented.
Please use  "return 0xffffffff" to emulate the PCI read failure.
(0 is a successfully read)

Thanks,
Marcel

> +}
> +
>   static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>   {
>       PVRDMADev *dev = opaque;
> @@ -489,6 +494,7 @@ static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>   }
>   
>   static const MemoryRegionOps uar_ops = {
> +    .read = uar_read,
>       .write = uar_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl = {
