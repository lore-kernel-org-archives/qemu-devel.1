Received: from eggs.gnu.org ([2001:4830:134:3::10]:53113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhXx-0000or-8V
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enhXu-0002vg-3p
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1enhXt-0002vF-Uj
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 04:15:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C631A4023EDE
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:15:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 10:15:20 +0100
Message-Id: <1519031728-9850-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/8] Improvements and clean-ups related to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

"-net" is a legacy option that often causes confusion and
misconfigurations for the users, since most people are not aware
of the underlying "vlan" (i.e. hub) concept that is used for this
parameter. The prefered way of configuring your network stack is
to use "--netdev" instead, which gives you a clean 1:1 connection
between your emulated guest hardware and the host network backend.

However, there are two reasons why we could not completely deprecate
"-net" yet:

1) Convenience:
In some cases, it's more convenient to use "-net" instead of "-netdev",
e.g. if you just want to have a "tap" network connection, it's faster
to type "-net nic -net tap" instead of "-device e1000,netdev=n1 -netdev
tap,id=n1".

2) On-board NICs:
Currently the "-net nic" parameter is the only way to configure on-board
NICs on certain (embedded) machines via the nd_table[] array.

So beside some generic clean-ups and removal of code that has been
marked as deprecated since QEMU 2.10 already, this patch series
introduces a new parameter "-n" (in patch 7/8) which should be able to
replace "-net" in the long run completely: This new convenience parameter
can be used to configure the default/on-board guest HW together with a
host network backend in a very compact way. To configure a tap backend
for the default NIC, you just have to type "-n tap" here for example.

The last patch finally makes "-net" less prominent in our qemu docs,
e.g. by replacing the examples that contain "-net" with "-netdev".

Note that "-net" itself is not marked as deprecated yet - I think we
should rather do that after one or two QEMU release with "-n" so that
we have enough time to test and get used to the new parameter first.
Or we should likely even keep the "-net" around for a couple of years
since there are a lot of scripts and tools out there that still use
this legacy parameter...

Thomas Huth (8):
  net: Move error reporting from net_init_client/netdev to the calling
    site
  net: List available netdevs with "-netdev help"
  net: Only show vhost-user in the help text if CONFIG_POSIX is defined
  net: Make net_client_init() static
  net: Remove the deprecated way of dumping network packets
  net: Remove the deprecated 'host_net_add' and 'host_net_remove' HMP
    commands
  net: Add a new convenience option "-n" to configure default/on-board
    NICs
  qemu-doc: Make "-net" less prominent

 hmp-commands.hx         |  30 ------
 hmp.h                   |   3 -
 include/net/net.h       |   4 +-
 include/sysemu/sysemu.h |   1 +
 monitor.c               |  61 -------------
 net/dump.c              | 102 +--------------------
 net/net.c               | 237 +++++++++++++++++++++++-------------------------
 qapi/net.json           |  27 +-----
 qemu-doc.texi           |  16 ----
 qemu-options.hx         | 213 +++++++++++++++++++++++--------------------
 tests/test-hmp.c        |   2 -
 vl.c                    |  10 +-
 12 files changed, 247 insertions(+), 459 deletions(-)

-- 
1.8.3.1
