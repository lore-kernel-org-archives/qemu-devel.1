Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6DEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB067222D9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk8B+OyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB067222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvtN-0000Po-0b
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuvqf-0004ZX-Gz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuvqe-0001hg-FV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuvqe-0001hN-Bc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wy5YzHDdsr2qqpSVhC05VXyiO7gJIKM1+zMcbcg62TM=;
 b=Sk8B+OyO/nvrmI48c0G3I18AdVY9ciS13cZWo/rb+lo53pTdmugaIid5ikupVdXNGDT3bi
 a1vgajy5gLeALurzjC6QXI/j/ktbr/hKG2v+LBhXZTnmHTkY5n7J64dopkopoYAYQo1mw5
 YIFajtDuBMSyq/JVAmXujSqC+QjmPRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-pZ_4rxarMV2qhAbp-v5b9A-1; Fri, 24 Jan 2020 05:05:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32553805731;
 Fri, 24 Jan 2020 10:05:53 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D70BA5C28D;
 Fri, 24 Jan 2020 10:05:49 +0000 (UTC)
Date: Fri, 24 Jan 2020 11:05:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] s390x: sigp: Fix sense running reporting
Message-ID: <20200124110547.50c73851.cohuck@redhat.com>
In-Reply-To: <20200124100137.28656-1-frankja@linux.ibm.com>
References: <20200124100137.28656-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pZ_4rxarMV2qhAbp-v5b9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 05:01:37 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The logic was inversed and reported running if the cpu was stopped.

s/inversed/inverted/ ?

> Let's fix that.
>

Fixes: d1b468bc8869 ("s390x/tcg: implement SIGP SENSE RUNNING STATUS")

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/sigp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 727875bb4a..286c0d6c9c 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -347,7 +347,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
>      }
>  
>      /* If halted (which includes also STOPPED), it is not running */
> -    if (CPU(dst_cpu)->halted) {
> +    if (!CPU(dst_cpu)->halted) {
>          si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
>      } else {
>          set_sigp_status(si, SIGP_STAT_NOT_RUNNING);

I'm wondering why nobody noticed this before...


