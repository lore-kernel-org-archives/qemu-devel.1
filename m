Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7227C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDFA20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="My/iDUpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDFA20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbe71-0004So-Kc
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe6R-00042I-Rs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:50:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22425
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbe6P-0000vK-Kx
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590040244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bFTk11GANAXZqYfrVbw2Ik4BHNK1rmOHAuLOXOC3GL0=;
 b=My/iDUpr7BUOeMnGevvN8VJ19+d2b1U9nloEeCodjcqmBFx69rf86DcTp/KrjeOyMuBVrU
 ZrsF3wQiBlS2TxTtuWWvg4CeqREF0jTYW2qvTkhY0BFcVIJn1WgVYMs8YzQcKJVYipUH4H
 h4p2E78Vs9vHvY9lHCjnog9nv7168Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-m4KaYacoNSKFfftES4cF_g-1; Thu, 21 May 2020 01:50:42 -0400
X-MC-Unique: m4KaYacoNSKFfftES4cF_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 724AD1005510;
 Thu, 21 May 2020 05:50:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B49005C1B0;
 Thu, 21 May 2020 05:50:36 +0000 (UTC)
Subject: Re: [PATCH v2 5/9] pc-bios: s390x: Use PSW masks where possible
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f4e7b4fa-b2f4-13ee-2a20-3e7ce1a26c54@redhat.com>
Date: Thu, 21 May 2020 07:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-6-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> Let's move some of the PSW mask defines into s390-arch.h and use them
> in jump2ipl.c
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c  | 10 ++++------
>  pc-bios/s390-ccw/s390-arch.h |  2 ++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 4eba2510b0..767012bf0c 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -8,12 +8,10 @@
>  
>  #include "libc.h"
>  #include "s390-ccw.h"
> +#include "s390-arch.h"
>  
>  #define KERN_IMAGE_START 0x010000UL
> -#define PSW_MASK_64 0x0000000100000000ULL
> -#define PSW_MASK_32 0x0000000080000000ULL
> -#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
> -#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
> +#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>  
>  typedef struct ResetInfo {
>      uint64_t ipl_psw;
> @@ -54,7 +52,7 @@ void jump_to_IPL_code(uint64_t address)
>  
>      current->ipl_psw = (uint64_t) &jump_to_IPL_2;
>      current->ipl_psw |= RESET_PSW_MASK;
> -    current->ipl_continue = address & 0x7fffffff;
> +    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
>  
>      debug_print_int("set IPL addr to", current->ipl_continue);
>  
> @@ -86,7 +84,7 @@ void jump_to_low_kernel(void)
>  
>      /* Trying to get PSW at zero address */
>      if (*((uint64_t *)0) & RESET_PSW_MASK) {
> -        jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
> +        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
>      }
>  
>      /* No other option left, so use the Linux kernel start address */
> diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
> index 73852029d4..6da44d4436 100644
> --- a/pc-bios/s390-ccw/s390-arch.h
> +++ b/pc-bios/s390-ccw/s390-arch.h
> @@ -26,9 +26,11 @@ _Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
>  
>  /* s390 psw bit masks */
>  #define PSW_MASK_IOINT      0x0200000000000000ULL
> +#define PSW_MASK_SHORTPSW   0x0008000000000000ULL
>  #define PSW_MASK_WAIT       0x0002000000000000ULL
>  #define PSW_MASK_EAMODE     0x0000000100000000ULL
>  #define PSW_MASK_BAMODE     0x0000000080000000ULL
> +#define PSW_MASK_SHORT_ADDR 0x000000007fffffffULL

Please also mention that new define in the patch description.

 Thomas


