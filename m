Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F03C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B4120838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O58cOD03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B4120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OXy-0003oh-6Z
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWq-00023v-1R
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007p4-RF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007ni-MA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioKiR0424ftBjD7lpbVOIDL2uezKt3IXhOhLa6WO5o4=;
 b=O58cOD03zsNR/gpyUvhkds2cTDjX3Qr8U8hkvv/s9JsB0GzorAZk/AGdufZnM3E4cWL7Az
 2WunkYktjRu1atFBX7h6/v3FCcZV9CO468yR1id+3IkF3Mubv2tMlUNR/KNvYiA6iEvyfP
 fRHqw3P1kjzizhgKMtbb3LyYu+ZUors=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-yjBk6Y9WNzCmdhx0L8enYw-1; Mon, 24 Feb 2020 19:56:48 -0500
X-MC-Unique: yjBk6Y9WNzCmdhx0L8enYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45E213E2;
 Tue, 25 Feb 2020 00:56:47 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B647289F30;
 Tue, 25 Feb 2020 00:56:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] iotests: add hmp helper with logging
Date: Mon, 24 Feb 2020 19:56:39 -0500
Message-Id: <20200225005641.5478-5-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just a mild cleanup while I was here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8815052eb5..5d2990a0e4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -525,23 +525,27 @@ def add_incoming(self, addr):
         self._args.append(addr)
         return self
=20
+    def hmp(self, command_line, log=3DFalse):
+        cmd =3D 'human-monitor-command'
+        kwargs =3D { 'command-line': command_line }
+        if log:
+            return self.qmp_log(cmd, **kwargs)
+        return self.qmp(cmd, **kwargs)
+
     def pause_drive(self, drive, event=3DNone):
         '''Pause drive r/w operations'''
         if not event:
             self.pause_drive(drive, "read_aio")
             self.pause_drive(drive, "write_aio")
             return
-        self.qmp('human-monitor-command',
-                    command_line=3D'qemu-io %s "break %s bp_%s"' % (drive,=
 event, drive))
+        self.hmp('qemu-io %s "break %s bp_%s"' % (drive, event, drive))
=20
     def resume_drive(self, drive):
-        self.qmp('human-monitor-command',
-                    command_line=3D'qemu-io %s "remove_break bp_%s"' % (dr=
ive, drive))
+        self.hmp('qemu-io %s "remove_break bp_%s"' % (drive, drive))
=20
-    def hmp_qemu_io(self, drive, cmd):
+    def hmp_qemu_io(self, drive, cmd, log=3DFalse):
         '''Write to a given drive using an HMP command'''
-        return self.qmp('human-monitor-command',
-                        command_line=3D'qemu-io %s "%s"' % (drive, cmd))
+        return self.hmp('qemu-io %s "%s"' % (drive, cmd), log=3Dlog)
=20
     def flatten_qmp_object(self, obj, output=3DNone, basestr=3D''):
         if output is None:
--=20
2.21.1


