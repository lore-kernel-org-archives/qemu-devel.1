Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD38C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3109720656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOzm9AlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3109720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97TT-0006lS-G2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97Sn-0005vc-6b
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:52:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97Sk-0002NY-AK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598017929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8X/34eU6tad8+yScBoLn3huELbgomAzhhbwTolRyI0=;
 b=BOzm9AlUPwD2gAR+2DklBeUb0uC9+A36psv9iqqwSVOhmwKZURpRsfsC1jOWf8cn7+VDpz
 i2/I8gTuBIdjSwx4MthOES6WpHjlUa0PziTxJ8iGjIX2INLpADjYLijxWlAeHMHjfPXNs8
 O76/v9SBmCMP4N0dRXWCDazsd0DBv8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-EMfwNQoVMr2IFhZsSpxSZg-1; Fri, 21 Aug 2020 09:52:07 -0400
X-MC-Unique: EMfwNQoVMr2IFhZsSpxSZg-1
Received: by mail-wr1-f70.google.com with SMTP id b8so575167wrr.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=E8X/34eU6tad8+yScBoLn3huELbgomAzhhbwTolRyI0=;
 b=mrYu0v3d74w7mYQBLfGJDrnvDsCKYeeZn/14aj0GSSKUK0+orspR9r5GKlzmcCstMp
 tgzzpuwX32JA9EHfj5qutK4dJLacjKCav6c98w4bEMCA3BkGvQOgYnVmczfxy9xdAOG8
 9N20+rVfWv6N0GqBJu49iV5ufM+2mBPWJhY+f12q5jr/QwZmHOZ32zQzTN16U6eVTqs3
 vV8lYddfVt3/u5sOep7ZbeQ4naKLcxZzOKv5V454SYDPn1Wz9IIBjXZKipIC0EcwOTNG
 wFkyjI5oTn3djAjyFw6ejlb2F9nwFNb7I8FMunIMfViksDmbpFMnphS2lW3jLSLh7mFo
 2IPw==
X-Gm-Message-State: AOAM531yYnpKd4Qp0coMhdjpu9CFZ6kprgbT/yr/QrXAvwQ+IqhFk7xx
 WI1l92Yc+EQNPUX0SrW4djkPbujnFezjjN479925LYUzqTgqfPR+lLOmdbmjAuc7OY6fKBY7RKN
 Wvk9PFxurpqoK/Nw=
X-Received: by 2002:adf:83c5:: with SMTP id 63mr2797973wre.321.1598017926099; 
 Fri, 21 Aug 2020 06:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4RYkDm0EERUDu5g+j4hT6UBLJK9qVXO3Pfcl+wsScOXbthb2cI7vPVlqz6SJqvd1ZaXpVOg==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr2797954wre.321.1598017925829; 
 Fri, 21 Aug 2020 06:52:05 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id q19sm4755355wrf.48.2020.08.21.06.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:52:05 -0700 (PDT)
Date: Fri, 21 Aug 2020 15:52:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 08/15] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Message-ID: <20200821135202.2z6da2kbrrrpkfhb@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-9-philmd@redhat.com>
 <20200821100341.a6xtnv4e2dqli56a@steredhat>
 <f35b9d96-1584-b627-895f-a4f0214d55a6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f35b9d96-1584-b627-895f-a4f0214d55a6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 03:27:15PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/21/20 12:03 PM, Stefano Garzarella wrote:
