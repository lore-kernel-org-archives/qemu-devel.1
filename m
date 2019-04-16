Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7FC282DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD55720872
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD55720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGQD5-00069e-1S
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 11:41:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQAg-0004Up-1M
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQAf-0000ma-2C
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGQAe-0000m6-Qc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A90881F18;
	Tue, 16 Apr 2019 15:38:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D9FB55D9CA;
	Tue, 16 Apr 2019 15:38:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AF9A61138648; Tue, 16 Apr 2019 17:38:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 17:38:50 +0200
Message-Id: <20190416153850.5186-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 16 Apr 2019 15:38:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416153850.wp0MK_BRW8lF2JiqbG_4VcGYJDWhY7G5MigGLwhGMlw@z>

Before the from qerror_report() to error_setg(), hints looked like
this:

    qerror_report(QERR_MACRO, ... arguments ...);
    error_printf_unless_qmp(... hint ...);

error_printf_unless_qmp() made perfect sense: it printed exactly when
qerror_report() did.

After the conversion to error_setg():

    error_setg(errp, QERR_MACRO, ... arguments ...);
    error_printf_unless_qmp(... hint ...);

The "unless QMP part" still made some sense; in QMP context, the
caller generally uses the error as QMP response instead of printing
it.

However, everything else is wrong.  If the caller handles the error,
the hint gets printed anyway (unless QMP).  If the caller reports the
error, the hint gets printed *before* the report (unless QMP) or not
at all (if QMP).

Commit 50b7b000c91 fixed this by making hints a member of Error.  It
kept printing hints with error_printf_unless_qmp():

     void error_report_err(Error *err)
     {
	 error_report("%s", error_get_pretty(err));
    +    if (err->hint) {
    +        error_printf_unless_qmp("%s\n", err->hint->str);
    +    }
	 error_free(err);
     }

This is wrong.  We should (and now can) print the hint exactly when we
print the error.

The mistake has since been copied to warn_report_err().

Fix both to use error_printf().

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/error.c b/util/error.c
index 934a78e1b1..712b4d4b5d 100644
--- a/util/error.c
+++ b/util/error.c
@@ -223,7 +223,7 @@ void error_report_err(Error *err)
 {
     error_report("%s", error_get_pretty(err));
     if (err->hint) {
-        error_printf_unless_qmp("%s", err->hint->str);
+        error_printf("%s", err->hint->str);
     }
     error_free(err);
 }
@@ -232,7 +232,7 @@ void warn_report_err(Error *err)
 {
     warn_report("%s", error_get_pretty(err));
     if (err->hint) {
-        error_printf_unless_qmp("%s", err->hint->str);
+        error_printf("%s", err->hint->str);
     }
     error_free(err);
 }
-- 
2.17.2


