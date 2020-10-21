Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B691424182
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba4oPfaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B691424182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLCA-00075S-MT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAq-0005Su-1v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAh-0006eq-Jq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsRFiIN1PeYLuXwm9621UgCML5X3cOzx9xwX2BS2mAE=;
 b=Ba4oPfaWilcaqkokQtV7Uc1E84jUeHLxY1LXEfys167oMgSo/VpLEzIVjSMsa8oSz7NM5j
 x0UYqSNFJr2oLpZ/0b0YobaEKxzdTxbsY/W6zH+uaP1M6KMLy9wZvOR+Chjt9CleuKbxbc
 esGLRCzdMDgX/shAmINiAaYWEqPFvrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-BHO0pe9vOmuQh3IbwJ3g7Q-1; Wed, 21 Oct 2020 16:57:20 -0400
X-MC-Unique: BHO0pe9vOmuQh3IbwJ3g7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF757835B92
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 729E96EF62;
 Wed, 21 Oct 2020 20:57:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/22] machine: move UP defaults to class_base_init
Date: Wed, 21 Oct 2020 16:56:57 -0400
Message-Id: <20201021205716.2359430-4-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean up vl.c, default min/max/default_cpus to uniprocessor
directly in the QOM class initialization code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c | 6 +++++-
 softmmu/vl.c      | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 80a918895a..d3a8450b1f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -854,8 +854,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+    mc->max_cpus = mc->max_cpus ?: 1;
+    mc->min_cpus = mc->min_cpus ?: 1;
+    mc->default_cpus = mc->default_cpus ?: 1;
+
     if (!object_class_is_abstract(oc)) {
-        MachineClass *mc = MACHINE_CLASS(oc);
         const char *cname = object_class_get_name(oc);
         assert(g_str_has_suffix(cname, TYPE_MACHINE_SUFFIX));
         mc->name = g_strndup(cname,
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 42314e6ff9..75bc686397 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3966,11 +3966,6 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(0);
     }
 
-    /* machine_class: default to UP */
-    machine_class->max_cpus = machine_class->max_cpus ?: 1;
-    machine_class->min_cpus = machine_class->min_cpus ?: 1;
-    machine_class->default_cpus = machine_class->default_cpus ?: 1;
-
     /* default to machine_class->default_cpus */
     current_machine->smp.cpus = machine_class->default_cpus;
     current_machine->smp.max_cpus = machine_class->default_cpus;
-- 
2.26.2



