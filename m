Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1CD20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1CD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9U3w-0005Zb-JK
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9U2y-0004cR-ON
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j9U2x-0002EJ-3M
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53918
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j9U2w-0000yd-UM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024DJtjE077463
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 08:26:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhyxqsrk9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 08:26:14 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Wed, 4 Mar 2020 13:25:55 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 13:25:53 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 024DPq5Y18088444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 13:25:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F9811C04C;
 Wed,  4 Mar 2020 13:25:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35D4111C054;
 Wed,  4 Mar 2020 13:25:52 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.97.179])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 13:25:52 +0000 (GMT)
Subject: Re: [PATCH v6 18/18] pc-bios: s390x: Save iplb location in lowcore
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-19-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Wed, 4 Mar 2020 14:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304114231.23493-19-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030413-0028-0000-0000-000003E0D20F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030413-0029-0000-0000-000024A602B7
Message-Id: <23191e82-1f87-f132-c3aa-cb52d495bad6@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_05:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=726 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040102
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.03.20 12:42, Janosch Frank wrote:
> The POP states that for a list directed IPL the IPLB is stored into
> memory by the machine loader and its address is stored at offset 0x14
> of the lowcore.
> 
> ZIPL currently uses the address in offset 0x14 to access the IPLB and
> acquire flags about secure boot. If the IPLB address points into
> memory which has an unsupported mix of flags set, ZIPL will panic
> instead of booting the OS.
> 
> As the lowcore can have quite a high entropy for a guest that did drop
> out of protected mode (i.e. rebooted) we encountered the ZIPL panic
> quite often.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

I think this makes sense even without protected virtualization, no?
Unless somebody complains, I think I will pick this up while Conny is
on vacation.



> ---
>  pc-bios/s390-ccw/jump2ipl.c  |  1 +
>  pc-bios/s390-ccw/main.c      |  8 +++++++-
>  pc-bios/s390-ccw/netmain.c   |  1 +
>  pc-bios/s390-ccw/s390-arch.h | 10 ++++++++--
>  pc-bios/s390-ccw/s390-ccw.h  |  1 +
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index da13c43cc0..4eba2510b0 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -35,6 +35,7 @@ void jump_to_IPL_code(uint64_t address)
>  {
>      /* store the subsystem information _after_ the bootmap was loaded */
>      write_subsystem_identification();
> +    write_iplb_location();
>  
>      /* prevent unknown IPL types in the guest */
>      if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a21b386280..4e65b411e1 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include "libc.h"
> +#include "helper.h"
>  #include "s390-arch.h"
>  #include "s390-ccw.h"
>  #include "cio.h"
> @@ -22,7 +23,7 @@ QemuIplParameters qipl;
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static bool have_iplb;
>  static uint16_t cutype;
> -LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
> +LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
> @@ -42,6 +43,11 @@ void write_subsystem_identification(void)
>      *zeroes = 0;
>  }
>  
> +void write_iplb_location(void)
> +{
> +    lowcore->ptr_iplb = ptr2u32(&iplb);
> +}
> +
>  void panic(const char *string)
>  {
>      sclp_print(string);
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index f2dcc01e27..309ffa30d9 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -40,6 +40,7 @@
>  #define DEFAULT_TFTP_RETRIES 20
>  
>  extern char _start[];
> +void write_iplb_location(void) {}
>  
>  #define KERNEL_ADDR             ((void *)0L)
>  #define KERNEL_MAX_SIZE         ((long)_start)
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 504fc7c2f0..5f36361c02 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -36,7 +36,13 @@ typedef struct LowCore {
>      /* prefix area: defined by architecture */
>      PSWLegacy       ipl_psw;                  /* 0x000 */
>      uint32_t        ccw1[2];                  /* 0x008 */
> -    uint32_t        ccw2[2];                  /* 0x010 */
> +    union {
> +        uint32_t        ccw2[2];                  /* 0x010 */
> +        struct {
> +            uint32_t reserved10;
> +            uint32_t ptr_iplb;
> +        };
> +    };
>      uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
>      uint32_t        ext_params;               /* 0x080 */
>      uint16_t        cpu_addr;                 /* 0x084 */
> @@ -85,7 +91,7 @@ typedef struct LowCore {
>      PSW             io_new_psw;               /* 0x1f0 */
>  } __attribute__((packed, aligned(8192))) LowCore;
>  
> -extern LowCore const *lowcore;
> +extern LowCore *lowcore;
>  
>  static inline void set_prefix(uint32_t address)
>  {
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 11bce7d73c..21f27e7990 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -57,6 +57,7 @@ void consume_io_int(void);
>  /* main.c */
>  void panic(const char *string);
>  void write_subsystem_identification(void);
> +void write_iplb_location(void);
>  extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  unsigned int get_loadparm_index(void);
>  
> 


