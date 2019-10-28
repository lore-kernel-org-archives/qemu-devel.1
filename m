Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71193CA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35342208C0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deICxhNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35342208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPF5a-0001B0-Bd
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 20:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn6-00030D-Ks
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEmH-0003rm-Ua
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEmH-0003rd-Qm
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOgyww85CaZTd33qjudOfCpcXibyYIgkL0SAsN2TQtI=;
 b=deICxhNrxb9hiU5MmH6wPIMlIm5N7acyYe+aiZecs1wKMGBYbrRiG2hs/CMOMj5u9JuauF
 wOztrxDBWNqyFksZ29ttmzb8Qz+pRPpP7cnljQDjTwHpuAP3KwiCRNJKWNHLPilUGYdnIs
 frCjX8Nx3dqBLEjfQmEWZIN6Pd5/kJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-1ta5b690MvGw4gmZGWRACg-1; Mon, 28 Oct 2019 19:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C63A8017DD;
 Mon, 28 Oct 2019 23:50:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B90D5C1B2;
 Mon, 28 Oct 2019 23:50:19 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 3/16] Python libs: close console sockets before shutting down
 the VMs
Date: Mon, 28 Oct 2019 19:49:49 -0400
Message-Id: <20191028235002.17691-4-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1ta5b690MvGw4gmZGWRACg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, the console socket on QEMUMachine is closed after the QMP
command to gracefully exit QEMU is executed.  Because of a possible
deadlock (QEMU waiting for the socket to become writable) let's close
the console socket earlier.

Reference: <20190607034214.GB22416@habkost.net>
Reference: https://bugs.launchpad.net/qemu/+bug/1829779
From: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190911023558.4880-2-crosa@redhat.com>
---
 python/qemu/machine.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 2024e8b1b1..a4631d6934 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -277,10 +277,6 @@ class QEMUMachine(object):
=20
         self._qemu_log_path =3D None
=20
-        if self._console_socket is not None:
-            self._console_socket.close()
-            self._console_socket =3D None
-
         if self._temp_dir is not None:
             shutil.rmtree(self._temp_dir)
             self._temp_dir =3D None
@@ -342,6 +338,13 @@ class QEMUMachine(object):
         """
         Terminate the VM and clean up
         """
+        # If we keep the console socket open, we may deadlock waiting
+        # for QEMU to exit, while QEMU is waiting for the socket to
+        # become writeable.
+        if self._console_socket is not None:
+            self._console_socket.close()
+            self._console_socket =3D None
+
         if self.is_running():
             try:
                 if not has_quit:
--=20
2.21.0


