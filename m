Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B439DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A65420767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSxfKfeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A65420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCljF-0004I7-Lz
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kClii-0003ms-Bz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:27:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kClif-0000A4-S7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598887660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuQINYSmuW/JNfQpCDjH6jpmMtxG9H/Ai4ORKm04Ejw=;
 b=jSxfKfeun1Hw+wVWKHL9TksKxTyIDAH1vkDIit9khGun8GMnGbWQxsBAHpbVikhIqvj1M5
 K/otatBJRsKxxDiEwojsJtuUBdBpNMdQH5WGLcfp9HhYCOQiOw3R2fcg3uJaOLVx8EjAA5
 bG6n7v13sgEYtSkXofqN1nID2Cx++sY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-fMY_D--sNK-Q9xpXYB33Ew-1; Mon, 31 Aug 2020 11:27:38 -0400
X-MC-Unique: fMY_D--sNK-Q9xpXYB33Ew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84ECD107465E;
 Mon, 31 Aug 2020 15:27:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-174.ams2.redhat.com [10.36.112.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C59D19C4F;
 Mon, 31 Aug 2020 15:27:32 +0000 (UTC)
Subject: Re: [PATCH v3 2/5] pc-bios: s390x: Save PSW rework
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200831150910.317171-1-frankja@linux.ibm.com>
 <20200831150910.317171-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cad6b591-259d-059e-f971-2ae5eaf6d733@redhat.com>
Date: Mon, 31 Aug 2020 17:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200831150910.317171-3-frankja@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 31/08/2020 17.09, Janosch Frank wrote:
> We don't need to save the ipl_continue variable in lowcore and have it
> limited to 32 bits because of the lowcore layout. Let's move it to a
> new 64 bit variable and get rid of the reset info struct.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 767012bf0c..b6aad32def 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -13,20 +13,17 @@
>  #define KERN_IMAGE_START 0x010000UL
>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>  
> -typedef struct ResetInfo {
> -    uint64_t ipl_psw;
> -    uint32_t ipl_continue;
> -} ResetInfo;
> +static uint64_t *reset_psw = 0, save_psw, ipl_continue;
>  
> -static ResetInfo save;
> -
> -static void jump_to_IPL_2(void)
> +static void jump_to_IPL_addr(void)
>  {
> -    ResetInfo *current = 0;
> +    __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
>  
> -    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
> -    *current = save;
> -    ipl(); /* should not return */
> +    /* Restore reset PSW */
> +    *reset_psw = save_psw;
> +
> +    ipl();
> +    /* should not return */
>  }
>  
>  void jump_to_IPL_code(uint64_t address)
> @@ -46,15 +43,11 @@ void jump_to_IPL_code(uint64_t address)
>       * content of non-BIOS memory after we loaded the guest, so we
>       * save the original content and restore it in jump_to_IPL_2.
>       */
> -    ResetInfo *current = 0;
> -
> -    save = *current;
> -
> -    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
> -    current->ipl_psw |= RESET_PSW_MASK;
> -    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
> -
> -    debug_print_int("set IPL addr to", current->ipl_continue);
> +    save_psw = *reset_psw;
> +    *reset_psw = (uint64_t) &jump_to_IPL_addr;
> +    *reset_psw |= RESET_PSW_MASK;
> +    ipl_continue = address;
> +    debug_print_int("set IPL addr to", ipl_continue);
>  
>      /* Ensure the guest output starts fresh */
>      sclp_print("\n");

Reviewed-by: Thomas Huth <thuth@redhat.com>


