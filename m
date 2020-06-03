Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0000C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAD02067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+WIHC76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD02067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgH5M-000066-Ob
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4E-00075a-H5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgH4B-0005ik-SM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 20:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591143335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQ/ZZgI3wkMg+EWOVlunYJIGzvi+Wf9raeLHcHRi3JE=;
 b=F+WIHC76Q51fY8YxPjmO23GZTIWIpLb1pvtr+iI88zmI6U7YmRNrqaF+hS2Rxa/hsvQv2A
 q42VdU1PZGWCFWeMAS/KP8j1zNfXkrB+qaULR+XcQwVcNSQR9CeYHwjIcrnn/hGyZqd/7f
 06iLGpZR0smuTHiJDpsYrR/HVodaaw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-2PSM5acuOZ6NQoaBFF_KJg-1; Tue, 02 Jun 2020 20:15:31 -0400
X-MC-Unique: 2PSM5acuOZ6NQoaBFF_KJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3440D8018A5;
 Wed,  3 Jun 2020 00:15:30 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6DB7F0B8;
 Wed,  3 Jun 2020 00:15:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] python/qemu: create qemu.lib module
Date: Tue,  2 Jun 2020 20:15:17 -0400
Message-Id: <20200603001523.18085-2-jsnow@redhat.com>
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 20:15:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

