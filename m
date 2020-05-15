Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E2E20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mab9/bHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E2E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXEO-0006W9-W5
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZXDb-0005O0-MC
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:05:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZXDa-0007L7-TT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589537126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+md8leBb0UjCnPOFi3xRcnXDLIwtbPDJO3SFtbmrYZE=;
 b=Mab9/bHbuSB9j6kv2+PqWs0GPF+5AmY3Wd70pu+DVC7FtKtmdasnkkylEbH8rBV4YTEdfY
 B0ulQAE6tl/7TL+ulX0vG/dGWLskI202r9l9aR5i1RVkA83FPDXAYegQBYB80eb7SFvZR6
 vBCts9sEaDLHdAkYUHvmZ/OIxHzzvRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-MsLoBko2PPKeseF7I8idWA-1; Fri, 15 May 2020 06:05:24 -0400
X-MC-Unique: MsLoBko2PPKeseF7I8idWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F4C21899536;
 Fri, 15 May 2020 10:05:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4589A5D9F1;
 Fri, 15 May 2020 10:05:22 +0000 (UTC)
Date: Fri, 15 May 2020 12:05:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] hw/ide/ahci: Log lost IRQs
Message-ID: <20200515100520.GF93011@linux.fritz.box>
References: <20200504094858.5975-1-f4bug@amsat.org>
 <6139ac24-dc2a-d4e0-7f88-eeb72a05490d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6139ac24-dc2a-d4e0-7f88-eeb72a05490d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 22:20 hat John Snow geschrieben:
> 
> 
> On 5/4/20 5:48 AM, Philippe Mathieu-Daudé wrote:
> > One might find interesting to look at AHCI IRQs.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > ---
> >  hw/ide/ahci.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> > index 13d91e109a..fc82cbd5f1 100644
> > --- a/hw/ide/ahci.c
> > +++ b/hw/ide/ahci.c
> > @@ -1509,6 +1509,7 @@ static void ahci_cmd_done(IDEDMA *dma)
> >  
> >  static void ahci_irq_set(void *opaque, int n, int level)
> >  {
> > +    qemu_log_mask(LOG_UNIMP, "ahci: IRQ#%d level:%d\n", n, level);
> >  }
> >  
> >  static const IDEDMAOps ahci_dma_ops = {
> > 
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Sorry, just drowning in backlog. Thanks for the ping on IRC.
> 
> Acked-by: John Snow <jsnow@redhat.com>
> 
> ^ Feel free to take through trivial tree.

I'll take it through the block tree then.

Kevin


