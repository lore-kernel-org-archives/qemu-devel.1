Received: from eggs.gnu.org ([209.51.188.92]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNQz-0005ni-Od
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNQw-0002Ag-Oj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLNQt-00025a-A7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so19759899wrt.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 00:44:01 -0700 (PDT)
References: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2faba88e-19a3-2674-afa8-f9cfe8241da9@redhat.com>
Date: Tue, 30 Apr 2019 09:43:58 +0200
MIME-Version: 1.0
In-Reply-To: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] usb/xchi: avoid trigger assertion if
 guest write wrong epid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, kraxel@redhat.com
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org

On 4/30/19 8:21 AM, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> we found the following core in our environment:
> 0  0x00007fc6b06c2237 in raise ()
> 1  0x00007fc6b06c3928 in abort ()
> 2  0x00007fc6b06bb056 in __assert_fail_base ()
> 3  0x00007fc6b06bb102 in __assert_fail ()
> 4  0x0000000000702e36 in xhci_kick_ep (...)
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 6  0x000000000047767f in access_with_adjusted_size (...)
> 7  0x000000000047944d in memory_region_dispatch_write (...)
> (mr=mr@entry=0x7fc6a0138df0, addr=addr@entry=156, data=1648892416,
> size=size@entry=4, attrs=attrs@entry=...)
> 8  0x000000000042df17 in address_space_write_continue (...)
> 10 0x000000000043084d in address_space_rw (...)
> 11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
> 13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
> 15 0x00007fc6b0a60dd5 in start_thread ()
> 16 0x00007fc6b078a59d in clone ()
> 
> (gdb) f 5
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
> (gdb) p /x tmp
> $9 = 0x62481a00 <-- last byte 0x00 is @epid
> 
> xhci_doorbell_write() already check the upper bound of @slotid an @epid,
> it also need to check the lower bound.
> 
> Cc: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v1 -> v2:
>   1) update the description, include the full backtrace
>   2) remove unnecessary check: 'reg == 0'
> 
> ---
>  hw/usb/hcd-xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee..d8472b4 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3137,7 +3137,7 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
>          streamid = (val >> 16) & 0xffff;
>          if (reg > xhci->numslots) {
>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
> -        } else if (epid > 31) {
> +        } else if (epid == 0 || epid > 31) {
>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>                      (int)reg, (uint32_t)val);
>          } else {
> 
