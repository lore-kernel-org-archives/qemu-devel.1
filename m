Received: from eggs.gnu.org ([2001:4830:134:3::10]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbKWQ-0006nI-Ea
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbKWN-0006Xt-8q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:47:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fbKWN-00068k-2U
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:47:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w666hwt2047958
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 02:47:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1ywxeuu4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:47:05 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 6 Jul 2018 07:47:03 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Jul 2018 08:46:58 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
Content-Language: en-US
Message-Id: <b8dec20a-9d33-c84a-8621-50c4f4686a12@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 08/15] s390-bios: Map low core memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com



On 07/05/2018 07:25 PM, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Create a new header for basic architecture specific definitions and add a
> mapping of low core memory. This mapping will be used by the real dasd boot
> process.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c      |   2 +
>  pc-bios/s390-ccw/s390-arch.h | 100 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 pc-bios/s390-ccw/s390-arch.h
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e5174fb..20c30c6 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include "libc.h"
> +#include "s390-arch.h"
>  #include "s390-ccw.h"
>  #include "cio.h"
>  #include "virtio.h"
> @@ -19,6 +20,7 @@ static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>  QemuIplParameters qipl;
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static bool have_iplb;
> +LowCore *lowcore = 0;
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> new file mode 100644
> index 0000000..9074ba2
> --- /dev/null
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -0,0 +1,100 @@
> +/*
> + * S390 Basic Architecture
> + *
> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef S390_ARCH_H
> +#define S390_ARCH_H
> +
> +typedef struct PSW {
> +    uint64_t mask;
> +    uint64_t addr;
> +} __attribute__ ((packed, aligned(8))) PSW;
> +
> +/* Older PSW format used by LPSW instruction */
> +typedef struct PSWLegacy {
> +    uint32_t mask;
> +    uint32_t addr;
> +} __attribute__ ((packed, aligned(8))) PSWLegacy;
> +
> +/* s390 psw bit masks */
> +#define PSW_MASK_IOINT      0x0200000000000000ULL
> +#define PSW_MASK_WAIT       0x0002000000000000ULL
> +#define PSW_MASK_EAMODE     0x0000000100000000ULL
> +#define PSW_MASK_BAMODE     0x0000000080000000ULL
> +#define PSW_MASK_ZMODE      (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
> +
> +/* Low core mapping */
> +typedef struct LowCore {
> +    /* prefix area: defined by architecture */
> +    uint64_t        ipl_psw;                  /* 0x000 */
> +    uint32_t        ccw1[2];                 /* 0x008 */
> +    uint32_t        ccw2[2];                  /* 0x010 */
> +    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
> +    uint32_t        ext_params;               /* 0x080 */
> +    uint16_t        cpu_addr;                 /* 0x084 */
> +    uint16_t        ext_int_code;             /* 0x086 */
> +    uint16_t        svc_ilen;                 /* 0x088 */
> +    uint16_t        svc_code;                 /* 0x08a */
> +    uint16_t        pgm_ilen;                 /* 0x08c */
> +    uint16_t        pgm_code;                 /* 0x08e */
> +    uint32_t        data_exc_code;            /* 0x090 */
> +    uint16_t        mon_class_num;            /* 0x094 */
> +    uint16_t        per_perc_atmid;           /* 0x096 */
> +    uint64_t        per_address;              /* 0x098 */
> +    uint8_t         exc_access_id;            /* 0x0a0 */
> +    uint8_t         per_access_id;            /* 0x0a1 */
> +    uint8_t         op_access_id;             /* 0x0a2 */
> +    uint8_t         ar_access_id;             /* 0x0a3 */
> +    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
> +    uint64_t        trans_exc_code;           /* 0x0a8 */
> +    uint64_t        monitor_code;             /* 0x0b0 */
> +    uint16_t        subchannel_id;            /* 0x0b8 */
> +    uint16_t        subchannel_nr;            /* 0x0ba */
> +    uint32_t        io_int_parm;              /* 0x0bc */
> +    uint32_t        io_int_word;              /* 0x0c0 */
> +    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
> +    uint32_t        stfl_fac_list;            /* 0x0c8 */
> +    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
> +    uint64_t        mcic;                     /* 0x0e8 */
> +    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
> +    uint32_t        external_damage_code;     /* 0x0f4 */
> +    uint64_t        failing_storage_address;  /* 0x0f8 */
> +    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
> +    uint64_t        per_breaking_event_addr;  /* 0x110 */
> +    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
> +    PSW             restart_old_psw;          /* 0x120 */
> +    PSW             external_old_psw;         /* 0x130 */
> +    PSW             svc_old_psw;              /* 0x140 */
> +    PSW             program_old_psw;          /* 0x150 */
> +    PSW             mcck_old_psw;             /* 0x160 */
> +    PSW             io_old_psw;               /* 0x170 */
> +    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
> +    PSW             restart_new_psw;          /* 0x1a0 */
> +    PSW             external_new_psw;         /* 0x1b0 */
> +    PSW             svc_new_psw;              /* 0x1c0 */
> +    PSW             program_new_psw;          /* 0x1d0 */
> +    PSW             mcck_new_psw;             /* 0x1e0 */
> +    PSW             io_new_psw;               /* 0x1f0 */
> +    PSW             return_psw;               /* 0x200 */
> +    uint8_t         irb[64];                  /* 0x210 */
> +    uint64_t        sync_enter_timer;         /* 0x250 */
> +    uint64_t        async_enter_timer;        /* 0x258 */
> +    uint64_t        exit_timer;               /* 0x260 */
> +    uint64_t        last_update_timer;        /* 0x268 */
> +    uint64_t        user_timer;               /* 0x270 */
> +    uint64_t        system_timer;             /* 0x278 */
> +    uint64_t        last_update_clock;        /* 0x280 */
> +    uint64_t        steal_clock;              /* 0x288 */
> +    PSW             return_mcck_psw;          /* 0x290 */
> +    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
> +} __attribute__((packed)) LowCore;


Please use
     __attribute__((packed, aligned(8192))) LowCore;


as gcc 8 will complain otherwise.
