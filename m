Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF49C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE09E217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE09E217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXtN-00071K-8w
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:29:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEXsI-0006Rx-IA
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEXsH-0005qp-I0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hEXsH-0005po-9X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AB073086258;
	Thu, 11 Apr 2019 11:28:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F2355D9C4;
	Thu, 11 Apr 2019 11:27:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 13:28:18 +0200
Message-Id: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 11 Apr 2019 11:28:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] roms: assert if max rom size is less
 than the used size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, mst@redhat.com, richard.henderson@linaro.org,
	stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411112818.dplb-KM6c-IinqPElH28GHBVMiWh74v-0TXo03Gk2D8@z>

It would ensure that we would notice attempt to write beyond
the allocated buffer. In case of MemoryRegion backed ROM it's
the host buffer and the guest RAM otherwise.

assert can be triggered with:
  dd if=/dev/zero of=/tmp/blob bs=63k count=1
  qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`

Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)

Reported-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fe5cb24..a097bbe 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1025,6 +1025,7 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     rom->addr     = addr;
     rom->romsize  = max_len ? max_len : len;
     rom->datasize = len;
+    g_assert(rom->romsize >= rom->datasize);
     rom->data     = g_malloc0(rom->datasize);
     memcpy(rom->data, blob, len);
     rom_insert(rom);
-- 
2.7.4


