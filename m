Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6811BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C0020684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRrBR9+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C0020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAY6-0006GX-SV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIAMZ-00006x-N6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIAMW-0003xt-LU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ddvOW0Bgfqp0UQJ2cPte165OtK5S5MyeErAXwve5cw=;
 b=IRrBR9+Ug2dnmB4rLp/nl475jSuC10OQUv0muPu0/g8dtBdi6PQfDln4yPMNfFAV6KtF6S
 uYvfOAOYg1QGmGiZguWKkqwuNH5tR9LFl7vuvmyB///Oh/52pMqNh42AZN/TnNco0ZY4zG
 dXicPRcLtH3XkM0pycI8fk/lEZY/utI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-EjEUUuK_MIqJq8TEjNqeVQ-1; Tue, 15 Sep 2020 08:47:00 -0400
X-MC-Unique: EjEUUuK_MIqJq8TEjNqeVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B01F80EF9D;
 Tue, 15 Sep 2020 12:46:59 +0000 (UTC)
Received: from kaapi (ovpn-116-229.sin2.redhat.com [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B496F5C1CF;
 Tue, 15 Sep 2020 12:46:54 +0000 (UTC)
Date: Tue, 15 Sep 2020 18:16:52 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
In-Reply-To: <20200827114917.1851111-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009151816180.10832@xnncv>
References: <20200827114917.1851111-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 27 Aug 2020, P J P wrote --+
| While mapping IRQ level in pci_change_irq_level() routine,
| it does not check if pci_get_bus() returned a valid pointer.
| It may lead to a NULL pointer dereference issue. Add check to
| avoid it.
| 
|  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Flsi_nullptr1
|     ==1183858==Hint: address points to the zero page.
|     #0 pci_change_irq_level hw/pci/pci.c:259
|     #1 pci_irq_handler hw/pci/pci.c:1445
|     #2 pci_set_irq hw/pci/pci.c:1463
|     #3 lsi_set_irq hw/scsi/lsi53c895a.c:488
|     #4 lsi_update_irq hw/scsi/lsi53c895a.c:523
|     #5 lsi_script_scsi_interrupt hw/scsi/lsi53c895a.c:554
|     #6 lsi_execute_script hw/scsi/lsi53c895a.c:1149
|     #7 lsi_reg_writeb hw/scsi/lsi53c895a.c:1984
|     #8 lsi_io_write hw/scsi/lsi53c895a.c:2146
|     ...
| 
| Reported-by: Ruhr-University <bugs-syssec@rub.de>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  hw/pci/pci.c | 3 +++
|  1 file changed, 3 insertions(+)
| 
| diff --git a/hw/pci/pci.c b/hw/pci/pci.c
| index de0fae10ab..df5a2c3294 100644
| --- a/hw/pci/pci.c
| +++ b/hw/pci/pci.c
| @@ -253,6 +253,9 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
|      PCIBus *bus;
|      for (;;) {
|          bus = pci_get_bus(pci_dev);
| +        if (!bus) {
| +            return;
| +        }
|          irq_num = bus->map_irq(pci_dev, irq_num);
|          if (bus->set_irq)
|              break;
| 


Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


