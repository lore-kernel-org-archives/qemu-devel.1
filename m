Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31AFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1C0205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn+YedWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1C0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icDUy-0006xV-TL
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 14:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icCOh-0000yA-NQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icCEZ-0002QI-5R
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:45:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icCEY-0002AL-W2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575395107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnoWjKqEdlm1fTXuC1+D9+nfJHlNu/mUTRQNbMKIx7s=;
 b=Mn+YedWTQBnvSToY3JTSbKbfkpCYthNT7rXOIWH7hAyfg99Gsno+BufEHHi28tG3IgZYWZ
 g51Gtfdi7MKAc/hqj7hOrlD9BLAxhZ7pdjb9RKtuVJD8lEv4w7zeROPMNHpqT+LDpqqQhC
 KhjchJVfaw1VzktVPv+AkqEuHOVxChI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-2pIGc_3NOwezloyFa39nMQ-1; Tue, 03 Dec 2019 12:45:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3EF18C35A3;
 Tue,  3 Dec 2019 17:45:02 +0000 (UTC)
Received: from gondolin (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 945E15D6A7;
 Tue,  3 Dec 2019 17:45:01 +0000 (UTC)
Date: Tue, 3 Dec 2019 18:44:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] s390x: Add missing vcpu reset functions
Message-ID: <20191203184459.0417a40a.cohuck@redhat.com>
In-Reply-To: <20191203132813.2734-3-frankja@linux.ibm.com>
References: <20191203132813.2734-1-frankja@linux.ibm.com>
 <20191203132813.2734-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2pIGc_3NOwezloyFa39nMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue,  3 Dec 2019 08:28:11 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
> for the initial reset, and that was also called for the clear
> reset. To be architecture compliant, we also need to clear local
> interrupts on a normal reset.
> 
> Because of this and the upcoming protvirt support we need to add
> ioctls for the missing clear and normal resets.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c       | 16 +++++++++++++--
>  target/s390x/kvm-stub.c  | 10 +++++++++-
>  target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++--------
>  target/s390x/kvm_s390x.h |  4 +++-
>  4 files changed, 60 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 829ce6ad54..4973365d6c 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -139,8 +139,20 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>      }
>  
>      /* Reset state inside the kernel that we cannot access yet from QEMU. */

For the last iteration, I asked about the 'yet' here...

> -    if (kvm_enabled() && type != S390_CPU_RESET_NORMAL) {
> -        kvm_s390_reset_vcpu(cpu);
> +    if (kvm_enabled()) {
> +        switch (type) {
> +        case S390_CPU_RESET_CLEAR:
> +            kvm_s390_reset_vcpu_clear(cpu);
> +            break;
> +        case S390_CPU_RESET_INITIAL:
> +            kvm_s390_reset_vcpu_initial(cpu);
> +            break;
> +        case S390_CPU_RESET_NORMAL:
> +            kvm_s390_reset_vcpu_normal(cpu);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>      }
>  }
>  

(...)

> @@ -403,17 +405,41 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>      return 0;
>  }
>  
> -void kvm_s390_reset_vcpu(S390CPU *cpu)
> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
>  {
>      CPUState *cs = CPU(cpu);
>  
> -    /* The initial reset call is needed here to reset in-kernel
> -     * vcpu data that we can't access directly from QEMU
> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG).
> -     * Before this ioctl cpu_synchronize_state() is called in common kvm
> -     * code (kvm-all) */
> -    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
> -        error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
> +    /*
> +     * The reset call is needed here to reset in-kernel vcpu data that
> +     * we can't access directly from QEMU (i.e. with older kernels
> +     * which don't support sync_regs/ONE_REG).  Before this ioctl

...and this reference to 'older kernels' here.

Are the comments still correct/relevant?

> +     * cpu_synchronize_state() is called in common kvm code
> +     * (kvm-all).
> +     */
> +    if (kvm_vcpu_ioctl(cs, type)) {
> +        error_report("CPU reset failed on CPU %i type %lx",
> +                     cs->cpu_index, type);
> +    }
> +}


