Received: from eggs.gnu.org ([2001:4830:134:3::10]:35670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dFNYm-0004iP-OL
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dFNYj-0000hJ-Js
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38814
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dFNYj-0000gq-ES
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:30:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4TGTmSS083579
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 12:30:19 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2arha4pdsg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 12:30:19 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 29 May 2017 13:30:17 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 29 May 2017 13:30:04 -0300
Message-Id: <1496075404-8845-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] simpletrace: Improve the error message if
 event is not declared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Today, if we use a trace-event file which does not declare an event
existing in the log file we'll get the following error:

$ scripts/simpletrace.py trace-events trace-68508
Traceback (most recent call last):
  File "scripts/simpletrace.py", line 242, in <module>
    run(Formatter())
  File "scripts/simpletrace.py", line 217, in run
    process(events, sys.argv[2], analyzer, read_header=read_header)
  File "scripts/simpletrace.py", line 192, in process
    for rec in read_trace_records(edict, log):
  File "scripts/simpletrace.py", line 107, in read_trace_records
    rec = read_record(edict, idtoname, fobj)
  File "scripts/simpletrace.py", line 71, in read_record
    return get_record(edict, idtoname, rechdr, fobj)
  File "scripts/simpletrace.py", line 45, in get_record
    event = edict[name]
KeyError: 'qemu_mutex_locked'

This patch improves this error by adding a hint instead of just that
KeyError log:

$ scripts/simpletrace.py trace-events trace-68508
'qemu_mutex_locked' event is logged but is not declared in the trace
events file, try using trace-events-all instead.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 scripts/simpletrace.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index d60b3a0..f1be6e4 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -42,7 +42,15 @@ def get_record(edict, idtoname, rechdr, fobj):
         event_id = rechdr[0]
         name = idtoname[event_id]
         rec = (name, rechdr[1], rechdr[3])
-        event = edict[name]
+        try:
+            event = edict[name]
+        except KeyError, e:
+            import sys
+            sys.stderr.write('%s event is logged but is not declared ' \
+                             'in the trace events file, try using ' \
+                             'trace-events-all instead.\n' % str(e))
+            sys.exit(1)
+
         for type, name in event.args:
             if is_string(type):
                 l = fobj.read(4)
-- 
2.7.4
