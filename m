Received: from eggs.gnu.org ([2001:4830:134:3::10]:47513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ8z-0007sa-5w
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ8u-0001gV-Th
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:37 -0400
Received: from [59.151.112.132] (port=40923 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKQ8u-0001ek-HO
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:16:32 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 22:15:01 +0800
Message-ID: <cover.1497276062.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/4] Improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, armbru@redhat.com, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

Daniel's patch(commit 6701e551, Revert "Change net/socket.c to use socket_*() 
functions" again) has been in upstream. Continue this patchset.

In v2, this series convert the non-blocking connect mechanism to QIOchannel 
by replace the socket_connect(), and some errors also are converted to Error. 

The v2 related discussion was listed on:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04886.html

v4: 
* PATCH 01 is redoing previous patch 1, replace the fprintf() with error_report()
		     in the 'default' case of net_socket_fd_init() [Markus Armbruster]

v3:
* PATCH 01 is suggested by Markus and Daniel that removes the dubious 'default' case
           in the net_socket_fd_init(). Jason agreed.
* PATCH 02 is redoing previous patch 4.
* PATCH 04 is redoing previous patch 2, improves sort of error messages. 

v2:
* PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
           in the function called by net_socket_*_init() to Error. Also add many error 
           handling information.
* PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init() 
           use the function such as fprintf, perror to report an error message. Convert it 
           to Error.
* PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
           error when it fails.


Cc: jasowang@redhat.com
Cc: armbru@redhat.com
Cc: berrange@redhat.com
Cc: kraxel@redhat.com
Cc: pbonzini@redhat.com

Mao Zhongyi (4):
  net/socket: Drop the odd 'default' case and comment
  net/net: Convert parse_host_port() to Error
  net/socket: Convert error report message to Error
  net/socket: Improve -net socket error reporting

 include/qemu/sockets.h |   2 +-
 net/net.c              |  21 ++++++--
 net/socket.c           | 133 +++++++++++++++++++++++++++++--------------------
 3 files changed, 96 insertions(+), 60 deletions(-)

-- 
2.9.3
