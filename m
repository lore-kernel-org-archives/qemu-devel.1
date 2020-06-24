Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299932088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ7iu2MP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299932088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0vk-00038u-BX
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0um-0000nv-Ok
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ug-00025J-Da
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZGpqjNhU3VLrZIjNN+wDj8VUXVmtMcVJTCwh6ZL+O0=;
 b=QZ7iu2MPkCuhsogzoaQNYYS32jXYHIukRAiBZw/Y4TKcYBzexXvcKy1O3NBYU8hw/wKnB3
 cE3Uz9oGLtFjwL8UWD9ppA6DxhNwgcFL4GIE+lwVUNtN1laaZOIOl8LlzOO/Ypu/sdAKsQ
 rZAcJ8uH4yxpelg43NIjkAvdcvo9tyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-mvuRLvRBM6--BA6Bu4nHuA-1; Wed, 24 Jun 2020 04:37:44 -0400
X-MC-Unique: mvuRLvRBM6--BA6Bu4nHuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 402A61005512;
 Wed, 24 Jun 2020 08:37:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 059EF78FDB;
 Wed, 24 Jun 2020 08:37:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C347D1138482; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/25] x86: Fix x86_cpu_new() error API violations
Date: Wed, 24 Jun 2020 10:37:32 +0200
Message-Id: <20200624083737.3086768-21-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

x86_cpu_new() is wrong that way: it passes &local_err to
object_property_set_uint() without checking it, and then to
qdev_realize().  Harmless, because the former can't actually fail
here.

Fix by checking for failure right away.  While there, replace
qdev_realize(); object_unref() by qdev_realize_and_unref().

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/x86.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 34229b45c7..3a7029e6db 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -118,16 +118,10 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
 void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
-    Object *cpu = NULL;
-    Error *local_err = NULL;
+    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    cpu = object_new(MACHINE(x86ms)->cpu_type);
-
-    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
-    qdev_realize(DEVICE(cpu), NULL, &local_err);
-
-    object_unref(cpu);
-    error_propagate(errp, local_err);
+    object_property_set_uint(cpu, apic_id, "apic-id", &error_abort);
+    qdev_realize_and_unref(DEVICE(cpu), NULL, errp);
 }
 
 void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
-- 
2.26.2


