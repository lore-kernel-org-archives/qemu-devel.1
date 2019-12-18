Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30BEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00462176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPB+9eSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00462176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUdB-0006sK-Gr
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWV-0005zt-8b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWS-0002U3-GS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWR-0002Rg-GF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tG58nF4sXqRdxJ0EBOKqq4NTFPvei9v1v/+uaiuykRE=;
 b=fPB+9eSpCETSTtFV2347agYt6M1JOpXUSvkl6iLI07excl5q8KSsafO6BV/jgZi4cy7+t0
 KGHks93UA5Rsh61R+BpbwuoWMoJW6EX4RjzILGokd9RcUjDLOQTq5fDnMrs3n66xTtxZI8
 z6S79zyBqfBNQJMV4QKombD27TLVuj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ImDVafSKN_SosXfHp6xR7w-1; Wed, 18 Dec 2019 03:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12ADB1005512;
 Wed, 18 Dec 2019 08:17:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BCD67D909;
 Wed, 18 Dec 2019 08:17:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 773AB11384D2; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/35] qga: Fix guest-get-fsinfo error API violations
Date: Wed, 18 Dec 2019 09:16:56 +0100
Message-Id: <20191218081721.23520-11-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ImDVafSKN_SosXfHp6xR7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

build_guest_fsinfo_for_virtual_device() dereferences @errp when
build_guest_fsinfo_for_device() fails.  That's wrong; see the big
comment in error.h.  Introduced in commit 46d4c5723e "qga: Add
guest-get-fsinfo command".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191204093625.14836-10-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qga/commands-posix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0be301a4ea..10d818c3b2 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1060,6 +1060,7 @@ static void build_guest_fsinfo_for_virtual_device(cha=
r const *syspath,
                                                   GuestFilesystemInfo *fs,
                                                   Error **errp)
 {
+    Error *err =3D NULL;
     DIR *dir;
     char *dirpath;
     struct dirent *entry;
@@ -1089,10 +1090,11 @@ static void build_guest_fsinfo_for_virtual_device(c=
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


