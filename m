Received: from eggs.gnu.org ([2001:4830:134:3::10]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw6KP-0003T0-C8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw6KM-0006zN-45
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cw6KL-0006xr-OX
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:15:49 -0400
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
	<20170406111646.12624-4-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <865405dc-f785-c458-3de7-dfc49dfca15f@redhat.com>
Date: Thu, 6 Apr 2017 14:15:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170406111646.12624-4-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] s390x/pci: make printf
 always compile in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, Danil Antonov <g.danil.anto@gmail.com>, agraf@suse.de

On 06.04.2017 13:16, Cornelia Huck wrote:
> From: Danil Antonov <g.danil.anto@gmail.com>
> 
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
> 
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> Message-Id: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 16 ++++++++++------
>  hw/s390x/s390-pci-inst.c | 16 ++++++++++------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 69b0291e8a..0f62363434 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -24,14 +24,18 @@
>  #include "qemu/error-report.h"
>  
>  /* #define DEBUG_S390PCI_BUS */

This comment is now somewhat misleading. If you uncomment this "#define
DEBUG_S390PCI_BUS" (without adding a "1" at the end), you end up with
some empty "if ()" statements now, i.e. compilation failures. So I'd
like to suggest to simply remove the above line.

> -#ifdef DEBUG_S390PCI_BUS
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> +
> +#ifndef DEBUG_S390PCI_BUS
> +#define DEBUG_S390PCI_BUS  0
>  #endif
>  
> +#define DPRINTF(fmt, ...)                                         \
> +    do {                                                          \
> +        if (DEBUG_S390PCI_BUS) {                                  \
> +            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
> +        }                                                         \
> +    } while (0)
> +
>  S390pciState *s390_get_phb(void)
>  {
>      static S390pciState *phb;
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index d2a8c0a083..763eebd67f 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -21,14 +21,18 @@
>  #include "sysemu/hw_accel.h"
>  
>  /* #define DEBUG_S390PCI_INST */

dito

> -#ifdef DEBUG_S390PCI_INST
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> +
> +#ifndef DEBUG_S390PCI_INST
> +#define DEBUG_S390PCI_INST  0
>  #endif
>  
> +#define DPRINTF(fmt, ...)                                          \
> +    do {                                                           \
> +        if (DEBUG_S390PCI_INST) {                                  \
> +            fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); \
> +        }                                                          \
> +    } while (0)
> +
>  static void s390_set_status_code(CPUS390XState *env,
>                                   uint8_t r, uint64_t status_code)
>  {
> 

 Thomas
