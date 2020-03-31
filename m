Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62981207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fosbuM5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62981207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCZO-0004xH-Ib
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJCYM-0003dU-Jd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJCYK-0002X3-7H
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:47:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJCYK-0002WN-3u
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585644439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2bg3AQWWZxxztJOiS9tc4Y0vPcBFzQ5+N5rlMgPiUM=;
 b=fosbuM5sOmdvAhnKPIrvpAK+tjSjtzT3zywwiwFC9IloVYRcD2T5zxRHzGQuBePzTXtIR5
 X+dcU4pYV4Fv3q7O4IWJrFcfjzC+v/FT0o7g2qFTJ/FwKET9yO133AO+PlFoC7vpLDMyWD
 K05VM4JwDBTS4nCX1MbEzIYl6qzFe30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-B-KCRsZuNbyI9GqIf-tbvg-1; Tue, 31 Mar 2020 04:47:16 -0400
X-MC-Unique: B-KCRsZuNbyI9GqIf-tbvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8D16DB20;
 Tue, 31 Mar 2020 08:47:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69C3F60BE0;
 Tue, 31 Mar 2020 08:47:12 +0000 (UTC)
Message-ID: <0499d18ffca0ef188c8932ac903a950b0dfa92c0.camel@redhat.com>
Subject: Re: [PATCH v6 38/42] nvme: support multiple namespaces
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 11:47:10 +0300
In-Reply-To: <20200331054829.nhxmcfhc5k5y4fzw@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-39-its@irrelevant.dk>
 <1f37eb79998c7db5f4f83b19fd5004d357bfd392.camel@redhat.com>
 <20200331054829.nhxmcfhc5k5y4fzw@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:48 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:59, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > This adds support for multiple namespaces by introducing a new 'nvme-ns'
> > > device model. The nvme device creates a bus named from the device name
> > > ('id'). The nvme-ns devices then connect to this and registers
> > > themselves with the nvme device.
> > > 
> > > This changes how an nvme device is created. Example with two namespaces:
> > > 
> > >   -drive file=nvme0n1.img,if=none,id=disk1
> > >   -drive file=nvme0n2.img,if=none,id=disk2
> > >   -device nvme,serial=deadbeef,id=nvme0
> > >   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> > >   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> > > 
> > > The drive property is kept on the nvme device to keep the change
> > > backward compatible, but the property is now optional. Specifying a
> > > drive for the nvme device will always create the namespace with nsid 1.
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  hw/block/Makefile.objs |   2 +-
> > >  hw/block/nvme-ns.c     | 157 +++++++++++++++++++++++++++
> > >  hw/block/nvme-ns.h     |  60 +++++++++++
> > >  hw/block/nvme.c        | 233 ++++++++++++++++++++++++++---------------
> > >  hw/block/nvme.h        |  47 ++++-----
> > >  hw/block/trace-events  |   4 +-
> > >  6 files changed, 389 insertions(+), 114 deletions(-)
> > >  create mode 100644 hw/block/nvme-ns.c
> > >  create mode 100644 hw/block/nvme-ns.h
> > > 
> > > diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> > > index 4b4a2b338dc4..d9141d6a4b9b 100644
> > > --- a/hw/block/Makefile.objs
> > > +++ b/hw/block/Makefile.objs
> > > @@ -2518,9 +2561,6 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      id->psd[0].mp = cpu_to_le16(0x9c4);
> > >      id->psd[0].enlat = cpu_to_le32(0x10);
> > >      id->psd[0].exlat = cpu_to_le32(0x4);
> > > -    if (blk_enable_write_cache(n->conf.blk)) {
> > > -        id->vwc = 1;
> > > -    }
> > 
> > Shouldn't that be kept? Assuming that user used the legacy 'drive' option,
> > and it had no write cache enabled.
> > 
> 
> When using the drive option we still end up calling the same code that
> handles the "new style" namespaces and that code will handle the write
> cache similary.
OK. That makes sense.

> 
> > >  
> > >      n->bar.cap = 0;
> > >      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
> > > @@ -2533,25 +2573,34 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      n->bar.intmc = n->bar.intms = 0;
> > >  }
> > >  
> > > -static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > > +int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > >  {
> > > -    int64_t bs_size;
> > > -    NvmeIdNs *id_ns = &ns->id_ns;
> > > +    uint32_t nsid = nvme_nsid(ns);
> > >  
> > > -    bs_size = blk_getlength(n->conf.blk);
> > > -    if (bs_size < 0) {
> > > -        error_setg_errno(errp, -bs_size, "blk_getlength");
> > > +    if (nsid > NVME_MAX_NAMESPACES) {
> > > +        error_setg(errp, "invalid nsid (must be between 0 and %d)",
> > > +                   NVME_MAX_NAMESPACES);
> > >          return -1;
> > >      }
> > >  
> > > -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > > -    n->ns_size = bs_size;
> > > +    if (!nsid) {
> > > +        for (int i = 1; i <= n->num_namespaces; i++) {
> > > +            NvmeNamespace *ns = nvme_ns(n, i);
> > > +            if (!ns) {
> > > +                nsid = i;
> > > +                break;
> > > +            }
> > > +        }
> > 
> > This misses an edge error case, where all the namespaces are allocated.
> > Yes, it would be insane to allocate all 256 namespaces but still.
> > 
> 
> Impressive catch! Fixed!
Thanks!
> 
> > 
> > > +    } else {
> > > +        if (n->namespaces[nsid - 1]) {
> > > +            error_setg(errp, "nsid must be unique");
> > 
> > I''l would change that error message to something like 
> > "namespace id %d is already in use" or something like that.
> > 
> 
> Done.
> 

Best regards,
	Maxim Levitsky


