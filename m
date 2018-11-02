Received: from eggs.gnu.org ([2001:4830:134:3::10]:39341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIUFR-0003Ml-Gc
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIUFO-0005B2-40
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIUFN-0005A5-R0
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so1087529wmh.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 00:52:01 -0700 (PDT)
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db1c6887-8c1d-62e5-8363-2b775892ed6f@redhat.com>
Date: Fri, 2 Nov 2018 08:51:56 +0100
MIME-Version: 1.0
In-Reply-To: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, ppandit@redhat.com

On 2/11/18 2:22, Li Qiang wrote:
> Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> This can lead an oob access issue. This is triggerable in the guest.
> Add check to avoid this issue.
> 
> Fixes CVE-2018-16847.
> 
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>   hw/block/nvme.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index fc7dacb..d097add 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
>       unsigned size)
>   {
>       NvmeCtrl *n = (NvmeCtrl *)opaque;
> +
> +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {

Should this be reported via qemu_log_mask(LOG_GUEST_ERROR, ...)?

> +        return;
> +    }
>       memcpy(&n->cmbuf[addr], &data, size);
>   }
>   
> @@ -1183,6 +1187,9 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr addr, unsigned size)
>       uint64_t val;
>       NvmeCtrl *n = (NvmeCtrl *)opaque;
>   
> +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {

Ditto.

> +        return 0;
> +    }
>       memcpy(&val, &n->cmbuf[addr], size);
>       return val;
>   }
> 
