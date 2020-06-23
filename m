Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9634C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBF720738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWh5ZUPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBF720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngZf-0003Ra-TV
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWN-0005br-3M
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jngWK-0007Ud-3S
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592909475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfdDklJm7xq7V0EjioTwWRWt93bUpNOFzkHuwwNGVEE=;
 b=aWh5ZUPhBIrjuIxtTF/NgJ5Wqh9A1fQY/sveJ+HZmXOHoSGNCRo9ucgrNRqLeJoWqJ+KNw
 e3IasCG/vfwHY1QljaPhyqaCwqnLNZopFkdGPqsZdN3HqJvZRJ96cOpG0EGPBx4iVL+EZo
 3CBZCBcI818uJEC6j66RHt4dmLGm4e0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-TMY6qV4HPt2J2YZPb-z0cQ-1; Tue, 23 Jun 2020 06:51:13 -0400
X-MC-Unique: TMY6qV4HPt2J2YZPb-z0cQ-1
Received: by mail-wr1-f69.google.com with SMTP id y16so11064750wrr.20
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HfdDklJm7xq7V0EjioTwWRWt93bUpNOFzkHuwwNGVEE=;
 b=ivnoVah6zu+bjJm7ms5zvOItxCJS7/SQoVYE54gS2K1vlonLGwIYHnkJIRLmfY5WxY
 xln8Itk8/xIY9SLztM+yqqtUU19jeigJkbRLgkijL7IuHHerLNX793oxlweXttLsZCJN
 jwqkh6rNelkTGFRFOS/72dMM6Oo0pSdt+73fhOWAiM7eHC00oSpOt4wu/tx24HZQbMpv
 2hHaarIBLsE0ZdOoEZ84NUc4i9yigpg3jtk4uWHU9+zytKbGxL0VGhTdjo2UMQ+/cl/9
 L1OsbSzn55/wkcsWoTd+dUMO5cpE9oFZAdYs9+92BNHiVRm/wsw4mSLrKPGYlb2XKE0k
 C2ZA==
X-Gm-Message-State: AOAM530dWpPfYEy6ulSBZtk9iJCsZGRjx4YymVMi2KQJ1i+xKQxFvpQN
 bHG60ui0gZBVf0vHQrlhG+nBZzVo7OTxEnriE3a48NC3cfvzWKoxBgSe4dqG6KieoLnQHm5M8VT
 Y7o4CHmW/BRGePQw=
X-Received: by 2002:adf:f889:: with SMTP id u9mr26631722wrp.149.1592909472563; 
 Tue, 23 Jun 2020 03:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9WRvI2kbpsPLHP97oIP7w6Av+O3l+a0GhoMq90nNnJIF5O7szSibw72P2QsuBd0UT4wQtdA==
X-Received: by 2002:adf:f889:: with SMTP id u9mr26631685wrp.149.1592909472348; 
 Tue, 23 Jun 2020 03:51:12 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p13sm11583726wrn.0.2020.06.23.03.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] accel/kvm: Simplify kvm_check_extension_list()
Date: Tue, 23 Jun 2020 12:50:48 +0200
Message-Id: <20200623105052.1700-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
References: <20200623105052.1700-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVMState* argument is now unused, drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/kvm/kvm-all.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b6b39b0e92..afd14492a0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1088,7 +1088,7 @@ static int kvm_check_many_ioeventfds(void)
 }
 
 static const KVMCapabilityInfo *
-kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
+kvm_check_extension_list(const KVMCapabilityInfo *list)
 {
     while (list->name) {
         if (!kvm_check_extension(list->value)) {
@@ -2104,10 +2104,10 @@ static int kvm_init(MachineState *ms)
         nc++;
     }
 
-    missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
+    missing_cap = kvm_check_extension_list(kvm_required_capabilites);
     if (!missing_cap) {
         missing_cap =
-            kvm_check_extension_list(s, kvm_arch_required_capabilities);
+            kvm_check_extension_list(kvm_arch_required_capabilities);
     }
     if (missing_cap) {
         ret = -EINVAL;
-- 
2.21.3


