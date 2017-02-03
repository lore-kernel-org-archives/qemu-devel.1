Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcdl-0005JT-VE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcdi-0003zt-S5
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:06:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZcdi-0003zT-MW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:06:54 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF33C80F9B
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 12:06:54 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Feb 2017 12:06:41 +0000
Message-Id: <20170203120649.15637-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/8] Support multiple listening sockets per
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

Followup to

 v2: https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04951.html

There are two core feature changes in this series

 - If a DNS name resolves to multiple distinct IP addresses,
   the VNC server is now able to listen on all of them

 - The -vnc argument syntax is extended to allow the 'vnc'
   and 'websocket' arguments to be listed multiple times.
   This allows a single VNC server to listen on multiple
   different names / addresses.

The io/ patch series that this previously depended on is now merged
in git master.

Changed in v3:

 - Resolve conflicts with master for qapi schema
 - Remove left-over debug statement (Eric)

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
 ui/vnc.c              | 655 +++++++++++++++++++++++++++++++++++---------------
 ui/vnc.h              |  10 +-
 util/qemu-option.c    |  19 ++
 6 files changed, 531 insertions(+), 202 deletions(-)

-- 
2.9.3
