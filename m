Received: from eggs.gnu.org ([2001:4830:134:3::10]:49939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qL-0006Gn-U9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0q9-0004sr-B5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0q8-0004s3-PJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01D0C4900D
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:40 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:15 +0000
Message-Id: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 00/13] Fix VNC server unbounded memory usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

In the 2.11 release we fixed CVE-2017-15268, which allowed the VNC websockets
server to consume arbitrary memory when a slow client was connected. I have
since discovered that this same type of problem can be triggered in several
other ways in the regular (non-websockets) VNC server. This patch series
attempts to fix this problem by limiting framebuffer updates and other data
sent from server to client. The mitigating factor is that you need to have
successfully authenticated with the VNC server to trigger these new flaws.
This new more general flaw is assigned CVE-2017-15124 by the Red Hat security
team.

The key patches containing the security fix are 9, 10, 11.

Since this code is incredibly subtle & hard to understand though, the first
8 patches do a bunch of independant cleanups/refactoring to make the security
fixes clearer.  The last two patches are just some extra cleanup / help for
future maint.

Daniel P. Berrange (13):
  ui: remove 'sync' parametr from vnc_update_client
  ui: remove unreachable code in vnc_update_client
  ui: remove redundant indentation in vnc_client_update
  ui: avoid pointless VNC updates if framebuffer isn't dirty
  ui: track how much decoded data we consumed when doing SASL encoding
  ui: introduce enum to track VNC client framebuffer update request
    state
  ui: correctly reset framebuffer update state after processing dirty
    regions
  ui: refactor code for determining if an update should be sent to the
    client
  ui: fix VNC client throttling when audio capture is active
  ui: fix VNC client throttling when forced update is requested
  ui: place a hard cap on VNC server output buffer size
  ui: add trace events related to VNC client throttling
  ui: mix misleading comments & return types of VNC I/O helper methods

 ui/trace-events    |   7 ++
 ui/vnc-auth-sasl.c |  16 ++-
 ui/vnc-auth-sasl.h |   5 +-
 ui/vnc-jobs.c      |   5 +
 ui/vnc.c           | 320 ++++++++++++++++++++++++++++++++++++++---------------
 ui/vnc.h           |  28 ++++-
 6 files changed, 277 insertions(+), 104 deletions(-)

-- 
2.14.3
