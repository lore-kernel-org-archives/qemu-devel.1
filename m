Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6694C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B6824659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5fIG22M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B6824659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFdt-0004xO-4j
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1idEbV-00072u-BO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1idEbU-00018g-08
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:29:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1idEbT-00016S-Rl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPlqeEsVBOgtaq5nNdjurvIsHEwch9TNbmiJeABjkyQ=;
 b=P5fIG22MZbYqPjYxmriv8sSeOllxbP8Bw92vfsQWEkFi5TpFbTQ2mQ7WXYKU6Kem0nUd3b
 qFw9590x2GplNL+ojLriWEVUsAJdKMf/DXVsbJcklApYIfrA8Yu5CfmxrZz/j0+KKlYSeu
 Sqv4NoRptlMTaMw9XPqfc4dVQ/iS+kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-bDhnPZLiO4Gs8o_UcPFQ8A-1; Fri, 06 Dec 2019 05:27:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 877F08017DF;
 Fri,  6 Dec 2019 10:27:36 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 858926013B;
 Fri,  6 Dec 2019 10:27:32 +0000 (UTC)
Date: Fri, 6 Dec 2019 11:27:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] s390x/tcg: clear local interrupts on reset normal
Message-ID: <20191206112730.3959e58c.cohuck@redhat.com>
In-Reply-To: <4939898a-99c6-2257-9f44-3d706190f331@redhat.com>
References: <20191205103844.10404-1-cohuck@redhat.com>
 <4939898a-99c6-2257-9f44-3d706190f331@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bDhnPZLiO4Gs8o_UcPFQ8A-1
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 10:36:40 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 05.12.19 11:38, Cornelia Huck wrote:
> > We neglected to clean up pending interrupts and emergency signals;
> > fix that.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > Noted while looking at the fixes for the kvm reset handling.
> > 
> > We now clear some fields twice in the paths for clear or initial reset;
> > but (a) we already do that for other fields and (b) it does not really
> > hurt. Maybe we should give the cpu structure some love in the future,
> > as it's not always clear whether some fields are tcg only.
> > 
> > ---
> >  target/s390x/cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> > index 829ce6ad5491..f2572961dc3a 100644
> > --- a/target/s390x/cpu.c
> > +++ b/target/s390x/cpu.c
> > @@ -133,6 +133,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
> >      case S390_CPU_RESET_NORMAL:
> >          env->pfault_token = -1UL;
> >          env->bpbc = false;
> > +        env->pending_int = 0;
> > +        env->external_call_addr = 0;
> > +        bitmap_zero(env->emergency_signals, S390_MAX_CPUS);
> >          break;
> >      default:
> >          g_assert_not_reached();
> >   
> 
> I'd suggest we rework the memsetting instead, now that we always
> "fall through" in this call chain, e.g, something like

Yeah, I did this patch before I applied Janosch's patch that reworks
this function... now it probably makes more sense to do it your way.

> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index bd39cb54b7..492f0c766d 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -95,12 +95,14 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>  
>      switch (type) {
>      case S390_CPU_RESET_CLEAR:
> -        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_fields));
> +        memset(&env->start_clear_reset_fields, 0,
> +               offsetof(CPUS390XState, end_clear_reset_fields) -
> +               offsetof(CPUS390XState, start_clear_reset_fields));
>          /* fall through */
>      case S390_CPU_RESET_INITIAL:
>          /* initial reset does not clear everything! */
>          memset(&env->start_initial_reset_fields, 0,
> -               offsetof(CPUS390XState, end_reset_fields) -
> +               offsetof(CPUS390XState, end_initial_reset_fields) -
>                 offsetof(CPUS390XState, start_initial_reset_fields));
>  
>          /* architectured initial value for Breaking-Event-Address register */
> @@ -123,8 +125,10 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>                                    &env->fpu_status);
>         /* fall through */
>      case S390_CPU_RESET_NORMAL:
> +        memset(&env->start_normal_reset_fields, 0,
> +               offsetof(CPUS390XState, end_normal_reset_fields) -
> +               offsetof(CPUS390XState, start_normal_reset_fields));
>          env->pfault_token = -1UL;
> -        env->bpbc = false;
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index d2af13b345..fe2ab6b89e 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -51,6 +51,9 @@ typedef struct PSW {
>  } PSW;
>  
>  struct CPUS390XState {
> +
> +    struct {} start_clear_reset_fields;
> +
>      uint64_t regs[16];     /* GP registers */
>      /*
>       * The floating point registers are part of the vector registers.
> @@ -63,12 +66,11 @@ struct CPUS390XState {
>      uint64_t etoken;       /* etoken */
>      uint64_t etoken_extension; /* etoken extension */
>  
> -    /* Fields up to this point are not cleared by initial CPU reset */
> +    struct {} end_clear_reset_fields;
>      struct {} start_initial_reset_fields;
>  
>      uint32_t fpc;          /* floating-point control register */
>      uint32_t cc_op;
> -    bool bpbc;             /* branch prediction blocking */
>  
>      float_status fpu_status; /* passed to softfloat lib */
>  
> @@ -99,10 +101,6 @@ struct CPUS390XState {
>  
>      uint64_t cregs[16]; /* control registers */
>  
> -    int pending_int;
> -    uint16_t external_call_addr;
> -    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> -
>      uint64_t ckc;
>      uint64_t cputm;
>      uint32_t todpr;
> @@ -114,8 +112,17 @@ struct CPUS390XState {
>      uint64_t gbea;
>      uint64_t pp;
>  
> -    /* Fields up to this point are cleared by a CPU reset */
> -    struct {} end_reset_fields;
> +    struct {} end_initial_reset_fields;
> +    struct {} start_normal_reset_fields;
> +
> +    /* local interrupt state */
> +    int pending_int;
> +    uint16_t external_call_addr;
> +    DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> +
> +    bool bpbc;             /* branch prediction blocking */
> +
> +    struct {} end_normal_reset_fields;
>  
>  #if !defined(CONFIG_USER_ONLY)
>      uint32_t core_id; /* PoP "CPU address", same as cpu_index */


