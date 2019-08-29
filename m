Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85CAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA8B2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA8B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GWY-00087H-Nu
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1i3GVp-0007hA-Ci
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1i3GVn-0007qK-PN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:14:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1i3GVn-0007pd-Hv
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:14:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 019EE3082145;
 Thu, 29 Aug 2019 09:14:34 +0000 (UTC)
Received: from moe.brq.redhat.com (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F9F860872;
 Thu, 29 Aug 2019 09:14:30 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 11:14:14 +0200
Message-Id: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 29 Aug 2019 09:14:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qapi: Reintroduce CommandDisabled error class
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
Cc: lcapitulino@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If there was a disabled command, then qemu-ga used to report
CommandDisabled error class (among with human readable
description). This changed in v1.2.0-rc0~28^2~16 in favor of
GenericError class. While the change might work for other
classes, this one should not have been dropped because it helps
callers distinguish the root cause of the error.

A bit of background: up until very recently libvirt used qemu-ga
in all or nothing way. It didn't care why a qemu-ga command
failed. But very recently a new API was introduced which
implements 'best effort' approach (in some cases) and thus
libvirt must differentiate between: {CommandNotFound,
CommandDisabled} and some generic error. While the former classes
mean the API can issue some other commands the latter raises a
red flag causing the API to fail.

This reverts df1e608a01 partially.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 include/qapi/error.h | 1 +
 qapi/error.json      | 4 +++-
 qapi/qmp-dispatch.c  | 5 +++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 3f95141a01..7116b86a92 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -129,6 +129,7 @@
 typedef enum ErrorClass {
     ERROR_CLASS_GENERIC_ERROR =3D QAPI_ERROR_CLASS_GENERICERROR,
     ERROR_CLASS_COMMAND_NOT_FOUND =3D QAPI_ERROR_CLASS_COMMANDNOTFOUND,
+    ERROR_CLASS_COMMAND_DISABLED =3D QAPI_ERROR_CLASS_COMMANDDISABLED,
     ERROR_CLASS_DEVICE_NOT_ACTIVE =3D QAPI_ERROR_CLASS_DEVICENOTACTIVE,
     ERROR_CLASS_DEVICE_NOT_FOUND =3D QAPI_ERROR_CLASS_DEVICENOTFOUND,
     ERROR_CLASS_KVM_MISSING_CAP =3D QAPI_ERROR_CLASS_KVMMISSINGCAP,
diff --git a/qapi/error.json b/qapi/error.json
index 3fad08f506..334d481399 100644
--- a/qapi/error.json
+++ b/qapi/error.json
@@ -14,6 +14,8 @@
 #
 # @CommandNotFound: the requested command has not been found
 #
+# @CommandDisabled: the requested command has been disabled
+#
 # @DeviceNotActive: a device has failed to be become active
 #
 # @DeviceNotFound: the requested device has not been found
@@ -25,5 +27,5 @@
 ##
 { 'enum': 'QapiErrorClass',
   # Keep this in sync with ErrorClass in error.h
-  'data': [ 'GenericError', 'CommandNotFound',
+  'data': [ 'GenericError', 'CommandNotFound', 'CommandDisabled',
             'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 3037d353a4..913b3363cb 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -104,8 +104,9 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
         return NULL;
     }
     if (!cmd->enabled) {
-        error_setg(errp, "The command %s has been disabled for this inst=
ance",
-                   command);
+        error_set(errp, ERROR_CLASS_COMMAND_DISABLED,
+                  "The command %s has been disabled for this instance",
+                  command);
         return NULL;
     }
     if (oob && !(cmd->options & QCO_ALLOW_OOB)) {
--=20
2.21.0


