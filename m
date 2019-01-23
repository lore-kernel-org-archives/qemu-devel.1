Received: from eggs.gnu.org ([209.51.188.92]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHOq-0002Ua-Cp
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmHCw-0003rN-GL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmHCw-0003qu-7U
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:00:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80171C04BD2F
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:00:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 23 Jan 2019 12:00:16 +0000
Message-Id: <20190123120016.4538-5-berrange@redhat.com>
In-Reply-To: <20190123120016.4538-1-berrange@redhat.com>
References: <20190123120016.4538-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/4] trace: add ability to do simple printf
 logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The dtrace systemtap trace backend for QEMU is very powerful but it is
also somewhat unfriendly to users who aren't familiar with systemtap,
or who don't need its power right now.

  stap -e "....some strange script...."

The 'log' backend for QEMU by comparison is very crude but incredibly
easy to use:

 $ qemu -d trace:qio* ...some args...
 23266@1547735759.137292:qio_channel_socket_new Socket new ioc=3D0x563a8a=
39d400
 23266@1547735759.137305:qio_task_new Task new task=3D0x563a891d0570 sour=
ce=3D0x563a8a39d400 func=3D0x563a86f1e6c0 opaque=3D0x563a89078000
 23266@1547735759.137326:qio_task_thread_start Task thread start task=3D0=
x563a891d0570 worker=3D0x563a86f1ce50 opaque=3D0x563a891d9d90
 23273@1547735759.137491:qio_task_thread_run Task thread run task=3D0x563=
a891d0570
 23273@1547735759.137503:qio_channel_socket_connect_sync Socket connect s=
ync ioc=3D0x563a8a39d400 addr=3D0x563a891d9d90
 23273@1547735759.138108:qio_channel_socket_connect_fail Socket connect f=
ail ioc=3D0x563a8a39d400

This commit introduces a way to do simple printf style logging of probe
points using systemtap. In particular it creates another set of tapsets,
one per emulator:

  /usr/share/systemtap/tapset/qemu-*-log.stp

These pre-define probe functions which simply call printf() on their
arguments. The printf() format string is taken from the normal
trace-events files, with a little munging to the format specifiers
to cope with systemtap's more restrictive syntax.

With this you can now do

 $ stap -e 'probe qemu.system.x86_64.log.qio*{}'
 22806@1547735341399856820 qio_channel_socket_new Socket new ioc=3D0x5613=
5d1d7c00
 22806@1547735341399862570 qio_task_new Task new task=3D0x56135cd66eb0 so=
urce=3D0x56135d1d7c00 func=3D0x56135af746c0 opaque=3D0x56135bf06400
 22806@1547735341399865943 qio_task_thread_start Task thread start task=3D=
0x56135cd66eb0 worker=3D0x56135af72e50 opaque=3D0x56135c071d70
 22806@1547735341399976816 qio_task_thread_run Task thread run task=3D0x5=
6135cd66eb0

We go one step further though and introduce a 'qemu-trace-stap' tool to
make this even easier

 $ qemu-trace-stap run qemu-system-x86_64 'qio*'
 22806@1547735341399856820 qio_channel_socket_new Socket new ioc=3D0x5613=
5d1d7c00
 22806@1547735341399862570 qio_task_new Task new task=3D0x56135cd66eb0 so=
urce=3D0x56135d1d7c00 func=3D0x56135af746c0 opaque=3D0x56135bf06400
 22806@1547735341399865943 qio_task_thread_start Task thread start task=3D=
0x56135cd66eb0 worker=3D0x56135af72e50 opaque=3D0x56135c071d70
 22806@1547735341399976816 qio_task_thread_run Task thread run task=3D0x5=
6135cd66eb0

This tool is clever in that it will automatically change the
SYSTEMTAP_TAPSET env variable to point to the directory containing the
right set of probes for the QEMU binary path you give it. This is useful
if you have QEMU installed in /usr but are trying to test and trace a
binary in /home/berrange/usr/qemu-git. In that case you'd do

 $ qemu-trace-stap run /home/berrange/usr/qemu-git/bin/qemu-system-x86_64=
 'qio*'

And it'll make sure /home/berrange/usr/qemu-git/share/systemtap/tapset
is used for the trace session

