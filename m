Received: from eggs.gnu.org ([2001:4830:134:3::10]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1db2Sm-0008Ka-8H
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1db2Si-00010N-KH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:25:44 -0400
Received: from mail-he1eur01on0101.outbound.protection.outlook.com
	([104.47.0.101]:18976
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1db2Sh-0000vY-AM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:25:40 -0400
References: <20170728092053.10122-1-stefanha@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <0ffcc283-7a2d-43fc-e6b2-7cfb90de439e@openvz.org>
Date: Fri, 28 Jul 2017 13:25:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170728092053.10122-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] trace: fix trace_event_get_state() for
 SystemTap and LTTng UST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 07/28/2017 12:20 PM, Stefan Hajnoczi wrote:
> Trace events that compute their arguments can affect performance.  The
> following idom can be used to avoid computing arguments when the trace event is
> disabled:
>
>   if (trace_event_get_state(TRACE_MY_EVENT)) {
>       char *str = g_strdup_printf("Expensive string ...", ...);
>       trace_my_event(str);
>       g_free(str);
>   }
>
> Unfortunately this breaks the trace event for SystemTap and LTTng UST since
> those tracers manage their own enabled/disabled state.
>
> These patches add per-backend dstate to trace_event_get_state() so that the
> trace event fires as expected when enabled via SystemTap or LTTng UST.
>
> Stefan Hajnoczi (2):
>   trace: add TRACE_<event>_BACKEND_DSTATE()
>   trace: check backend dstate in trace_event_get_state()
>
>  trace/control.h                       | 20 ++++++++++++++++++--
>  scripts/tracetool/__init__.py         |  1 +
>  scripts/tracetool/backend/__init__.py |  3 +++
>  scripts/tracetool/backend/dtrace.py   | 12 ++++++++++++
>  scripts/tracetool/backend/ftrace.py   |  2 +-
>  scripts/tracetool/backend/log.py      |  3 ++-
>  scripts/tracetool/backend/simple.py   |  2 +-
>  scripts/tracetool/backend/syslog.py   |  3 ++-
>  scripts/tracetool/backend/ust.py      |  5 +++++
>  scripts/tracetool/format/h.py         | 10 ++++++++++
>  10 files changed, 55 insertions(+), 6 deletions(-)
>
looks good to me!

This also fixes the same issue not only in my code, but in

static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
and in colo code.

Reviewed-by: Denis V. Lunev <den@openvz.org>
