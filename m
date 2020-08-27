Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A218C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242442177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c72IvhiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242442177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHNy-0004UM-Ea
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBHFd-0000SF-Gl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:43:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBHFa-0006ny-J0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598532209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S41Wa+SSgcZ+UTOYttg3gDAeVHbsRn/5fMCPyL1Cd9g=;
 b=c72IvhiLISpietDfceM53RxQGBJkGLi7YODb6TdDPeLkB+m8y80ZahXkK/yZGfdYYRghvU
 MzYOa7EHImsrgIsh+aTOvIEUvPkfGrGKLr9u4hOfDFpxJRrLNeyXl83ocmS4cnpTtvH1xk
 Kx/505hQNm5m+K8aFPV626KARPxh8xM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-IasIJMt4OcedGJDA9dP-MQ-1; Thu, 27 Aug 2020 08:43:27 -0400
X-MC-Unique: IasIJMt4OcedGJDA9dP-MQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2051DE09;
 Thu, 27 Aug 2020 12:43:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5732747BD;
 Thu, 27 Aug 2020 12:43:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] pc-bios: s390x: Use reset PSW if avaliable
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200827093152.3026-1-frankja@linux.ibm.com>
 <20200827093152.3026-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb62946c-1acd-80d8-d3be-8ce104a5f47f@redhat.com>
Date: Thu, 27 Aug 2020 14:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827093152.3026-3-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 11.31, Janosch Frank wrote:
> If a blob provides a reset PSW then we should use it instead of
> branching to the PSW address and using our own mask.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c  |  1 +
>  pc-bios/s390-ccw/jump2ipl.c | 48 ++++++++++++++++++++++---------------
>  pc-bios/s390-ccw/s390-ccw.h |  1 +
>  3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 8747c4ea26..0df9b3781d 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -515,6 +515,7 @@ static void zipl_run(ScsiBlockPtr *pte)
>      IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
>  
>      /* should not return */
> +    write_reset_psw(entry->compdat.load_psw);
>      jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);

Shouldn't that be jump_to_IPL_code(0) now? Wouldn't it be cleaner to
have a jump_to_IPL_PSW() function instead?

>  }
>  
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 767012bf0c..143d027bf7 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -13,20 +13,28 @@
>  #define KERN_IMAGE_START 0x010000UL
>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>  
> -typedef struct ResetInfo {
> -    uint64_t ipl_psw;
> -    uint32_t ipl_continue;
> -} ResetInfo;
> -
> -static ResetInfo save;
> +uint64_t *reset_psw = 0, save_psw, ipl_continue;

I think the patch would be better readable if you'd split it in two -
first the ResetInfo rework, then the use-reset-PSW-if-available stuff ?

>  static void jump_to_IPL_2(void)
>  {
> -    ResetInfo *current = 0;
> +    /* Restore reset PSW and io and external new PSWs */
> +    *reset_psw = save_psw;

The comment talks about io and external new PSWs ... but where is it in
the code?

> -    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
> -    *current = save;
> -    ipl(); /* should not return */
> +    /* No reset PSW, let's jump instead. */
> +    if (ipl_continue) {
> +        void (*ipl)(void) = (void *) (uint64_t) ipl_continue;

Is it possible to mark a function pointer with __attribute__((noreturn)) ?

> +        ipl();
> +    }
> +
> +    /* Reset PSW available, let's load it */
> +    asm volatile ("lpsw 0(%0)\n"
> +        :  : "a" (0):);

I've never tried. but maybe you could add __attribute__((noreturn)) to
an inline asm statement, too?

> +    /* should not return */
> +}
> +
> +void write_reset_psw(uint64_t psw)
> +{
> +    *reset_psw = psw;
>  }
>  
>  void jump_to_IPL_code(uint64_t address)
> @@ -46,15 +54,12 @@ void jump_to_IPL_code(uint64_t address)
>       * content of non-BIOS memory after we loaded the guest, so we
>       * save the original content and restore it in jump_to_IPL_2.
>       */
> -    ResetInfo *current = 0;
> +    save_psw = *reset_psw;
> +    *reset_psw = (uint64_t) &jump_to_IPL_2;
> +    *reset_psw |= RESET_PSW_MASK;
> +    ipl_continue = address;
>  
> -    save = *current;
> -
> -    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
> -    current->ipl_psw |= RESET_PSW_MASK;
> -    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
> -
> -    debug_print_int("set IPL addr to", current->ipl_continue);
> +    debug_print_int("set IPL addr to", ipl_continue);
>  
>      /* Ensure the guest output starts fresh */
>      sclp_print("\n");
> @@ -84,7 +89,12 @@ void jump_to_low_kernel(void)
>  
>      /* Trying to get PSW at zero address */
>      if (*((uint64_t *)0) & RESET_PSW_MASK) {
> -        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
> +        /*
> +         * Surely nobody will try running directly from lowcore, so
> +         * let's use 0 as an indication that we want to load the reset
> +         * psw at 0x0 and not jump to the entry.
> +         */
> +        jump_to_IPL_code(0);
>      }
>  
>      /* No other option left, so use the Linux kernel start address */
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 36b884cced..7090720422 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -78,6 +78,7 @@ int virtio_read(ulong sector, void *load_addr);
>  void zipl_load(void);
>  
>  /* jump2ipl.c */
> +void write_reset_psw(uint64_t psw);
>  void jump_to_IPL_code(uint64_t address);
>  void jump_to_low_kernel(void);
>  
> 

 Thomas