> > On Thu, Aug 20, 2020 at 06:58:54PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> We allocate an unique chunk of memory then use it for two
> >> different structures. By using an union, we make it clear
> >> the data is overlapping (and we can remove the casts).
> >>
> >> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >> ---
> >>  block/nvme.c | 31 +++++++++++++++----------------
> >>  1 file changed, 15 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/block/nvme.c b/block/nvme.c
> >> index 99822d9fd36..2bd1935f951 100644
> >> --- a/block/nvme.c
> >> +++ b/block/nvme.c
> >> @@ -508,9 +508,10 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
> >>  static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >>  {
> >>      BDRVNVMeState *s = bs->opaque;
> >> -    NvmeIdCtrl *idctrl;
> >> -    NvmeIdNs *idns;
> >> -    uint8_t *id;
> >> +    union {
> >> +        NvmeIdCtrl ctrl;
> >> +        NvmeIdNs ns;
> >> +    } *id;
> > 
> > What about defining a new 'NvmeId' type with this union?
> 
> I'd rather not, these are different command responses, it
> just happens to make this code simpler as the same response
> packet is used for the 2 requests.
> 
> See previous discussion:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg716858.html

Yeah, if it is useful only in this part of the code, never mind defining a
new type.

> 
> > 
> >>      NvmeLBAF *lbaf;
> >>      uint16_t oncs;
> >>      int r;
> >> @@ -520,14 +521,12 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >>          .cdw10 = cpu_to_le32(0x1),
> >>      };
> >>  
> >> -    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
> >> +    id = qemu_try_blockalign0(bs, sizeof(*id));
> >>      if (!id) {
> >>          error_setg(errp, "Cannot allocate buffer for identify response");
> >>          goto out;
> >>      }
> >> -    idctrl = (NvmeIdCtrl *)id;
> >> -    idns = (NvmeIdNs *)id;
> >> -    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
> >> +    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
> >>      if (r) {
> >>          error_setg(errp, "Cannot map buffer for DMA");
> >>          goto out;
> >> @@ -539,22 +538,22 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >>          goto out;
> >>      }
> >>  
> >> -    if (le32_to_cpu(idctrl->nn) < namespace) {
> >> +    if (le32_to_cpu(id->ctrl.nn) < namespace) {
> >>          error_setg(errp, "Invalid namespace");
> >>          goto out;
> >>      }
> >> -    s->write_cache_supported = le32_to_cpu(idctrl->vwc) & 0x1;
> >> -    s->max_transfer = (idctrl->mdts ? 1 << idctrl->mdts : 0) * s->page_size;
> >> +    s->write_cache_supported = le32_to_cpu(id->ctrl.vwc) & 0x1;
> >> +    s->max_transfer = (id->ctrl.mdts ? 1 << id->ctrl.mdts : 0) * s->page_size;
> >>      /* For now the page list buffer per command is one page, to hold at most
> >>       * s->page_size / sizeof(uint64_t) entries. */
> >>      s->max_transfer = MIN_NON_ZERO(s->max_transfer,
> >>                            s->page_size / sizeof(uint64_t) * s->page_size);
> >>  
> >> -    oncs = le16_to_cpu(idctrl->oncs);
> >> +    oncs = le16_to_cpu(id->ctrl.oncs);
> >>      s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
> >>      s->supports_discard = !!(oncs & NVME_ONCS_DSM);
> >>  
> >> -    memset(id, 0, 4096);
> >> +    memset(id, 0, sizeof(*id));
> >>      cmd.cdw10 = 0;
> >>      cmd.nsid = cpu_to_le32(namespace);
> >>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
> >> @@ -562,11 +561,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> >>          goto out;
> >>      }
> >>  
> >> -    s->nsze = le64_to_cpu(idns->nsze);
> >> -    lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
> >> +    s->nsze = le64_to_cpu(id->ns.nsze);
> >> +    lbaf = &id->ns.lbaf[NVME_ID_NS_FLBAS_INDEX(id->ns.flbas)];
> >>  
> >> -    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(idns->dlfeat) &&
> >> -            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
> >> +    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(id->ns.dlfeat) &&
> >> +            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(id->ns.dlfeat) ==
> >>                      NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES) {
> >>          bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
> >>      }
> >> -- 
> >> 2.26.2
> >>
> >>
> > 
> > With or without the new tyoe, the patch looks good to me:
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks!
> 
> Phil.
> 


