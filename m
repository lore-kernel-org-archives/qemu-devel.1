Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBBC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F22720658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgwuVZF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F22720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izofN-00029r-Ff
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZm-0007qX-L3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZj-0002CZ-Q6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZj-0002Ah-Kn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHzkSk+zwjCY8tvDa+pGb2eUwE5S8GdLdlfrE8mx5rg=;
 b=fgwuVZF93Zt8zRksYhtmMANOhFoPaOir3SFmaz43y+Is2vEXFKY1SGP6gljnwC/HJZLDcN
 M3D5xeMGAZZtH6Zpuj0Jry6BQExs8um5WqWWi7Ox2PEAbCUOkEreY88FWgJo6bPQbx9GMQ
 IsYKJX8g+CmhaFGTLJ3gcjHvrUzNcRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Ijq6XsOnMRy--cVyk2XXuA-1; Thu, 06 Feb 2020 16:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E99DB1081FA0;
 Thu,  6 Feb 2020 21:20:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB8E60BEC;
 Thu,  6 Feb 2020 21:20:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/46] Acceptance tests: Extract _console_interaction()
Date: Thu,  6 Feb 2020 22:19:00 +0100
Message-Id: <20200206211936.17098-11-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Ijq6XsOnMRy--cVyk2XXuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since we are going to re-use the code shared between
wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
extract the common part into a local function.

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200120235159.18510-3-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 6618ea67c1..0a50fcf2be 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=3DNone):
         return qemu_bin_from_src_dir_path
=20
=20
-def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):
-    """
-    Waits for messages to appear on the console, while logging the content
-
-    :param test: an Avocado test containing a VM that will have its consol=
e
-                 read and probed for a success or failure message
-    :type test: :class:`avocado_qemu.Test`
-    :param success_message: if this message appears, test succeeds
-    :param failure_message: if this message appears, test fails
-    """
+def _console_interaction(test, success_message, failure_message,
+                         send_string):
     console =3D test.vm.console_socket.makefile()
     console_logger =3D logging.getLogger('console')
     while True:
+        if send_string:
+            test.vm.console_socket.sendall(send_string.encode())
+            send_string =3D None # send only once
         msg =3D console.readline().strip()
         if not msg:
             continue
@@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message, fail=
ure_message=3DNone):
             fail =3D 'Failure message found in console: %s' % failure_mess=
age
             test.fail(fail)
=20
+def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):
+    """
+    Waits for messages to appear on the console, while logging the content
+
+    :param test: an Avocado test containing a VM that will have its consol=
e
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, None)
=20
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=3DN=
one):
@@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
-    command +=3D '\r'
-    test.vm.console_socket.sendall(command.encode())
-    wait_for_console_pattern(test, success_message, failure_message)
-
+    _console_interaction(test, success_message, failure_message, command +=
 '\r')
=20
 class Test(avocado.Test):
     def _get_unique_tag_val(self, tag_name):
--=20
2.21.1


