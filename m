Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341CC4346D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA5A2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlZTD6oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA5A2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8W6-00069M-U1
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TU-0001Bh-Qs
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TS-0004nR-V9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Niysg7WTlNSx02t7lJR8c0jLBz+5tSaBfOmOvj5U1Fw=;
 b=WlZTD6oYFJz2QbGQb/8vhvob7xvDOe0LngM7uZ7DpFPAU1YLu8zfn8xrzV55Zv7LFv8ZDL
 4dGgQt4UNFiWMZNl7uSkfNb6btxEbS/HUBlocwhg0ZCv7cnG27cUnmbcBpl/WlF1PZD2QB
 W2iCutuulDIDxKbCfpK0yP7yDGErpuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ADM0nizMP4eEEM8ZAdaD9Q-1; Thu, 16 Jul 2020 14:19:10 -0400
X-MC-Unique: ADM0nizMP4eEEM8ZAdaD9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892B08014D4;
 Thu, 16 Jul 2020 18:19:09 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5069560C47;
 Thu, 16 Jul 2020 18:19:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 4/6] target/i386: fix model number and add missing features for
 Icelake-Server CPU model
Date: Thu, 16 Jul 2020 14:19:01 -0400
Message-Id: <20200716181903.1895314-5-ehabkost@redhat.com>
In-Reply-To: <20200716181903.1895314-1-ehabkost@redhat.com>
References: <20200716181903.1895314-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 13:59:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chenyi Qiang <chenyi.qiang@intel.com>

Add the missing features(sha_ni, avx512ifma, rdpid, fsrm,
vmx-rdseed-exit, vmx-pml, vmx-eptp-switching) and change the model
number to 106 in the Icelake-Server-v4 CPU model.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Message-Id: <20200714084148.26690-3-chenyi.qiang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3885826bc4..132ef90421 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3512,6 +3512,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "sha-ni", "on" },
+                    { "avx512ifma", "on" },
+                    { "rdpid", "on" },
+                    { "fsrm", "on" },
+                    { "vmx-rdseed-exit", "on" },
+                    { "vmx-pml", "on" },
+                    { "vmx-eptp-switching", "on" },
+                    { "model", "106" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.26.2


