Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F802073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBxdT668"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F802073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU4M-0004Ai-OQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAS-00020h-SG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAN-0001QE-4u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDOSBX+I1rycg2KqbZ9V3sM7gy5Up2HI9ibUsGnKUzQ=;
 b=DBxdT668AeNtG5BKARUN0T6hEgzpYILtN1MLVpF3QSJ9M3rOsdm2WEqJLtutVpA9kNqJ95
 Q8wmdcnoMXxeDhNlbLxH50BORuQmcdp9KTFwQ2ywE7E657lDGxsucWZJWw/LBBzqlloF7X
 SWmrHPPA+Pr6IzLtsOfKLTmOPCju+uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-tD5-rnoaMDK9bfPik4eNJQ-1; Thu, 11 Jun 2020 15:45:38 -0400
X-MC-Unique: tD5-rnoaMDK9bfPik4eNJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D0C88015CE;
 Thu, 11 Jun 2020 19:45:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7BD58FF91;
 Thu, 11 Jun 2020 19:45:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 058/115] disas: Let disas::read_memory() handler return EIO on
 error
Date: Thu, 11 Jun 2020 15:43:52 -0400
Message-Id: <20200611194449.31468-59-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Both cpu_memory_rw_debug() and address_space_read() return
an error on failed transaction. Check the returned value,
and return EIO in case of error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/disas.c b/disas.c
index 45285d3f63..c1397d3933 100644
--- a/disas.c
+++ b/disas.c
@@ -39,9 +39,11 @@ target_read_memory (bfd_vma memaddr,
                     struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
+    int r;
 
-    cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-    return 0;
+    r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
+
+    return r ? EIO : 0;
 }
 
 /* Print an error message.  We can assume that this is in response to
@@ -718,10 +720,11 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
+    MemTxResult res;
 
-    address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
-                       myaddr, length);
-    return 0;
+    res = address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
+                             myaddr, length);
+    return res == MEMTX_OK ? 0 : EIO;
 }
 
 /* Disassembler for the monitor.  */
-- 
2.26.2



