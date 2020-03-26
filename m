Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A6C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB4D2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj8WK38s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB4D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSl6-0003SN-2W
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHSkA-0002Gz-74
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHSk8-0001Hk-Kr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHSk8-0001HN-CJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585230019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCYr0d62dAcG/vbDx3bXeo52O/ssg+gGu8HNGqy9AU4=;
 b=cj8WK38sLamqmGsyXEjyTmzw+TKvQvbu3KwJpyjHtOFmrLcKf01IbxiewEDQ4+3CqtMCE2
 bJuvws8DWYrg74S4xZacnd1hMYqLg01Mtm7fWlsIirXi1NmJ6HuxFcnRwizTtd7x7nwKOp
 92772yztiYjYLWFECiuT6q18eIIrvpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-Zgm424a2NKysYI2MnWVQcw-1; Thu, 26 Mar 2020 09:40:18 -0400
X-MC-Unique: Zgm424a2NKysYI2MnWVQcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 062F1107B796;
 Thu, 26 Mar 2020 13:40:17 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A556D5C1B0;
 Thu, 26 Mar 2020 13:40:10 +0000 (UTC)
Date: Thu, 26 Mar 2020 14:40:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: acpi_pcihp_eject_slot() bug if passed 'slots == 0'
Message-ID: <20200326144008.7511cdf5@redhat.com>
In-Reply-To: <20200326092955-mutt-send-email-mst@kernel.org>
References: <CAFEAcA-oWBjOXWmnLvPww9wrty_QbSc+Xv3BY3sQAnEXFkfQbA@mail.gmail.com>
 <20200326142317.018c13e1@redhat.com>
 <20200326092535-mutt-send-email-mst@kernel.org>
 <20200326092955-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 09:31:09 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 26, 2020 at 09:28:27AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 26, 2020 at 02:23:17PM +0100, Igor Mammedov wrote:  
> > > On Thu, 26 Mar 2020 11:52:36 +0000
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >   
> > > > Hi; Coverity spots that if hw/acpi/pcihp.c:acpi_pcihp_eject_slot()
> > > > is passed a zero 'slots' argument then ctz32(slots) will return 32,
> > > > and then the code that does '1U << slot' is C undefined behaviour
> > > > because it's an oversized shift. (This is CID 1421896.)
> > > > 
> > > > Since the pci_write() function in this file can call
> > > > acpi_pcihp_eject_slot() with an arbitrary value from the guest,
> > > > I think we need to handle 'slots == 0' safely. But what should
> > > > the behaviour be?  
> > > 
> > > it also uncovers a bug, where we are not able to eject slot 0 on bridge,  
> > 
> > 
> > And that is by design. A standard PCI SHPC register can support up to 31
> > hotpluggable slots. So we chose slot 0 as non hotpluggable.
> > It's consistent across SHPC, PCI-E, so I made ACPI match.  
> 
> Sorry I was confused. It's a PCI thing, PCI-E does not have
> slot numbers for downstream ports at all.

Scratch that, it was mistake on my part where I tests with a change
that masks 0 and wrongly at that.

slot 0 on bridge can be removed just fine 

> 
> > You can't hot-add it either.
> >   
> > > can be reproduced with:
> > > 
> > >  -enable-kvm -m 4G -device pci-bridge,chassis_nr=1 -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device virtio-net-pci,bus=pci.1,addr=0,id=netdev12
> > > 
> > > (monitor) device_del netdev12
> > > (monitor) qtree # still shows the device
> > > 
> > > reason is that acpi_pcihp_eject_slot()
> > >    if (PCI_SLOT(dev->devfn) == slot) { # doesn't  match (0 != 32)
> > > 
> > > so device is not deleted  
> > 
> > We should probably teach QEMU that some slots aren't hotpluggable
> > even if device in it is hotpluggable in theory. But that is
> > a separate issue.
> >   
> > > > thanks
> > > > -- PMM
> > > >   
> 


