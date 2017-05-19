Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmFs-0000UA-53
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBmFp-0007Ol-1q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:04:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBmFo-0007ON-Ro
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9FC63B70D
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 18:03:54 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 19 May 2017 19:03:37 +0100
Message-Id: <20170519180342.19618-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Fix handling of IPv4/IPv6 dual stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a (much larger) followup to:

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05659.html

This series aims to fix a lot of bugs related to handling of IPv4 / IPv6
dual stack.

 - The VNC server mistakenly listened on two separate ports 5900+5901
   when the to= parameter was given
 - IPv6 sockets are accepting IPv4 clients even when IPv4 is set to
   be disabled
 - IPv6 sockets are failing to accept IPv4 clients when IPv4 is not set
   to be disabled
 - The VNC server was loosing the ipv4=/ipv6= settings due to a bug
   in the DNS resolver

The behaviour of all this is really subtle and hard to get working correctly
across all the different network backends. Thus, the most important part of
this patch series is the last patch which adds a test case covering the
backends for -vnc, -chardev tcp, -net socket, and -incoming socket, with
a 120 entry matrix.

IOW, if you think any of the first 4 patches are applying the wrong logic,
then take a look at the last patch and indicate which test matrix entries
are believed to be defining wrong behaviour :-)

Daniel P. Berrange (5):
  sockets: ensure we can bind to both ipv4 & ipv6 separately
  sockets: don't block IPv4 clients when listening on "::"
  sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
  io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
  tests: add functional test validating ipv4/ipv6 address flag handling

 io/dns-resolver.c          |   6 +-
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   4 +
 tests/test-sockets-proto.c | 855 +++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c        |  71 +++-
 5 files changed, 916 insertions(+), 21 deletions(-)
 create mode 100644 tests/test-sockets-proto.c

-- 
2.9.3
