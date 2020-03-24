Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8ADC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1583A20409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUFm8R5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1583A20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGsuy-0005XG-5W
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGssH-00082I-4N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGssF-00022X-US
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGssF-000228-Q0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585092139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0YjqPNVav5l4BTZupSoEKVM5UlhLCtLwyLDUL165Ng=;
 b=CUFm8R5DzJhjXyUh8UUQxZx26inHCZaooauREBK+BqosSHI1fURR2NxNgjdkAzFlucxUWD
 7kVElXNNvuGSciCEplVLwBaaXtRHTF3zDOgZiy6qBijsL2ySFniZuFr6ueEQtVIROx3Kh4
 ju7OsfIQt2CtMp6oPdqq6hJowIWdH+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-tSwNDBN3PaeTIWY4xuF2cw-1; Tue, 24 Mar 2020 19:22:18 -0400
X-MC-Unique: tSwNDBN3PaeTIWY4xuF2cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734AD18FE882;
 Tue, 24 Mar 2020 23:21:58 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A19FF5D9C5;
 Tue, 24 Mar 2020 23:21:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/14] iotests: add hmp helper with logging
Date: Tue, 24 Mar 2020 19:20:59 -0400
Message-Id: <20200324232103.4195-11-jsnow@redhat.com>
In-Reply-To: <20200324232103.4195-1-jsnow@redhat.com>
References: <20200324232103.4195-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just a mild cleanup while I was here.

Although we now have universal qmp logging on or off, many existing
callers to hmp functions don't expect that output to be logged, which
causes quite a few changes in the test output.

For now, just offer a use_log parameter.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e12d6e533e..4faee06f14 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -540,25 +540,29 @@ def add_incoming(self, addr):
         self._args.append(addr)
         return self
=20
-    def pause_drive(self, drive, event=3DNone):
-        '''Pause drive r/w operations'''
+    def hmp(self, command_line: str, use_log: bool =3D False):
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
+        self.hmp(f'qemu-io {drive} "break {event} bp_{drive}"')
=20
-    def resume_drive(self, drive):
-        self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "remove_break bp_%s"'
-                 % (drive, drive))
+    def resume_drive(self, drive: str) -> None:
+        """Resume drive r/w operations"""
+        self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
=20
-    def hmp_qemu_io(self, drive, cmd):
-        '''Write to a given drive using an HMP command'''
-        return self.qmp('human-monitor-command',
-                        command_line=3D'qemu-io %s "%s"' % (drive, cmd))
+    def hmp_qemu_io(self, drive: str, cmd: str, use_log: bool =3D False) -=
> None:
+        """Write to a given drive using an HMP command"""
+        return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=3Duse_log)
=20
     def flatten_qmp_object(self, obj, output=3DNone, basestr=3D''):
         if output is None:
--=20
2.21.1


