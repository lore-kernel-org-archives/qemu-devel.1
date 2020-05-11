Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB8CC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BCE206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Js+DQA/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BCE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9E7-0006zX-DE
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jY99E-00009q-O0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:11:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jY99D-0003lq-EN
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589206270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=FoWugb4SMioNVak/flWWIJKpsLlUq04MPMmILVMZqsc=;
 b=Js+DQA/I+CbIq04L3VQZuuCgvmy3yy47diQxTmHBJJS19FFJe9OSOPNchQDfbL3MVgr0t6
 c1PaBPPzIeF+gUkeNLoipdxbvE9XXOMmTeEBwFSCuPONZjOX3xlansJTf5v0dq/y1U+DvV
 Fjlfgz2iCg0LSiuH++EyQ2eqPbGWhVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-UDTYxdfWOPCB8dqthnmr2w-1; Mon, 11 May 2020 10:11:08 -0400
X-MC-Unique: UDTYxdfWOPCB8dqthnmr2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B51D0872FE0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 14:11:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCB795C1B2;
 Mon, 11 May 2020 14:11:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vl.c: run preconfig loop before creating default RAM
 backend
Date: Mon, 11 May 2020 10:11:02 -0400
Message-Id: <20200511141103.43768-2-imammedo@redhat.com>
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

Default RAM backend depends on numa_uses_legacy_mem(), which is
infulenced by -numa options on CLI or set-numa-node QMP command
at preconfig time. If QEMU is started with  '-preconfig'
without -numa, it will lead to creating default RAM backend
even if later set-numa-node is used to assing RAM to NUMA nodes
using 'memdev' NUMA option.
That at best will waste RAM object created by default and with
next patch adding a check to prevent usage of conflicting
 '-M memory-backend' and '-numa memdev'
options, it will make QEMU error out if user tries to configure
NUMA at preconfig time with memdev option, making set-numa-node
unusable.

To fix issue, move preconfig loop before default RAM backend is
created, so that numa_uses_legacy_mem() would take into account
effects of set-numa-node commands executed at preconfig time.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 softmmu/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index afd2615fb3..8e806c9b25 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4333,12 +4333,13 @@ void qemu_init(int argc, char **argv, char **envp)
 
     parse_numa_opts(current_machine);
 
+    /* do monitor/qmp handling at preconfig state if requested */
+    qemu_main_loop();
+
     if (machine_class->default_ram_id && current_machine->ram_size &&
         numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
         create_default_memdev(current_machine, mem_path);
     }
-    /* do monitor/qmp handling at preconfig state if requested */
-    qemu_main_loop();
 
     audio_init_audiodevs();
 
-- 
2.18.4


