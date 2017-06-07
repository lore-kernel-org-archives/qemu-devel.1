Received: from eggs.gnu.org ([2001:4830:134:3::10]:42013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIg7R-0003eH-3y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dIg7O-00073U-0e
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dIg7N-000733-QL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:55:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Jun 2017 19:55:05 +0100
Message-Id: <20170607185505.12542-2-stefanha@redhat.com>
In-Reply-To: <20170607185505.12542-1-stefanha@redhat.com>
References: <20170607185505.12542-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 1/1] simpletrace: Improve the error
 message if event is not declared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

Today, if we use a trace-event file which does not declare an event
existing in the log file we'll get the following error:

$ scripts/simpletrace.py trace-events trace-68508
Traceback (most recent call last):
  File "scripts/simpletrace.py", line 242, in <module>
    run(Formatter())
  File "scripts/simpletrace.py", line 217, in run
    process(events, sys.argv[2], analyzer, read_header=3Dread_header)
  File "scripts/simpletrace.py", line 192, in process
    for rec in read_trace_records(edict, log):
  File "scripts/simpletrace.py", line 107, in read_trace_records
    rec =3D read_record(edict, idtoname, fobj)
  File "scripts/simpletrace.py", line 71, in read_record
    return get_record(edict, idtoname, rechdr, fobj)
  File "scripts/simpletrace.py", line 45, in get_record
    event =3D edict[name]
KeyError: 'qemu_mutex_locked'

This patch improves this error by adding a hint instead of just that
KeyError log:

$ scripts/simpletrace.py trace-events trace-68508
'qemu_mutex_locked' event is logged but is not declared in the trace
events file, try using trace-events-all instead.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index d60b3a0..f1be6e4 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -42,7 +42,15 @@ def get_record(edict, idtoname, rechdr, fobj):
         event_id =3D rechdr[0]
         name =3D idtoname[event_id]
         rec =3D (name, rechdr[1], rechdr[3])
-        event =3D edict[name]
+        try:
+            event =3D edict[name]
+        except KeyError, e:
+            import sys
+            sys.stderr.write('%s event is logged but is not declared ' \
+                             'in the trace events file, try using ' \
+                             'trace-events-all instead.\n' % str(e))
+            sys.exit(1)
+
         for type, name in event.args:
             if is_string(type):
                 l =3D fobj.read(4)
--=20
2.9.4
