Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A7DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6222242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT8o4rJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6222242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX372-0003Sf-Dr
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2up-0005mV-VS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2ud-0001lm-3R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IPxjIOUZn/1VGpToOU0+IAVfiE7t1Imy6ppH0DPjxg=;
 b=VT8o4rJJGPXzq7VObwU1l+yXJ1MWklKBmleBW8ZfQfQ4Qk6FIq21wTSwn9m00QFMYuZrNA
 1AbDHUY6v9abyhAXKz8rEIh8f4spSDICrbdcoG52advsVkSOzY6loL5c4ANriYjpn7HXFD
 XB8L8JZ3bjiCYBzLO6B4wQXzCitcD9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-LJ9sFaYYPxKVEP6_bbaBAw-1; Mon, 26 Oct 2020 09:51:39 -0400
X-MC-Unique: LJ9sFaYYPxKVEP6_bbaBAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE73FEC501
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91C331002C00;
 Mon, 26 Oct 2020 13:51:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] machine: move UP defaults to class_base_init
Date: Mon, 26 Oct 2020 09:51:30 -0400
Message-Id: <20201026135131.3006712-17-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clean up vl.c, default min/max/default_cpus to uniprocessor
directly in the QOM class initialization code.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c | 6 +++++-
 softmmu/vl.c      | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7a0b263cda..57463ad77a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -853,8 +853,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
 
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
index 09b033ff73..9b67ea300e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3970,11 +3970,6 @@ void qemu_init(int argc, char **argv, char **envp)
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



