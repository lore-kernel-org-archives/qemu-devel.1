Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB26C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D882073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOZejpNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D882073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxJ6-0008Uk-Hi
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxA0-0001Ww-3S
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59404
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9z-0000vH-7b
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mb9m9GfCxKbgsPWdefIelFbw1RfASfl7wVa2Lb2r6UI=;
 b=iOZejpNzx9bJYW20f4EQ5pufQjGK8sN+UuQZrpWue8A0jj0Wpr9JuUVICOmqFBOwUhCK1H
 VN01mI1gKy8f8h8iKHXCMVFQEfi/0ycziTlei2oxbgOb7c6rdXktXqbjCPK66+kZzXkM6H
 eE2qoRhtbKrVQHbU8umrNxmXn9q7QgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-7D9XcggRMBaS-JaoKdoVgA-1; Tue, 05 May 2020 08:58:51 -0400
X-MC-Unique: 7D9XcggRMBaS-JaoKdoVgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F2071899521;
 Tue,  5 May 2020 12:58:50 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E50345C1D3;
 Tue,  5 May 2020 12:58:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/24] iotests: add hmp helper with logging
Date: Tue,  5 May 2020 14:58:12 +0200
Message-Id: <20200505125826.1001451-11-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Minor cleanup for HMP functions; helps with line length and consolidates
HMP helpers through one implementation function.

Although we are adding a universal toggle to turn QMP logging on or off,
many existing callers to hmp functions don't expect that output to be
logged, which causes quite a few changes in the test output.

For now, offer a use_log parameter.

Typing notes:

QMPResponse is just an alias for Dict[str, Any]. It holds no special
meanings and it is not a formal subtype of Dict[str, Any]. It is best
thought of as a lexical synonym.

We may well wish to add stricter subtypes in the future for certain
shapes of data that are not formalized as Python objects, at which point
we can simply retire the alias and allow mypy to more strictly check
usages of the name.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200331000014.11581-11-jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 39 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9f5da32dae..cf10c428b5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -37,6 +37,10 @@ from qemu import qtest
=20
 assert sys.version_info >=3D (3, 6)
=20
+# Type Aliases
+QMPResponse =3D Dict[str, Any]
+
+
 faulthandler.enable()
=20
 # This will not work if arguments contain spaces but is necessary if we
@@ -541,25 +545,30 @@ class VM(qtest.QEMUQtestMachine):
         self._args.append(addr)
         return self
=20
-    def pause_drive(self, drive, event=3DNone):
-        '''Pause drive r/w operations'''
+    def hmp(self, command_line: str, use_log: bool =3D False) -> QMPRespon=
se:
+        cmd =3D 'human-monitor-command'
+        kwargs =3D {'command-line': command_line}
+        if use_log:
+            return self.qmp_log(cmd, **kwargs)
+        else:
+            return self.qmp(cmd, **kwargs)
+
+    def pause_drive(self, drive: str, event: Optional[str] =3D None) -> No=
ne:
+        """Pause drive r/w operations"""
         if not event:
             self.pause_drive(drive, "read_aio")
             self.pause_drive(drive, "write_aio")
             return
-        self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "break %s bp_%s"'
-                 % (drive, event, drive))
-
-    def resume_drive(self, drive):
-        self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "remove_break bp_%s"'
-                 % (drive, drive))
-
-    def hmp_qemu_io(self, drive, cmd):
-        '''Write to a given drive using an HMP command'''
-        return self.qmp('human-monitor-command',
-                        command_line=3D'qemu-io %s "%s"' % (drive, cmd))
+        self.hmp(f'qemu-io {drive} "break {event} bp_{drive}"')
+
+    def resume_drive(self, drive: str) -> None:
+        """Resume drive r/w operations"""
+        self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
+
+    def hmp_qemu_io(self, drive: str, cmd: str,
+                    use_log: bool =3D False) -> QMPResponse:
+        """Write to a given drive using an HMP command"""
+        return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=3Duse_log)
=20
     def flatten_qmp_object(self, obj, output=3DNone, basestr=3D''):
         if output is None:
--=20
2.26.2


