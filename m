Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA45C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743CE208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd3YVKfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743CE208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jao-0006OG-Ia
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4jZr-0005oW-Gv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4jZp-000389-GR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:01:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4jZp-00037x-Ah
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582196464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ts+SBMoj2ZcCa8EbWYilZZxrQhsRp1v0I1e9nSfSkxk=;
 b=Sd3YVKfVn1VFcp/V2VKig4CrMwiK6/bXmd1cv/QhZjLm9nrDHmSUitOUb1phIlSqRToQbY
 e+LJLcpjavOLCkTalrMfRQRix1q+c+MFYLm8EjSRlpzYvxdE51MhihMuCPV9ELnXudSc3t
 tKI1HeW9CW4vfs+BU/h8wcga7avsxbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-kE2mtnvIPfSZgcL8BJQCqQ-1; Thu, 20 Feb 2020 06:01:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F03EE800D6C;
 Thu, 20 Feb 2020 11:00:59 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDC978ECEC;
 Thu, 20 Feb 2020 11:00:55 +0000 (UTC)
Date: Thu, 20 Feb 2020 12:00:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 13/17] s390x: protvirt: Move diag 308 data over SIDAD
Message-ID: <20200220120052.7691f6f8.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-14-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-14-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: kE2mtnvIPfSZgcL8BJQCqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Fri, 14 Feb 2020 10:16:32 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected guests the IPIB is written/read to/from the satellite
> block, so we need to make those accesses virtual to make them go
> through KVM mem ops.

Confused. What does 'make those accesses virtual' mean?

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/diag.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 6aaeef6029..59ae122e82 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -88,6 +88,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
>      CPUState *cs = env_cpu(env);
> +    S390CPU *cpu = S390_CPU(cs);
>      uint64_t addr =  env->regs[r1];
>      uint64_t subcode = env->regs[r3];
>      IplParameterBlock *iplb;
> @@ -118,14 +119,24 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> +

Whitespace.

>          iplb = g_new0(IplParameterBlock, 1);
> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        if (!env->pv) {
> +            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
> +        }
> +
>          if (!iplb_valid_len(iplb)) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }
>  
> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +        if (!env->pv) {
> +            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
> +        }
>  
>          if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
>              !(iplb_valid_pv(iplb) && s390_ipl_pv_check_components(iplb) >= 0)) {
> @@ -137,23 +148,30 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          env->regs[r1 + 1] = DIAG_308_RC_OK;
>  out:
>          g_free(iplb);
> -        return;
> +        break;
>      case DIAG308_STORE:
>      case DIAG308_PV_STORE:
>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> +

Whitespace.

>          if (subcode == DIAG308_PV_STORE) {
>              iplb = s390_ipl_get_iplb_secure();
>          } else {
>              iplb = s390_ipl_get_iplb();
>          }
> -        if (iplb) {
> -            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
> -            env->regs[r1 + 1] = DIAG_308_RC_OK;
> -        } else {
> +        if (!iplb) {
>              env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
> +            return;
>          }
> +
> +        if (!env->pv) {
> +            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
> +        } else {
> +            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
> +        }
> +
> +        env->regs[r1 + 1] = DIAG_308_RC_OK;
>          break;
>      case DIAG308_PV_START:
>          iplb = s390_ipl_get_iplb_secure();


