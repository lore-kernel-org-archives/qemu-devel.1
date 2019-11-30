Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E2C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972D62073C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll7KZcHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972D62073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8m0-0007vZ-ET
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 14:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dw-0006YD-Pa
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8du-0005Co-Lu
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8dt-00056y-Sz
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+WDpTr2l+S+ufHYzRrbqlPbh/3TDGw8iJU+PKCkrjo=;
 b=Ll7KZcHRfqNxPZNHs8Y5cb4izbiCW9BTQDGUFXLa3nz9m9VlmySK1UEgCsNANq9SAoM3Hz
 wKLgy//IDVv/qRbZghojZWJMMABC8wGRECEIbLHXu8lpWVJootKoDf0TX6L4YhFPbgwlHY
 GQBefCOwfGqRdpltQIJ5iM4k3wpSkEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-xQaGg6W7MmW7h5WDQbly0Q-1; Sat, 30 Nov 2019 14:42:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F84B80183C;
 Sat, 30 Nov 2019 19:42:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3A6F5D6D8;
 Sat, 30 Nov 2019 19:42:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D12111366F3; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/21] qga: Fix latent guest-get-fsinfo error handling bug
Date: Sat, 30 Nov 2019 20:42:31 +0100
Message-Id: <20191130194240.10517-13-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xQaGg6W7MmW7h5WDQbly0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: vsementsov@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

build_guest_fsinfo_for_virtual_device() crashes when
build_guest_fsinfo_for_device() fails and its @errp argument is null.
Messed up in commit 46d4c5723e "qga: Add guest-get-fsinfo command".

The bug can't bite as no caller actually passes null.  Fix it anyway.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1c1a165dae..0be527ccb8 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1049,6 +1049,7 @@ static void build_guest_fsinfo_for_virtual_device(cha=
r const *syspath,
                                                   GuestFilesystemInfo *fs,
                                                   Error **errp)
 {
+    Error *err =3D NULL;
     DIR *dir;
     char *dirpath;
     struct dirent *entry;
@@ -1078,10 +1079,11 @@ static void build_guest_fsinfo_for_virtual_device(c=
har const *syspath,
=20
             g_debug(" slave device '%s'", entry->d_name);
             path =3D g_strdup_printf("%s/slaves/%s", syspath, entry->d_nam=
e);
-            build_guest_fsinfo_for_device(path, fs, errp);
+            build_guest_fsinfo_for_device(path, fs, &err);
             g_free(path);
=20
-            if (*errp) {
+            if (err) {
+                error_propagate(errp, err);
                 break;
             }
         }
--=20
2.21.0


