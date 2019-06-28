Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89376C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FD72083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xdhD0JqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FD72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqem-0002H2-DI
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGU-0000Ch-HB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGL-0001aO-9H
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgqGK-0001Rl-Pt
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:57 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 89F6696F57;
 Fri, 28 Jun 2019 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561725941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ong44x20Rm5gt6iEZYBnbtQRmzo27WdaVQNGYbfZANU=;
 b=xdhD0JqG4sX39UDxDDrU6GJdw+AyoOhZnyHVL2P5diI2K8ZUuaqAnZgdqEY926Xx7u29eg
 tSJLpew9zXYlOn3UI0tSxQLFokmYLKj66wGKL0VGCj5Blu4bnLy2vSz+QbQSwJuV7gWVrs
 ZEZkH/cnRS8dGK9/RfS0x1hur7DR9G0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:45:33 +0200
Message-Id: <20190628124534.10679-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628124534.10679-1-damien.hedde@greensocs.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561725941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ong44x20Rm5gt6iEZYBnbtQRmzo27WdaVQNGYbfZANU=;
 b=kEIaNtXQTQGW31G4bX0llfuF/1zTSd99+QsZFKVycIKGP+vg4I1BPaeQMg+dMklMYsbAF/
 EFJ+0MiXKfhT7GoxA2Iji1locG5nT/2l6pYI2LbaSmg/d2m0I+nvPUHEQXvX0uH7Lhg1cJ
 03CLJSdb/RlUiMTDnpMiqqGAQRp5J80=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561725941; a=rsa-sha256; cv=none;
 b=UOHYaG6Qe4PK8Rx2zVozTMkIiKBrpiIUqBapzGToQYaNop/W0kYhrtAv/xK8nD9zytbto3
 g3gtbyp1bqhhtBvUyIZ726b4tj8L4yWvFuleWe/oGipAY5BOslqvJXEqa737rOzLNHGgfW
 zjKNuDcHLdVSQR1eDK0uq38TuFfmPwQ=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH 4/5] fault_injection: introduce Python
 scripting framework
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 mark.burton@greensocs.com, armbru@redhat.com, sakisp@xilinx.com,
 edgari@xilinx.com, crosa@redhat.com, pbonzini@redhat.com,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the actual Python framework.
It provides some wrappers:
  * which allow to notify a callback in a given qemu time.
  * read or write some memory location
  * read/write qom properties.
  * set a GPIO.

This is based on the work of Frederic Konrad

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 scripts/qmp/fault_injection.py | 278 +++++++++++++++++++++++++++++++++
 1 file changed, 278 insertions(+)
 create mode 100644 scripts/qmp/fault_injection.py

