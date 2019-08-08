Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE5C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AB12171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 12:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AB12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvhzI-0004Gp-Lu
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60643)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hvhyr-0003Y4-4x
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hvhyq-0000Rz-7e
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 08:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hvhyq-0000Ra-19; Thu, 08 Aug 2019 08:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9D81306731E;
 Thu,  8 Aug 2019 12:57:17 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0724061B62;
 Thu,  8 Aug 2019 12:57:15 +0000 (UTC)
Date: Thu, 8 Aug 2019 14:57:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190808145713.6622ac61.cohuck@redhat.com>
In-Reply-To: <20190805152947.28536-2-david@redhat.com>
References: <20190805152947.28536-1-david@redhat.com>
 <20190805152947.28536-2-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 12:57:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v1 1/9] s390x/mmu: Better ASC
 selection in s390_cpu_get_phys_page_debug()
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
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  5 Aug 2019 17:29:39 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's select the ASC before calling the function and use MMU_DATA_LOAD.
> This is a preparation to:
> - Remove the ASC magic depending on the access mode from mmu_translate
> - Implement IEP support, where we could run into access exceptions

'IEP' was instruction execution protection?

>   trying to fetch instructions
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 13ae9909ad..08166558a0 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -58,7 +58,15 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
>          vaddr &= 0x7fffffff;
>      }
>  
> -    if (mmu_translate(env, vaddr, MMU_INST_FETCH, asc, &raddr, &prot, false)) {
> +    /*
> +     * We want to read the code, however, not run into access exceptions
> +     * (especially, IEP).
> +     */
> +    if (asc != PSW_ASC_HOME) {
> +        asc = PSW_ASC_PRIMARY;
> +    }

Previously, if we'd go in here specifying access register mode, we'd
hw_error() out. Now, that would be rewritten to using primary. Could
that be a problem, or do we filter out access register mode even
earlier?

(As an aside, I'm not sure the guest crashing qemu by specifying access
register mode was a good idea. Or do we get to slap the guest before
that happens?)

> +
> +    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, false)) {
>          return -1;
>      }
>      return raddr;


