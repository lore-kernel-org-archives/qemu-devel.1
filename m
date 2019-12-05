Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5F92464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKCXq1z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5F92464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icusc-0006vb-3B
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icujK-0006R0-Vk
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icujH-0001YP-Fc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icujB-0001S0-VS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575566144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEUOMbIygaqBqOcYOLbMXA+06PdFfByqREjygLLYbpc=;
 b=HKCXq1z09pCxHOl8nU4Z1r99uUh8CFvKK6s98hhAze084a02NT84u2a/uQfTmSKDN57Rvi
 t4NHYcIICvuJINRJUpuAYhsKdeKhvlMghYOZoOzb/WjkAH3ePQgYIZXsv4HuX1PFblaZ/Y
 9chBcihjfEXE/9HGU0ft/HBrfcjSXDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-6q4W63osPfSOlk0iwm81og-1; Thu, 05 Dec 2019 12:15:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093DC800D41;
 Thu,  5 Dec 2019 17:15:40 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D5A95C1C3;
 Thu,  5 Dec 2019 17:15:35 +0000 (UTC)
Date: Thu, 5 Dec 2019 18:15:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
Message-ID: <20191205181532.46bee55c.cohuck@redhat.com>
In-Reply-To: <20191129094809.26684-7-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6q4W63osPfSOlk0iwm81og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 04:48:02 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Secure guests no longer intercept with code 4 for an instruction
> interception. Instead they have codes 104 and 108 for secure
> instruction interception and secure instruction notification
> respectively.
> 
> The 104 mirrors the 4 interception.
> 
> The 108 is a notification interception to let KVM and QEMU know that
> something changed and we need to update tracking information or
> perform specific tasks. It's currently taken for the following
> instructions:
> 
> * stpx (To inform about the changed prefix location)
> * sclp (On incorrect SCCB values, so we can inject a IRQ)
> * sigp (All but "stop and store status")
> * diag308 (Subcodes 0/1)
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ad6e38c876..3d9c44ba9d 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -115,6 +115,8 @@
>  #define ICPT_CPU_STOP                   0x28
>  #define ICPT_OPEREXC                    0x2c
>  #define ICPT_IO                         0x40
> +#define ICPT_PV_INSTR                   0x68
> +#define ICPT_PV_INSTR_NOTIFICATION      0x6c
>  
>  #define NR_LOCAL_IRQS 32
>  /*
> @@ -151,6 +153,7 @@ static int cap_s390_irq;
>  static int cap_ri;
>  static int cap_gs;
>  static int cap_hpage_1m;
> +static int cap_protvirt;
>  
>  static int active_cmma;
>  
> @@ -342,6 +345,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>      cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>      cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
> +    cap_protvirt = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
>  
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
>              (long)cs->kvm_run->psw_addr);
>      switch (icpt_code) {
>          case ICPT_INSTRUCTION:
> +        case ICPT_PV_INSTR:
> +        case ICPT_PV_INSTR_NOTIFICATION:
>              r = handle_instruction(cpu, run);

I'm still a bit uneasy about going through the same path for both 104
and 108. How does the handler figure out whether it should emulate an
instruction, or just process a notification? Is it guaranteed that a
given instruction is always showing up as either a 104 or a 108, so
that the handler can check the pv state?

[Even if that works, it still feels a bit unclean to me.]

>              break;
>          case ICPT_PROGRAM:


