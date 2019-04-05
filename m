Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38AEC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B4221855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B4221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCR7s-0004kB-0x
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:51:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6H-0003mD-E0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCR6F-0004DR-Al
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCR6A-000475-Sp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E8333078AC3;
	Fri,  5 Apr 2019 15:49:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-242.ams2.redhat.com
	[10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BD915D704;
	Fri,  5 Apr 2019 15:49:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, quintela@redhat.com,
	peterx@redhat.com
Date: Fri,  5 Apr 2019 16:49:34 +0100
Message-Id: <20190405154934.18664-3-dgilbert@redhat.com>
In-Reply-To: <20190405154934.18664-1-dgilbert@redhat.com>
References: <20190405154934.18664-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 05 Apr 2019 15:49:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] migration: Fix migrate_set_parameter
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405154934.Wo5czzT2-VllvleveR460FHinPr-LZzgQz0s4FaE5Ek@z>

From: Juan Quintela <quintela@redhat.com>

Otherwise we are setting err twice, what is wrong and causes an abort.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190403114958.3705-2-quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index 92941142af..8eec768088 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1825,8 +1825,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
-        if (err || cache_size > INT64_MAX
-            || (size_t)cache_size !=3D cache_size) {
+        if (err) {
+            break;
+        }
+        if (cache_size > INT64_MAX || (size_t)cache_size !=3D cache_size=
) {
             error_setg(&err, "Invalid size %s", valuestr);
             break;
         }
--=20
2.21.0


