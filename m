Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC7DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E0620848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7FB30Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E0620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2sS-0003tc-4u
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fb-0003aD-P3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fW-0006pR-Tn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmimizovWQ8kEMBX0Xd3BqYrtymzyrFOHBYXTZjWNPQ=;
 b=E7FB30Wye4yIBn6RZCJz9upgsYT9NiqsXfEW09dW/4TkzZ09Hvfk9KttqW17ceVl5WN9I/
 5Dbdiy4kIVdbRpWv9vk3nb6ukZ7MvzSw0ovl/q0wQVvfxcv0oOHDQmvo/7dPkA4x/x3jxp
 crMFaueM+xg4NTsg69vS2By8bYbwyos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-2Nq6EXG2PQO_uDQ495g0UQ-1; Thu, 01 Oct 2020 13:46:58 -0400
X-MC-Unique: 2Nq6EXG2PQO_uDQ495g0UQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7925801AC2;
 Thu,  1 Oct 2020 17:46:56 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 300545C1CF;
 Thu,  1 Oct 2020 17:46:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/ide/ahci: Do not dma_memory_unmap(NULL)
Date: Thu,  1 Oct 2020 13:46:42 -0400
Message-Id: <20201001174649.1911016-3-jsnow@redhat.com>
In-Reply-To: <20201001174649.1911016-1-jsnow@redhat.com>
References: <20201001174649.1911016-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none -qtest stdio
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe1068000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0xe1068304 0x1 0x21
  write 0xe1068318 0x1 0x21
  write 0xe1068384 0x1 0x21
  write 0xe1068398 0x2 0x21
  EOF
  qemu-system-i386: exec.c:3621: address_space_unmap: Assertion `mr != NULL' failed.
  Aborted (core dumped)

This is because we don't check the return value from dma_memory_map()
which can return NULL, then we call dma_memory_unmap(NULL) which is
illegal. Fix by only unmap if the value is not NULL (and the size is
not the expected one).

Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200718072854.7001-1-f4bug@amsat.org
Fixes: f6ad2e32f8 ("ahci: add ahci emulation")
BugLink: https://bugs.launchpad.net/qemu/+bug/1884693
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ee1d47ff756..680304a24c3 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -250,7 +250,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
     }
 
     *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
-    if (len < wanted) {
+    if (len < wanted && *ptr) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
     }
-- 
2.26.2


