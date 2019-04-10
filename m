Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D7C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100C420874
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100C420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1li-0004US-7u
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:11:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sZ-0003PI-2J
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sX-0003c1-W1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghook@redhat.com>) id 1hE0sW-0003Rn-Ei
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D02F83003B44;
	Wed, 10 Apr 2019 00:08:09 +0000 (UTC)
Received: from rhel74-ghook-amd.khw1.lab.eng.bos.redhat.com
	(rhel74-ghook-amd.khw1.lab.eng.bos.redhat.com [10.16.200.139])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3C41716C;
	Wed, 10 Apr 2019 00:08:09 +0000 (UTC)
From: Gary R Hook <ghook@redhat.com>
To: rhvirt-patches@redhat.com
Date: Tue,  9 Apr 2019 20:08:03 -0400
Message-Id: <20190410000803.1744-3-ghook@redhat.com>
In-Reply-To: <20190410000803.1744-1-ghook@redhat.com>
References: <20190410000803.1744-1-ghook@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 10 Apr 2019 00:08:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Tue, 09 Apr 2019 21:10:01 -0400
Subject: [Qemu-devel] [RHEL-8.1 virt 2/2] target/i386: sev: Do not pin the
 ram device memory region
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	ghook@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410000803.kXxkMIVMHDYOVa0TqVEQcxaaMJujrVLZGMHm7vtCOZc@z>

BZ: 1667249
Branch: rhel-8.1.0
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
Upstream Status: 4.0.0-rc1
Build Info: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=20980582
Conflicts: None

commit cedc0ad539afbbb669dba9e73dfad2915bc1c25b
Author: Singh, Brijesh <brijesh.singh@amd.com>
Date:   Mon Feb 4 22:23:40 2019 +0000

    target/i386: sev: Do not pin the ram device memory region

    The RAM device presents a memory region that should be handled
    as an IO region and should not be pinned.

    In the case of the vfio-pci, RAM device represents a MMIO BAR
    and the memory region is not backed by pages hence
    KVM_MEMORY_ENCRYPT_REG_REGION fails to lock the memory range.

    Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
    Cc: Alex Williamson <alex.williamson@redhat.com>
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
    Message-Id: <20190204222322.26766-3-brijesh.singh@amd.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Richard Henderson <rth@twiddle.net> 
Cc: Eduardo Habkost <ehabkost@redhat.com> 
Cc: qemu-devel@nongnu.org 
---
 target/i386/sev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2395171acf..b8009b001a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -130,6 +130,17 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
     struct kvm_enc_region range;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+
+    /*
+     * The RAM device presents a memory region that should be treated
+     * as IO region and should not be pinned.
+     */
+    mr = memory_region_from_host(host, &offset);
+    if (mr && memory_region_is_ram_device(mr)) {
+	return;
+    }
 
     range.addr = (__u64)(unsigned long)host;
     range.size = size;
-- 
2.18.1


