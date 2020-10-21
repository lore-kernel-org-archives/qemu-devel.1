Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58016C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F8E20870
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8GLzaNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLFW-0002PC-JE
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAt-0005TV-Hd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAm-0006ew-NS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDqH/sBJn/80Lhr0h8LxhXgjheMXH4gfSukABjUgxwA=;
 b=C8GLzaNJ4gIPoXbeG42RiSYIduq39gj6mjvEDzcFR1PMTbWu1rNf10Eo5x52tGN7Zf3N3R
 rSqzFeehyYSRVS8Q5BUK19k5KVSRwrO6IcQbEcL1kKSygWF7rjWdKq18XECX9CxpDbwuEi
 WYuK6jPG5SMiSMf54ueubjNnjDfVGms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-ltO41byjPdKAzKWcsGoTAQ-1; Wed, 21 Oct 2020 16:57:21 -0400
X-MC-Unique: ltO41byjPdKAzKWcsGoTAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71256186843A
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04ED16EF6B;
 Wed, 21 Oct 2020 20:57:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/22] machine: move SMP initialization from vl.c
Date: Wed, 21 Oct 2020 16:56:58 -0400
Message-Id: <20201021205716.2359430-5-pbonzini@redhat.com>
In-Reply-To: <20201021205716.2359430-1-pbonzini@redhat.com>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initialize the object's values from the class when the object is
created, no need to have vl.c do it for us.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c | 7 +++++++
 softmmu/vl.c      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d3a8450b1f..7efeac03b3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -908,6 +908,13 @@ static void machine_initfn(Object *obj)
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify = machine_init_notify;
     qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
+
+    /* default to mc->default_cpus */
+    ms->smp.cpus = mc->default_cpus;
+    ms->smp.max_cpus = mc->default_cpus;
+    ms->smp.cores = 1;
+    ms->smp.threads = 1;
+    ms->smp.sockets = 1;
 }
 
 static void machine_finalize(Object *obj)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 75bc686397..05422a15ee 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3966,13 +3966,6 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(0);
     }
 
-    /* default to machine_class->default_cpus */
-    current_machine->smp.cpus = machine_class->default_cpus;
-    current_machine->smp.max_cpus = machine_class->default_cpus;
-    current_machine->smp.cores = 1;
-    current_machine->smp.threads = 1;
-    current_machine->smp.sockets = 1;
-
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
-- 
2.26.2



