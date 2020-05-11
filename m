Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0835C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F755206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGgHS3Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F755206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9Gi-0001tF-PB
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jY99H-0000GM-2Y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:11:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jY99G-0003m9-8C
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589206273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=kX9jF7eoGAEHyIV6/c7y0ZOPuncIrUjOHAqyeUtGQzg=;
 b=GGgHS3Kt0AIK/5DbWPzORQ/YD4s6TCH4qu2Tg4A+T5/1nsVjVkddx4eFodJThfCssZgl6R
 G8M/SX8coZmgpaHEp3FplOZzJ5Rl6x9HsJZwoUGlFy3N8RBKLGhpQ5Jg3OsEMEHRXFKTWD
 Tn+xiOY9IaDzqcF2L+gWAkExufLo3AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-OZKtK-JhPj2O7Gc86mdgnA-1; Mon, 11 May 2020 10:11:09 -0400
X-MC-Unique: OZKtK-JhPj2O7Gc86mdgnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E68872FE2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 14:11:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D7FF5C1B2;
 Mon, 11 May 2020 14:11:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] numa: prevent usage of -M memory-backend and -numa memdev
 at the same time
Date: Mon, 11 May 2020 10:11:03 -0400
Message-Id: <20200511141103.43768-3-imammedo@redhat.com>
In-Reply-To: <20200511141103.43768-1-imammedo@redhat.com>
References: <20200511141103.43768-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Options -M memory-backend and -numa memdev are mutually exclusive,
and if used together, it might lead to a crash in the worst case.
For example when the same backend is used with these options together:
  -m 4G \
  -object memory-backend-ram,id=mem0,size=4G \
  -M pc,memory-backend=mem0 \
  -numa node,memdev=mem0
QEMU will abort with:
   exec.c:2006: qemu_ram_set_idstr: Assertion `!new_block->idstr[0]' failed.

and following backtrace:
    abort ()
    qemu_ram_set_idstr ()
    vmstate_register_ram ()
    vmstate_register_ram_global ()
    machine_consume_memdev ()
    numa_init_memdev_container ()
    numa_complete_configuration ()
    machine_run_board_init ()

add a check to error out in case the user tries to use both options at
the same time.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/numa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 316bc50d75..5f81900f88 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -757,6 +757,11 @@ void numa_complete_configuration(MachineState *ms)
         }
 
         if (!numa_uses_legacy_mem() && mc->default_ram_id) {
+            if (ms->ram_memdev_id) {
+                error_report("'-machine memory-backend' and '-numa memdev'"
+                             " properties are mutually exclusive");
+                exit(1);
+            }
             ms->ram = g_new(MemoryRegion, 1);
             memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
                                ram_size);
-- 
2.18.4


