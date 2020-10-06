Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49613C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3EE206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XP3z5MoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3EE206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrS8-0004yS-Fh
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrQe-0004HH-V7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrQV-0003lB-Ov
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602007860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDcI2k7CuhIdxBQk4dMvdfXjP91VuncO4Bb+EtbiC1Y=;
 b=XP3z5MoCti8CLx7F25cR8b5lydQVvgpMDx8xY1pyFHJN/srCIXVa19KzgiF2N0Vc5VeOgH
 qL4ca2tRKWRf2cNW/27v4aubvp4Myuipwvg60sBWTOWKT2Y5DdSU7WrrlE+u6cv5PIQetS
 qCkyVlaYDAhlQGbsXiV4KZ82ijlHadk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-KJo8jP_0PnS48OdCkoJm_w-1; Tue, 06 Oct 2020 14:10:58 -0400
X-MC-Unique: KJo8jP_0PnS48OdCkoJm_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6391C191E2A5;
 Tue,  6 Oct 2020 18:10:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9293176643;
 Tue,  6 Oct 2020 18:10:52 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] pc-bios: s390x: Use reset PSW if avaliable
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20201006094249.50640-1-frankja@linux.ibm.com>
 <20201006094249.50640-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <599d15ac-6b27-438a-ab8a-551a1d8e3411@redhat.com>
Date: Tue, 6 Oct 2020 20:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201006094249.50640-4-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: borntraeger@de.ibm.com, qemu-s390x <qemu-s390x@nongnu.org>,
 cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/2020 11.42, Janosch Frank wrote:
> If a blob provides a reset PSW then we should use it instead of
> branching to the PSW address and using our own mask.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/bootmap.c  |  6 ++++--
>   pc-bios/s390-ccw/jump2ipl.c | 26 +++++++++++++++++++-------
>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>   3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 8747c4ea26..88bd12d5d7 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -273,7 +273,8 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
>   
>       IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
>                  "Unknown script entry type");
> -    jump_to_IPL_code(bms->entry[i].address.load_address); /* no return */
> +    write_reset_psw(bms->entry[i].address.load_address); /* no return */
> +    jump_to_IPL_code(0); /* no return */
>   }
>   
>   static void ipl_eckd_cdl(void)
> @@ -515,7 +516,8 @@ static void zipl_run(ScsiBlockPtr *pte)
>       IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
>   
>       /* should not return */
> -    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
> +    write_reset_psw(entry->compdat.load_psw);
> +    jump_to_IPL_code(0);
>   }
>   
>   static void ipl_scsi(void)
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index b6aad32def..63afa4a349 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -12,15 +12,21 @@
>   
>   #define KERN_IMAGE_START 0x010000UL
>   #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
> +#define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
>   
>   static uint64_t *reset_psw = 0, save_psw, ipl_continue;
>   
> +void write_reset_psw(uint64_t psw)
> +{
> +    *reset_psw = psw;
> +}
> +
>   static void jump_to_IPL_addr(void)
>   {
>       __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
>   
>       /* Restore reset PSW */
> -    *reset_psw = save_psw;
> +    write_reset_psw(save_psw);
>   
>       ipl();
>       /* should not return */
> @@ -43,11 +49,12 @@ void jump_to_IPL_code(uint64_t address)
>        * content of non-BIOS memory after we loaded the guest, so we
>        * save the original content and restore it in jump_to_IPL_2.
>        */
> -    save_psw = *reset_psw;
> -    *reset_psw = (uint64_t) &jump_to_IPL_addr;
> -    *reset_psw |= RESET_PSW_MASK;
> -    ipl_continue = address;
> -    debug_print_int("set IPL addr to", ipl_continue);
> +    if (address) {
> +        save_psw = *reset_psw;
> +        write_reset_psw(RESET_PSW);
> +        ipl_continue = address;
> +    }
> +    debug_print_int("set IPL addr to", address ? address : *reset_psw & PSW_MASK_SHORT_ADDR);

checkpatch.pl complains about a very long line here...
I'll change this line to use the Elvis operator, so that is a little bit 
short, ok?

  Thomas


