Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2903208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2903208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsge-0005lG-3Z
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgsOt-0002Oh-Qw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgsOq-0004v3-W6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgsOq-0004iX-Kw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34026D56F1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:02:33 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 902E15D704;
 Fri, 28 Jun 2019 15:02:32 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 11:02:16 -0400
Message-Id: <20190628150217.32659-3-wainersm@redhat.com>
In-Reply-To: <20190628150217.32659-1-wainersm@redhat.com>
References: <20190628150217.32659-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 28 Jun 2019 15:02:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] tests/acceptance: Introduce the "accel" tag
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
Cc: philmd@redhat.com, jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some test cases may boot a VM with accelerator that isn't actually
enabled on the QEMU binary or present in the host. In this case
the test case is gonna fail miserably, unless it can be skipped.

This change introduces the "accel" tag, used to mark the test
case requires a given accelerator(s). It was implemented a
mechanism to check the given accelerator is available, and if not
then the test case is skipped.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py |  5 ++
 tests/acceptance/avocado_qemu/accel.py    | 60 +++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tests/acceptance/avocado_qemu/accel.py

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 2b236a1cf0..f823f7525b 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -18,6 +18,7 @@ SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__)=
, '..', '..', '..')
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu import QEMUMachine
+from .accel import is_accel_available
=20
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
@@ -65,6 +66,10 @@ class Test(avocado.Test):
         if self.qemu_bin is None:
             self.cancel("No QEMU binary defined or found in the source t=
ree")
=20
+        for accel in self.tags.get('accel', []):
+            if not is_accel_available(accel, self.qemu_bin):
+                self.cancel("Accelerator %s not available" % accel)
+
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin)
         if args:
diff --git a/tests/acceptance/avocado_qemu/accel.py b/tests/acceptance/av=
ocado_qemu/accel.py
new file mode 100644
index 0000000000..21f7240d56
--- /dev/null
+++ b/tests/acceptance/avocado_qemu/accel.py
@@ -0,0 +1,60 @@
+# Utilities for using QEMU accelerators on tests.
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Wainer dos Santos Moschetta <wainersm@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu import QEMUMachine
+from qemu import kvm_available
+
+def list_accel(qemu_bin):
+    """
+    List accelerators enabled in the binary.
+
+    :param qemu_bin: path to the QEMU binary.
+    :type qemu_bin: str
+    :returns: list of accelerator names.
+    :rtype: list
+    """
+    vm =3D QEMUMachine(qemu_bin)
+    vm.set_qmp_monitor(disabled=3DTrue)
+    vm.add_args('-accel', 'help')
+    vm.launch()
+    vm.wait()
+    if vm.exitcode() !=3D 0:
+        raise Exception("Failed to get the accelerators in %s" % qemu_bi=
n)
+    lines =3D vm.get_log().splitlines()
+    # skip first line which is the output header.
+    return [l for l in lines[1:] if l]
+
+def _tcg_avail_checker(qemu_bin):
+    # checks TCG is enabled in the binary only.
+    return 'tcg' in list_accel(qemu_bin)
+
+def _kvm_avail_checker(qemu_bin):
+    # checks KVM is present in the host as well as enabled in the binary=
.
+    return kvm_available() and "kvm" in list_accel(qemu_bin)
+
+_CHECKERS =3D {"tcg": _tcg_avail_checker, "kvm": _kvm_avail_checker}
+
+def is_accel_available(accel, qemu_bin):
+    """
+    Check the accelerator is available (enabled in the binary as well as
+    present on host).
+
+    :param accel:  accelerator's name.
+    :type accel: str
+    :param qemu_bin: path to the QEMU binary.
+    :type qemu_bin: str
+    :returns: True if accelerator is available, False otherwise.
+    :rtype: boolean
+    """
+    checker =3D _CHECKERS.get(accel, None)
+    if checker:
+        return checker(qemu_bin)
+    raise Exception("Availability checker not implemented for %s acceler=
ator." %
+                    accel)
--=20
2.21.0


