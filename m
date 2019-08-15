Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A59C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5664320665
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5664320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHyP-0008MA-5A
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1hyHuj-0004zx-O5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hyHue-0002UC-IT
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hyHue-0002Tx-B6; Thu, 15 Aug 2019 11:43:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D78FFC015C30;
 Thu, 15 Aug 2019 15:43:38 +0000 (UTC)
Received: from gondolin (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B75F93798;
 Thu, 15 Aug 2019 15:43:33 +0000 (UTC)
Date: Thu, 15 Aug 2019 17:43:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190815174330.3d66bd2c.cohuck@redhat.com>
In-Reply-To: <20190814072355.15333-3-david@redhat.com>
References: <20190814072355.15333-1-david@redhat.com>
 <20190814072355.15333-3-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 15 Aug 2019 15:43:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2 2/6] s390x/tcg: Rework MMU
 selection for instruction fetches
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 09:23:51 +0200
David Hildenbrand <david@redhat.com> wrote:

> Instructions are always fetched from primary address space, except when
> in home address mode. Perform the selection directly in cpu_mmu_index().
> 
> get_mem_index() is only used to perform data access, instructions are
> fetched via cpu_lduw_code(), which translates to cpu_mmu_index(env, true).
> 
> We don't care about restricting the access permissions of the TLB
> entries anymore, as we no longer enter PRIMARY entries into the
> SECONDARY MMU. Cleanup related code a bit.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        |  7 +++++++
>  target/s390x/mmu_helper.c | 38 +++++++++++++++-----------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
> 

(...)

> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 6e9c4d6151..c34e8d2021 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -349,8 +349,9 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>  {
>      static S390SKeysState *ss;
>      static S390SKeysClass *skeyclass;
> -    int r = -1;
> +    uint64_t asce;
>      uint8_t key;
> +    int r;
>  
>      if (unlikely(!ss)) {
>          ss = s390_get_skeys_device();
> @@ -380,36 +381,21 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>  
>      if (!(env->psw.mask & PSW_MASK_DAT)) {
>          *raddr = vaddr;
> -        r = 0;
> -        goto out;
> +        goto nodat;
>      }
>  
>      switch (asc) {
>      case PSW_ASC_PRIMARY:
>          PTE_DPRINTF("%s: asc=primary\n", __func__);
> -        r = mmu_translate_asce(env, vaddr, asc, env->cregs[1], raddr, flags,
> -                               rw, exc);
> +        asce = env->cregs[1];
>          break;
>      case PSW_ASC_HOME:
>          PTE_DPRINTF("%s: asc=home\n", __func__);
> -        r = mmu_translate_asce(env, vaddr, asc, env->cregs[13], raddr, flags,
> -                               rw, exc);
> +        asce = env->cregs[13];
>          break;
>      case PSW_ASC_SECONDARY:
>          PTE_DPRINTF("%s: asc=secondary\n", __func__);
> -        /*
> -         * Instruction: Primary
> -         * Data: Secondary
> -         */
> -        if (rw == MMU_INST_FETCH) {
> -            r = mmu_translate_asce(env, vaddr, PSW_ASC_PRIMARY, env->cregs[1],
> -                                   raddr, flags, rw, exc);
> -            *flags &= ~(PAGE_READ | PAGE_WRITE);
> -        } else {
> -            r = mmu_translate_asce(env, vaddr, PSW_ASC_SECONDARY, env->cregs[7],
> -                                   raddr, flags, rw, exc);
> -            *flags &= ~(PAGE_EXEC);
> -        }
> +        asce = env->cregs[7];
>          break;
>      case PSW_ASC_ACCREG:
>      default:
> @@ -417,11 +403,17 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>          break;
>      }
>  
> - out:
> +    /* perform the DAT translation */
> +    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw, exc);
> +    if (r) {
> +        return r;
> +    }
> +
> +nodat:
>      /* Convert real address -> absolute address */
>      *raddr = mmu_real2abs(env, *raddr);
>  
> -    if (r == 0 && *raddr < ram_size) {
> +    if (*raddr < ram_size) {
>          if (skeyclass->get_skeys(ss, *raddr / TARGET_PAGE_SIZE, 1, &key)) {
>              trace_get_skeys_nonzero(r);

I think you might up here with an uninitialized r before patch 4?

>              return 0;
> @@ -441,7 +433,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
>          }
>      }
>  
> -    return r;
> +    return 0;
>  }
>  
>  /**


