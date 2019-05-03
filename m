Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D504DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87282070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87282070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMLH-0007Ms-Ur
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:46:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHJ-00042z-NC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHH-0006xs-WA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHH-0006x6-OR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2438881F1B;
	Fri,  3 May 2019 00:42:14 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2C5D60BF7;
	Fri,  3 May 2019 00:42:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:23 -0300
Message-Id: <20190503004130.8285-13-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 03 May 2019 00:42:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/19] scripts/qemu.py: support adding a console
 with the default serial device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503004123.YLwS1pGMXMbGuQQlSGjtJQTI4ERpnFuPdPQI02OWuig@z>

From: Cleber Rosa <crosa@redhat.com>

The set_console() utility function either adds a device based on the
explicitly given device type, or adds a known good type of device
based on the machine type.

But, for a number of machine types, it may be impossible or
inconvenient to add the devices by means of "-device" command line
options, and then it may better to just use the "-serial" option and
let QEMU itself, based on the machine type, set the device
accordingly.

To achieve that, the behavior of set_console() now flags the intention
to add a console device on launch(), and if no explicit device type is
given the "-serial" option is going to be added to the QEMU command
line, instead of raising exceptions.

Based on testing with different machine types, the CONSOLE_DEV_TYPES
is not necessary anymore, so it's being removed, as is the logic to
use it.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-13-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 python/qemu/__init__.py | 50 ++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index fd144c0006..81d9657ec0 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -41,17 +41,6 @@ def kvm_available(target_arch=None):
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
 
 
-#: Maps machine types to the preferred console device types
-CONSOLE_DEV_TYPES = {
-    r'^clipper$': 'isa-serial',
-    r'^malta': 'isa-serial',
-    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
-    r'^(40p|powernv|prep)$': 'isa-serial',
-    r'^pseries.*': 'spapr-vty',
-    r'^s390-ccw-virtio.*': 'sclpconsole',
-    }
-
-
 class QEMUMachineError(Exception):
     """
     Exception called when an error in QEMUMachine happens.
@@ -130,6 +119,7 @@ class QEMUMachine(object):
         self._temp_dir = None
         self._launched = False
         self._machine = None
+        self._console_set = False
         self._console_device_type = None
         self._console_address = None
         self._console_socket = None
@@ -248,13 +238,17 @@ class QEMUMachine(object):
                 '-display', 'none', '-vga', 'none']
         if self._machine is not None:
             args.extend(['-machine', self._machine])
-        if self._console_device_type is not None:
+        if self._console_set:
             self._console_address = os.path.join(self._temp_dir,
                                                  self._name + "-console.sock")
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
-            device = '%s,chardev=console' % self._console_device_type
-            args.extend(['-chardev', chardev, '-device', device])
+            args.extend(['-chardev', chardev])
+            if self._console_device_type is None:
+                args.extend(['-serial', 'chardev:console'])
+            else:
+                device = '%s,chardev=console' % self._console_device_type
+                args.extend(['-device', device])
         return args
 
     def _pre_launch(self):
@@ -480,30 +474,20 @@ class QEMUMachine(object):
         line.
 
         This is a convenience method that will either use the provided
-        device type, of if not given, it will used the device type set
-        on CONSOLE_DEV_TYPES.
+        device type, or default to a "-serial chardev:console" command
+        line argument.
 
         The actual setting of command line arguments will be be done at
         machine launch time, as it depends on the temporary directory
         to be created.
 
-        @param device_type: the device type, such as "isa-serial"
-        @raises: QEMUMachineAddDeviceError if the device type is not given
-                 and can not be determined.
-        """
-        if device_type is None:
-            if self._machine is None:
-                raise QEMUMachineAddDeviceError("Can not add a console device:"
-                                                " QEMU instance without a "
-                                                "defined machine type")
-            for regex, device in CONSOLE_DEV_TYPES.items():
-                if re.match(regex, self._machine):
-                    device_type = device
-                    break
-            if device_type is None:
-                raise QEMUMachineAddDeviceError("Can not add a console device:"
-                                                " no matching console device "
-                                                "type definition")
+        @param device_type: the device type, such as "isa-serial".  If
+                            None is given (the default value) a "-serial
+                            chardev:console" command line argument will
+                            be used instead, resorting to the machine's
+                            default device type.
+        """
+        self._console_set = True
         self._console_device_type = device_type
 
     @property
-- 
2.18.0.rc1.1.g3f1ff2140