The 'qemu-trace-stap' script takes a verbose arg so you can understand
what it is running

 $ qemu-trace-stap run /home/berrange/usr/qemu-git/bin/qemu-system-x86_64=
 'qio*'
 Using tapset dir '/home/berrange/usr/qemu-git/share/systemtap/tapset' fo=
r binary '/home/berrange/usr/qemu-git/bin/qemu-system-x86_64'
 Compiling script 'probe qemu.system.x86_64.log.qio* {}'
 Running script, <Ctrl>-c to quit
 ...trace output...

It can enable multiple probes at once

 $ qemu-trace-stap run qemu-system-x86_64 'qio*' 'qcrypto*' 'buffer*'

By default it monitors all existing running processes and all future
launched proceses. This can be restricted to a specific PID using the
--pid arg

 $ qemu-trace-stap run --pid 2532 qemu-system-x86_64 'qio*'

Finally if you can't remember what probes are valid it can tell you

 $ qemu-trace-stap list qemu-system-x86_64
 ahci_check_irq
 ahci_cmd_done
 ahci_dma_prepare_buf
 ahci_dma_prepare_buf_fail
 ahci_dma_rw_buf
 ahci_irq_lower
 ...snip...

Or list just those matching a prefix pattern

 $ qemu-trace-stap list -v qemu-system-x86_64 'qio*'
 Using tapset dir '/home/berrange/usr/qemu-git/share/systemtap/tapset' fo=
r binary '/home/berrange/usr/qemu-git/bin/qemu-system-x86_64'
 Listing probes with name 'qemu.system.x86_64.log.qio*'
 qio_channel_command_abort
 qio_channel_command_new_pid
 qio_channel_command_new_spawn
 qio_channel_command_wait
 qio_channel_file_new_fd
 ...snip...

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS                          |   1 +
 Makefile                             |  10 ++
 Makefile.target                      |  11 +-
 docs/devel/tracing.txt               |   4 +
 scripts/qemu-trace-stap              | 175 +++++++++++++++++++++++++++
 scripts/qemu-trace-stap.texi         | 140 +++++++++++++++++++++
 scripts/tracetool/format/log_stap.py | 127 +++++++++++++++++++
 7 files changed, 467 insertions(+), 1 deletion(-)
 create mode 100755 scripts/qemu-trace-stap
 create mode 100644 scripts/qemu-trace-stap.texi
 create mode 100644 scripts/tracetool/format/log_stap.py

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..efa42c79fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2017,6 +2017,7 @@ F: trace-events
 F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
+F: scripts/qemu-trace-stap*
 F: docs/devel/tracing.txt
 T: git https://github.com/stefanha/qemu.git tracing
=20
diff --git a/Makefile b/Makefile
index 4219624fa0..d360f49069 100644
--- a/Makefile
+++ b/Makefile
@@ -305,6 +305,9 @@ DOCS+=3Ddocs/qemu-cpu-models.7
 ifdef CONFIG_VIRTFS
 DOCS+=3Dfsdev/virtfs-proxy-helper.1
 endif
+ifdef CONFIG_TRACE_SYSTEMTAP
+DOCS+=3Dscripts/qemu-trace-stap.1
+endif
 else
 DOCS=3D
 endif
@@ -700,6 +703,9 @@ ifneq ($(TOOLS),)
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) qemu-nbd.8 "$(DESTDIR)$(mandir)/man8"
 endif
+ifdef CONFIG_TRACE_SYSTEMTAP
+	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
+endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)=
"
@@ -738,6 +744,9 @@ endif
 ifneq ($(HELPERS-y),)
 	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
 endif
