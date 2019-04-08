Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C20C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC812087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC812087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXGT-000696-Ue
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:36:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEu-00058E-Ue
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEu-00061M-2H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDXEo-0005w9-Qe; Mon, 08 Apr 2019 12:35:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34D0AC04F4D3;
	Mon,  8 Apr 2019 16:35:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20BFA1001E7D;
	Mon,  8 Apr 2019 16:35:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 18:34:39 +0200
Message-Id: <20190408163439.18818-3-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
References: <20190408163439.18818-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 08 Apr 2019 16:35:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] hmp: Fix drive_add ... format=help crash
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408163439.v6agfGIa0vgjVDBaA5wVCe5gKqiBFTYAT6CPmLSNUNo@z>

From: Markus Armbruster <armbru@redhat.com>

drive_new() returns null without setting an error when it provided
help.  add_init_drive() assumes null means failure, and crashes trying
to report a null error.

Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 device-hotplug.c | 2 +-
 tests/test-hmp.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index 6090d5f1e9..6153259d71 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -48,7 +48,7 @@ static DriveInfo *add_init_drive(const char *optstr)
=20
     mc =3D MACHINE_GET_CLASS(current_machine);
     dinfo =3D drive_new(opts, mc->block_default_type, &err);
-    if (!dinfo) {
+    if (err) {
         error_report_err(err);
         qemu_opts_del(opts);
         return NULL;
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 8c49d2fdf1..54a01824dc 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -31,6 +31,7 @@ static const char *hmp_cmds[] =3D {
     "cpu 0",
     "device_add ?",
     "device_add usb-mouse,id=3Dmouse1",
+    "drive_add ignored format=3Dhelp",
     "mouse_button 7",
     "mouse_move 10 10",
     "mouse_button 0",
--=20
2.20.1


