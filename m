Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BD5CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BE620663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOo0QSog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BE620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPRJ-0004Ej-1N
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPY-0002G0-55
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNPPT-0007Lc-NA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNPPQ-0007DP-2K
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571870833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yDDY6oOVAl1wZFIuiv6IAxl42tD8bgPjZNcyepNtE/I=;
 b=IOo0QSog1oR8YyGsFQLDu0veHbJPlUL7Qe7kNIEzPzom3CBXKFTtVoIbtbDAdLOQmcgB80
 gBKqNvrbmiNxlNvV5fIjAcgth6XyUurz3xicYVWQItWqsNZU5aCc7evIGZopra/d41bJ/L
 24IOnXo5nSfX0RiJs4ubeneH0T+WM8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Fj0MvnJ3N4C12QfD-2nEDQ-1; Wed, 23 Oct 2019 18:47:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 641731800D6B
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:47:10 +0000 (UTC)
Received: from gimli.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 858605D6D0;
 Wed, 23 Oct 2019 22:47:03 +0000 (UTC)
Subject: [RESEND PATCH 0/2] PCI DMA alias support
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 23 Oct 2019 16:47:02 -0600
Message-ID: <157187055395.5439.6693401317571144578.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Fj0MvnJ3N4C12QfD-2nEDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous posting:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06182.html

Rebased (no change) and added Peter's R-b.  Please apply for QEMU 4.2.

Previous cover letter:

Please see patch 1/ for the motivation and utility of this series.
This v1 submission improves on the previous RFC with revised commit
logs, comments, and more testing, and the missing IVRS support for DMA
alias ranges is now included.  Testing has been done with Linux guests
with both SeaBIOS and OVMF with configurations of intel-iommu and
amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
is necessarily limited to emulated devices with interrupt remapping
disabled and iommu=3Dpt in the guest (enabling interrupt remapping or
disabling guest passthrough mode fails to work regardless of this
series).  This series is NOT intended for QEMU v4.1.  Thanks,

Alex

---

Alex Williamson (2):
      pci: Use PCI aliases when determining device IOMMU address space
      hw/i386: AMD-Vi IVRS DMA alias support


 hw/i386/acpi-build.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++=
+---
 hw/pci/pci.c         |   43 ++++++++++++++++-
 2 files changed, 160 insertions(+), 10 deletions(-)


