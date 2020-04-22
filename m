Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7FC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D08206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOMOPRY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D08206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFJO-0006BQ-Um
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF6K-00043W-UZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF65-0003jb-RA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF65-0003fz-DQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfYN+TU+3RtiZ4Pa1zd3jj/XHqO17tt2OP3Q91CNoWs=;
 b=dOMOPRY1yVJRYlS9L3MbuGev7n9s5dTHXYfMefXXut/Juq7u3YZs8FCTcvPd1FSZTs9O9n
 OvI8ALHkE4hIEkVnQZH4BOOPLyUQZwpSPnp4vUULHvxjQfOqyi19bEvnONpMcDcMMQ2xk+
 sCwFo5FGd5AM5LZR9ghcya+WSfrnlTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-MBZJOojGPgqV0JcqchcQGg-1; Wed, 22 Apr 2020 09:07:22 -0400
X-MC-Unique: MBZJOojGPgqV0JcqchcQGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2521084431
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97AFD60C99;
 Wed, 22 Apr 2020 13:07:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0ADCF11358C0; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] cpus: Proper range-checking for -icount shift=N
Date: Wed, 22 Apr 2020 15:07:09 +0200
Message-Id: <20200422130719.28225-5-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

timers_state.icount_time_shift must be in [0,63] to avoid undefined
behavior when shifting by it, e.g. in cpu_icount_to_ns().
icount_adjust() clamps it to [0,MAX_ICOUNT_SHIFT], with
MAX_ICOUNT_SHIFT =3D 10.  configure_icount() doesn't.  Fix that.

Fixes: a8bfac37085c3372366d722f131a7e18d664ee4d
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 cpus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index 1b542b37f9..5670c96bcf 100644
--- a/cpus.c
+++ b/cpus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/cutils.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
@@ -801,7 +802,6 @@ void configure_icount(QemuOpts *opts, Error **errp)
     bool sleep =3D qemu_opt_get_bool(opts, "sleep", true);
     bool align =3D qemu_opt_get_bool(opts, "align", false);
     long time_shift =3D -1;
-    char *rem_str =3D NULL;
=20
     if (!option && qemu_opt_get(opts, "align")) {
         error_setg(errp, "Please specify shift option when using align");
@@ -814,9 +814,8 @@ void configure_icount(QemuOpts *opts, Error **errp)
     }
=20
     if (strcmp(option, "auto") !=3D 0) {
-        errno =3D 0;
-        time_shift =3D strtol(option, &rem_str, 0);
-        if (errno !=3D 0 || *rem_str !=3D '\0' || !strlen(option)) {
+        if (qemu_strtol(option, NULL, 0, &time_shift) < 0
+            || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
             error_setg(errp, "icount: Invalid shift value");
             return;
         }
--=20
2.21.1


