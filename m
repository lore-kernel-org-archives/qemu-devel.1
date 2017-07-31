Received: from eggs.gnu.org ([2001:4830:134:3::10]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcBM2-0008G0-2Q
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcBLy-0006Hp-3Y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcBLx-0006Ed-T5
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:07:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 31 Jul 2017 15:07:16 +0100
Message-Id: <20170731140718.22010-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] trace: fix trace_event_get_state() for
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
Cc: "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Don't special-case QEMU dstate [Daniel Berrange]
 * Use _backends() postfix to clarify function purpose [Llu=C3=ADs]

Trace events that compute their arguments can affect performance.  The
following idom can be used to avoid computing arguments when the trace ev=
ent is
disabled:

  if (trace_event_get_state(TRACE_MY_EVENT)) {
      char *str =3D g_strdup_printf("Expensive string ...", ...);
      trace_my_event(str);
      g_free(str);
  }

Unfortunately this breaks the trace event for SystemTap and LTTng UST sin=
ce
those tracers manage their own enabled/disabled state.

These patches add per-backend dstate to trace_event_get_state() so that t=
he
trace event fires as expected when enabled via SystemTap or LTTng UST.

Stefan Hajnoczi (2):
  trace: add TRACE_<event>_BACKEND_DSTATE()
  trace: add trace_event_get_state_backends()

 docs/devel/tracing.txt                |  2 +-
 trace/control.h                       | 18 +++++++++++++++++-
 hw/usb/hcd-ohci.c                     | 13 +++++--------
 net/colo-compare.c                    | 11 ++++++-----
 net/filter-rewriter.c                 |  4 ++--
 scripts/tracetool/__init__.py         |  1 +
 scripts/tracetool/backend/__init__.py |  3 +++
 scripts/tracetool/backend/dtrace.py   | 12 ++++++++++++
 scripts/tracetool/backend/ftrace.py   |  5 +++++
 scripts/tracetool/backend/log.py      |  5 +++++
 scripts/tracetool/backend/simple.py   |  5 +++++
 scripts/tracetool/backend/syslog.py   |  5 +++++
 scripts/tracetool/backend/ust.py      |  5 +++++
 scripts/tracetool/format/h.py         | 10 ++++++++++
 14 files changed, 82 insertions(+), 17 deletions(-)

--=20
2.13.3
