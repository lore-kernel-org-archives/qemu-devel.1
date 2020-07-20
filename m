Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBF52176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiU2pnWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBF52176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxS7o-0003pW-56
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxS6k-0003CO-Lb
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:29:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxS6i-0002ol-4F
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595237351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1pEPthk6V7dKIxeoWQjkLbSNzH3B/wQj5BahGPw+Xg=;
 b=RiU2pnWRk7ka1bPj+JbkV17LVHuyRFLGWs+D9m6iSxwGwRiX6/nKLRry9Xk7t9Ohwz4hHJ
 mxd4yDMkgh7Z/MUj0UfS6255V0KFZkM9s0XefWVsp+VUMVuxdFmpCOxfq3M1NvzS/zQNX+
 cr6MARMrrJRew2Q17KlYWppWBYUCqOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-ZMFODs4ZNZCytEP-3K3odw-1; Mon, 20 Jul 2020 05:29:09 -0400
X-MC-Unique: ZMFODs4ZNZCytEP-3K3odw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16778108A;
 Mon, 20 Jul 2020 09:29:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B890787303;
 Mon, 20 Jul 2020 09:29:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 144DE1141C54; Mon, 20 Jul 2020 11:29:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2] spapr: Simplify error handling in
 spapr_phb_realize()
References: <159500760539.383731.10928308889360009122.stgit@bahia.lan>
Date: Mon, 20 Jul 2020 11:29:06 +0200
In-Reply-To: <159500760539.383731.10928308889360009122.stgit@bahia.lan> (Greg
 Kurz's message of "Fri, 17 Jul 2020 19:40:05 +0200")
Message-ID: <87lfjefsbh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> The spapr_phb_realize() function has a local_err variable which
> is used to:
>
> 1) check failures of spapr_irq_findone() and spapr_irq_claim()
>
> 2) prepend extra information to the error message
>
> Recent work from Markus Armbruster highlighted we get better
> code when testing the return value of a function, rather than
> setting up all the local_err boiler plate. For similar reasons,
> it is now preferred to use ERRP_GUARD() and error_prepend()
> rather than error_propagate_prepend().
>
> Since spapr_irq_findone() and spapr_irq_claim() return negative
> values in case of failure, do both changes.
>
> This is just cleanup, no functional impact.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> Since we add ERRP_GUARD(), we could theoretically check *errp
> rather than the return value, and thus avoid the uint32_t to
> int32_t change but I personally find it clearer the other way.
> ---
>  hw/ppc/spapr_pci.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 21681215d405..b1ce51327db4 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1796,6 +1796,7 @@ static void spapr_phb_destroy_msi(gpointer opaque)
>  
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
>       * tries to add a sPAPR PHB to a non-pseries machine.
>       */
> @@ -1813,7 +1814,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      uint64_t msi_window_size = 4096;
>      SpaprTceTable *tcet;
>      const unsigned windows_supported = spapr_phb_windows_supported(sphb);
> -    Error *local_err = NULL;
>  
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
> @@ -1964,13 +1964,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  
>      /* Initialize the LSI table */
>      for (i = 0; i < PCI_NUM_PINS; i++) {
> -        uint32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> +        int32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;

(1)

>  
>          if (smc->legacy_irq_allocation) {
> -            irq = spapr_irq_findone(spapr, &local_err);
> -            if (local_err) {
> -                error_propagate_prepend(errp, local_err,
> -                                        "can't allocate LSIs: ");
> +            irq = spapr_irq_findone(spapr, errp);

(2)

> +            if (irq < 0) {
> +                error_prepend(errp, "can't allocate LSIs: ");
>                  /*
>                   * Older machines will never support PHB hotplug, ie, this is an
>                   * init only path and QEMU will terminate. No need to rollback.
> @@ -1979,9 +1978,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>              }
>          }
>  
> -        spapr_irq_claim(spapr, irq, true, &local_err);
> -        if (local_err) {
> -            error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
> +        if (spapr_irq_claim(spapr, irq, true, errp) < 0) {

(3)

> +            error_prepend(errp, "can't allocate LSIs: ");
>              goto unrealize;
>          }

           sphb->lsi_table[i].irq = irq;

(4)

       }

The error propagation elimination looks good to me, but I wonder whether
int32_t is the best choice for @irq.

Before the patch:

(1) The initialization converts unsigned (I think) to uint32_t.

(2) Converts from int (value of spapr_irq_findone()) to uint32_t.

(3) spapr_irq_claim() takes int, we convert back to int.

(4) The assignment does not convert.

After the patch:

(1) The initialization converts unsigned (I think) to int32_t.

(2) Converts from int (value of spapr_irq_findone()) to int32_t.

(3) spapr_irq_claim() takes int, we convert back to int.

(4) Converts from int32_t to uint32_t

I assume the conversions are all safe before and after the patch
(spapr_irq_claim() asserts @irq is between 0x1000 and 0x1000 + small
change).  Still, too many conversions for my taste.  What about making
irq plain int?  Then:

(1) The initialization converts unsigned (I think) to int.

(2) Does not convert.

(3) Does not convert.

(4) Converts from int to uint32_t.

Feels neater to me.

Regardless:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