diff --git a/scripts/qmp/fault_injection.py b/scripts/qmp/fault_injection=
.py
new file mode 100644
index 0000000000..2d23e69d47
--- /dev/null
+++ b/scripts/qmp/fault_injection.py
@@ -0,0 +1,278 @@
+# Fault injection helper script based on top of QMP.
+#
+# Copyright (C) 2016,2019 GreenSocs SAS
+#
+# Authors:
+#   Frederic Konrad <fred.konrad@greensocs.com>
+#   Damien Hedde <damien.hedde@greensocs.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+#
+
+import json
+import ast
+import readline
+import sys
+import struct
+import os
+sys.path.append(os.path.join(os.path.dirname(__file__),
+                             '..', '..', 'python', 'qemu'))
+import qmp
+
+def die(cause):
+    print(sys.stderr.write('error: %s\n' % cause))
+    sys.exit(1)
+
+class FaultInjectionQMPError(Exception):
+    def __init__(self, rsp):
+        self.args =3D (rsp,)
+
+class FaultInjectionFramework(qmp.QEMUMonitorProtocol):
+    qemu_time =3D 0
+    verbose =3D 0
+    callback =3D {}
+    endianness =3D None
+
+    def print_v(self, msg, level):
+        if level <=3D self.verbose:
+            print(msg)
+
+    def print_qemu_version(self):
+        version =3D self._greeting['QMP']['version']['qemu']
+        print('Connected to QEMU %d.%d.%d' % (version['major'],
+                                                version['minor'],
+                                                version['micro']))
+
+    def __init__(self, address, verbose =3D 0):
+        self.verbose =3D verbose
+        qmp.QEMUMonitorProtocol.__init__(self, self.__get_address(addres=
s))
+
+        try:
+            self._greeting =3D qmp.QEMUMonitorProtocol.connect(self)
+        except qmp.QMPConnectError:
+            die('Didn\'t get QMP greeting message')
+        except qmp.QMPCapabilitiesError:
+            die('Could not negotiate capabilities')
+        except self.error:
+            die('Could not connect to %s' % address)
+
+        self.print_qemu_version()
+        self._completer =3D None
+        self._pretty =3D False
+        self._transmode =3D False
+        self._actions =3D list()
+
+    def set_endian_big(self):
+        self.endianness =3D 'big'
+
+    def set_endian_little(self):
+        self.endianness =3D 'little'
+
+    def time_print(self, arg):
+        self.print_v('%sns: %s' % (self.qemu_time, arg), 1)
+
+    def send(self, qmpcmd):
+        self.print_v(qmpcmd, 2)
+        resp =3D self.cmd_obj(qmpcmd)
+        if resp is None:
+            die('Disconnected')
+        self.print_v(resp, 2)
+        if 'error' in resp:
+            raise FaultInjectionQMPError(resp)
+        return resp
+
+    def cont(self):
+        qmpcmd =3D {'execute': 'cont', 'arguments': {}}
+        self.send(qmpcmd)
+
+    def run_once(self):
+        # RUN the simulation until one event is received
+        self.cont()
+        # Wait for an event to appear
+        done =3D False
+        while done =3D=3D False:
+            for ev in self.get_events(True):
+                self.print_v(ev, 2)
+                if ev['event'] =3D=3D 'TIME_NOTIFICATION':
+                    data =3D ev['data']
+                    self.qemu_time =3D data['time_ns'];
+                    self.callback[data['event_id']]()
+                    self.cont()
+                    done =3D True
+                elif ev['event'] =3D=3D 'SHUTDOWN':
+                    self.clear_events()
+                    return True
+        self.clear_events()
+        return False
+
+    def run(self):
+        # RUN the simulation.
+        self.time_print('Simulation is now running')
+        # Wait for an event to appear
+        shutdown_evt =3D False
+        while shutdown_evt =3D=3D False:
+            shutdown_evt =3D self.run_once()
+        self.close()
+
+    def notify(self, time_ns, cb, relative =3D False):
+        # Notify a callback at qemu time time_ns
+        next_index =3D len(self.callback)
+        elt =3D 0
+        for elt in range(0, next_index + 1):
+            if elt =3D=3D next_index:
+                break
+            if self.callback[elt] =3D=3D cb:
+                break
+
+        self.callback[elt] =3D cb
+        if relative:
+            self.time_print('Notify %s in %sns' % (cb, time_ns))
+        else:
+            self.time_print('Notify %s at %sns' % (cb, time_ns))
+        qmpcmd =3D {'execute': 'time-notify',
+                  'arguments': {'event_id': elt,
+                                'time_ns': time_ns,
+                                'pause' : True}}
+        if relative:
+            qmpcmd['arguments']['relative'] =3D True
+        self.send(qmpcmd)
+
+    def _pvmemwrite(self, virtual, address, value, cpu =3D None):
+        # write a value to a virtual or physical address
+        if type(value) is not list:
+            value =3D list(value)
+
+        self.time_print('write: @%s0x%08x size %d values ['
+                        % ('V' if virtual else 'P', address, len(value))
+                        + ','.join('%d' % i for i in value)
+                        + '] from cpu %s' % (cpu))
+        qmpcmd =3D {'execute': 'memwrite' if virtual else 'pmemwrite',
+                  'arguments': {'addr': address, 'bytes': value}}
+        if cpu is not None:
+            qmpcmd['arguments']['cpu'] =3D cpu;
+        rsp =3D self.send(qmpcmd)
+
+    def _pvmemread(self, virtual, address, size, cpu =3D None):
+        # read a value to a virtual or physical address
+
+        self.time_print('read: @%s0x%08x size %d values from cpu %s'
+                        % ('V' if virtual else 'P', address, size, cpu))
+        qmpcmd =3D {'execute': 'memread' if virtual else 'pmemread',
+                  'arguments': {'addr': address, 'size': size}}
+        if cpu is not None:
+            qmpcmd['arguments']['cpu'] =3D cpu;
+        rsp =3D self.send(qmpcmd)
+        value =3D bytearray(rsp['return']['bytes'])
+        return value
+
+    def _memstructformat(self, size):
+        if self.endianness =3D=3D 'little':
+            s =3D '<'
+        elif self.endianness =3D=3D 'big':
+            s =3D '>'
+        else:
+            #defaults to native
+            s =3D '=3D'
+        s +=3D {1:'B', 2:'H', 4:'I', 8:'Q'}[size]
+        return s
+
+    def read_mem(self, address, size, cpu =3D None):
+        fmt =3D self._memstructformat(size)
+        value =3D self._pvmemread(True, address, size, cpu)
+        return struct.unpack(fmt, value)[0]
+
+    def write_mem(self, address, size, value, cpu =3D None):
+        fmt =3D self._memstructformat(size)
+        value =3D bytearray(struct.pack(fmt, value))
+        self._pvmemwrite(True, address, value, cpu)
+
+    def read_pmem(self, address, size):
+        fmt =3D self._memstructformat(size)
+        value =3D self._pvmemread(False, address, size)
+        return struct.unpack(fmt, value)[0]
+
+    def write_pmem(self, address, size, value):
+        fmt =3D self._memstructformat(size)
+        value =3D bytearray(struct.pack(fmt, value))
+        self._pvmemwrite(False, address, value)
+
+    def get_qom_property(self, path, property):
+        # Get a QOM property
+        qmpcmd =3D {'execute': 'qom-get',
+                  'arguments': {'path': path,
+                                'property': property}}
+        value =3D self.send(qmpcmd)['return']
+        return value
+
+    def set_qom_property(self, path, property, value):
+        # Set a QOM property
+        qmpcmd =3D {'execute': 'qom-set',
+                  'arguments': {'path': path,
+                                'property': property,
+                                'value': value}}
+        self.send(qmpcmd)
+
+    def set_gpio(self, path, gpio, num, value):
+        # Set a GPIO
+        qmpcmd =3D {'execute': 'gpio-set',
+                  'arguments': {'path': path, 'value': value}}
+        if gpio is not None:
+            qmpcmd['arguments']['gpio'] =3D gpio
+        if num is not None:
+            qmpcmd['arguments']['number'] =3D num
+        self.send(qmpcmd)
+
+    def help(self):
+        msg =3D [
+            "Fault Injection Framework Commands",
+            "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+            "cont()",
+            " * Resume the simulation when the Virtual Machine is stoppe=
d.\n",
+            "run()",
+            " * Start the simulation when the notify are set.\n",
+            "notify(delta_ns, cb)",
+            " * Notify the callback cb in guest time delta_ns.\n",
+            "write_mem(address, size, value, cpu)",
+            " * write @value of size @size at virtual @address from @cpu=
.",
+            " * @size is in bytes, supported values are 1, 2, 4 and 8.",
+            " * @cpu is the cpu id.\n",
+            "read_mem(address, size, cpu)",
+            " * read a value of size @size at virtual @address from @cpu=
.",
+            " * @size is in bytes, supported values are 1, 2, 4 and 8.",
+            " * @cpu is the cpu id.",
+            " * returns the value.\n",
+            "write_pmem(address, size, value)",
+            " * write @value of size @size at physical @address.",
+            " * @size is in bytes, supported values are 1, 2, 4 and 8.\n=
",
+            "read_pmem(address, size)",
+            " * read a value of size @size at physical @address.",
+            " * @size is in bytes, supported values are 1, 2, 4 and 8.",
+            " * returns the value.\n",
+            "get_qom_property(path, property)",
+            " * Get a qom property.",
+            " * Returns the qom property named @property in @path.\n",
+            "set_qom_property(path, property, value)",
+            " * Set the property named @property in @path with @value.\n=
",
+            "set_gpio(path, gpio, num, value)",
+            " * Set the gpio named @gpio number @num in @path with the @=
val.",
+            " * @val is a boolean.\n"
+            ]
+        for m in msg:
+            print(m)
+
+    def __get_address(self, arg):
+        """
+        Figure out if the argument is in the port:host form, if it's not=
 it's
+        probably a file path.
+        """
+        addr =3D arg.split(':')
+        if len(addr) =3D=3D 2:
+            try:
+                port =3D int(addr[1])
+            except ValueError:
+                raise QMPShellBadPort
+            return ( addr[0], port )
+        # socket path
+        return arg
+
--=20
2.22.0