move python/qemu/*.py to python/qemu/core/*.py.

To create a namespace package, the 'qemu' directory itself shouldn't
have module files in it. Thus, these files will go under a 'lib' package
directory instead.

Bolster the core/__init__.py file a little bit, Make the top-level
classes and functions available directly inside the `qemu.core`
namespace, to facilitate a convenient shorthand:

> from qemu.core import QEMUQtestMachine, QEMUMonitorProtocol

Lastly, update all of the existing import directives.

(Note: these scripts were not necessarily tested to see if they still
work. Some of these scripts are in obvious states of disrepair and it is
beyond the scope of this patch to attempt to fix them.)


RFC: For now, I have used the 'qemu.core' namespace to provide a group
of related tools. I liked Daniel's suggestion of using qemu.machine (and
possible qemu.monitor), but that requires me to rewrite the import
statements and understand a bit more about how to configure
pylint/mypy/flake8 and it's not right to focus on that right now. In the
interest of expedience, I've chosen to keep everything in one package to
be able to send another RFC patchset.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/__init__.py                   | 11 -----
 python/qemu/{ => core}/.flake8            |  0
 python/qemu/core/__init__.py              | 57 +++++++++++++++++++++++
 python/qemu/{ => core}/accel.py           |  0
 python/qemu/{ => core}/machine.py         |  0
 python/qemu/{ => core}/pylintrc           |  0
 python/qemu/{ => core}/qmp.py             |  0
 python/qemu/{ => core}/qtest.py           |  0
 scripts/device-crash-test                 |  2 +-
 scripts/qmp/qemu-ga-client                |  2 +-
 scripts/qmp/qmp                           |  2 +-
 scripts/qmp/qmp-shell                     |  2 +-
 scripts/qmp/qom-fuse                      |  2 +-
 scripts/qmp/qom-get                       |  2 +-
 scripts/qmp/qom-list                      |  2 +-
 scripts/qmp/qom-set                       |  2 +-
 scripts/qmp/qom-tree                      |  2 +-
 scripts/render_block_graph.py             |  6 +--
 scripts/simplebench/bench_block_job.py    |  4 +-
 tests/acceptance/avocado_qemu/__init__.py |  2 +-
 tests/acceptance/boot_linux.py            |  3 +-
 tests/acceptance/virtio_check_params.py   |  2 +-
 tests/acceptance/virtio_version.py        |  2 +-
 tests/migration/guestperf/engine.py       |  2 +-
 tests/qemu-iotests/235                    |  2 +-
 tests/qemu-iotests/297                    |  2 +-
 tests/qemu-iotests/iotests.py             |  4 +-
 tests/vm/basevm.py                        |  6 +--
 28 files changed, 82 insertions(+), 39 deletions(-)
 delete mode 100644 python/qemu/__init__.py
 rename python/qemu/{ => core}/.flake8 (100%)
 create mode 100644 python/qemu/core/__init__.py
 rename python/qemu/{ => core}/accel.py (100%)
 rename python/qemu/{ => core}/machine.py (100%)
 rename python/qemu/{ => core}/pylintrc (100%)
 rename python/qemu/{ => core}/qmp.py (100%)
 rename python/qemu/{ => core}/qtest.py (100%)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
deleted file mode 100644
index 4ca06c34a41..00000000000
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
diff --git a/python/qemu/.flake8 b/python/qemu/core/.flake8
similarity index 100%
rename from python/qemu/.flake8
rename to python/qemu/core/.flake8
diff --git a/python/qemu/core/__init__.py b/python/qemu/core/__init__.py
new file mode 100644
index 00000000000..afc587bfdcf
--- /dev/null
+++ b/python/qemu/core/__init__.py
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
diff --git a/python/qemu/accel.py b/python/qemu/core/accel.py
similarity index 100%
rename from python/qemu/accel.py
rename to python/qemu/core/accel.py
diff --git a/python/qemu/machine.py b/python/qemu/core/machine.py
similarity index 100%
rename from python/qemu/machine.py
rename to python/qemu/core/machine.py
diff --git a/python/qemu/pylintrc b/python/qemu/core/pylintrc
similarity index 100%
rename from python/qemu/pylintrc
rename to python/qemu/core/pylintrc
diff --git a/python/qemu/qmp.py b/python/qemu/core/qmp.py
similarity index 100%
rename from python/qemu/qmp.py
rename to python/qemu/core/qmp.py
diff --git a/python/qemu/qtest.py b/python/qemu/core/qtest.py
similarity index 100%
rename from python/qemu/qtest.py
rename to python/qemu/core/qtest.py
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 305d0427af6..e8f878e7b2f 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -35,7 +35,7 @@ import argparse
 from itertools import chain
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 
 logger = logging.getLogger('device-crash-test')
 dbg = logger.debug
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index ce122984a9c..b1e8add6f5d 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -42,7 +42,7 @@ import base64
 import random
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qmp
+from qemu.core import qmp
 
 
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 8e52e4a54de..eaf4b0333aa 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -13,7 +13,7 @@
 import sys, os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 def print_response(rsp, prefix=[]):
     if type(rsp) == list:
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index c5eef06f3fd..e819382f68d 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -75,7 +75,7 @@ import atexit
 import re
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qmp
+from qemu.core import qmp
 
 class QMPCompleter(list):
     def complete(self, text, state):
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 5fa6b3bf64d..28f51ec1547 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -17,7 +17,7 @@ import os, posix
 from errno import *
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 666df718320..cc97ae09e41 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -15,7 +15,7 @@ import sys
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 5074fd939f4..2b5e1881b0b 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -15,7 +15,7 @@ import sys
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 240a78187f9..e001eebe6c4 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -15,7 +15,7 @@ import sys
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 25b0781323c..bd677fd28a0 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -17,7 +17,7 @@ import sys
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.core import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index da6acf050d1..90301f244ba 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -25,10 +25,8 @@
 from graphviz import Digraph
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.qmp import (
-    QEMUMonitorProtocol,
-    QMPResponseError,
-)
+from qemu.core import QEMUMonitorProtocol
+from qemu.core.machine import MonitorResponseError
 
 
 def perm(arr):
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 9808d696cfe..9ec5c0a42bb 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -25,8 +25,8 @@
 import json
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
-from qemu.qmp import QMPConnectError
+from qemu.core import QEMUMachine
+from qemu.core.qmp import QMPConnectError
 
 
 def bench_block_job(cmd, cmd_args, qemu_args):
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 77d1c1d9ff1..55e416f7df4 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -32,7 +32,7 @@
 
 sys.path.append(os.path.join(SOURCE_DIR, 'python'))
 
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 
 def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 3aa57e88b0b..334bc628e80 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -12,8 +12,7 @@
 
 from avocado_qemu import Test, BUILD_DIR
 
-from qemu.accel import kvm_available
-from qemu.accel import tcg_available
+from qemu.core import kvm_available, tcg_available
 
 from avocado.utils import cloudinit
 from avocado.utils import network
diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/virtio_check_params.py
index 87e6c839d14..51d9d169cc6 100644
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -23,7 +23,7 @@
 import logging
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 from avocado_qemu import Test
 from avocado import skip
 
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
index 33593c29dd0..dba149ec4fc 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -12,7 +12,7 @@
 import os
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 from avocado_qemu import Test
 
 # Virtio Device IDs:
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index fd63c666015..fef02e157ca 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -29,7 +29,7 @@
 
 sys.path.append(os.path.join(os.path.dirname(__file__),
                              '..', '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 
 
 class Engine(object):
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index d1b10ac36bd..4fc4e600414 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -25,7 +25,7 @@ from iotests import qemu_img_create, qemu_io, file_path, log
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 
-from qemu.machine import QEMUMachine
+from qemu.core import QEMUMachine
 
 iotests.script_initialize(supported_fmts=['qcow2'])
 
diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
index 5c5420712b1..8236875222d 100755
--- a/tests/qemu-iotests/297
+++ b/tests/qemu-iotests/297
@@ -36,7 +36,7 @@ MYPYPATH=../../python/ mypy --warn-unused-configs --disallow-subclassing-any \
     --disallow-any-generics --disallow-incomplete-defs \
     --disallow-untyped-decorators --no-implicit-optional \
     --warn-redundant-casts --warn-unused-ignores \
-    --no-implicit-reexport iotests.py
+    --no-implicit-reexport --namespace-packages iotests.py
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 19b22bee618..0a6df990f46 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -34,8 +34,8 @@
 
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu import qtest
-from qemu.qmp import QMPMessage
+from qemu.core import qtest
+from qemu.core.qmp import QMPMessage
 
 assert sys.version_info >= (3, 6)
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index a80b616a08d..fa5e807689f 100644
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
+from qemu.core import kvm_available, QEMUMachine
+
 SSH_KEY = open(os.path.join(os.path.dirname(__file__),
                "..", "keys", "id_rsa")).read()
 SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
-- 
2.21.3


