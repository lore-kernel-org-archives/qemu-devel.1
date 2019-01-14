Received: from eggs.gnu.org ([209.51.188.92]:57631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54V-0003oS-Ju
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54U-0005OG-JM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:55 -0600
Message-Id: <20190114162605.5330-11-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/20] iotests: implement pretty-print for log
 and qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

If iotests have lines exceeding >998 characters long, git doesn't
want to send it plaintext to the list. We can solve this by allowing
the iotests to use pretty printed QMP output that we can match against
instead.

As a bonus, it's much nicer for human eyes too.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-11-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index a96a7010d49..cbedfaf1df6 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -288,13 +288,18 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)

-def log(msg, filters=3D[]):
+def log(msg, filters=3D[], indent=3DNone):
+    '''Logs either a string message or a JSON serializable message (like=
 QMP).
+    If indent is provided, JSON serializable messages are pretty-printed=
.'''
     for flt in filters:
         msg =3D flt(msg)
     if isinstance(msg, dict) or isinstance(msg, list):
+        # Python < 3.4 needs to know not to add whitespace when pretty-p=
rinting:
+        separators =3D (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
         do_sort =3D not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=3Ddo_sort))
+        print(json.dumps(msg, sort_keys=3Ddo_sort,
+                         indent=3Dindent, separators=3Dseparators))
     else:
         print(msg)

@@ -483,14 +488,14 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result

-    def qmp_log(self, cmd, filters=3D[], **kwargs):
+    def qmp_log(self, cmd, filters=3D[], indent=3DNone, **kwargs):
         full_cmd =3D OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
         ))
-        log(full_cmd, filters)
+        log(full_cmd, filters, indent=3Dindent)
         result =3D self.qmp(cmd, **kwargs)
-        log(result, filters)
+        log(result, filters, indent=3Dindent)
         return result

     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse):
--=20
2.20.1
