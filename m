Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D032EC35256
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B97206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZx8fc+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B97206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQwd-0003Me-Dr
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIQvD-0001gr-0R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:28:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIQv9-0007ST-HY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600237678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxEKtj0TConFqtJMGdUGim2Qm+NGUqGqg2OeQXOKzEQ=;
 b=fZx8fc+clMzBUWcD85Wry5CEFHLio9+Ddy1KVMdNCIoQbFC5rJ7pjclF6uMdGt6LiScUQp
 ZQKYX+D6NV0VvHs0ua+B8b6pNANBC+ydwvNU+zAEZ65Q/Hgz5wIStkTke1VhEY/EyxLc+z
 GKqPEW9/iZ52OP76+G1A7oAp2B6laNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-N1bvOt4tMJqk4C3tyg5XMA-1; Wed, 16 Sep 2020 02:27:56 -0400
X-MC-Unique: N1bvOt4tMJqk4C3tyg5XMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C032E801F97;
 Wed, 16 Sep 2020 06:27:54 +0000 (UTC)
Received: from kaapi (ovpn-112-169.phx2.redhat.com [10.3.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2484F5D9CA;
 Wed, 16 Sep 2020 06:27:47 +0000 (UTC)
Date: Wed, 16 Sep 2020 11:57:45 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
In-Reply-To: <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
 <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-425576118-1600237674=:10832"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ruhr-University <bugs-syssec@rub.de>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-425576118-1600237674=:10832
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Tue, 15 Sep 2020, Philippe Mathieu-Daudé wrote --+
| > I think in normal this 'bus' will be not NULL. I have look at the link in 
| > the commit msg. I find it is another DMA to MMIO issue which we have 
| > discussed a lot but didn't come up with an satisfying solution.

  If 'bus' is unlikely to be NULL, should this be a regular non-CVE bug?
 
| As usual, question is how we got here.
| As Li said, it is another DMA to MMIO bug class.
| 
| lsi_execute_script
|  -> address_space_write
|     -> acpi_pcihp_eject_slot
|        -> bus_remove_child
| 
| So at this point the PCI device is still MMIO-mapped but eject from the 
| bus... ??? Then IRQ is triggered, which the device wants to propagate via 
| its PCI bus but it doesn't have any more and b00m.
| 
| If a device is hotpluggable, who is responsible to unmap its regions?

  Not sure, I guess I'll leave it for the upstream maintainers to device a 
better solution.

| Nack, this should be an abort().

===
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab..0ccb991410 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -253,6 +253,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int 
irq_num, int change)
     PCIBus *bus;
     for (;;) {
         bus = pci_get_bus(pci_dev);
+        assert(bus);
         irq_num = bus->map_irq(pci_dev, irq_num);
         if (bus->set_irq)
             break;
===

This should be okay for now?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-425576118-1600237674=:10832--


