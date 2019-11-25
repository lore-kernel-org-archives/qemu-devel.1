Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53488C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FADA2075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoVaukPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FADA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEJt-0000rX-Ob
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iZEHM-0007io-0s
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iZEHJ-00063H-S3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:19:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iZEHJ-00062s-Nt
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574687985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iF2570oNJnfJeZNqdNnBgs8IdRK6VljeArGhrAErqA=;
 b=XoVaukPZe2TCJ/S6GhiJZizUHb4iK6SkYaPihHU29OsRBoG+3pzpU+6y6BnP78iHCGdZbP
 Ba2vbAJiL1VqRb0kFiwcOrtyd6TzJY6B2mPSFq1wcjAyAlD7pSfI8vSwIFn51tLc9p5Af4
 aM75t9nCmcANIL5z4bM5MWXmPCqSSz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-_vWfxgpOOTSGxId-pxlUBA-1; Mon, 25 Nov 2019 08:19:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBF710054AE;
 Mon, 25 Nov 2019 13:19:34 +0000 (UTC)
Received: from gondolin (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBD7A60872;
 Mon, 25 Nov 2019 13:19:29 +0000 (UTC)
Date: Mon, 25 Nov 2019 14:19:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 2/5] s390x: Move reset normal to shared reset handler
Message-ID: <20191125141926.427c30e6.cohuck@redhat.com>
In-Reply-To: <20191125090348.27010-3-frankja@linux.ibm.com>
References: <20191125090348.27010-1-frankja@linux.ibm.com>
 <20191125090348.27010-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _vWfxgpOOTSGxId-pxlUBA-1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 04:03:45 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's start moving the cpu reset functions into a single function with
> a switch/case, so we can use fallthroughs and share more code between
> resets.
> 
> This patch introduces the reset function by renaming cpu_reset() and
> cleaning up leftovers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu-qom.h |  6 +++++-
>  target/s390x/cpu.c     | 16 ++++++++++------
>  target/s390x/cpu.h     |  2 +-
>  target/s390x/sigp.c    |  2 +-
>  4 files changed, 17 insertions(+), 9 deletions(-)
> 

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd..8d35a2a723 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,18 +82,22 @@ static void s390_cpu_load_normal(CPUState *s)
>  }
>  #endif
>  
> -/* S390CPUClass::cpu_reset() */
> -static void s390_cpu_reset(CPUState *s)
> +/* S390CPUClass::reset() */
> +static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>  {
>      S390CPU *cpu = S390_CPU(s);
>      S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
>      CPUS390XState *env = &cpu->env;
>  
> -    env->pfault_token = -1UL;
> -    env->bpbc = false;
>      scc->parent_reset(s);
>      cpu->env.sigp_order = 0;
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
> +
> +    switch (type) {
> +    case S390_CPU_RESET_NORMAL:
> +        env->pfault_token = -1UL;
> +        env->bpbc = false;

I'm wondering whether we want a default case here to catch programming
errors.

> +    }
>  }
>  
>  /* S390CPUClass::initial_reset() */


