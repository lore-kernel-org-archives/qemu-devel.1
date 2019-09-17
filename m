Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9970CC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E07D214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E07D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADGI-0003cv-5A
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iADCQ-00005B-9W
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iADCO-0002Y4-C7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iADCO-0002Xu-7B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A501315C00C;
 Tue, 17 Sep 2019 13:07:15 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEF1419C4F;
 Tue, 17 Sep 2019 13:07:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 09:07:06 -0400
Message-Id: <20190917130708.10281-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 13:07:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] q35: mch: allow to lock down 128K RAM at
 default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, lersek@redhat.com, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Try #2 using PCI config space of MCH to negotiate/lock SMRAM
at 0x30000.

CC: yingwen.chen@intel.com
CC: devel@edk2.groups.io
CC: phillip.goerl@oracle.com
CC: alex.williamson@redhat.com
CC: jiewen.yao@intel.com
CC: jun.nakajima@intel.com
CC: michael.d.kinney@intel.com
CC: pbonzini@redhat.com
CC: boris.ostrovsky@oracle.com
CC: rfc@edk2.groups.io
CC: joao.m.martins@oracle.com
CC: lersek@redhat.com


Igor Mammedov (2):
  q35: implement 128K SMRAM at default SMBASE address
  tests: q35: MCH: add default SMBASE SMRAM lock test

 include/hw/pci-host/q35.h |  10 ++++
 hw/i386/pc.c              |   4 +-
 hw/pci-host/q35.c         |  80 ++++++++++++++++++++++++++---
 tests/q35-test.c          | 105 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.18.1


