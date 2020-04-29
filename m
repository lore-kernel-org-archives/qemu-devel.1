Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0776AC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F582076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0TN+dpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F582076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh5P-0004wR-UT
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1y-0007tq-CB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003y3-H5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1g-0003ub-KB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nz3jWVyp59t6okYH7nE69b5YZrpl0FIWVQOMM5Ns0Y=;
 b=i0TN+dpMM/R56BcRyzjXD9XZI1r6NrxPvfV04yLzfLxNynYiLopF3/ibsBYYWirz/CFyMF
 evsoCVwFG/QRRSJ4sTka7J/fRebx9aWwKzu+LsmD1YuxDgyx0EYwTVjmoRGGAKgnXMUFxP
 M11sMT6dtTK6zBb/IHBJsNxicVBuBLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-0V47d_TFMaCGA4yZTIVm4A-1; Wed, 29 Apr 2020 03:20:54 -0400
X-MC-Unique: 0V47d_TFMaCGA4yZTIVm4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C324EBFC4;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D65D5C221;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B20E11358D5; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] qga: Fix qmp_guest_suspend_{disk, ram}() error handling
Date: Wed, 29 Apr 2020 09:20:40 +0200
Message-Id: <20200429072048.29963-25-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second

qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
first to check_suspend_mode(), then to acquire_privilege(), then to
execute_async().  Continuing after errors here can only end in tears.
For instance, we risk tripping error_setv()'s assertion.

Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
Fixes: f54603b6aa765514b2519e74114a2f417759d727
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200422130719.28225-15-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-win32.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 9717a8d52d..5ba56327dd 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1322,9 +1322,16 @@ void qmp_guest_suspend_disk(Error **errp)
=20
     *mode =3D GUEST_SUSPEND_MODE_DISK;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
=20
+out:
     if (local_err) {
         error_propagate(errp, local_err);
         g_free(mode);
@@ -1338,9 +1345,16 @@ void qmp_guest_suspend_ram(Error **errp)
=20
     *mode =3D GUEST_SUSPEND_MODE_RAM;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
=20
+out:
     if (local_err) {
         error_propagate(errp, local_err);
         g_free(mode);
--=20
2.21.1


