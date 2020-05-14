Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7754E205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUVisbNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7754E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6pz-000622-Hb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ou-0004FY-FP
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6ot-0001ZH-4U
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42GgRBxZblLaf2qM0qkYFg+G0IvXQZU790nzwM9ThSg=;
 b=IUVisbNf+fKN7mcXdtmLp8E+LZKljI/qgi4bEcDPWwcDjDt2fczVBlp0AZee0Ln4HJzAWA
 dpuweiwzKXXhq/cY76xBx0BkkSbe/eFsKzAU+3Ls0/Q/Ivza7p2SQGajKkyRrTeBKJx0ip
 K0q+z698rJsC5eWHIPTt6rEk7BDg5fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-0JRiK0G9Mx2XCGUmaPB6pg-1; Thu, 14 May 2020 01:54:08 -0400
X-MC-Unique: 0JRiK0G9Mx2XCGUmaPB6pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 723B5107ACCA;
 Thu, 14 May 2020 05:54:07 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 028817D952;
 Thu, 14 May 2020 05:54:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 01/32] python/qemu: create qemu.lib module
Date: Thu, 14 May 2020 01:53:32 -0400
Message-Id: <20200514055403.18902-2-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

move python/qemu/*.py to python/qemu/lib/*.py.

To create a namespace package, the 'qemu' directory itself shouldn't
have module files in it. Thus, these files will go under a 'lib' package
directory instead.

Bolster the lib/__init__.py file a little bit, Make the top-level
classes and functions available directly inside the `qemu.lib`
namespace, to facilitate a convenient shorthand:

> from qemu.lib import QEMUQtestMachine, QEMUMonitorProtocol

Lastly, update all of the existing import directives.

(Note: these scripts were not necessarily tested to see if they still
work. Some of these scripts are in obvious states of disrepair and it is
beyond the scope of this patch to attempt to fix them.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/__init__.py                   | 11 -----
 python/qemu/lib/__init__.py               | 57 +++++++++++++++++++++++
 python/qemu/{ => lib}/accel.py            |  0
 python/qemu/{ => lib}/machine.py          |  0
 python/qemu/{ => lib}/qmp.py              |  0
 python/qemu/{ => lib}/qtest.py            |  0
 scripts/device-crash-test                 |  2 +-
 scripts/qmp/qemu-ga-client                |  2 +-
 scripts/qmp/qmp-shell                     |  2 +-
 scripts/render_block_graph.py             |  3 +-
 scripts/simplebench/bench_block_job.py    |  4 +-
 tests/acceptance/avocado_qemu/__init__.py |  2 +-
 tests/acceptance/boot_linux.py            |  3 +-
 tests/acceptance/virtio_check_params.py   |  2 +-
 tests/acceptance/virtio_version.py        |  2 +-
 tests/migration/guestperf/engine.py       |  2 +-
 tests/qemu-iotests/235                    |  2 +-
 tests/qemu-iotests/iotests.py             |  2 +-
 tests/vm/basevm.py                        |  6 +--
 19 files changed, 74 insertions(+), 28 deletions(-)
 delete mode 100644 python/qemu/__init__.py
 create mode 100644 python/qemu/lib/__init__.py
 rename python/qemu/{ => lib}/accel.py (100%)
 rename python/qemu/{ => lib}/machine.py (100%)
 rename python/qemu/{ => lib}/qmp.py (100%)
 rename python/qemu/{ => lib}/qtest.py (100%)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
deleted file mode 100644
index 4ca06c34a4..0000000000
--- a/python/qemu/__init__.py
+++ /dev/null
@@ -1,11 +0,0 @@
-# QEMU library
-#
-# Copyright (C) 2015-2016 Red Hat Inc.
-# Copyright (C) 2012 IBM Corp.
-#
-# Authors:
-#  Fam Zheng <famz@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2.  See
-# the COPYING file in the top-level directory.
-#
diff --git a/python/qemu/lib/__init__.py b/python/qemu/lib/__init__.py
new file mode 100644
index 0000000000..afc587bfdc
--- /dev/null
+++ b/python/qemu/lib/__init__.py
@@ -0,0 +1,57 @@
+"""
+QEMU development and testing library.
+
+This library provides a few high-level classes for driving QEMU from a
+test suite, not intended for production use.
+
+- QEMUMachine: Configure and Boot a QEMU VM
+ - QEMUQtestMachine: VM class, with a qtest socket.
+
+- QEMUMonitorProtocol: Connect to, send/receive QMP messages.
+- QEMUQtestProtocol: Connect to, send/receive qtest message.
+
+- list_accel: List available accelerators
+- kvm_available: Probe for KVM support
+- tcg_available: Probe for TCG support
+"""
+
+# Copyright (C) 2020 John Snow for Red Hat Inc.
+# Copyright (C) 2015-2016 Red Hat Inc.
+# Copyright (C) 2012 IBM Corp.
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#  Fam Zheng <fam@euphon.net>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+
+from .accel import (
+    list_accel,
+    kvm_available,
+    tcg_available,
+)
+
+from .qmp import (
+    QEMUMonitorProtocol,
+)
+
+from .machine import (
+    QEMUMachine,
+)
+
+from .qtest import (
+    QEMUQtestProtocol,
+    QEMUQtestMachine,
+)
+
+__all__ = (
+    'list_accel',
+    'kvm_available',
+    'tcg_available',
+    'QEMUMonitorProtocol',
+    'QEMUMachine',
+    'QEMUQtestProtocol',
+    'QEMUQtestMachine',
+)
diff --git a/python/qemu/accel.py b/python/qemu/lib/accel.py
similarity index 100%
rename from python/qemu/accel.py
rename to python/qemu/lib/accel.py
diff --git a/python/qemu/machine.py b/python/qemu/lib/machine.py
similarity index 100%
rename from python/qemu/machine.py
rename to python/qemu/lib/machine.py
diff --git a/python/qemu/qmp.py b/python/qemu/lib/qmp.py
similarity index 100%
rename from python/qemu/qmp.py
rename to python/qemu/lib/qmp.py
diff --git a/python/qemu/qtest.py b/python/qemu/lib/qtest.py
similarity index 100%
rename from python/qemu/qtest.py
rename to python/qemu/lib/qtest.py
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 305d0427af..49efd4abd7 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,7 +35,7 @@ import argparse
 from itertools import chain
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 
 logger = logging.getLogger('device-crash-test')
 dbg = logger.debug
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index ce122984a9..db27cfcd55 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -42,7 +42,7 @@ import base64
 import random
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qmp
+from qemu.lib import qmp
 
 
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index a01d31de1e..2441f4ae01 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -75,7 +75,7 @@ import atexit
 import re
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qmp
+from qemu.lib import qmp
 
 if sys.version_info[0] == 2:
     input = raw_input
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 409b4321f2..8048d9fbbe 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -25,7 +25,8 @@
 from graphviz import Digraph
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.machine import MonitorResponseError
+from qemu.lib import QEMUMonitorProtocol
+from qemu.lib.machine import MonitorResponseError
 
 
 def perm(arr):
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 9808d696cf..dbac12ddec 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -25,8 +25,8 @@
 import json
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
-from qemu.qmp import QMPConnectError
+from qemu.lib import QEMUMachine
+from qemu.lib.qmp import QMPConnectError
 
 
 def bench_block_job(cmd, cmd_args, qemu_args):
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 59e7b4f763..bc433d4f40 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -32,7 +32,7 @@
 
 sys.path.append(os.path.join(SOURCE_DIR, 'python'))
 
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 075a386300..4a51e1324b 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -12,8 +12,7 @@
 
 from avocado_qemu import Test, BUILD_DIR
 
-from qemu.accel import kvm_available
-from qemu.accel import tcg_available
+from qemu.lib import kvm_available, tcg_available
 
 from avocado.utils import cloudinit
 from avocado.utils import network
diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/virtio_check_params.py
index 87e6c839d1..be8069778a 100644
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -23,7 +23,7 @@
 import logging
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 from avocado_qemu import Test
 from avocado import skip
 
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
index 33593c29dd..726f50c603 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -12,7 +12,7 @@
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 from avocado_qemu import Test
 
 # Virtio Device IDs:
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index fd63c66601..22dab849f9 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -29,7 +29,7 @@
 
 sys.path.append(os.path.join(os.path.dirname(__file__),
                              '..', '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 
 
 class Engine(object):
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d1b10ac36b..13a565934c 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -25,7 +25,7 @@ from iotests import qemu_img_create, qemu_io, file_path, log
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 
-from qemu.machine import QEMUMachine
+from qemu.lib import QEMUMachine
 
 iotests.script_initialize(supported_fmts=['qcow2'])
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6c0e781af7..c69ac07e69 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -34,7 +34,7 @@
 
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qtest
+from qemu.lib import qtest
 
 assert sys.version_info >= (3, 6)
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 756ccf7aca..4c89c62fb8 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -18,9 +18,6 @@
 import logging
 import time
 import datetime
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.accel import kvm_available
-from qemu.machine import QEMUMachine
 import subprocess
 import hashlib
 import optparse
@@ -30,6 +27,9 @@
 import multiprocessing
 import traceback
 
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.lib import kvm_available, QEMUMachine
+
 SSH_KEY = open(os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")).read()
 SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
-- 
2.21.1


