Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E5C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 00:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC16C229F9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 00:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC16C229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrB03-0007cW-TI
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 20:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hrAzu-0007DL-KO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hrAzt-00080H-J2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:55:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hrAzt-0007sW-6P
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 20:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64A994ACDF;
 Sat, 27 Jul 2019 00:55:35 +0000 (UTC)
Received: from gimli.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E394219C79;
 Sat, 27 Jul 2019 00:55:27 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 18:55:27 -0600
Message-ID: <156418830210.10856.17740359763468342629.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Sat, 27 Jul 2019 00:55:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [for-4.2 PATCH 0/2] PCI DMA alias support
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
Cc: brijesh.singh@amd.com, mst@redhat.com, zhexu@redhat.com,
 eric.auger@redhat.com, Suravee.Suthikulpanit@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please see patch 1/ for the motivation and utility of this series.
This v1 submission improves on the previous RFC with revised commit
logs, comments, and more testing, and the missing IVRS support for DMA
alias ranges is now included.  Testing has been done with Linux guests
with both SeaBIOS and OVMF with configurations of intel-iommu and
amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
is necessarily limited to emulated devices with interrupt remapping
disabled and iommu=pt in the guest (enabling interrupt remapping or
disabling guest passthrough mode fails to work regardless of this
series).  This series is NOT intended for QEMU v4.1.  Thanks,

Alex

---

Alex Williamson (2):
      pci: Use PCI aliases when determining device IOMMU address space
      hw/i386: AMD-Vi IVRS DMA alias support


 hw/i386/acpi-build.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++---
 hw/pci/pci.c         |   43 ++++++++++++++++-
 2 files changed, 160 insertions(+), 10 deletions(-)

