Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DDC2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP8yozfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DDC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16j1-0005Ew-2h
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k16hm-0003mx-Jy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k16hk-00057P-Q4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596108391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5fPmrZi5xSgV8I3utaG0lt3gQuwX1qhxTkTkYRBRaE=;
 b=MP8yozfcz4Ef2tEaSLWRBY/yjXiTfbqcE+Nm1kNHJ+CjxUT6tyJBwnHaqsJrJVx87+1NA1
 IrYTVu9Q/06DFyS88VMOujnDuEGqSVa5C8EViiLO0BDYXl01Ei58r3wqzTuSDbqkrwRkLx
 xMQOlqcx4HuLsGhmdZ0tm7+8+Kx68so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-P27fdCiUPaKCPOwDWBZBBg-1; Thu, 30 Jul 2020 07:26:28 -0400
X-MC-Unique: P27fdCiUPaKCPOwDWBZBBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0E61009600;
 Thu, 30 Jul 2020 11:26:26 +0000 (UTC)
Received: from starship (unknown [10.35.206.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58F3F1B46C;
 Thu, 30 Jul 2020 11:26:23 +0000 (UTC)
Message-ID: <10e041ac12802972dc4b093cb139c71cb92c108b.camel@redhat.com>
Subject: Re: [PATCH v4 1/2] nvme: indicate CMB support through controller
 capabilities register
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 30 Jul 2020 14:26:22 +0300
In-Reply-To: <20200707191559.GA669353@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-2-andrzej.jakowski@linux.intel.com>
 <a483e0a935a9c2d47232a9f7e653e950de525e68.camel@redhat.com>
 <20200707191559.GA669353@apples.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, kbusch@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-07-07 at 21:15 +0200, Klaus Jensen wrote:
> On Jul  7 19:27, Maxim Levitsky wrote:
> > On Wed, 2020-07-01 at 14:48 -0700, Andrzej Jakowski wrote:
> > > This patch sets CMBS bit in controller capabilities register when user
> > > configures NVMe driver with CMB support, so capabilites are correctly
> > > reported to guest OS.
> > > 
> > > Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> > > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c      | 2 +-
> > >  include/block/nvme.h | 6 +++++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 1aee042d4c..9f11f3e9da 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1582,6 +1582,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> > >      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> > >      NVME_CAP_SET_CSS(n->bar.cap, 1);
> > >      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> > > +    NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
> > >  
> > >      n->bar.vs = 0x00010200;
> > >      n->bar.intmc = n->bar.intms = 0;
> > > @@ -1591,7 +1592,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > >  {
> > >      NvmeCtrl *n = NVME(pci_dev);
> > >      Error *local_err = NULL;
> > > -
> > >      int i;
> > >  
> > >      nvme_check_constraints(n, &local_err);
> > > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > > index 1720ee1d51..14cf398dfa 100644
> > > --- a/include/block/nvme.h
> > > +++ b/include/block/nvme.h
> > > @@ -35,6 +35,7 @@ enum NvmeCapShift {
> > >      CAP_MPSMIN_SHIFT   = 48,
> > >      CAP_MPSMAX_SHIFT   = 52,
> > >      CAP_PMR_SHIFT      = 56,
> > > +    CAP_CMB_SHIFT      = 57,
> > >  };
> > >  
> > >  enum NvmeCapMask {
> > > @@ -48,6 +49,7 @@ enum NvmeCapMask {
> > >      CAP_MPSMIN_MASK    = 0xf,
> > >      CAP_MPSMAX_MASK    = 0xf,
> > >      CAP_PMR_MASK       = 0x1,
> > > +    CAP_CMB_MASK       = 0x1,
> > >  };
> > >  
> > >  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
> > > @@ -78,8 +80,10 @@ enum NvmeCapMask {
> > >                                                             << CAP_MPSMIN_SHIFT)
> > >  #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
> > >                                                              << CAP_MPSMAX_SHIFT)
> > > -#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
> > > +#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMR_MASK)   \
> > >                                                              << CAP_PMR_SHIFT)
> > > +#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMB_MASK)   \
> > > +                                                           << CAP_CMB_SHIFT)
> > >  
> > >  enum NvmeCcShift {
> > >      CC_EN_SHIFT     = 0,
> > 
> > I wonder how this could have beeing forgotten. Hmm.
> > I see that Linux kernel uses CMBSZ != for that.
> > I guess this explains it.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsky@gmail.com>
> > 
> 
> It is a v1.4 field. The CMB support was added when NVMe was at v1.2.
> And the Linux kernel is also basically adhering to v1.3 wrt. CMB
> support. In v1.4 the host actually needs to specifically enable the CMB
> - and that is not something the kernel does currently IIRC.
> 
Ah, makes sense!
I by now have specs for each NVME revision, but I am getting lazy sometimes to cross-check
them.

Best regards,
	Maxim Levitsky


