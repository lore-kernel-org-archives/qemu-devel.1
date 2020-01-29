Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B283C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694742070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPTvE+9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694742070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlyo-0006DW-GX
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlxz-0004nF-3s
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlxy-00061f-6X
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:57:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlxy-000614-2n
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580299025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbBVwTwxgB7nPVUXFlKEK3auQkBLFXi2IJU563asPOQ=;
 b=cPTvE+9eNo+knsIW8zJ/kcFwIsZePVWPx9Anm1yEIbWbPr7gE0c20fQqAwjZuFkZz2BRY2
 Fq73rTe+vCqYuYn7KCJq5nm6FCfwGp+J2sg5CWOgDnydrKKbjSSVMpEzhG8wIWmLZKGxVt
 91DvT90kZY5nNPLy6SCPLiUTlvuKUe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-BFbyGoMhNeW4Ey45IR3Ikw-1; Wed, 29 Jan 2020 06:57:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A46E2189F770
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:57:03 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69F5919E9C;
 Wed, 29 Jan 2020 11:57:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/8] migration: Add support for modules
Date: Wed, 29 Jan 2020 12:56:49 +0100
Message-Id: <20200129115655.10414-3-quintela@redhat.com>
In-Reply-To: <20200129115655.10414-1-quintela@redhat.com>
References: <20200129115655.10414-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BFbyGoMhNeW4Ey45IR3Ikw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So we don't have to compile everything in, or have ifdefs

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/qemu/module.h | 2 ++
 vl.c                  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 65ba596e46..907cb5c0a5 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -40,6 +40,7 @@ static void __attribute__((constructor)) do_qemu_init_ ##=
 function(void)    \
 #endif
=20
 typedef enum {
+    MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
     MODULE_INIT_QOM,
@@ -56,6 +57,7 @@ typedef enum {
 #define xen_backend_init(function) module_init(function, \
                                                MODULE_INIT_XEN_BACKEND)
 #define libqos_init(function) module_init(function, MODULE_INIT_LIBQOS)
+#define migration_init(function) module_init(function, MODULE_INIT_MIGRATI=
ON)
=20
 #define block_module_load_one(lib) module_load_one("block-", lib)
 #define ui_module_load_one(lib) module_load_one("ui-", lib)
diff --git a/vl.c b/vl.c
index b0f52c4d6e..9f8577955a 100644
--- a/vl.c
+++ b/vl.c
@@ -2890,6 +2890,7 @@ int main(int argc, char **argv, char **envp)
     qemu_init_exec_dir(argv[0]);
=20
     module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_MIGRATION);
=20
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
--=20
2.24.1


