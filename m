Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C81C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F63020829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="bwecQQRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F63020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0mSn-0005jK-Fj
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0mSA-0005Cx-CC; Wed, 29 Jul 2020 09:49:06 -0400
Received: from charlie.dont.surf ([128.199.63.193]:33876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0mS7-00045p-4o; Wed, 29 Jul 2020 09:49:05 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C44AABF616;
 Wed, 29 Jul 2020 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596030540;
 bh=Xmf7EAigExAi9sAZuX5NU9T71eGcb7yfbuJRQj5d+oE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bwecQQRc3LyglBoJYqqx/+/M4wGXc1p8W/+y13OdJJ/ymYGF19I4ZUt4dHac6pXoo
 pU5Q+pPmAzVsIjSLDAbu1tIBcQaEiveH9e6g4KHFB+RPIx6SMANzCUMLMmqXIgmGH5
 oIX/gU+1hIFnLhy5Qb6hNTl+XaPF0zlxs98u+4fHIP8oNszyyJ6JTATBtc4iVhzj77
 yWBw7MDnsXRKZJAt3EW9SPcCt1SxTThOcfriPm5bHzgZx7D5oE4o4vVIwZRztZ7UZu
 0/pE2+QX3b/q50XuYHXnT2+eJek8aK1qHODqrf+bJwtPgPr5Dr0YvkEAPEf0l/usU7
 liaiMXNqxFcaw==
Date: Wed, 29 Jul 2020 15:48:56 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 12/18] hw/block/nvme: support the get/set features
 select and save fields
Message-ID: <20200729134856.GA181110@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-13-its@irrelevant.dk>
 <e8cbd8b2126ae35324d13f24a75f591a5a0b1e82.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8cbd8b2126ae35324d13f24a75f591a5a0b1e82.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:44:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 16:17, Maxim Levitsky wrote:
> On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Since the device does not have any persistent state storage, no
> > features are "saveable" and setting the Save (SV) field in any Set
> > Features command will result in a Feature Identifier Not Saveable status
> > code.
> > 
> > Similarly, if the Select (SEL) field is set to request saved values, the
> > devices will (as it should) return the default values instead.
> > 
> > Since this also introduces "Supported Capabilities", the nsid field is
> > now also checked for validity wrt. the feature being get/set'ed.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c       | 103 +++++++++++++++++++++++++++++++++++++-----
> >  hw/block/trace-events |   4 +-
> >  include/block/nvme.h  |  27 ++++++++++-
> >  3 files changed, 119 insertions(+), 15 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 2d85e853403f..df8b786e4875 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1083,20 +1091,47 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> >      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> >      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> > +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> >      uint32_t result;
> >      uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> > +    NvmeGetFeatureSelect sel = NVME_GETFEAT_SELECT(dw10);
> >      uint16_t iv;
> >  
> >      static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
> >          [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
> >      };
> >  
> > -    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
> > +    trace_pci_nvme_getfeat(nvme_cid(req), fid, sel, dw11);
> >  
> >      if (!nvme_feature_support[fid]) {
> >          return NVME_INVALID_FIELD | NVME_DNR;
> >      }
> >  
> > +    if (nvme_feature_cap[fid] & NVME_FEAT_CAP_NS) {
> > +        if (!nsid || nsid > n->num_namespaces) {
> > +            /*
> > +             * The Reservation Notification Mask and Reservation Persistence
> > +             * features require a status code of Invalid Field in Command when
> > +             * NSID is 0xFFFFFFFF. Since the device does not support those
> > +             * features we can always return Invalid Namespace or Format as we
> > +             * should do for all other features.
> > +             */
> > +            return NVME_INVALID_NSID | NVME_DNR;
> > +        }
> > +    }
> > +
> > +    switch (sel) {
> > +    case NVME_GETFEAT_SELECT_CURRENT:
> > +        break;
> > +    case NVME_GETFEAT_SELECT_SAVED:
> > +        /* no features are saveable by the controller; fallthrough */
> > +    case NVME_GETFEAT_SELECT_DEFAULT:
> > +        goto defaults;
> 
> I hate to say it, but while I have nothing against using 'goto' (unlike some types I met),
> In this particular case it feels like it would be better to have  a separate function for
> defaults, or have even have a a separate function per feature and have it return current/default/saved/whatever
> value. The later would allow to have each feature self contained in its own function.
> 
> But on the other hand I see that you fail back to defaults for unchangeble features, which does make
> sense. In other words, I don't have strong opinion against using goto here after all.
> 
> When feature code will be getting more features in the future (pun intended) you probably will have to split it,\
> like I suggest to keep code complexity low.
> 

Argh... I know you are right.

Since you are "accepting" the current state with your R-b and it already
carries one from Dmitry I think I'll let this stay for now, but I will
fix this in a follow up patch for sure.

> > @@ -926,6 +949,8 @@ typedef struct NvmeLBAF {
> >      uint8_t     rp;
> >  } NvmeLBAF;
> >  
> > +#define NVME_NSID_BROADCAST 0xffffffff
> 
> Cool, you probably want eventually to go over code and
> change all places that use the number to the define.
> (No need to do this now)
> 

True. Noted :)

