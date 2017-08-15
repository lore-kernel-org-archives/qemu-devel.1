Received: from eggs.gnu.org ([2001:4830:134:3::10]:50036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhXSy-0002sZ-Om
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhXSv-0005yn-Lz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhXSv-0005yQ-D2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 582216C0AA
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:44:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 15 Aug 2017 09:44:30 +0100
Message-Id: <20170815084430.7128-3-stefanha@redhat.com>
In-Reply-To: <20170815084430.7128-1-stefanha@redhat.com>
References: <20170815084430.7128-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2 2/2] simpletrace: fix flight
 recorder --no-header option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The simpletrace.py script can pretty-print flight recorder ring buffers.
These are not full simpletrace binary trace files but just the end of a
trace file.  There is no header and the event ID mapping information is
often unavailable since the ring buffer may have filled up and discarded
event ID mapping records.

The simpletrace.stp script that generates ring buffer traces uses the
same trace-events-all input file as simpletrace.py.  Therefore both
scripts have the same global ordering of trace events.  A dynamic event
ID mapping isn't necessary: just use the trace-events-all file as the
reference for how event IDs are numbered.

It is now possible to analyze simpletrace.stp ring buffers again using:

  $ ./simpletrace.py trace-events-all path/to/ring-buffer

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 2a977e2ab9..a3a6315055 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -97,11 +97,17 @@ def read_trace_header(fobj):
         raise ValueError('Log format %d not supported with this QEMU release!'
                          % log_version)
 
-def read_trace_records(edict, fobj):
-    """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6)."""
-    idtoname = {
-        dropped_event_id: "dropped"
-    }
+def read_trace_records(edict, idtoname, fobj):
+    """Deserialize trace records from a file, yielding record tuples (event_num, timestamp, pid, arg1, ..., arg6).
+
+    Note that `idtoname` is modified if the file contains mapping records.
+
+    Args:
+        edict (str -> Event): events dict, indexed by name
+        idtoname (int -> str): event names dict, indexed by event ID
+        fobj (file): input file
+
+    """
     while True:
         t = fobj.read(8)
         if len(t) == 0:
@@ -171,10 +177,16 @@ def process(events, log, analyzer, read_header=True):
 
     dropped_event = Event.build("Dropped_Event(uint64_t num_events_dropped)")
     edict = {"dropped": dropped_event}
+    idtoname = {dropped_event_id: "dropped"}
 
     for event in events:
         edict[event.name] = event
 
+    # If there is no header assume event ID mapping matches events list
+    if not read_header:
+        for event_id, event in enumerate(events):
+            idtoname[event_id] = event.name
+
     def build_fn(analyzer, event):
         if isinstance(event, str):
             return analyzer.catchall
@@ -197,7 +209,7 @@ def process(events, log, analyzer, read_header=True):
 
     analyzer.begin()
     fn_cache = {}
-    for rec in read_trace_records(edict, log):
+    for rec in read_trace_records(edict, idtoname, log):
         event_num = rec[0]
         event = edict[event_num]
         if event_num not in fn_cache:
-- 
2.13.4
