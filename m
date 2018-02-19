Received: from eggs.gnu.org ([2001:4830:134:3::10]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ennyP-0006b2-93
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ennyO-00018l-4V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:07:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ennyN-000185-SM
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:07:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JG6Ocu131584
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:07:23 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1bgqw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:07:22 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 16:07:14 -0000
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 17:07:10 +0100
MIME-Version: 1.0
In-Reply-To: <1518818879-18608-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <66a7c8d0-ce43-d514-ea46-36c6c386e3f1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 05/12] s390-ccw: move auxiliary IPL data
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 16.02.2018 23:07, Collin L. Walling wrote:
[...]
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8a705e0..74469b1 100644
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
> @@ -59,6 +58,21 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
> 
>  #define DIAG308_FLAGS_LP_VALID 0x80
> 
> +#define QIPL_ADDRESS  0xcc
> +
> +/*
> + * The QEMU IPL Parameters will be stored 32-bit word aligned.
> + * Placement of data fields in this area must account for
> + * their alignment needs.
> + * The entire structure must not be larger than 28 bytes.
> + */
I realize that my initial suggestion was flawed. Hopefully better:
/*
 * The QEMU IPL Parameters will be stored at absolute address
 * 204 (0xcc) which means it is 32-bit word aligned but not
 * double-word aligned.
 * Placement of data fields in this area must account for
 * their alignment needs. E.g., netboot_start_address must
 * have an offset of n * 8 bytes within the struct in order
 * to keep it double-word aligned.
 * The total size of the struct must never exceed 28 bytes.
 * This definition must be kept in sync with the defininition
 * in pc-bios/s390-ccw/iplb.h.
 */
> +struct QemuIplParameters {
> +    uint8_t  reserved1[4];
> +    uint64_t netboot_start_addr;
> +    uint8_t  reserved2[16];
> +} QEMU_PACKED;
> +typedef struct QemuIplParameters QemuIplParameters;
> +
>  union IplParameterBlock {
>      struct {
>          uint32_t len;
[...]
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 890aed9..a23237e 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -13,8 +13,7 @@
>  #define IPLB_H
> 
>  struct IplBlockCcw {
> -    uint64_t netboot_start_addr;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[85];
>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -73,6 +72,23 @@ typedef struct IplParameterBlock IplParameterBlock;
> 
>  extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> 
> +#define QIPL_ADDRESS  0xcc
> +
> +/*
> + * The QEMU IPL Parameters will be stored 32-bit word aligned.
> + * Placement of data fields in this area must account for
> + * their alignment needs.
> + * The entire structure must not be larger than 28 bytes.
> + */
The comment can probably be a bit more terse, avoiding text duplication
and potential inconsistencies arising thereof.
/*
 * This definition must be kept in sync with the defininition
 * in hw/s390x/ipl.h
 */
> +struct QemuIplParameters {
> +    uint8_t  reserved1[4];
> +    uint64_t netboot_start_addr;
> +    uint8_t  reserved2[16];
> +} __attribute__ ((packed));
> +typedef struct QemuIplParameters QemuIplParameters;
> +
> +extern QemuIplParameters qipl;
> +
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
[...]

-- 
Regards,
 Viktor Mihajlovski
