Received: from eggs.gnu.org ([2001:4830:134:3::10]:53753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRUC-0004hm-0L
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoRU7-0001V0-35
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50129 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoRU6-0001UM-UA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:18:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 877308182D15
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:18:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 21 Feb 2018 11:18:29 +0100
Message-Id: <1519208316-18812-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/7] Improvements and clean-ups related to
 -net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

"-net" is a legacy option that often causes confusion and
misconfigurations for the users, since most people are not aware
of the underlying "vlan" (i.e. hub) concept that is used for this
parameter. The prefered way of configuring your network stack is
to use "--netdev" instead, which gives you a clean 1:1 connection
between your emulated guest hardware and the host network backend.

However, there are two reasons why we could not completely deprecate
"-net" yet:

1) Convenience:
In some cases, it's more convenient to use "-net" instead of "--netdev",
e.g. if you just want to have a "tap" network connection, it's faster
to type "-net nic -net tap" instead of "--device e1000,netdev=n1
--netdev tap,id=n1".

2) On-board NICs:
Currently the "-net nic" parameter is the only way to configure on-
board NICs on certain (embedded) machines via the nd_table[] array.

So beside some generic clean-ups and removal of code that has been
marked as deprecated since QEMU 2.10 already, this patch series intro-
duces a new parameter "--nic" (in patch 7) which should be able to re-
place "-net" in the long run completely: This new convenience parameter
can be used to configure the default/on-board guest HW together with a
host network backend in a very compact way. To configure a tap backend
for the default NIC, you just have to type "--nic tap" here for example.

Note that "-net" itself is not marked as deprecated yet - that is
subject to a later patch, since it likely needs some additional
discussion first (or we might rather want to wait for some more
releases first until --nic has been properly established instead)...

v3:
- Changed the comments in qapi/net.json in patch 5/7 according
  to the suggestion from Eric. Dropped the Reviewed-bys from this
  patch since the text changed a bit now.
- Dropped the final patch 8 with the updates to qemu-doc about
  making -net less prominent. I'll resubmit that patch together
  with a patch that deprecates "-net" in a separate patch series
  instead (which will likely both need some more discussion first).

v2:
- Renamed "-n" to "--nic" (suggested by Paolo)
- Improved the QAPI comment about the removal of 'dump (suggested by Eric)
- exit(0) instead of exit(1) after showing the "-netdev help" (Eric)
- Improved the documenation for hubport a little bit (suggested by Paolo)

Thomas Huth (7):
  net: Move error reporting from net_init_client/netdev to the calling
    site
  net: List available netdevs with "-netdev help"
  net: Only show vhost-user in the help text if CONFIG_POSIX is defined
  net: Make net_client_init() static
  net: Remove the deprecated way of dumping network packets
  net: Remove the deprecated 'host_net_add' and 'host_net_remove' HMP
    commands
  net: Add a new convenience option "--nic" to configure
    default/on-board NICs

 hmp-commands.hx         |  30 ------
 hmp.h                   |   3 -
 include/net/net.h       |   4 +-
 include/sysemu/sysemu.h |   1 +
 monitor.c               |  61 ------------
 net/dump.c              | 102 +--------------------
 net/net.c               | 239 +++++++++++++++++++++++-------------------------
 qapi/net.json           |  29 ++----
 qemu-doc.texi           |  16 ----
 qemu-options.hx         |  48 +++++++---
 tests/test-hmp.c        |   2 -
 vl.c                    |  10 +-
 12 files changed, 170 insertions(+), 375 deletions(-)

-- 
1.8.3.1
