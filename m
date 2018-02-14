Received: from eggs.gnu.org ([2001:4830:134:3::10]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elukS-0003IZ-Ly
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elukP-0002nF-KR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:57:12 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8259c694-3f9a-ce9e-9d1d-252568f3e73a@redhat.com>
Date: Wed, 14 Feb 2018 11:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 05.02.2018 21:57, Collin L. Walling wrote:
> It is possible while waiting for multiple types of external
> interrupts that we might have pending irqs remaining between
> irq consumption and irq disabling. Those interrupts could
> propagate to the guest after IPL completes and cause unwanted
> behavior.
> 
> To avoid this, we clear the write event mask to prevent further
> service interrupts from ASCII events and then consume all pending
> irqs for a miniscule duration. Once finished, we reset the write
> event mask and resume business as usual.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c | 16 ++++++++++++++++
>  pc-bios/s390-ccw/sclp.c | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 85d285f..971f6b6 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -64,6 +64,20 @@ static inline bool check_clock_int(void)
>      return *code == 0x1004;
>  }
>  
> +static void clear_pending_irqs(void)
> +{
> +    uint64_t time = 50 * TOD_CLOCK_SECOND / 0x3e8;
> +
> +    sclp_clear_write_mask();
> +
> +    set_clock_comparator(get_clock() + time);
> +    enable_clock_int();
> +    consume_sclp_int();
> +    disable_clock_int();
> +
> +    sclp_setup(); /* re-enable write mask */
> +}
> +
>  static int read_prompt(char *buf, size_t len)
>  {
>      char inp[2] = {};
> @@ -165,6 +179,8 @@ static int get_boot_index(int entries)
>      sclp_print("\nBooting entry #");
>      sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
>  
> +    clear_pending_irqs();
> +
>      return boot_index;
>  }
>  
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 5902d5b..025eb2d 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -46,6 +46,18 @@ static int sclp_service_call(unsigned int command, void *sccb)
>          return 0;
>  }
>  
> +void sclp_clear_write_mask(void)
> +{
> +    WriteEventMask *sccb = (void *)_sccb;
> +
> +    sccb->h.length = sizeof(WriteEventMask);
> +    sccb->mask_length = sizeof(unsigned int);
> +    sccb->cp_receive_mask = 0;
> +    sccb->cp_send_mask = 0;
> +
> +    sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
> +}
> +
>  static void sclp_set_write_mask(void)
>  {
>      WriteEventMask *sccb = (void *)_sccb;
> 

1. CKC interrupts can be cleared by resetting the CKC
2. SCLP interrupts can be cleared only via delivery (apart from CPU reset)

So if you have CKC and SCLP pending at the same time, you get the CKC
delivered first and the SCLP remains pending.

Now, the easiest way to clear that (if you don't know if any is
pending!) is to simply print a string. Then you know that you have
exactly one SCLP interrupt pending.

So simply printing a string after potentially reading should be
sufficient to clear the SCLP interrupt deterministically :)

-- 

Thanks,

David / dhildenb
