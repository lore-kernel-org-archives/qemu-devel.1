Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CE72074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIiiOetI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CE72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAetr-00018J-8D
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXO-0002fc-S4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeXN-0006M1-6g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ly8MIP4Epa+Vz1TRhAwsQ91dLJJc9+zxXEsL+EX6qR8=;
 b=gIiiOetIt/I55S/UHGD2zkc1RUMdS5tYb7uRbJGzWQZkGUafe/2wgliLvuMQ49yLR6UczJ
 Kca+PVcPIKxsYAUaYgZQel564g3O/TEF29HA3aNuEmFO3PsZCeoOvSLwx8sCfQ2VKGY96H
 +66TkrZKMiSrVCP2iYj0cIafb4sA0p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-kjuLYSiKP_mEwOOKWvWjnA-1; Tue, 25 Aug 2020 15:23:11 -0400
X-MC-Unique: kjuLYSiKP_mEwOOKWvWjnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5A681074642;
 Tue, 25 Aug 2020 19:23:09 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C31977D42;
 Tue, 25 Aug 2020 19:23:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 53/74] rx: Move typedef RXCPU to cpu-qom.h
Date: Tue, 25 Aug 2020 15:20:49 -0400
Message-Id: <20200825192110.3528606-54-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the typedef closer to the QOM type checking macros.
This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v2 -> v3: new patch added to series v3

---
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-devel@nongnu.org
---
 target/rx/cpu-qom.h | 1 +
 target/rx/cpu.h     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index af937bc680..9054762326 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -25,6 +25,7 @@
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
 
+typedef struct RXCPU RXCPU;
 #define RX_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
 #define RX_CPU(obj) \
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index d1fb1ef3ca..0b4b998c7b 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -115,7 +115,6 @@ struct RXCPU {
     CPURXState env;
 };
 
-typedef struct RXCPU RXCPU;
 typedef RXCPU ArchCPU;
 
 #define ENV_OFFSET offsetof(RXCPU, env)
-- 
2.26.2


