Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F4C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D222073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF7VN7y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D222073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ABu-0002ca-AC
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9AAy-00021r-Cw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9AAx-000252-0h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:13:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9AAw-00024Q-S6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583252021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Md/Uy89kp/QAjWhsQTDexMlWeAXiJPfuIY0WrySAKvs=;
 b=VF7VN7y/oaPiMIQhM6xsgEjGXdbd9k7uA2gyI/oJ0wVCd1aVgdhAQVvlZ/NlntR1lmDExI
 022Aiim3k242vxO270fu2CXir/+OK3uolhrH+T1j8puiYKbQ8X7wdwrJkRrjNoNlL6NiEM
 y0+9QvHKDVY4/6vz0dL/aoPFsODUBkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-K38KxfmBMO-_VIXBf9e4wA-1; Tue, 03 Mar 2020 11:13:40 -0500
X-MC-Unique: K38KxfmBMO-_VIXBf9e4wA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3C848017DF;
 Tue,  3 Mar 2020 16:13:38 +0000 (UTC)
Received: from [10.36.117.113] (ovpn-117-113.ams2.redhat.com [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 915855C1D6;
 Tue,  3 Mar 2020 16:13:37 +0000 (UTC)
Subject: Re: [PATCH] pc-bios: s390x: Save iplb location in lowcore
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200303155010.2519-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <49294c6a-38f6-8358-b613-72d3c3c7cf4f@redhat.com>
Date: Tue, 3 Mar 2020 17:13:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303155010.2519-1-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.03.20 16:50, Janosch Frank wrote:
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

How did this ever work? Or does this only become relevant with secure boot?

Fixes: ? Or has this always been broken?

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
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

In general LGTM.


Side note: I wonder if the assert in ptr2u32() should actually be

IPL_assert((uint64_t)ptr <= 0xfffffffful, "ptr2u32: ptr too large");
				      ^
or even better

IPL_assert((uint64_t)ptr != (uint32_t)ptr, "ptr2u32: ptr too large");

Otherwise, sign extension will simply always make this pass.

-- 
Thanks,

David / dhildenb


