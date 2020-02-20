Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE6C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813762071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+cDXLGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813762071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jOH-00010s-O3
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4jNa-0000Xv-NQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4jNZ-0004yi-MQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:48:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4jNZ-0004yY-If
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582195705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAV3s6nCQKLipsxDlV42vD6ms2Wrki/5ZlXyu+hgvdg=;
 b=a+cDXLGXcOYwpBHoxtBQ9C09pYbzf4w3m8obJv7qkeeMvN+sdjOKpr1AUsQzaFTpXwHnBv
 23poBjpLkhmVTZ0SVqb33p3alC8b0QnGPZScwaDcP01qXKXaXN0twxEeWbilYs/HVMpjP2
 JO30OSRetzi3zHnNXqDsBZeuI2RaK2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7MLA5VkfMJCNlV0oQHVlAA-1; Thu, 20 Feb 2020 05:48:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6958513E4;
 Thu, 20 Feb 2020 10:48:22 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4391C5DA60;
 Thu, 20 Feb 2020 10:48:18 +0000 (UTC)
Date: Thu, 20 Feb 2020 11:48:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 06/17] s390x: protvirt: Add migration blocker
Message-ID: <20200220114815.01634a4c.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-7-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-7-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7MLA5VkfMJCNlV0oQHVlAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:16:25 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Migration is not yet supported.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 5fa4372083..d64724af91 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -42,6 +42,9 @@
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/s390x/pv.h"
> +#include "migration/blocker.h"
> +
> +static Error *pv_mig_blocker;
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -373,6 +376,7 @@ static void s390_machine_reset(MachineState *machine)
>      CPUState *cs, *t;
>      S390CPU *cpu;
>      S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
> +    static Error *local_err;
>  
>      /* get the reset parameters, reset them once done */
>      s390_ipl_get_reset_request(&cs, &reset_type);
> @@ -422,6 +426,17 @@ static void s390_machine_reset(MachineState *machine)
>          }
>          run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
>  
> +        if (!pv_mig_blocker) {
> +            error_setg(&pv_mig_blocker,
> +                       "protected VMs are currently not migrateable.");
> +        }
> +        migrate_add_blocker(pv_mig_blocker, &local_err);

If I'm not lost in the context, that's during PV_RESET. I'm a bit
confused why you'd add the blocker here?

> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(pv_mig_blocker);
> +            exit(1);

Why the exit()? Can't you fail the call?

> +        }
> +
>          if (s390_machine_pv_secure(ms)) {
>              CPU_FOREACH(t) {
>                  s390_pv_vcpu_destroy(t);
> @@ -430,6 +445,7 @@ static void s390_machine_reset(MachineState *machine)
>              ms->pv = false;
>  
>              s390_machine_inject_pv_error(cs);
> +            migrate_del_blocker(pv_mig_blocker);
>              s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>              return;
>          }


