Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0288C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EE12086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EE12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggKP-0006Ah-PX
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50115)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8m-0000uM-PV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8l-0001gX-FD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg8j-0000qg-O3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55063308339A;
 Fri, 28 Jun 2019 01:57:05 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEFEF608A7;
 Fri, 28 Jun 2019 01:57:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:55:59 -0300
Message-Id: <20190628015606.32107-23-ehabkost@redhat.com>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
References: <20190628015606.32107-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 01:57:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 22/29] i386: Don't print warning if phys-bits
 was set automatically
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If cpu->host_phys_bits_limit is set, QEMU will make
cpu->phys_bits be lower than host_phys_bits on some cases.  This
triggers a warning that was supposed to be printed only if
phys-bits was explicitly set in the command-line.

Reorder the code so the value of cpu->phys_bits is validated
before the cpu->host_phys_bits handling.  This will avoid
unexpected warnings when cpu->host_phys_bits_limit is set.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190611205420.20286-1-ehabkost@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3a38fe3633..390f47adc5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5293,15 +5293,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             uint32_t host_phys_bits = x86_host_phys_bits();
             static bool warned;
 
-            if (cpu->host_phys_bits) {
-                /* The user asked for us to use the host physical bits */
-                cpu->phys_bits = host_phys_bits;
-                if (cpu->host_phys_bits_limit &&
-                    cpu->phys_bits > cpu->host_phys_bits_limit) {
-                    cpu->phys_bits = cpu->host_phys_bits_limit;
-                }
-            }
-
             /* Print a warning if the user set it to a value that's not the
              * host value.
              */
@@ -5313,6 +5304,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                 warned = true;
             }
 
+            if (cpu->host_phys_bits) {
+                /* The user asked for us to use the host physical bits */
+                cpu->phys_bits = host_phys_bits;
+                if (cpu->host_phys_bits_limit &&
+                    cpu->phys_bits > cpu->host_phys_bits_limit) {
+                    cpu->phys_bits = cpu->host_phys_bits_limit;
+                }
+            }
+
             if (cpu->phys_bits &&
                 (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
                 cpu->phys_bits < 32)) {
-- 
2.18.0.rc1.1.g3f1ff2140


