Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24AC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAEB2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD80/l3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAEB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvDC-0007DF-5y
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icvBc-0006dC-Q5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icvBa-00086h-QJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:45:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icvBa-000821-KF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575567905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tXFKYq/1FWlQ48OM0s1F7OaRr0JHBxAtsOn362Bl68=;
 b=SD80/l3bUeEGDuqZkMCkaqghZJSfDF9xmzKpV3j1LMRwrZzWBsiHqCl9JSjKAXQAb/2ErF
 yduUNPylAMkR+Lm5FdxFeyCpIUGiWvnP4i9cGB3cmMUqeeEH6Zr0+NqxYAVzf38YFiw+O/
 CPuFgEc0oV8Mop+PbmGzEWXUclPkdS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-_eBbR6i0OlOYUTFW8f5mfw-1; Thu, 05 Dec 2019 12:45:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD1981005502;
 Thu,  5 Dec 2019 17:45:00 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D5DE691A7;
 Thu,  5 Dec 2019 17:44:53 +0000 (UTC)
Date: Thu, 5 Dec 2019 18:44:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 12/13] s390x: protvirt: Disable address checks for PV
 guest IO emulation
Message-ID: <20191205184450.4e2e47d3.cohuck@redhat.com>
In-Reply-To: <20191129094809.26684-13-frankja@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-13-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _eBbR6i0OlOYUTFW8f5mfw-1
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

On Fri, 29 Nov 2019 04:48:08 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> IO instruction data is routed through SIDAD for protected guests, so
> adresses do not need to be checked, as this is kernel memory.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/ioinst.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index c437a1d8c6..e4102430aa 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -17,6 +17,16 @@
>  #include "trace.h"
>  #include "hw/s390x/s390-pci-bus.h"
>  
> +static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> +                                      uint8_t *ar)

Would like to keep the ioinst_* pattern here (even though this is an
internal function). ioinst_decode_addr()?

> +{
> +    if (env->pv) {
> +        *ar = 0;
> +        return 0;
> +    }
> +    return decode_basedisp_s(env, ipb, ar);
> +}
> +
>  int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
>                                   int *schid)
>  {

(...)

> @@ -601,7 +611,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
>  {
>      ChscReq *req;
>      ChscResp *res;
> -    uint64_t addr;
> +    uint64_t addr = 0;
>      int reg;
>      uint16_t len;
>      uint16_t command;
> @@ -610,7 +620,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
>  
>      trace_ioinst("chsc");
>      reg = (ipb >> 20) & 0x00f;
> -    addr = env->regs[reg];
> +    if (!env->pv) {
> +        addr = env->regs[reg];
> +    }

addr = env->pv ? 0 : env->regs[reg];

?

>      /* Page boundary? */
>      if (addr & 0xfff) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);


