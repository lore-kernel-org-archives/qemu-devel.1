Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C43C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50692077B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxZY7nQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50692077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipcgd-0007eN-My
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ipcfA-0006CT-EV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ipcf9-0003zW-GK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ipcf9-0003wV-CE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578594966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFK0xPcZh/DGSYgb7LQFrR+Sjv4jJ+T/sr1m/avhMYs=;
 b=IxZY7nQLtpweajawXHXlXoqIY4AIgVmTBiZ++TKFoCbBAFxsh1mEIgQ2xLiqnv3/B6ezsl
 EQ9o1VTVpc+KoAs8GDr/R1fAZOwvF8DkCnlcfRg1wxLMZYU1dYuZWUHCa1jLHvy2a7gpi2
 dYRcMZMcaOHDhkV71ewx8uy1rgJ5Dtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-SBZR6OGpMWKLEhw4krR8KA-1; Thu, 09 Jan 2020 13:36:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9361F593A0;
 Thu,  9 Jan 2020 18:36:02 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72CA1691AD;
 Thu,  9 Jan 2020 18:36:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] vl: Initialise main loop earlier
Date: Thu,  9 Jan 2020 19:35:44 +0100
Message-Id: <20200109183545.27452-4-kwolf@redhat.com>
In-Reply-To: <20200109183545.27452-1-kwolf@redhat.com>
References: <20200109183545.27452-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SBZR6OGpMWKLEhw4krR8KA-1
X-Mimecast-Spam-Score: 0
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to be able to use qemu_aio_context in the monitor
initialisation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 86474a55c9..4c79a00857 100644
--- a/vl.c
+++ b/vl.c
@@ -2903,6 +2903,11 @@ int main(int argc, char **argv, char **envp)
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
@@ -3817,11 +3822,6 @@ int main(int argc, char **argv, char **envp)
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


