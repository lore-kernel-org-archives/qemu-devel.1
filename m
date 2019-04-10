Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0721DC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EEC20820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EEC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHaF-000358-55
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:04:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEHZS-0002o7-HO
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEHZR-0001fE-MT
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:03:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hEHZR-0001ep-ER
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE42781E19
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 18:03:36 +0000 (UTC)
Received: from worklaptop.redhat.com (ovpn-123-233.rdu2.redhat.com
	[10.10.123.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFFFA5C3FD;
	Wed, 10 Apr 2019 18:03:35 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Apr 2019 14:03:31 -0400
Message-Id:
 <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 10 Apr 2019 18:03:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hmp: delvm: use hmp_handle_error
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dgilbert@redhat.com, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410180331.aFsZ69aDUcrHT180Jiq9RyG2gLpAlTnsneBYws0c-k4@z>

This gives us the consistent 'Error:' prefix added in 66363e9a43f,
which helps users like libvirt who still need to scrape hmp error
messages to detect failure.

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 hmp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8eec768088..74a4bfc1f9 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
     const char *name =3D qdict_get_str(qdict, "name");
=20
     if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
-        error_reportf_err(err,
-                          "Error while deleting snapshot on device '%s':=
 ",
-                          bdrv_get_device_name(bs));
+        error_prepend(&err,
+                      "Error while deleting snapshot on device '%s': ",
+                      bdrv_get_device_name(bs));
     }
+    hmp_handle_error(mon, &err);
 }
=20
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
--=20
2.21.0


