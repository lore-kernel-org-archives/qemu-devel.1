Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA30C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7E72173E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqoMIc+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7E72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUbDX-00056p-66
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb8B-0006lj-6K
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUb8A-0000B1-A5
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb89-0000AD-QS
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588360525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iz1+575CZTAwF4/10qO3yMqVxn8dKAPijQXPhGnAxMs=;
 b=XqoMIc+/WKj3+zVAAb9zW+mIMSmmoJggWwv9mnhevf8zrgR9/WOtUTZEEVmCaaJrKUIuni
 rIsMzSv9kwK0sdNaWPZOR20LnXrzqKjDHNtlqV/o7A1AtXfkYs5JGZzgI/zWtYWVknq9cq
 HPT75SF1czNvC3akaK2sts0FrntFGQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-n_IFVKRNOfCm3Dk7rru0TQ-1; Fri, 01 May 2020 15:15:20 -0400
X-MC-Unique: n_IFVKRNOfCm3Dk7rru0TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86576107ACF3;
 Fri,  1 May 2020 19:15:19 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-191.ams2.redhat.com
 [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 545B710013BD;
 Fri,  1 May 2020 19:15:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, yavrahami@paloaltonetworks.com,
 mszeredi@redhat.com, mreitz@redhat.com
Subject: [PULL 5/6] virtiofsd: only retain file system capabilities
Date: Fri,  1 May 2020 20:14:59 +0100
Message-Id: <20200501191500.126432-6-dgilbert@redhat.com>
In-Reply-To: <20200501191500.126432-1-dgilbert@redhat.com>
References: <20200501191500.126432-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 14:29:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

virtiofsd runs as root but only needs a subset of root's Linux
capabilities(7).  As a file server its purpose is to create and access
files on behalf of a client.  It needs to be able to access files with
arbitrary uid/gid owners.  It also needs to be create device nodes.

Introduce a Linux capabilities(7) whitelist and drop all capabilities
that we don't need, making the virtiofsd process less powerful than a
regular uid root process.

  # cat /proc/PID/status
  ...
          Before           After
  CapInh: 0000000000000000 0000000000000000
  CapPrm: 0000003fffffffff 00000000880000df
  CapEff: 0000003fffffffff 00000000880000df
  CapBnd: 0000003fffffffff 0000000000000000
  CapAmb: 0000000000000000 0000000000000000

Note that file capabilities cannot be used to achieve the same effect on
the virtiofsd executable because mount is used during sandbox setup.
Therefore we drop capabilities programmatically at the right point
during startup.

This patch only affects the sandboxed child process.  The parent process
that sits in waitpid(2) still has full root capabilities and will be
addressed in the next patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200416164907.244868-2-stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 7873692168..e49650b63d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2718,6 +2718,43 @@ static void setup_mounts(const char *source)
     close(oldroot);
 }
=20
+/*
+ * Only keep whitelisted capabilities that are needed for file system oper=
ation
+ */
+static void setup_capabilities(void)
+{
+    pthread_mutex_lock(&cap.mutex);
+    capng_restore_state(&cap.saved);
+
+    /*
+     * Whitelist file system-related capabilities that are needed for a fi=
le
+     * server to act like root.  Drop everything else like networking and
+     * sysadmin capabilities.
+     *
+     * Exclusions:
+     * 1. CAP_LINUX_IMMUTABLE is not included because it's only used via i=
octl
+     *    and we don't support that.
+     * 2. CAP_MAC_OVERRIDE is not included because it only seems to be
+     *    used by the Smack LSM.  Omit it until there is demand for it.
+     */
+    capng_setpid(syscall(SYS_gettid));
+    capng_clear(CAPNG_SELECT_BOTH);
+    capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE,
+            CAP_CHOWN,
+            CAP_DAC_OVERRIDE,
+            CAP_DAC_READ_SEARCH,
+            CAP_FOWNER,
+            CAP_FSETID,
+            CAP_SETGID,
+            CAP_SETUID,
+            CAP_MKNOD,
+            CAP_SETFCAP);
+    capng_apply(CAPNG_SELECT_BOTH);
+
+    cap.saved =3D capng_save_state();
+    pthread_mutex_unlock(&cap.mutex);
+}
+
 /*
  * Lock down this process to prevent access to other processes or files ou=
tside
  * source directory.  This reduces the impact of arbitrary code execution =
bugs.
@@ -2728,6 +2765,7 @@ static void setup_sandbox(struct lo_data *lo, struct =
fuse_session *se,
     setup_namespaces(lo, se);
     setup_mounts(lo->source);
     setup_seccomp(enable_syslog);
+    setup_capabilities();
 }
=20
 /* Set the maximum number of open file descriptors */
--=20
2.26.2


