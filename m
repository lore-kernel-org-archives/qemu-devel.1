Received: from eggs.gnu.org ([208.118.235.92]:51106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsJ-0004zS-6f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsD-0000k0-8u
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evPsC-0000jV-Vd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:00:12 +0000
Message-Id: <20180312160014.6804-4-stefanha@redhat.com>
In-Reply-To: <20180312160014.6804-1-stefanha@redhat.com>
References: <20180312160014.6804-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] trace: include filename when printing
 parser error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Improves error messages from:

  ValueError: Error on line 72: need more than 1 value to unpack

To

  ValueError: Error at /home/berrange/src/virt/qemu/trace-events:72:
    need more than 1 value to unpack

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180306154650.24075-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py        | 4 ++--
 scripts/tracetool.py          | 2 +-
 scripts/tracetool/__init__.py | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index be3d1affaf..9d45c6ba4e 100755
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
index 3646c2b9fc..4236062650 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -291,13 +291,15 @@ class Event(object):
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
@@ -312,7 +314,7 @@ def read_events(fobj):
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
