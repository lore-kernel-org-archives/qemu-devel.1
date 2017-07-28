Received: from eggs.gnu.org ([2001:4830:134:3::10]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1SA-00075X-0o
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db1S5-00071R-Tn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db1S5-00070n-OG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:20:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 28 Jul 2017 10:20:51 +0100
Message-Id: <20170728092053.10122-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] trace: fix trace_event_get_state() for
 SystemTap and LTTng UST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

Trace events that compute their arguments can affect performance.  The
following idom can be used to avoid computing arguments when the trace event is
disabled:

  if (trace_event_get_state(TRACE_MY_EVENT)) {
      char *str = g_strdup_printf("Expensive string ...", ...);
      trace_my_event(str);
      g_free(str);
  }

Unfortunately this breaks the trace event for SystemTap and LTTng UST since
those tracers manage their own enabled/disabled state.

These patches add per-backend dstate to trace_event_get_state() so that the
trace event fires as expected when enabled via SystemTap or LTTng UST.

Stefan Hajnoczi (2):
  trace: add TRACE_<event>_BACKEND_DSTATE()
  trace: check backend dstate in trace_event_get_state()

 trace/control.h                       | 20 ++++++++++++++++++--
 scripts/tracetool/__init__.py         |  1 +
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   | 12 ++++++++++++
 scripts/tracetool/backend/ftrace.py   |  2 +-
 scripts/tracetool/backend/log.py      |  3 ++-
 scripts/tracetool/backend/simple.py   |  2 +-
 scripts/tracetool/backend/syslog.py   |  3 ++-
 scripts/tracetool/backend/ust.py      |  5 +++++
 scripts/tracetool/format/h.py         | 10 ++++++++++
 10 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.13.3
