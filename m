Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8FC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3CD2186A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3CD2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNKE-0008FF-6K
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:48:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCNHb-00060t-CC
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCNHa-0005TG-G1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hCNHY-0005N1-6T; Fri, 05 Apr 2019 07:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 071D120264;
	Fri,  5 Apr 2019 11:45:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C566B1001E8A;
	Fri,  5 Apr 2019 11:45:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4D2BE1138648; Fri,  5 Apr 2019 13:45:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Apr 2019 13:45:13 +0200
Message-Id: <20190405114513.3141-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 05 Apr 2019 11:45:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.0] hmp: Fix drive_add ... format=help
 crash
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
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405114513.7A6Xyotc838YvV7B9b6x_pYzKcOCD7qmvhhSYudbgTs@z>

drive_new() returns null without setting an error when it provided
help.  add_init_drive() assumes null means failure, and crashes trying
to report a null error.

Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 device-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index 6090d5f1e9..6153259d71 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
 
     mc = MACHINE_GET_CLASS(current_machine);
     dinfo = drive_new(opts, mc->block_default_type, &err);
-    if (!dinfo) {
+    if (err) {
         error_report_err(err);
         qemu_opts_del(opts);
         return NULL;
-- 
2.17.2


