Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B086FECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE6F2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE6F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4oL-00081E-NA
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iL4lF-0005sY-Ui
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iL4lE-00070S-Sz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iL4lE-0006zz-N8; Thu, 17 Oct 2019 08:20:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5BF3307BD25;
 Thu, 17 Oct 2019 12:20:07 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19B5C60852;
 Thu, 17 Oct 2019 12:20:05 +0000 (UTC)
Subject: Re: [PATCH v1] s390x/mmu: Remove duplicate check for MMU_DATA_STORE
To: qemu-devel@nongnu.org
References: <20191017121922.18840-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5ad7023f-310b-eb7b-2e2e-b5cab073bb61@redhat.com>
Date: Thu, 17 Oct 2019 14:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017121922.18840-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 17 Oct 2019 12:20:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.10.19 14:19, David Hildenbrand wrote:
> No need to double-check if we have a write.
> 
> Found by Coverity (CID: 1381016).

Copy and past error, it's 1406404.

> 
> Fixes: 31b59419069e ("target/s390x: Return exception from mmu_translate_real")
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   target/s390x/mmu_helper.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 90b81335f9..c9f3f34750 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -556,9 +556,7 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>           *flags |= PAGE_WRITE_INV;
>           if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
>               /* LAP sets bit 56 */
> -            *tec = (raddr & TARGET_PAGE_MASK)
> -                 | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ)
> -                 | 0x80;
> +            *tec = (raddr & TARGET_PAGE_MASK) | FS_WRITE | 0x80;
>               return PGM_PROTECTION;
>           }
>       }
> 


-- 

Thanks,

David / dhildenb

