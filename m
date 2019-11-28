Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C130C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EDE2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9YOLiGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EDE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMnf-0003pr-RH
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaLiz-0007hO-CT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaLir-0002Gg-KX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:28:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50764
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaLir-00026H-79
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574954927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3y0wq24NcdU8h2Ck+tdEM6abb+2ByMt1MxN+VqmIzdM=;
 b=Z9YOLiGmHnxLa0lGXtZF48ol7YOKoDtZ5bHShlCPWhKSamLB1R9xU1mrR4d9ddW874Oe3e
 n1VIJxqgYrToH1YV+AciWu27q6+IvMLw+Bu/rNABptKO7ibB/yuJ0oeUt53Y8ZhKhy85dj
 G+CC35tFqgha5Mpwy3XUk3Ixx4Esi70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-LGpy3DJaM6WcY98UN0A53g-1; Thu, 28 Nov 2019 10:28:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239A31005502;
 Thu, 28 Nov 2019 15:28:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A40695D6D0;
 Thu, 28 Nov 2019 15:28:37 +0000 (UTC)
Subject: Re: [PATCH 14/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-15-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <db581b32-2b84-683c-0e7e-b6ee908eb701@redhat.com>
Date: Thu, 28 Nov 2019 16:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-15-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LGpy3DJaM6WcY98UN0A53g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> IO instruction data is routed through SIDAD for protected guests, so
> adresses do not need to be checked, as this is kernel memory.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/ioinst.c | 46 +++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index c437a1d8c6..d3bd422ddd 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -110,11 +110,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
>      SCHIB schib;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      CPUS390XState *env = &cpu->env;
> -    uint8_t ar;
> +    uint8_t ar = 0;
>  
> -    addr = decode_basedisp_s(env, ipb, &ar);
> +    if (!env->pv) {
> +        addr = decode_basedisp_s(env, ipb, &ar);
> +    }
>      if (addr & 3) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;
> @@ -167,11 +169,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
>      ORB orig_orb, orb;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      CPUS390XState *env = &cpu->env;
> -    uint8_t ar;
> +    uint8_t ar = 0;
>  
> -    addr = decode_basedisp_s(env, ipb, &ar);
> +    if (!env->pv) {
> +        addr = decode_basedisp_s(env, ipb, &ar);
> +    }
>      if (addr & 3) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;
> @@ -198,12 +202,14 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
>  void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
>  {
>      CRW crw;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      int cc;
>      CPUS390XState *env = &cpu->env;
> -    uint8_t ar;
> +    uint8_t ar = 0;
>  
> -    addr = decode_basedisp_s(env, ipb, &ar);
> +    if (!env->pv) {
> +        addr = decode_basedisp_s(env, ipb, &ar);
> +    }
>      if (addr & 3) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;
> @@ -228,13 +234,15 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
>  {
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      int cc;
>      SCHIB schib;
>      CPUS390XState *env = &cpu->env;
> -    uint8_t ar;
> +    uint8_t ar = 0;
>  
> -    addr = decode_basedisp_s(env, ipb, &ar);
> +    if (!env->pv) {
> +        addr = decode_basedisp_s(env, ipb, &ar);
> +    }
>      if (addr & 3) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;
> @@ -294,16 +302,18 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
>      IRB irb;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      int cc, irb_len;
> -    uint8_t ar;
> +    uint8_t ar = 0;
>  
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
>          s390_program_interrupt(env, PGM_OPERAND, ra);
>          return -EIO;
>      }
>      trace_ioinst_sch_id("tsch", cssid, ssid, schid);
> -    addr = decode_basedisp_s(env, ipb, &ar);
> +    if (!env->pv) {
> +        addr = decode_basedisp_s(env, ipb, &ar);
> +    }
>      if (addr & 3) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return -EIO;

Would it make sense to hide all these changes in decode_basedisp_s()
instead? ... so that decode_basedisp_s() returns 0 if env->pv == true ?
... or are there still cases where we need real values from
decode_basedisp_s() in case of env->pv==true?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


