Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CEC49ED9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0B92171F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0B92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7sWR-0004PS-UD
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 22:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7sUL-0001my-6F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7sUJ-0004nZ-FT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7sUJ-0004nM-AA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97FC530BA1B0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:36:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B5E60852;
 Wed, 11 Sep 2019 02:36:05 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 22:35:57 -0400
Message-Id: <20190911023558.4880-2-crosa@redhat.com>
In-Reply-To: <20190911023558.4880-1-crosa@redhat.com>
References: <20190911023558.4880-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 02:36:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] Python libs: close console sockets before
 shutting down the VMs
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
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
---
 python/qemu/machine.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 128a3d1dc2..4f533b7881 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -271,10 +271,6 @@ class QEMUMachine(object):
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
@@ -333,6 +329,13 @@ class QEMUMachine(object):
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


