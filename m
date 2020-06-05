Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE402074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+hx2Bak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE402074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhERC-0005yc-Oh
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQ6-0004On-Mr
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQ6-00020i-2V
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvpYvOw30YBys2pb8Z8TWIbBcpqQ5AtONZyw5Is+WsU=;
 b=Y+hx2Bak00n/ue6AY8w8VKqrQaUOIEyfe6acZgOjK8ato3xuxr8e7skhO+Z/S4xYUZorOF
 u4y5NvIjtVPd+hrhEfLWEUgnp4Ksqm/hnOCm15ZGK3mXudlXouXEJO1vRE1olWNoJF703f
 Uww8rLTq/fTwBzrBhWgH7XMjF7ig1Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-w5U96YEcO_OTLNbXCFUKuA-1; Fri, 05 Jun 2020 11:38:05 -0400
X-MC-Unique: w5U96YEcO_OTLNbXCFUKuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E49219200C0;
 Fri,  5 Jun 2020 15:38:04 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F2029CA0;
 Fri,  5 Jun 2020 15:38:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/10] s390x/kvm: help valgrind in several places
Date: Fri,  5 Jun 2020 17:37:47 +0200
Message-Id: <20200605153756.392825-2-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
References: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We need some little help in the code to reduce the valgrind noise.
This patch does this with some designated initializers for the cpu
model features and subfunctions.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200429074201.100924-1-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 69881a0da0b3..f2f75d2a57e8 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2165,7 +2165,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 
 static int query_cpu_subfunc(S390FeatBitmap features)
 {
-    struct kvm_s390_vm_cpu_subfunc prop;
+    struct kvm_s390_vm_cpu_subfunc prop = {};
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_CPU_MODEL,
         .attr = KVM_S390_VM_CPU_MACHINE_SUBFUNC,
@@ -2292,7 +2292,7 @@ static int kvm_to_feat[][2] = {
 
 static int query_cpu_feat(S390FeatBitmap features)
 {
-    struct kvm_s390_vm_cpu_feat prop;
+    struct kvm_s390_vm_cpu_feat prop = {};
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_CPU_MODEL,
         .attr = KVM_S390_VM_CPU_MACHINE_FEAT,
-- 
2.25.4


