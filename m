Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA9C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF4D206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF4D206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0tC-0007JD-8X
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:52:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rK-0005lp-00
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rI-00017o-1n
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0rH-00016m-Rj
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F90683F44
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:50:39 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 469D31820D;
	Wed, 15 May 2019 20:50:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:14 +0200
Message-Id: <1557953433-19663-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 15 May 2019 20:50:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/21] roms: assert if max rom size is less than
 the used size
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

It would ensure that we would notice attempt to write beyond
the allocated buffer. In case of MemoryRegion backed ROM it's
the host buffer and the guest RAM otherwise.

assert can be triggered with:
  dd if=/dev/zero of=/tmp/blob bs=63k count=1
  qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`

Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)

Reported-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1



