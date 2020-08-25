Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D6CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E252072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1NIA2/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E252072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAedf-00067i-Ig
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeW8-0007oc-0L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeW6-00068R-CL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVDwgTNUVgjR0WmL6SFjNJciv9Z9mAsyt/tnnTvdlhA=;
 b=d1NIA2/ZGRaSuxcjE3y2Y2Ly8xdcgJy6r6V9K9vsAHRy5gqnP3IEriY29uL9VSV7NGFKFm
 mAxUEQVjJHl6ihkUOtbbWCe/HQS8YJfKfM5YL0+Hmge9JC1dg8LaqsU9N0lYqh9drz7O1u
 KZ/n0XtiqRYTyqtzWzA2xqoP49f1RkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-5V5sXzkrMGaue6HfDEZYEg-1; Tue, 25 Aug 2020 15:21:55 -0400
X-MC-Unique: 5V5sXzkrMGaue6HfDEZYEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75754800467;
 Tue, 25 Aug 2020 19:21:54 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3738F18B59;
 Tue, 25 Aug 2020 19:21:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/74] hvf: Move HVFState typedef to hvf.h
Date: Tue, 25 Aug 2020 15:20:15 -0400
Message-Id: <20200825192110.3528606-20-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move typedef closer to the type check macros, to make it easier
to convert the code to OBJECT_DEFINE_TYPE() in the future.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: Cameron Esfahani <dirty@apple.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/sysemu/hvf.h       | 1 +
 target/i386/hvf/hvf-i386.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d3bed80ea8..760d6c79a2 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -35,6 +35,7 @@ void hvf_vcpu_destroy(CPUState *);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
+typedef struct HVFState HVFState;
 #define HVF_STATE(obj) \
     OBJECT_CHECK(HVFState, (obj), TYPE_HVF_ACCEL)
 
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index ef20c73eca..e0edffd077 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -57,13 +57,13 @@ typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_preemption_timer;
 } hvf_vcpu_caps;
 
-typedef struct HVFState {
+struct HVFState {
     AccelState parent;
     hvf_slot slots[32];
     int num_slots;
 
     hvf_vcpu_caps *hvf_caps;
-} HVFState;
+};
 extern HVFState *hvf_state;
 
 void hvf_set_phys_mem(MemoryRegionSection *, bool);
-- 
2.26.2


