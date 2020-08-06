Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8132B22CF6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3zSatZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8132B22CF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bsY-0002rl-IJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3brd-00021H-2u
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3brb-00044H-CM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596704822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWtbWQXwtrF5BvfNrGo8OzLCBd63XVozopD1jBzPNd4=;
 b=V3zSatZ/U4cDmN0OcvjQ9ehqvmPxh8dLwcHFwQbbyfrAGTKwPFNh/jpyKAN0yOkNmIVyII
 kqJkA0O9ksNm7fdP9y0XUL9ioyu252f30aVZu0sLleKTodr+OxlgmmICll8EbfYqeJCwRN
 UlFpF+8JTFZu3+3ThRKg0au61Wvq1y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-3Yu_RB3GNJK-m4lzUTQBtw-1; Thu, 06 Aug 2020 04:59:34 -0400
X-MC-Unique: 3Yu_RB3GNJK-m4lzUTQBtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2F16100AA21;
 Thu,  6 Aug 2020 08:59:32 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8C5B5C6D9;
 Thu,  6 Aug 2020 08:59:25 +0000 (UTC)
Date: Thu, 6 Aug 2020 10:59:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 17/21] target/s390x: add BQL to do_interrupt and
 cpu_exec_interrupt
Message-ID: <20200806105923.2bd2b0de.cohuck@redhat.com>
In-Reply-To: <20200805181303.7822-18-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-18-robert.foley@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 cota@braap.org, peter.puhov@linaro.org, pbonzini@redhat.com,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  5 Aug 2020 14:12:59 -0400
Robert Foley <robert.foley@linaro.org> wrote:

> This is part of a series of changes to remove the implied BQL
> from the common code of cpu_handle_interrupt and
> cpu_handle_exception.  As part of removing the implied BQL
> from the common code, we are pushing the BQL holding
> down into the per-arch implementation functions of
> do_interrupt and cpu_exec_interrupt.
> 
> The purpose of this set of changes is to set the groundwork
> so that an arch could move towards removing
> the BQL from the cpu_handle_interrupt/exception paths.
> 
> This approach was suggested by Paolo Bonzini.
> For reference, here are two key posts in the discussion, explaining
> the reasoning/benefits of this approach.
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  target/s390x/excp_helper.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index dde7afc2f0..b215b4a4a7 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -470,7 +470,10 @@ void s390_cpu_do_interrupt(CPUState *cs)
>      S390CPU *cpu = S390_CPU(cs);
>      CPUS390XState *env = &cpu->env;
>      bool stopped = false;
> -
> +    bool bql = !qemu_mutex_iothread_locked();
> +    if (bql) {
> +        qemu_mutex_lock_iothread();
> +    }

I'm not sure I like that conditional locking. Can we instead create
__s390_cpu_do_interrupt() or so, move the meat of this function there,
take the bql unconditionally here, and...

>      qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
>                    __func__, cs->exception_index, env->psw.mask, env->psw.addr);
>  
> @@ -541,10 +544,14 @@ try_deliver:
>          /* unhalt if we had a WAIT PSW somehwere in our injection chain */
>          s390_cpu_unhalt(cpu);
>      }
> +    if (bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
>  }
>  
>  bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
> +    qemu_mutex_lock_iothread();
>      if (interrupt_request & CPU_INTERRUPT_HARD) {
>          S390CPU *cpu = S390_CPU(cs);
>          CPUS390XState *env = &cpu->env;
> @@ -552,10 +559,12 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>          if (env->ex_value) {
>              /* Execution of the target insn is indivisible from
>                 the parent EXECUTE insn.  */
> +            qemu_mutex_unlock_iothread();
>              return false;
>          }
>          if (s390_cpu_has_int(cpu)) {
>              s390_cpu_do_interrupt(cs);

...call __s390_cpu_do_interrupt() here?

> +            qemu_mutex_unlock_iothread();
>              return true;
>          }
>          if (env->psw.mask & PSW_MASK_WAIT) {
> @@ -564,6 +573,7 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>              cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>          }
>      }
> +    qemu_mutex_unlock_iothread();
>      return false;
>  }
>  


