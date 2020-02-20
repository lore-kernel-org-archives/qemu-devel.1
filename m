Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E4C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6B5208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flt7l+7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jcH-0007Qt-6N
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4jbd-0006xd-Dc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4jbc-0003Xl-F4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:02:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4jbc-0003XZ-C7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582196575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhzkzaYnzDVVQWjQL9kkJLgA46L+7NPx9jrxdbiw3LQ=;
 b=flt7l+7UKutf+vgxoNfuk6OOnGsnNiZC+cMDVtUXiRx+VRJAQ6m6fZy3MRFjW8Rv2+KZBd
 uvzkn7Dk1+/W1g2Kk2ja03RusCmG90N9W8N0DshYxvV4n2CM5ANEzGD2WL0l2cjxjtKL/g
 33dF7+VYrohblrd72rWbCgSNX3yl9TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-ATBCDkSkO6mh9qltd8LjPQ-1; Thu, 20 Feb 2020 06:02:52 -0500
X-MC-Unique: ATBCDkSkO6mh9qltd8LjPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF228DB66;
 Thu, 20 Feb 2020 11:02:50 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAB5B5E1AE;
 Thu, 20 Feb 2020 11:02:46 +0000 (UTC)
Date: Thu, 20 Feb 2020 12:02:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 16/17] s390x: protvirt: Handle SIGP store status
 correctly
Message-ID: <20200220120244.2ea06cec.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-17-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-17-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On Fri, 14 Feb 2020 10:16:35 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Status storing is not done by QEMU anymore, but is handled by SIE.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/helper.c | 4 ++++
>  target/s390x/sigp.c   | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a3a49164e4..3800c4b395 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -246,6 +246,10 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>      hwaddr len = sizeof(*sa);
>      int i;
>  
> +    if (cpu->env.pv) {
> +        return 0;
> +    }
> +
>      sa = cpu_physical_memory_map(addr, &len, 1);
>      if (!sa) {
>          return -EFAULT;
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index c604f17710..da0cfb97de 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -497,6 +497,7 @@ void do_stop_interrupt(CPUS390XState *env)
>      if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
>          qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>      }
> +    /* Storing will occur on next SIE entry for fmt 4 */

What's fmt 4?

>      if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
>          s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
>      }


