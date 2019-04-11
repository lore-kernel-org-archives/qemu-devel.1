Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38593C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3C12077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEb7D-0005MC-78
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:55:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4b-0003Kv-1Z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEb4X-0000lo-2o
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:53:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEb4W-0000kx-OM; Thu, 11 Apr 2019 10:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0031A30B96F6;
	Thu, 11 Apr 2019 14:53:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C381018502;
	Thu, 11 Apr 2019 14:52:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DC08111329CF; Thu, 11 Apr 2019 16:52:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 16:52:50 +0200
Message-Id: <20190411145256.8614-10-armbru@redhat.com>
In-Reply-To: <20190411145256.8614-1-armbru@redhat.com>
References: <20190411145256.8614-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 11 Apr 2019 14:53:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/15] s390x/kvm: Report warnings with
 warn_report(), not error_printf()
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411145250.h8CXwp_M4-6OQOdwXjxm9HQpnV0Koz7OXSuekstBz0E@z>

kvm_s390_mem_op() can fail in two ways: when !cap_mem_op, it returns
-ENOSYS, and when kvm_vcpu_ioctl() fails, it returns -errno set by
ioctl().  Its caller s390_cpu_virt_mem_rw() recovers from both
failures.

kvm_s390_mem_op() prints "KVM_S390_MEM_OP failed" with error_printf()
in the latter failure mode.  Since this is obviously a warning, use
warn_report().

Perhaps the reporting should be left to the caller.  It could warn on
failure other than -ENOSYS.

Cc: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 19530fb94e..2c6e35b5aa 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -782,7 +782,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
     if (ret < 0) {
-        error_printf("KVM_S390_MEM_OP failed: %s\n", strerror(-ret));
+        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
     }
     return ret;
 }
-- 
2.17.2


