Received: from eggs.gnu.org ([2001:4830:134:3::10]:44770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnN-0000jp-MP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxnI-0005Qv-Gp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxnI-0005Qh-Ar
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:53:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 768188124D
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:53:40 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 09:53:24 +0000
Message-Id: <20170124095332.23955-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] Support multiple listening sockets per
 VNC server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

There are two core feature changes in this series

 - If a DNS name resolves to multiple distinct IP addresses,
   the VNC server is now able to listen on all of them

 - The -vnc argument syntax is extended to allow the 'vnc'
   and 'websocket' arguments to be listed multiple times.
   This allows a single VNC server to listen on multiple
   different names / addresses.

The io/ patch series that this previously depended on is now merged
in git master.

Changed in v2:

 - Fix qapi version annotation (Eric)
 - Fix misc typos in docs/commit message (Eric)
 - Replace qemu_opt_get_all() with generic QemuOpt iterator API
   to avoid needless mem allocations

Daniel P. Berrange (8):
  ui: fix regression handling bare 'websocket' option to -vnc
  ui: fix reporting of VNC auth in query-vnc-servers
  ui: refactor VncDisplay to allow multiple listening sockets
  ui: refactor code for populating SocketAddress from vnc_display_open
  ui: extract code to connect/listen from vnc_display_open
  ui: let VNC server listen on all resolved IP addresses
  util: add iterators for QemuOpts values
  ui: add ability to specify multiple VNC listen addresses

 include/qemu/option.h |   9 +
 qapi-schema.json      |  28 ++-
 qemu-options.hx       |  12 +-
 ui/vnc.c              | 656 +++++++++++++++++++++++++++++++++++---------------
 ui/vnc.h              |  10 +-
 util/qemu-option.c    |  19 ++
 6 files changed, 532 insertions(+), 202 deletions(-)

-- 
2.9.3
