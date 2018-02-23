Received: from eggs.gnu.org ([2001:4830:134:3::10]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epFon-0002Qr-Gn
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epFoi-0005EG-Ga
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:03:29 -0500
References: <1519400599-21081-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519400599-21081-6-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66c09cf1-464f-fb31-521c-7ab33c07b26c@redhat.com>
Date: Fri, 23 Feb 2018 17:03:01 +0100
MIME-Version: 1.0
In-Reply-To: <1519400599-21081-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 05/13] s390-ccw: move auxiliary IPL data
 to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

On 23.02.2018 16:43, Collin L. Walling wrote:
> The s390-ccw firmware needs some information in support of the
> boot process which is not available on the native machine.
> Examples are the netboot firmware load address and now the
> boot menu parameters.
> 
> While storing that data in unused fields of the IPL parameter block
> works, that approach could create problems if the parameter block
> definition should change in the future. Because then a guest could
> overwrite these fields using the set IPLB diagnose.
> 
> In fact the data in question is of more global nature and not really
> tied to an IPL device, so separating it is rather logical.
> 
> This commit introduces a new structure to hold firmware relevant
> IPL parameters set by QEMU. The data is stored at location 204 (dec)
> and can contain up to 7 32-bit words. This area is available to
> programming in the z/Architecture Principles of Operation and
> can thus safely be used by the firmware until the IPL has completed.
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c          | 18 +++++++++++++++++-
>  hw/s390x/ipl.h          | 25 +++++++++++++++++++++++--
>  pc-bios/s390-ccw/iplb.h | 18 ++++++++++++++++--
>  pc-bios/s390-ccw/main.c |  6 +++++-
>  4 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..79f5a58 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -399,6 +399,21 @@ void s390_reipl_request(void)
>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>  }
>  
> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    uint8_t *addr;
> +    uint64_t len = 4096;
> +
> +    addr = cpu_physical_memory_map(cpu->env.psa, &len, 1);
> +    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
> +        error_report("Cannot set QEMU IPL parameters");
> +        return;
> +    }
> +    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
> +    cpu_physical_memory_unmap(addr, len, 1, len);
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl = get_ipl_device();
> @@ -418,8 +433,9 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              error_report_err(err);
>              vm_stop(RUN_STATE_INTERNAL_ERROR);
>          }
> -        ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
> +        ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
>      }
> +    s390_ipl_prepare_qipl(cpu);
>  }
>  
>  static void s390_ipl_reset(DeviceState *dev)
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8a705e0..08926a3 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -16,8 +16,7 @@
>  #include "cpu.h"
>  
>  struct IplBlockCcw {
> -    uint64_t netboot_start_addr;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[85];
>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -90,6 +89,27 @@ void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
>  void s390_reipl_request(void);
>  
> +#define QIPL_ADDRESS  0xcc
> +
> +/*
> + * The QEMU IPL Parameters will be stored at absolute address
> + * 204 (0xcc) which means it is 32-bit word aligned but not
> + * double-word aligned.
> + * Placement of data fields in this area must account for
> + * their alignment needs. E.g., netboot_start_address must
> + * have an offset of n * 8 bytes within the struct in order

Please replace "n * 8" with "4 + n * 8" in your tree. I can fix it up
manually again, but in case we need a v10 ...

 Thomas
