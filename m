Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8591822522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYW2Lmnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8591822522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ity1U-0008CR-HO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 13:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ity0C-0006nu-QK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ity07-0008PV-Vi
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ity07-0008P1-Rd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579630302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFZpNhKsbMM7xZZ6L09t2stZ0Yrn125gar2FhBSAi48=;
 b=DYW2Lmnd7Y8BlOclLlBtucvRzNzzGBykG13RiUtMkHbO/395+VpY/gKGr5OkeT0kL9FsSg
 2Oudd1eS7dehWFAkIY8/AgykeWqf2pWIdrC+o5n0b+vLbwOGfX78s5EviebHhhXLUp7uRs
 GRD0SK5CsBT/Efzelrw4CwKZjzxHq3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-685A5pd8MKK_SP_yIcnGwg-1; Tue, 21 Jan 2020 13:11:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFD051882CC3;
 Tue, 21 Jan 2020 18:11:39 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A54F60FC1;
 Tue, 21 Jan 2020 18:11:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] vl: Initialise main loop earlier
Date: Tue, 21 Jan 2020 19:11:20 +0100
Message-Id: <20200121181122.15941-3-kwolf@redhat.com>
In-Reply-To: <20200121181122.15941-1-kwolf@redhat.com>
References: <20200121181122.15941-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 685A5pd8MKK_SP_yIcnGwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to be able to use qemu_aio_context in the monitor
initialisation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 751401214c..8064fef8b3 100644
--- a/vl.c
+++ b/vl.c
@@ -2909,6 +2909,11 @@ int main(int argc, char **argv, char **envp)
     runstate_init();
     precopy_infrastructure_init();
     postcopy_infrastructure_init();
+
+    if (qemu_init_main_loop(&main_loop_err)) {
+        error_report_err(main_loop_err);
+        exit(1);
+    }
     monitor_init_globals();
=20
     if (qcrypto_init(&err) < 0) {
@@ -3823,11 +3828,6 @@ int main(int argc, char **argv, char **envp)
     qemu_unlink_pidfile_notifier.notify =3D qemu_unlink_pidfile;
     qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
=20
-    if (qemu_init_main_loop(&main_loop_err)) {
-        error_report_err(main_loop_err);
-        exit(1);
-    }
-
 #ifdef CONFIG_SECCOMP
     olist =3D qemu_find_opts_err("sandbox", NULL);
     if (olist) {
--=20
2.20.1


