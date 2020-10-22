Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCAAC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DB822249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2WdZe4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DB822249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbAf-0001h6-PX
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVb9m-0000od-3X
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVb9k-0008T8-1g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603375287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xq3YgRne/1Oa0sCrarteptKxgeTDJlW4MNo3ant4Vug=;
 b=Z2WdZe4kktjehbgd9mDBMtaC5M19xTHxPPsEZi3eEXiXYr2LCZkbnNzaH09/YcICcn2kGr
 5YuSVt2cc3OuAS9QU1a0TEsQWfWXbC/0t+D7ZcdB8pxbqkxiCI39V2zrMEcIQLbbUAGPeq
 r4NlCDG7BN9omht9Ryw61q98qUT2QVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-3RlSO34wMHe-sluTf0oUQg-1; Thu, 22 Oct 2020 10:01:23 -0400
X-MC-Unique: 3RlSO34wMHe-sluTf0oUQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 339391084D65;
 Thu, 22 Oct 2020 14:01:22 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1DC85C1DA;
 Thu, 22 Oct 2020 14:01:17 +0000 (UTC)
Date: Thu, 22 Oct 2020 10:01:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201022100028-mutt-send-email-mst@kernel.org>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: David Gibson <dgibson@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 04:55:10PM +0300, Marcel Apfelbaum wrote:
> Hi David, Michael,
> 
> On Thu, Oct 22, 2020 at 3:56 PM David Gibson <dgibson@redhat.com> wrote:
> 
>     On Thu, 22 Oct 2020 08:06:55 -0400
>     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>     > On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum wrote:
>     > > From: Marcel Apfelbaum <marcel@redhat.com>
>     > >
>     > > During PCIe Root Port's transition from Power-Off to Power-ON (or
>     vice-versa)
>     > > the "Slot Control Register" has the "Power Indicator Control"
>     > > set to "Blinking" expressing a "power transition" mode.
>     > >
>     > > Any hotplug operation during the "power transition" mode is not
>     permitted
>     > > or at least not expected by the Guest OS leading to strange failures.
>     > >
>     > > Detect and refuse hotplug operations in such case.
>     > >
>     > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>     > > ---
>     > >  hw/pci/pcie.c | 7 +++++++
>     > >  1 file changed, 7 insertions(+)
>     > >
>     > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>     > > index 5b48bae0f6..2fe5c1473f 100644
>     > > --- a/hw/pci/pcie.c
>     > > +++ b/hw/pci/pcie.c
>     > > @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler
>     *hotplug_dev, DeviceState *dev,
>     > >      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
>     > >      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->
>     exp.exp_cap;
>     > >      uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
>     > > +    uint32_t sltctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
>     > > 
>     > >      /* Check if hot-plug is disabled on the slot */
>     > >      if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
>     > > @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler
>     *hotplug_dev, DeviceState *dev,
>     > >          return;
>     > >      }
>     > > 
>     > > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_BLINK)
>     {
>     > > +        error_setg(errp, "Hot-plug failed: %s is in Power Transition",
>     > > +                   DEVICE(hotplug_pdev)->id);
>     > > +        return;
>     > > +    }
>     > > +
>     > >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
>     > >  } 
>     >
>     > Probably the only way to handle for existing machine types.
> 
> 
> I agree
>  
> 
>     > For new ones, can't we queue it in host memory somewhere?
> 
> 
> 
> I am not sure I understand what will be the flow.
>   - The user asks for a hotplug operation.
>   -  QEMU deferred operation.
> After that the operation may still fail, how would the user know if the
> operation
> succeeded or not?


How can it fail? It's just a button press ...

>  
> 
>     I'm not actually convinced we can't do that even for existing machine
>     types. 
> 
> 
> Is a Guest visible change, I don't think we can do it.
>  
> 
>     So I'm a bit hesitant to suggest going ahead with this without
>     looking a bit closer at whether we can implement a wait-for-ready in
>     qemu, rather than forcing every user of qemu (human or machine) to do
>     so.
> 
> 
> While I agree it is a pain from the usability point of view, hotplug operations
> are allowed to fail. This is not more than a corner case, ensuring the right
> response (gracefully erroring out) may be enough.
> 
> Thanks,
> Marcel
> 


I don't think they ever failed in the past so management is unlikely
to handle the failure by retrying ...

> 
> 
> 
>     --
>     David Gibson <dgibson@redhat.com>
>     Principal Software Engineer, Virtualization, Red Hat
> 


