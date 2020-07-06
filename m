Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA1D20702
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiIhluPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA1D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUQ7-0000e2-6S
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCS-0003uA-G5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCO-00039y-9G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXRW3Q/WETn+JuDwQAj4PBLKu+E9iCTUxcQIDvJfX0A=;
 b=fiIhluPCgUamFTQ4funFmWyiY3UDqlyaGYP0YkbZ1NiyIaL787NHdLNN9jCWrtWLyaHyAb
 9Hj8L1ULkKE1Kflj/2dJ2QbH+VOks0aSzJzVn2nFnEz/B7QNqqr4aUqGxLau0BIFsDr1WM
 LPiHv51jLEWrCPkd2TlS3qST99e8zYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-YP884jmwNqGPDizIxk_-wA-1; Mon, 06 Jul 2020 12:42:29 -0400
X-MC-Unique: YP884jmwNqGPDizIxk_-wA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EEE4107ACF2;
 Mon,  6 Jul 2020 16:42:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19FC87B40D;
 Mon,  6 Jul 2020 16:42:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/53] pc: fix leak in pc_system_flash_cleanup_unused
Date: Mon,  6 Jul 2020 12:41:42 -0400
Message-Id: <20200706164155.24696-41-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

tries to fix a leak detected when building with --enable-sanitizers:
./i386-softmmu/qemu-system-i386
Upon exit:
==13576==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 1216 byte(s) in 1 object(s) allocated from:
    #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
    #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
    #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
    #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
    #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
    #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
    #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
    #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
    #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
    #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
    #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
    #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
    #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200701145231.19531-1-alxndr@bu.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_sysfw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ec2a3b3e7e..71ce273a14 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -93,6 +93,11 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(pcms), alias_prop_name,
                               OBJECT(dev), "drive");
+    /*
+     * The returned reference is tied to the child property and
+     * will be removed with object_unparent.
+     */
+    object_unref(OBJECT(dev));
     return PFLASH_CFI01(dev);
 }
 
-- 
2.26.2



