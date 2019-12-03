Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71656C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B85B20637
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+kLvFku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B85B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCy5-0008Iw-Bj
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icBtT-0002nI-NB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icBtK-0000ck-KH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:23:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icBtH-0000V4-MJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575393785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uivl8XWJmSz1KlMr3v+9BDEbqxH/3gVp6wVcFhQ8TZw=;
 b=d+kLvFku9FpggUgRr4LMRawHNfp6OyAg+PB2XYY0ZPHTTPiefjvkpCSLgIjTo8AMYg8XZo
 zJikxv1PiXSuBDH2xZHDg243hh/Q28qf9Q7fpI5IF6+mZZ3SKUSMAWrpX+Jm7Gf3c0jylm
 Blt8Lx9X3a3FBTULQeySCADgKR3sk80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-f9n7Q7b0OhCCVvHpJFxwlw-1; Tue, 03 Dec 2019 12:22:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F02E800D5A;
 Tue,  3 Dec 2019 17:22:55 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0437C67661;
 Tue,  3 Dec 2019 17:22:53 +0000 (UTC)
Date: Tue, 3 Dec 2019 18:22:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 4/4] pc-bios/s390x: Fix reset psw mask
Message-ID: <20191203182251.66f3ff6d.cohuck@redhat.com>
In-Reply-To: <20191203132813.2734-5-frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: f9n7Q7b0OhCCVvHpJFxwlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Dec 2019 08:28:13 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We need to set the short psw indication bit in the reset psw, as it is
> a short psw.
> 
> fixes: 9629823290 ("pc-bios/s390-ccw: do a subsystem reset before running the guest")

s/fixes: 9629823290/Fixes: 962982329029/

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 266f1502b9..da13c43cc0 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -12,11 +12,11 @@
>  #define KERN_IMAGE_START 0x010000UL
>  #define PSW_MASK_64 0x0000000100000000ULL
>  #define PSW_MASK_32 0x0000000080000000ULL
> -#define IPL_PSW_MASK (PSW_MASK_32 | PSW_MASK_64)
> +#define PSW_MASK_SHORTPSW 0x0008000000000000ULL
> +#define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_32 | PSW_MASK_64)
>  
>  typedef struct ResetInfo {
> -    uint32_t ipl_mask;
> -    uint32_t ipl_addr;
> +    uint64_t ipl_psw;
>      uint32_t ipl_continue;
>  } ResetInfo;
>  
> @@ -50,7 +50,9 @@ void jump_to_IPL_code(uint64_t address)
>      ResetInfo *current = 0;
>  
>      save = *current;
> -    current->ipl_addr = (uint32_t) (uint64_t) &jump_to_IPL_2;
> +
> +    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
> +    current->ipl_psw |= RESET_PSW_MASK;
>      current->ipl_continue = address & 0x7fffffff;
>  
>      debug_print_int("set IPL addr to", current->ipl_continue);
> @@ -82,7 +84,7 @@ void jump_to_low_kernel(void)
>      }
>  
>      /* Trying to get PSW at zero address */
> -    if (*((uint64_t *)0) & IPL_PSW_MASK) {
> +    if (*((uint64_t *)0) & RESET_PSW_MASK) {
>          jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
>      }
>  

Looks sane to me, but would like an ack from bios maintainers.

As this is independent of the other patches (which depend on a headers
update), I can pick this and do a rebuild of the bios(es). Unless one
of the bios maintainers wants to do that and send me a pull req :), but
that seems like overkill.


