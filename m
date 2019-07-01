Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319BF20881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319BF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhw5F-0006Fv-RZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hhvwr-0000BU-Fg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hhvwo-0002gA-WE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hhvwk-0002Qe-E6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 692F630811C7
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 13:01:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD31419C6F;
 Mon,  1 Jul 2019 13:01:54 +0000 (UTC)
Date: Mon, 1 Jul 2019 15:01:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190701150150.4f58cdb7@redhat.com>
In-Reply-To: <20190621064615.20099-4-mst@redhat.com>
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-4-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 01 Jul 2019 13:01:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] pcie: work around for racy guest init
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 02:46:50 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> During boot, linux guests tend to clear all bits in pcie slot status
> register which is used for hotplug.
> If they clear bits that weren't set this is racy and will lose events:
> not a big problem for manual hotplug on bare-metal, but a problem for us.
> 
> For example, the following is broken ATM:
> 
> /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
>     -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
>     -device virtio-balloon-pci,id=balloon,bus=pcie_root_port_0 \
>     -monitor stdio disk.qcow2
> (qemu)device_del balloon
> (qemu)cont
> 
> Balloon isn't deleted as it should.
> 
> As a work-around, detect this attempt to clear slot status and revert
> status to what it was before the write.
> 
> Note: in theory this can be detected as a duplicate button press
> which cancels the previous press. Does not seem to happen in
> practice as guests seem to only have this bug during init.
> 
> Note2: the right thing to do is probably to fix Linux to
> read status before clearing it, and act on the bits that are set.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>


had to change slot addr since #2 seems to be taken by default nic


> ---
>  hw/pci/pcie.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index f8490a00de..c605d32dd4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -610,6 +610,25 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
>      uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
>  
>      if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
> +        /*
> +         * Guests tend to clears all bits during init.
> +         * If they clear bits that weren't set this is racy and will lose events:
> +         * not a big problem for manual button presses, but a problem for us.
> +         * As a work-around, detect this and revert status to what it was
> +         * before the write.
> +         *
> +         * Note: in theory this can be detected as a duplicate button press
> +         * which cancels the previous press. Does not seem to happen in
> +         * practice as guests seem to only have this bug during init.
> +         */
> +#define PCIE_SLOT_EVENTS (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD | \
> +                          PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
> +                          PCI_EXP_SLTSTA_CC)
> +
> +        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
> +            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
> +            pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
> +        }
>          hotplug_event_clear(dev);
>      }
>  


