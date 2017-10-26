Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcT-0000hR-Pz
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcP-0005Qk-Sc
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcP-0005Om-Kr
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNTbHh081676
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:15 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dupejq45y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:15 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 17:31:14 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:48 -0500
Message-Id: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/6] qga: add support for re-opening channel on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

The following patches are also available at:
  https://github.com/mdroth/qemu/commits/qga-retry-path

This series adds a --retry-path option to qemu-ga to allow the agent
to periodically re-attempt opening a channel if the channel is not
yet present (e.g. qemu-ga is installed before virtio-serial drivers)
or if the channel encounters an error that might be recoverable (e.g.
the channel is hot unplugged/plugged).

This functionality is already possible via init systems like systemd (and
is already set up that way on Fedora), but we implement this option
to handle other OSs like Windows (where this was originally reported as
a problem).

PATCH 1-3 implement various refactorings that more clearly encapsulate
the agent's lifecycle into:

 a) config parsing (via main())
 b) initializing the agent (via initialize_agent())
 c) starting the agent (via run_agent())
 d) stopping the agent (via stop_agent())
 e) cleaning up the agent (via cleanup_agent())
 f) cleaning up the config (via main())

PATCH 4 implements the actual --retry-path option, which simply wraps
run_agent() in a continuous loop until the agent is explicitly told
to exit.

 qga/channel-win32.c       |   3 +-
 qga/installer/qemu-ga.wxs |   2 +-
 qga/main.c                | 205 ++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 3 files changed, 141 insertions(+), 69 deletions(-)
