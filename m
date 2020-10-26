Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D8EC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE2824650
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIRJFlhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE2824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0cY-0001Js-FI
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kX0S9-0005jY-Kq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kX0S7-0006Vb-Mz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603710854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkaNoBHpfpCUJ07C9leAfPW/7tEtt+kjYoWZ34Mpk3E=;
 b=hIRJFlhM/W9RvrPp0U2UzPgiQ/Fi+KrKMsgK6Z7wMGcOJCL6Qr/ECpxXi7WWSqz0xLi4Uq
 WD5ZQsm94SBMVkNvDjsI/tv65ScyZfzMQlRZpan/0P4p8WW1d7v/6htBYloiGJoiTHA0VC
 j5RWk9bUyz8+hoZ26de9y3d0ZIDyLGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-6DaqxEe3OlGRQhex82mhdA-1; Mon, 26 Oct 2020 07:14:11 -0400
X-MC-Unique: 6DaqxEe3OlGRQhex82mhdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8A81018F7C;
 Mon, 26 Oct 2020 11:14:09 +0000 (UTC)
Received: from gondolin.redhat.com (ovpn-113-108.ams2.redhat.com
 [10.36.113.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB54B60BF3;
 Mon, 26 Oct 2020 11:14:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] s390x: pv: Fix diag318 PV fencing
Date: Mon, 26 Oct 2020 12:13:47 +0100
Message-Id: <20201026111347.252015-4-cohuck@redhat.com>
In-Reply-To: <20201026111347.252015-1-cohuck@redhat.com>
References: <20201026111347.252015-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Collin Walling <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Diag318 fencing needs to be determined on the current VM PV state and
not on the state that the VM has when we create the CPU model.

Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201022103135.126033-3-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c | 5 +++++
 target/s390x/cpu_features.h | 4 ++++
 target/s390x/cpu_models.c   | 4 ++++
 target/s390x/kvm.c          | 3 +--
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 31ea8df2460e..42fe0bf4ca7a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu_features.h"
+#include "hw/s390x/pv.h"
 
 #define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
     [S390_FEAT_##_FEAT] = {                        \
@@ -105,6 +106,10 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         }
         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
     }
+
+    if (type == S390_FEAT_TYPE_SCLP_FAC134 && s390_is_pv()) {
+        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
+    }
 }
 
 void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index ef52ffce83ec..87463f064d2a 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -81,6 +81,10 @@ const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
 
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
 
+static inline void clear_be_bit(unsigned int bit_nr, uint8_t *array)
+{
+    array[bit_nr / 8] &= ~(0x80 >> (bit_nr % 8));
+}
 static inline void set_be_bit(unsigned int bit_nr, uint8_t *array)
 {
     array[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ca484bfda7be..461e0b8f4a8d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #endif
 #include "qapi/qapi-commands-machine-target.h"
+#include "hw/s390x/pv.h"
 
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
     {                                                                    \
@@ -238,6 +239,9 @@ bool s390_has_feat(S390Feat feat)
         }
         return 0;
     }
+    if (feat == S390_FEAT_DIAG_318 && s390_is_pv()) {
+        return false;
+    }
     return test_bit(feat, cpu->model->features);
 }
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index f13eff688caf..baa070fdf7f9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2498,8 +2498,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
      */
     set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
 
-    /* DIAGNOSE 0x318 is not supported under protected virtualization */
-    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
+    if (kvm_check_extension(kvm_state, KVM_CAP_S390_DIAG318)) {
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
-- 
2.26.2


