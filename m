Received: from eggs.gnu.org ([2001:4830:134:3::10]:52906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etEnr-0008Qy-KT
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etEnn-0002Am-FY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:46:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etEnn-0002Ag-BJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:46:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAFE88182D2A
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 15:46:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  6 Mar 2018 15:46:50 +0000
Message-Id: <20180306154650.24075-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: include filename when printing parser
 error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Improves error messages from:

  ValueError: Error on line 72: need more than 1 value to unpack

To

  ValueError: Error at /home/berrange/src/virt/qemu/trace-events:72:
    need more than 1 value to unpack

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 scripts/simpletrace.py        | 4 ++--
 scripts/tracetool.py          | 2 +-
 scripts/tracetool/__init__.py | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index a3a6315055..fefc0806b8 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -168,7 +168,7 @@ class Analyzer(object):
 def process(events, log, analyzer, read_header=3DTrue):
     """Invoke an analyzer on each event in a log."""
     if isinstance(events, str):
-        events =3D read_events(open(events, 'r'))
+        events =3D read_events(open(events, 'r'), events)
     if isinstance(log, str):
         log =3D open(log, 'rb')
=20
@@ -233,7 +233,7 @@ def run(analyzer):
                          '<trace-file>\n' % sys.argv[0])
         sys.exit(1)
=20
-    events =3D read_events(open(sys.argv[1], 'r'))
+    events =3D read_events(open(sys.argv[1], 'r'), sys.argv[1])
     process(events, sys.argv[2], analyzer, read_header=3Dread_header)
=20
 if __name__ =3D=3D '__main__':
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index c55a21518b..fe2b0771f2 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -142,7 +142,7 @@ def main(args):
     events =3D []
     for arg in args:
         with open(arg, "r") as fh:
-            events.extend(tracetool.read_events(fh))
+            events.extend(tracetool.read_events(fh, arg))
=20
     try:
         tracetool.generate(events, arg_group, arg_format, arg_backends,
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index 52cc687ae3..b645be30d1 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -336,13 +336,15 @@ class Event(object):
                      self)
=20
=20
-def read_events(fobj):
+def read_events(fobj, fname):
     """Generate the output for the given (format, backends) pair.
=20
     Parameters
     ----------
     fobj : file
         Event description file.
+    fname : str
+        Name of event file
=20
     Returns a list of Event objects
     """
@@ -357,7 +359,7 @@ def read_events(fobj):
         try:
             event =3D Event.build(line)
         except ValueError as e:
-            arg0 =3D 'Error on line %d: %s' % (lineno, e.args[0])
+            arg0 =3D 'Error at %s:%d: %s' % (fname, lineno, e.args[0])
             e.args =3D (arg0,) + e.args[1:]
             raise
=20
--=20
2.14.3
