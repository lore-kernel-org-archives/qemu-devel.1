Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOEX-0003T6-6J
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dOOET-0001l6-BH
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:45 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dOOET-0001kJ-3F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:02:41 -0400
Received: by mail-wr0-f177.google.com with SMTP id k67so64662256wrc.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:02:40 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 23 Jun 2017 15:02:34 +0200
Message-Id: <cover.1498222907.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 0/3] qemu-ga: support for sending events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

This is just a draft, or a request for comments if you will.

This patch sets drafts the support of sending events by QEMU Guest Agent.
Events can plan important role in monitoring of the guest OS behaviour. The
range of use cases ranges from events important for scheduling, e.g. memory and
CPU usage statistics, to things like changes to IP addresses on network
interfaces to for example changes in the list of active users.

For now the patch set adds single periodic callback function to the GA main
loop that can perform checks and trigger events that have occured since
previous run of the callback.

We can of course take it one step further and add a general framwork for
periodically running any of the already implemented commands. Add a function
that would maintain a list of registered checks. Client would use some command
(register-monitor-command) passing it a command name and timeout in seconds and
the monitoring handler would then run the specified command and report the
result... or report only if the return value changed since previous invocation.
This feature would remove part of the communication overhead between client and
GA.

So before I invest any more time in either of these approaches, tell me. Would
somethign like this be wanted or is that too controversial? Any other thoughts
and ideas?

Tomáš Golembiovský (3):
  qemu-ga: add support for events
  qemu-ga: add simple event reporting memory statistics
  qemu-ga: add support for periodic command runner

 Makefile               |  7 +++-
 qga/Makefile.objs      |  2 +-
 qga/channel-posix.c    |  8 +++++
 qga/channel-win32.c    |  6 ++++
 qga/channel.h          |  1 +
 qga/guest-agent-core.h |  1 +
 qga/main.c             | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-event.json    | 35 ++++++++++++++++++
 qga/qapi-schema.json   |  2 ++
 9 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 qga/qapi-event.json

-- 
2.13.1
