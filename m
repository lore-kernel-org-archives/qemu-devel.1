Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964E3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D044206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7PSjwps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D044206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0O9Q-0002zS-M9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0O8m-0002QM-2R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0O8k-0004DY-JG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595937085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=djA+eoSKxSLJMQF6BFjpg8uq+BSZ8eb0a0NU5HSY1Uo=;
 b=G7PSjwpskawG75uVKptNK5axFkRG1BC41RHezvITK+fMf+RADxpIRjzUaJydjI0CVSrRXm
 4PehDyERCBWuUsQK5m12wor+WP/ISmP63acXnhzBMzSgl/xt5+V4gy2eivI9ld7adv/H6h
 8q3nAP8s2ib3zO1K1VU24Tji5RODhsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-vWr8gDFvMjKEnUiFVefFbg-1; Tue, 28 Jul 2020 07:51:24 -0400
X-MC-Unique: vWr8gDFvMjKEnUiFVefFbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2AD158;
 Tue, 28 Jul 2020 11:51:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B46E510013C1;
 Tue, 28 Jul 2020 11:51:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 179CB1132FD2; Tue, 28 Jul 2020 13:51:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2] spapr: Avoid some integer conversions in
 spapr_phb_realize()
References: <159592765385.99837.12059368746532345109.stgit@bahia.lan>
Date: Tue, 28 Jul 2020 13:51:21 +0200
In-Reply-To: <159592765385.99837.12059368746532345109.stgit@bahia.lan> (Greg
 Kurz's message of "Tue, 28 Jul 2020 11:14:13 +0200")
Message-ID: <87365bdfie.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> Without this patch, the irq number gets converted uselessly from int
> to int32_t, back and forth.
>
> This doesn't fix an actual issue, it's just to make the code neater.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> This is a follow-up to my previous "spapr: Simplify error handling in
> spapr_phb_realize()" patch. Maybe worth squashing it there ?
> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 59441e2117f3..0a418f1e6711 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1964,7 +1964,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  
>      /* Initialize the LSI table */
>      for (i = 0; i < PCI_NUM_PINS; i++) {
> -        int32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> +        int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
>  
>          if (smc->legacy_irq_allocation) {
>              irq = spapr_irq_findone(spapr, errp);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


