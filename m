Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D4C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0850420656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLoSBUlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0850420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOi8-00008q-5s
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOObE-00046J-5d
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOObC-0005Jk-3j
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOObC-0005JZ-0O
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qjC9lQbtBwmg2LpxhoDQdfh6GuV5VMYwNdNRgoGjKo=;
 b=FLoSBUlv74lYitADx8q6JKf0k7+SUSU00xAUoKrDXWfaTn1qLCqfLERh2ykIThg4LjLecG
 WXMItAJ5yQ7GX03+C1n8SaGfE5OMyA2nPUaUd83DT3eKbIQX0/XXclOAm9fargrdcT9t7O
 ewmRqxXuEAHqyQRgrF0bDLAiCTAh4Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-33l8aHg8Mg-1ZtMzdYOZ8w-1; Tue, 14 Apr 2020 12:39:43 -0400
X-MC-Unique: 33l8aHg8Mg-1ZtMzdYOZ8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6AF5801A26;
 Tue, 14 Apr 2020 16:39:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3082260BF1;
 Tue, 14 Apr 2020 16:39:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] hax: Windows doesn't like posix device names
Date: Tue, 14 Apr 2020 12:39:37 -0400
Message-Id: <20200414163937.29669-4-pbonzini@redhat.com>
In-Reply-To: <20200414163937.29669-1-pbonzini@redhat.com>
References: <20200414163937.29669-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Patch acb9f95a7c "i386: Fix GCC warning with snprintf when HAX
is enabled" replaced Windows device names with posix device
names. Revert this.

Fixes: acb9f95a7c "i386: Fix GCC warning with snprintf when HAX is enabled"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200322210211.29603-1-vr_qemu@t-online.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-windows.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 0ba488c468..863c2bcc19 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -185,12 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct hax=
_module_version *version)
=20
 static char *hax_vm_devfs_string(int vm_id)
 {
-    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
+    return g_strdup_printf("\\\\.\\hax_vm%02d", vm_id);
 }
=20
 static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
 {
-    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
+    return g_strdup_printf("\\\\.\\hax_vm%02d_vcpu%02d", vm_id, vcpu_id);
 }
=20
 int hax_host_create_vm(struct hax_state *hax, int *vmid)
--=20
2.18.2