+ifdef CONFIG_TRACE_SYSTEMTAP
+	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
+endif
 ifneq ($(BLOBS),)
 	set -e; for x in $(BLOBS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
@@ -838,6 +847,7 @@ qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
 docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
+scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
=20
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info
diff --git a/Makefile.target b/Makefile.target
index 39f72e81be..401dc1ea6f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -45,7 +45,7 @@ config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
=20
 ifdef CONFIG_TRACE_SYSTEMTAP
-stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletra=
ce.stp
+stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletra=
ce.stp $(QEMU_PROG)-log.stp
=20
 ifdef CONFIG_USER_ONLY
 TARGET_TYPE=3Duser
@@ -84,6 +84,14 @@ $(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-event=
s-all $(tracetool-y)
 		--probe-prefix=3Dqemu.$(TARGET_TYPE).$(TARGET_NAME) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-simpletrace.stp")
=20
+$(QEMU_PROG)-log.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=3Dall \
+		--format=3Dlog-stap \
+		--backends=3D$(TRACE_BACKENDS) \
+		--probe-prefix=3Dqemu.$(TARGET_TYPE).$(TARGET_NAME) \
+		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG)-log.stp")
+
 else
 stap:
 endif
@@ -227,6 +235,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
 	$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/.=
./systemtap/tapset/$(QEMU_PROG).stp"
 	$(INSTALL_DATA) $(QEMU_PROG)-simpletrace.stp "$(DESTDIR)$(qemu_datadir)=
/../systemtap/tapset/$(QEMU_PROG)-simpletrace.stp"
+	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../syst=
emtap/tapset/$(QEMU_PROG)-log.stp"
 endif
=20
 GENERATED_FILES +=3D config-target.h
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index bc52f12485..056aa56496 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -317,6 +317,10 @@ probes:
                          --target-name x86_64 \
                          <trace-events-all >qemu.stp
=20
+To facilitate simple usage of systemtap where there merely needs to be p=
rintf
+logging of certain probes, a helper script "qemu-trace-stap" is provided=
.
+Consult its manual page for guidance on its usage.
+
 =3D=3D Trace event properties =3D=3D
=20
 Each event in the "trace-events-all" file can be prefixed with a space-s=
eparated
diff --git a/scripts/qemu-trace-stap b/scripts/qemu-trace-stap
new file mode 100755
index 0000000000..91d1051cdc
--- /dev/null
+++ b/scripts/qemu-trace-stap
@@ -0,0 +1,175 @@
+#!/usr/bin/python
+# -*- python -*-
+#
+# Copyright (C) 2019 Red Hat, Inc
+#
+# QEMU SystemTap Trace Tool
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+from __future__ import print_function
+
+import argparse
+import copy
+import os.path
+import re
+import subprocess
+import sys
+
+
+def probe_prefix(binary):
+    dirname, filename =3D os.path.split(binary)
+    return re.sub("-", ".", filename) + ".log"
+
+
+def which(binary):
+    for path in os.environ["PATH"].split(os.pathsep):
+        if os.path.exists(os.path.join(path, binary)):
+                return os.path.join(path, binary)
+
+    print("Unable to find '%s' in $PATH" % binary)
+    sys.exit(1)
+
+
+def tapset_dir(binary):
+    dirname, filename =3D os.path.split(binary)
+    if dirname =3D=3D '':
+        thisfile =3D which(binary)
+    else:
+        thisfile =3D os.path.realpath(binary)
+        if not os.path.exists(thisfile):
+            print("Unable to find '%s'" % thisfile)
+            sys.exit(1)
+
+    basedir =3D os.path.split(thisfile)[0]
+    tapset =3D os.path.join(basedir, "..", "share", "systemtap", "tapset=
")
+    return os.path.realpath(tapset)
+
+
+def tapset_env(tapset_dir):
+    tenv =3D copy.copy(os.environ)
+    tenv["SYSTEMTAP_TAPSET"] =3D tapset_dir
+    return tenv
+
+def cmd_run(args):
+    prefix =3D probe_prefix(args.binary)
+    tapsets =3D tapset_dir(args.binary)
+
+    if args.verbose:
+        print("Using tapset dir '%s' for binary '%s'" % (tapsets, args.b=
inary))
+
+    probes =3D []
+    for probe in args.probes:
+        probes.append("probe %s.%s {}" % (prefix, probe))
+    if len(probes) =3D=3D 0:
+        print("At least one probe pattern must be specified")
+        sys.exit(1)
+
+    script =3D " ".join(probes)
+    if args.verbose:
+        print("Compiling script '%s'" % script)
+        script =3D """probe begin { print("Running script, <Ctrl>-c to q=
uit\\n") } """ + script
+
+    # We request an 8MB buffer, since the stap default 1MB buffer
+    # can be easily overflowed by frequently firing QEMU traces
+    stapargs =3D ["stap", "-s", "8"]
+    if args.pid is not None:
+        stapargs.extend(["-x", args.pid])
+    stapargs.extend(["-e", script])
+    subprocess.call(stapargs, env=3Dtapset_env(tapsets))
+
+
+def cmd_list(args):
+    tapsets =3D tapset_dir(args.binary)
+
+    if args.verbose:
+        print("Using tapset dir '%s' for binary '%s'" % (tapsets, args.b=
inary))
+
+    def print_probes(verbose, name):
+        prefix =3D probe_prefix(args.binary)
+        offset =3D len(prefix) + 1
+        script =3D prefix + "." + name
+
+        if verbose:
+            print("Listing probes with name '%s'" % script)
+        proc =3D subprocess.Popen(["stap", "-l", script],
+                                stdout=3Dsubprocess.PIPE, env=3Dtapset_e=
nv(tapsets))
+        out, err =3D proc.communicate()
+        if proc.returncode !=3D 0:
+            print("No probes found, are the tapsets installed in %s" % t=
apset_dir(args.binary))
+            sys.exit(1)
+
+        for line in out.splitlines():
+            if line.startswith(prefix):
+                print("%s" % line[offset:])
+
+    if len(args.probes) =3D=3D 0:
+        print_probes(args.verbose, "*")
+    else:
+        for probe in args.probes:
+            print_probes(args.verbose, probe)
+
+
+def main():
+    parser =3D argparse.ArgumentParser(description=3D"QEMU SystemTap tra=
ce tool")
+    parser.add_argument("-v", "--verbose", help=3D"Print verbose progres=
s info",
+                        action=3D'store_true')
+
+    subparser =3D parser.add_subparsers(help=3D"commands")
+    subparser.required =3D True
+    subparser.dest =3D "command"
+
+    runparser =3D subparser.add_parser("run", help=3D"Run a trace sessio=
n",
+                                     formatter_class=3Dargparse.RawDescr=
iptionHelpFormatter,
+                                     epilog=3D"""
+
+To watch all trace points on the qemu-system-x86_64 binary:
+
+   %(argv0)s run qemu-system-x86_64
+
+To only watch the trace points matching the qio* and qcrypto* patterns
+
+   %(argv0)s run qemu-system-x86_64 'qio*' 'qcrypto*'
+""" % {"argv0": sys.argv[0]})
+    runparser.set_defaults(func=3Dcmd_run)
+    runparser.add_argument("--pid", "-p", dest=3D"pid",
+                           help=3D"Restrict tracing to a specific proces=
s ID")
+    runparser.add_argument("binary", help=3D"QEMU system or user emulato=
r binary")
+    runparser.add_argument("probes", help=3D"Probe names or wildcards",
+                           nargs=3Dargparse.REMAINDER)
+
+    listparser =3D subparser.add_parser("list", help=3D"List probe point=
s",
+                                      formatter_class=3Dargparse.RawDesc=
riptionHelpFormatter,
+                                      epilog=3D"""
+
+To list all trace points on the qemu-system-x86_64 binary:
+
+   %(argv0)s list qemu-system-x86_64
+
+To only list the trace points matching the qio* and qcrypto* patterns
+
+   %(argv0)s list qemu-system-x86_64 'qio*' 'qcrypto*'
+""" % {"argv0": sys.argv[0]})
+    listparser.set_defaults(func=3Dcmd_list)
+    listparser.add_argument("binary", help=3D"QEMU system or user emulat=
or binary")
+    listparser.add_argument("probes", help=3D"Probe names or wildcards",
+                            nargs=3Dargparse.REMAINDER)
+
+    args =3D parser.parse_args()
+
+    args.func(args)
+    sys.exit(0)
+
+if __name__ =3D=3D '__main__':
+    main()
diff --git a/scripts/qemu-trace-stap.texi b/scripts/qemu-trace-stap.texi
new file mode 100644
index 0000000000..07bb9eb94e
--- /dev/null
+++ b/scripts/qemu-trace-stap.texi
@@ -0,0 +1,140 @@
+@example
+@c man begin SYNOPSIS
+@command{qemu-trace-stap} @var{GLOBAL-OPTIONS} @var{COMMAND} @var{COMMAN=
D-OPTIONS} @var{ARGS...}
+@c man end
+@end example
+
+@c man begin DESCRIPTION
+
+The @command{qemu-trace-stap} program facilitates tracing of the executi=
on
+of QEMU emulators using SystemTap.
+
+It is required to have the SystemTap runtime environment installed to us=
e
+this program, since it is a wrapper around execution of the @command{sta=
p}
+program.
+
+@c man end
+
+@c man begin OPTIONS
+
+The following global options may be used regardless of which command
+is executed:
+
+@table @option
+@item @var{--verbose}, @var{-v}
+
+Display verbose information about command execution.
+
+@end table
+
+The following commands are valid:
+
+@table @option
+
+@item @var{list} @var{BINARY} @var{PATTERN...}
+
+List all the probe names provided by @var{BINARY} that match
+@var{PATTERN}.
+
+If @var{BINARY} is not an absolute path, it will be located by searching
+the directories listed in the @code{$PATH} environment variable.
+
+@var{PATTERN} is a plain string that is used to filter the results of
+this command. It may optionally contain a @code{*} wildcard to facilitat=
e
+matching multiple probes without listing each one explicitly. Multiple
+@var{PATTERN} arguments may be given, causing listing of probes that mat=
ch
+any of the listed names. If no @var{PATTERN} is given, the all possible
+probes will be listed.
+
+For example, to list all probes available in the @command{qemu-system-x8=
6_64}
+binary:
+
+@example
+$ qemu-trace-stap list qemu-system-x86_64
+@end example
+
+To filter the list to only cover probes related to QEMU's cryptographic
+subsystem, in a binary outside @code{$PATH}
+
+@example
+$ qemu-trace-stap list /opt/qemu/4.0.0/bin/qemu-system-x86_64 'qcrypto*'
+@end example
+
+
+@item @var{run} @var{OPTIONS} @var{BINARY} @var{PATTERN...}
+
+Run a trace session, printing formatted output any time a process that i=
s
+executing @var{BINARY} triggers a probe matching @var{PATTERN}.
+
+If @var{BINARY} is not an absolute path, it will be located by searching
+the directories listed in the @code{$PATH} environment variable.
+
+@var{PATTERN} is a plain string that matches a probe name shown by the
+@var{list} command. It may optionally contain a @code{*} wildcard to
+facilitate matching multiple probes without listing each one explicitly.
+Multiple @var{PATTERN} arguments may be given, causing all matching prob=
es
+to be monitored. At least one @var{PATTERN} is required, since stap is n=
ot
+capable of tracing all known QEMU probes concurrently without overflowin=
g
+its trace buffer.
+
+Invocation of this command does not need to be synchronized with
+invocation of the QEMU process(es). It will match probes on all
+existing running processes and all future launched processes,
+unless told to only monitor a specific process.
+
+Valid command specific options are:
+
+@table @option
+@item @var{--pid=3DPID}, @var{-p PID}
+
+Restrict the tracing session so that it only triggers for the process
+identified by @code{PID}.
+
+@end table
+
+For example, to monitor all processes executing @command{qemu-system-x86=
_64}
+as found on $PATH, displaying all I/O related probes:
+
+@example
+$ qemu-trace-stap run qemu-system-x86_64 'qio*'
+@end example
+
+To monitor only the QEMU process with PID 1732
+
+@example
+$ qemu-trace-stap run --pid=3D1732 qemu-system-x86_64 'qio*'
+@end example
+
+To monitor QEMU processes running an alternative binary outside of
+@code{$PATH}, displaying verbose information about setup of the
+tracing environment:
+
+@example
+$ qemu-trace-stap -v run /opt/qemu/4.0.0/qemu-system-x86_64 'qio*'
+@end example
+
+@end table
+
+@c man end
+
+@ignore
+
+@setfilename qemu-trace-stap
+@settitle QEMU SystemTap trace tool
+
+@c man begin LICENSE
+
+Copyright (C) 2019 Red Hat, Inc.
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+
+@c man end
+
+@c man begin SEEALSO
+qemu(1), stap(1)
+@c man end
+
+@end ignore
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/for=
mat/log_stap.py
new file mode 100644
index 0000000000..3ccbc09d61
--- /dev/null
+++ b/scripts/tracetool/format/log_stap.py
@@ -0,0 +1,127 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+
+"""
+Generate .stp file that printfs log messages (DTrace with SystemTAP only=
).
+"""
+
+__author__     =3D "Daniel P. Berrange <berrange@redhat.com>"
+__copyright__  =3D "Copyright (C) 2014-2019, Red Hat, Inc."
+__license__    =3D "GPL version 2 or (at your option) any later version"
+
+__maintainer__ =3D "Daniel Berrange"
+__email__      =3D "berrange@redhat.com"
+
+import re
+
+from tracetool import out
+from tracetool.backend.dtrace import binary, probeprefix
+from tracetool.backend.simple import is_string
+from tracetool.format.stap import stap_escape
+
+def global_var_name(name):
+    return probeprefix().replace(".", "_") + "_" + name
+
+STATE_SKIP =3D 0
+STATE_LITERAL =3D 1
+STATE_MACRO =3D 2
+
+def c_macro_to_format(macro):
+    if macro.startswith("PRI"):
+        return macro[3]
+
+    if macro =3D=3D "TARGET_FMT_plx":
+        return "%016x"
+
+    raise Exception("Unhandled macro '%s'" % macro)
+
+def c_fmt_to_stap(fmt):
+    state =3D 0
+    bits =3D []
+    literal =3D ""
+    macro =3D ""
+    escape =3D 0;
+    for i in range(len(fmt)):
+        if fmt[i] =3D=3D '\\':
+            if escape:
+                escape =3D 0
+            else:
+                escape =3D 1
+            if state !=3D STATE_LITERAL:
+                raise Exception("Unexpected escape outside string litera=
l")
+            literal =3D literal + fmt[i]
+        elif fmt[i] =3D=3D '"' and not escape:
+            if state =3D=3D STATE_LITERAL:
+                state =3D STATE_SKIP
+                bits.append(literal)
+                literal =3D ""
+            else:
+                if state =3D=3D STATE_MACRO:
+                    bits.append(c_macro_to_format(macro))
+                state =3D STATE_LITERAL
+        elif fmt[i] =3D=3D ' ' or fmt[i] =3D=3D '\t':
+            if state =3D=3D STATE_MACRO:
+                bits.append(c_macro_to_format(macro))
+                macro =3D ""
+                state =3D STATE_SKIP
+            elif state =3D=3D STATE_LITERAL:
+                literal =3D literal + fmt[i]
+        else:
+            escape =3D 0
+            if state =3D=3D STATE_SKIP:
+                state =3D STATE_MACRO
+
+            if state =3D=3D STATE_LITERAL:
+                literal =3D literal + fmt[i]
+            else:
+                macro =3D macro + fmt[i]
+
+    if state =3D=3D STATE_MACRO:
+        bits.append(c_macro_to_format(macro))
+    elif state =3D=3D STATE_LITERAL:
+        bits.append(literal)
+
+    fmt =3D re.sub("%(\d*)z(x|u|d)", "%\\1\\2", "".join(bits))
+    return fmt
+
+def generate(events, backend, group):
+    out('/* This file is autogenerated by tracetool, do not edit. */',
+        '')
+
+    for event_id, e in enumerate(events):
+        if 'disable' in e.properties:
+            continue
+
+        out('probe %(probeprefix)s.log.%(name)s =3D %(probeprefix)s.%(na=
me)s ?',
+            '{',
+            probeprefix=3Dprobeprefix(),
+            name=3De.name)
+
+        # Get references to userspace strings
+        for type_, name in e.args:
+            name =3D stap_escape(name)
+            if is_string(type_):
+                out('    try {',
+                    '        arg%(name)s_str =3D %(name)s ? ' +
+                    'user_string_n(%(name)s, 512) : "<null>"',
+                    '    } catch {}',
+                    name=3Dname)
+
+        # Determine systemtap's view of variable names
+        fields =3D ["pid()", "gettimeofday_ns()"]
+        for type_, name in e.args:
+            name =3D stap_escape(name)
+            if is_string(type_):
+                fields.append("arg" + name + "_str")
+            else:
+                fields.append(name)
+
+        # Emit the entire record in a single SystemTap printf()
+        arg_str =3D ', '.join(arg for arg in fields)
+        fmt_str =3D "%d@%d " + e.name + " " + c_fmt_to_stap(e.fmt) + "\\=
n"
+        out('    printf("%(fmt_str)s", %(arg_str)s)',
+            fmt_str=3Dfmt_str, arg_str=3Darg_str)
+
+        out('}')
+
+    out()
--=20
2.20.1
