Received: from eggs.gnu.org ([209.51.188.92]:55225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gweTP-0004rK-4z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gweTM-0007yE-BX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:52:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gweTL-0007ti-Av
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 21:52:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1L2n379011550
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 21:52:16 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qsgk2x8mr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 21:52:16 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 21 Feb 2019 02:52:15 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-16-git-send-email-jjherne@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 20 Feb 2019 21:52:07 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-16-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <95cb3df5-89cb-0d28-5fb7-2cea5d139484@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 15/15] s390-bios: Support
 booting from real dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
> Allows guest to boot from a vfio configured real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   docs/devel/s390-dasd-ipl.txt | 132 +++++++++++++++++++++++
>   pc-bios/s390-ccw/Makefile    |   2 +-
>   pc-bios/s390-ccw/dasd-ipl.c  | 249 +++++++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/dasd-ipl.h  |  16 +++
>   pc-bios/s390-ccw/main.c      |   4 +
>   pc-bios/s390-ccw/s390-arch.h |  13 +++
>   6 files changed, 415 insertions(+), 1 deletion(-)
>   create mode 100644 docs/devel/s390-dasd-ipl.txt
>   create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
>   create mode 100644 pc-bios/s390-ccw/dasd-ipl.h

...snip...

> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> new file mode 100644
> index 0000000..b7ce6d9
> --- /dev/null
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -0,0 +1,249 @@

...snip...

> +static void ipl1_fixup(void)
> +{
> +    Ccw0 *ccwSeek = (Ccw0 *) 0x08;
> +    Ccw0 *ccwSearchID = (Ccw0 *) 0x10;
> +    Ccw0 *ccwSearchTic = (Ccw0 *) 0x18;
> +    Ccw0 *ccwRead = (Ccw0 *) 0x20;
> +    CcwSeekData *seekData = (CcwSeekData *) 0x30;
> +    CcwSearchIdData *searchData = (CcwSearchIdData *) 0x38;
> +
> +    /* move IPL1 CCWs to make room for CCWs needed to locate record 2 */
> +    memcpy(ccwRead, (void *)0x08, 16);
> +
> +    /* Disable chaining so we don't TIC to IPL2 channel program */
> +    ccwRead->chain = 0x00;
> +
> +    ccwSeek->cmd_code = CCW_CMD_DASD_SEEK;
> +    ccwSeek->cda = ptr2u32(seekData);
> +    ccwSeek->chain = 1;
> +    ccwSeek->count = sizeof(seekData);

This needs to be sizeof(*seekData)

> +    seekData->reserved = 0x00;
> +    seekData->cyl = 0x00;
> +    seekData->head = 0x00;
> +
> +    ccwSearchID->cmd_code = CCW_CMD_DASD_SEARCH_ID_EQ;
> +    ccwSearchID->cda = ptr2u32(searchData);
> +    ccwSearchID->chain = 1;
> +    ccwSearchID->count = sizeof(searchData);

sizeof(*searchData)

I notice that vfio sees the count for each of these as 8 bytes despite 
them being packed structs of 6 or 5 bytes.

> +    searchData->cyl = 0;
> +    searchData->head = 0;
> +    searchData->record = 2;
> +
> +    /* Go back to Search CCW if correct record not yet found */
> +    ccwSearchTic->cmd_code = CCW_CMD_TIC;
> +    ccwSearchTic->cda = ptr2u32(ccwSearchID);
> +}
> +
> +static void run_ipl1(SubChannelId schid)
> + {
> +    uint32_t startAddr = 0x08;
> +
> +    if (do_cio(schid, startAddr, CCW_FMT0)) {
> +        panic("dasd-ipl: Failed to run IPL1 channel program");
> +    }
> +}
> +
> +static void run_ipl2(SubChannelId schid, uint32_t addr)
> +{
> +
> +    if (run_dynamic_ccw_program(schid, addr)) {
> +        panic("dasd-ipl: Failed to run IPL2 channel program");
> +    }
> +}
> +
> +static void lpsw(void *psw_addr)
> +{
> +    PSWLegacy *pswl = (PSWLegacy *) psw_addr;
> +
> +    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
> +    pswl->addr |= PSW_MASK_BAMODE;
> +    asm volatile("  llgtr 0,0\n llgtr 1,1\n"     /* Some OS's expect to be */
> +                 "  llgtr 2,2\n llgtr 3,3\n"     /* in 32-bit mode. Clear  */
> +                 "  llgtr 4,4\n llgtr 5,5\n"     /* high part of regs to   */
> +                 "  llgtr 6,6\n llgtr 7,7\n"     /* avoid messing up       */
> +                 "  llgtr 8,8\n llgtr 9,9\n"     /* instructions that work */
> +                 "  llgtr 10,10\n llgtr 11,11\n" /* in both addressing     */
> +                 "  llgtr 12,12\n llgtr 13,13\n" /* modes, like servc.     */
> +                 "  llgtr 14,14\n llgtr 15,15\n"
> +                 "  lpsw %0\n"
> +                 : : "Q" (*pswl) : "cc");
> +}
> +
> +/*
> + * Limitations in QEMU's CCW support complicate the IPL process. Details can
> + * be found in docs/devel/s390-dasd-ipl.txt
> + */
> +void dasd_ipl(SubChannelId schid)
> +{
> +    uint32_t ipl2_addr;
> +
> +    /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> +    make_readipl();
> +    run_readipl(schid);
> +    ipl2_addr = read_ipl2_addr();
> +    check_ipl1();
> +
> +    /*
> +     * Fixup IPL1 channel program to account for QEMU limitations, then run it
> +     * to read IPL2 channel program from boot disk.
> +     */
> +    ipl1_fixup();
> +    run_ipl1(schid);
> +    check_ipl2(ipl2_addr);
> +
> +    /*
> +     * Run IPL2 channel program to read operating system code from boot disk
> +     * then transfer control to the guest operating system
> +     */
> +    run_ipl2(schid, ipl2_addr);
> +    lpsw(0);
> +}
> diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
> new file mode 100644
> index 0000000..56bba82
> --- /dev/null
> +++ b/pc-bios/s390-ccw/dasd-ipl.h
> @@ -0,0 +1,16 @@
> +/*
> + * S390 IPL (boot) from a real DASD device via vfio framework.
> + *
> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef DASD_IPL_H
> +#define DASD_IPL_H
> +
> +void dasd_ipl(SubChannelId schid);
> +
> +#endif /* DASD_IPL_H */
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 5ee02c3..0a46339 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -13,6 +13,7 @@
>   #include "s390-ccw.h"
>   #include "cio.h"
>   #include "virtio.h"
> +#include "dasd-ipl.h"
>   
>   char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>   static SubChannelId blk_schid = { .one = 1 };
> @@ -210,6 +211,9 @@ int main(void)
>   
>       cutype = cu_type(blk_schid) ;
>       switch (cutype) {
> +    case CU_TYPE_DASD_3990:
> +        dasd_ipl(blk_schid); /* no return */
> +        break;
>       case CU_TYPE_VIRTIO:
>           virtio_setup();
>           zipl_load(); /* no return */
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 47eaa04..0438d42 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -97,4 +97,17 @@ typedef struct LowCore {
>   
>   extern const LowCore *lowcore;
>   
> +static inline void set_prefix(uint32_t address)
> +{
> +    asm volatile("spx %0" : : "m" (address) : "memory");
> +}
> +
> +static inline uint32_t store_prefix(void)
> +{
> +    uint32_t address;
> +
> +    asm volatile("stpx %0" : "=m" (address));
> +    return address;
> +}
> +
>   #endif
> 
