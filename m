Received: from eggs.gnu.org ([2001:4830:134:3::10]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eFNTi-0003dl-Sq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eFNTi-0002Fz-3A
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:57:26 -0500
References: <1510846183-756-1-git-send-email-thuth@redhat.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <ac117f5e-49cb-3832-c361-ca27bf574882@redhat.com>
Date: Thu, 16 Nov 2017 10:57:05 -0600
MIME-Version: 1.0
In-Reply-To: <1510846183-756-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Silence xlnx-ep108 deprecation
 warning during tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Alistair Francis <alistair.francis@xilinx.com>



On 11/16/2017 09:29 AM, Thomas Huth wrote:
> The new deprecation warning for the xlnx-ep108 machine also pops up
> during "make check" which is kind of confusing. Silence it if testing
> mode is enabled.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: I slightly shortened the message so that the code still fits
>  into the 80-columns limit.
> 
>  hw/arm/xlnx-zcu102.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 9631a53..bbe7d04 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -24,6 +24,7 @@
>  #include "qemu/error-report.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/log.h"
> +#include "sysemu/qtest.h"
>  
>  typedef struct XlnxZCU102 {
>      MachineState parent_obj;
> @@ -164,8 +165,10 @@ static void xlnx_ep108_init(MachineState *machine)
>  {
>      XlnxZCU102 *s = EP108_MACHINE(machine);
>  
> -    info_report("The Xilinx EP108 machine is deprecated, please use the "
> -                "ZCU102 machine instead. It has the same features supported.");
> +    if (!qtest_enabled()) {
> +        info_report("The Xilinx EP108 machine is deprecated, please use the "
> +                    "ZCU102 machine (which has the same features) instead.");
> +    }
>  
>      xlnx_zynqmp_init(s, machine);
>  }
> 

I tested it and it did solve the problem.

Acked-by: Wei Huang <wei@redhat.com>
