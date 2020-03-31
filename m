Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4212020774
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4JY3ep8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4212020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4Vh-000258-DX
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Kn-0003vQ-Hq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Kl-0000FE-Oa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34559)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jJ4Kl-0000E5-LG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585612847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCA3DJlHQg9mKXUw7SXWIQWeTiieHppDVr6xdVGxpvA=;
 b=e4JY3ep8js2ukNijPhKVg/vclseX946GDZkklN53igp5uMMY08uyIynoWw3WBKAB/yYHVG
 PB5JYDGQEr6K2Cb2jYXgV4ldVHPjmq8kkOUkpCkAJvXp3XlQS1yQtvOJ5d8NNd5YMaQcrd
 auGN5QUqHsyZWVgEFc9Avl2VUVpbUGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-twP8bCJVM22up0nFyzHuAg-1; Mon, 30 Mar 2020 20:00:45 -0400
X-MC-Unique: twP8bCJVM22up0nFyzHuAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF6C801E53;
 Tue, 31 Mar 2020 00:00:44 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39CCA100EBB6;
 Tue, 31 Mar 2020 00:00:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 10/14] iotests: add hmp helper with logging
Date: Mon, 30 Mar 2020 20:00:10 -0400
Message-Id: <20200331000014.11581-11-jsnow@redhat.com>
In-Reply-To: <20200331000014.11581-1-jsnow@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 tests/qemu-iotests/iotests.py | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b08bcb87e1..dfc753c319 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -37,6 +37,10 @@
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
@@ -540,25 +544,30 @@ def add_incoming(self, addr):
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
+    def hmp_qemu_io(self, drive: str, cmd: str,
+                    use_log: bool =3D False) -> QMPResponse:
+        """Write to a given drive using an HMP command"""
+        return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=3Duse_log)
=20
     def flatten_qmp_object(self, obj, output=3DNone, basestr=3D''):
         if output is None:
--=20
2.21.1


