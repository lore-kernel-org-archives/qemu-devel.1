Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B06C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA432051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bB8FCVg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA432051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAXQ-0006iG-3D
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEAWd-0005Ky-2D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEAWb-0003HC-TP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:36:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEAWb-0003FA-PZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584445005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3krP2d1UGuRP5K2SSw67Fz/ushU5yF9Xl9f9ELB8Jcs=;
 b=bB8FCVg1/Swg/vmI+ciHFtfbYxpumPM8HKyxmeoZe5hmvj0gjpt4Shqe7s8CjgpmZWKTob
 ZQa2KHAOBinGQ8umQcYGJy8MlIcirCLbCmprZ4/F440d0aEsxSHcutaReCgujX3H1wHxDs
 yzHJJ3rmm8kXr0ToRswNpnZihQd9Kbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-vo_M6kwKPgKs5sTcWVnb3w-1; Tue, 17 Mar 2020 07:36:42 -0400
X-MC-Unique: vo_M6kwKPgKs5sTcWVnb3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71F558017CC;
 Tue, 17 Mar 2020 11:36:40 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5359960CCC;
 Tue, 17 Mar 2020 11:36:36 +0000 (UTC)
Date: Tue, 17 Mar 2020 12:36:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 11/15] s390x: protvirt: Disable address checks for PV
 guest IO emulation
Message-ID: <20200317123633.4505099e.cohuck@redhat.com>
In-Reply-To: <20200311132151.172389-12-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-12-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 09:21:47 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> IO instruction data is routed through SIDAD for protected guests, so
> adresses do not need to be checked, as this is kernel memory.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/ioinst.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index c437a1d8c6afed80..481d789de9e09a04 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -16,6 +16,23 @@
>  #include "hw/s390x/ioinst.h"
>  #include "trace.h"
>  #include "hw/s390x/s390-pci-bus.h"
> +#include "hw/s390x/pv.h"
> +

Maybe add

/* all I/O instructions but chsc use the s format */

to emphasize that this is not a generic decoder?

> +static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> +                                      uint8_t *ar)
> +{
> +    /*
> +     * Addresses for protected guests are all offsets into the
> +     * satellite block which holds the IO control structures. Those
> +     * control structures are always aligned and accessible, so we can
> +     * return 0 here which will pass the following address checks.
> +     */
> +    if (s390_is_pv()) {
> +        *ar = 0;
> +        return 0;
> +    }
> +    return decode_basedisp_s(env, ipb, ar);
> +}
>  
>  int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
>                                   int *schid)

With the other comment updates,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


