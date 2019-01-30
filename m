Received: from eggs.gnu.org ([209.51.188.92]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosxr-00029i-AY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gosxq-0004T7-Cw
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:43:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gosxo-0004Py-E7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:43:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so155734wrt.11
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 08:43:47 -0800 (PST)
References: <20190130014216.98287-1-aik@ozlabs.ru>
	<20190130134303.754a43ab@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff95d376-1253-a5eb-0a71-02b8b4b76013@redhat.com>
Date: Wed, 30 Jan 2019 17:43:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190130134303.754a43ab@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] spapr: Drop unused
 parameters from fdt building helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Alexey,

On 1/30/19 1:43 PM, Greg Kurz wrote:
> On Wed, 30 Jan 2019 12:42:16 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> spapr_load_rtas() handles now RTAS address and size information in the FDT
>> so drop them from spapr_build_fdt().
>>
>> While we are here, fix a small typo.
>>
>> Fixes: 2cac78c12ade9 "pseries: Consolidate RTAS loading"
> 
> One nit. The last rtas_* user in spapr_build_fdt() was removed by the
> following hunk:
> 
> @@ -949,12 +966,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
>          }
>      }
>  
> -    /* RTAS */
> -    ret = spapr_rtas_device_tree_setup(fdt, rtas_addr, rtas_size);
> -    if (ret < 0) {
> -        error_report("Couldn't set up RTAS device tree properties");
> -    }
> -
>      /* cpus */
>      spapr_populate_cpus_dt_node(fdt, spapr);
>  
> from commit:
> 
> 3f5dabceba24 "pseries: Consolidate construction of /rtas device tree node"

Can you (or David if he agrees) add a line about since when/why it is no
more required?

> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>  hw/ppc/spapr.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index a217c7f..fa12723 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1225,9 +1225,7 @@ static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
>>      }
>>  }
>>  
>> -static void *spapr_build_fdt(sPAPRMachineState *spapr,
>> -                             hwaddr rtas_addr,
>> -                             hwaddr rtas_size)
>> +static void *spapr_build_fdt(sPAPRMachineState *spapr)
>>  {
>>      MachineState *machine = MACHINE(spapr);
>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>> @@ -1644,14 +1642,14 @@ static void spapr_machine_reset(void)
>>  
>>      /*
>>       * We place the device tree and RTAS just below either the top of the RMA,
>> -     * or just below 2GB, whichever is lowere, so that it can be
>> +     * or just below 2GB, whichever is lower, so that it can be
>>       * processed with 32-bit real mode code if necessary
>>       */
>>      rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
>>      rtas_addr = rtas_limit - RTAS_MAX_SIZE;
>>      fdt_addr = rtas_addr - FDT_MAX_SIZE;
>>  
>> -    fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
>> +    fdt = spapr_build_fdt(spapr);
>>  
>>      spapr_load_rtas(spapr, fdt, rtas_addr);
>>  
> 
> 
