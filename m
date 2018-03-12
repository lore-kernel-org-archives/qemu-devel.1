Received: from eggs.gnu.org ([208.118.235.92]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsF-0004wD-UI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsB-0000iL-Op
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evPsB-0000hT-K4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:00:11 +0000
Message-Id: <20180312160014.6804-3-stefanha@redhat.com>
In-Reply-To: <20180312160014.6804-1-stefanha@redhat.com>
References: <20180312160014.6804-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] simpletrace: fix timestamp argument type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The timestamp argument to a trace event method is documented as follows:

  The method can also take a timestamp argument before the trace event
  arguments:

    def runstate_set(self, timestamp, new_state):
        ...

  Timestamps have the uint64_t type and are in nanoseconds.

In reality methods with a timestamp argument actually receive a tuple
like (123456789,) as the timestamp argument.  This is due to a bug in
simpletrace.py.

This patch unpacks the tuple so that methods receive the correct
timestamp argument type.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180222163901.14095-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/simpletrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index a3a6315055..be3d1affaf 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -199,7 +199,7 @@ def process(events, log, analyzer, read_header=True):
         fn_argcount = len(inspect.getargspec(fn)[0]) - 1
         if fn_argcount == event_argcount + 1:
             # Include timestamp as first argument
-            return lambda _, rec: fn(*((rec[1:2],) + rec[3:3 + event_argcount]))
+            return lambda _, rec: fn(*(rec[1:2] + rec[3:3 + event_argcount]))
         elif fn_argcount == event_argcount + 2:
             # Include timestamp and pid
             return lambda _, rec: fn(*rec[1:3 + event_argcount])
-- 
2.14.3
