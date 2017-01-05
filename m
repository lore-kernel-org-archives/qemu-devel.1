Received: from eggs.gnu.org ([2001:4830:134:3::10]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZP-0000hI-Uc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZM-0001BF-Pl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAZM-0001B0-KS
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:12 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0F972172E
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:07:12 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:06:53 +0000
Message-Id: <20170105160701.22118-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] Support multiple listening sockets per VNC
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This series is dependant on the IO series just posted to support
DNS resolution separately from socket creation.

There are two core feature changes in this series

 - If a DNS name resolves to multiple distinct IP addresses,
   the VNC server is now able to listen on all of them

 - The -vnc argument syntax is extended to allow the 'vnc'
   and 'websocket' arguments to be listed multiple times.
   This allows a single VNC server to listen on multiple
   different names / addresses.

Daniel P. Berrange (8):
  ui: fix regression handling bare 'websocket' option to -vnc
  ui: fix reporting of VNC auth in query-vnc-servers
  ui: refactor VncDisplay to allow multiple listening sockets
  ui: refactor code for populating SocketAddress from vnc_display_open
  ui: extract code to connect/listen from vnc_display_open
  ui: let VNC server listen on all resolved IP addresses
  util: add qemu_opt_get_all() to get repeated opts
  ui: add ability to specify multiple VNC listen addresses

 include/qemu/option.h |   1 +
 qapi-schema.json      |  26 +-
 qemu-options.hx       |  12 +-
 ui/vnc.c              | 653 +++++++++++++++++++++++++++++++++++---------------
 ui/vnc.h              |  10 +-
 util/qemu-option.c    |  22 ++
 6 files changed, 523 insertions(+), 201 deletions(-)

-- 
2.9.3
