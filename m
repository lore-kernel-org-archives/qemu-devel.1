Received: from eggs.gnu.org ([2001:4830:134:3::10]:53557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSG0-0008V1-MW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSFx-0004B6-KK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ecSFx-00043j-EE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:37 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 Jan 2018 16:42:17 +0800
Message-Id: <20180119084219.31187-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] memory/vfio: notify region_del() when
 unregister listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>

I encountered an event loss problem during unplugging vfio devices:

  https://bugzilla.redhat.com/show_bug.cgi?id=1531393

I thought it should be a simple VT-d issue but I was wrong.  The whole
debugging leads me to these patches.

Basically I think what we missed is that when unregistering memory
listeners, we don't really call region_del() at all.  Instead we just
remove ourselves from the listener list.  IMHO that's not enough.  A
clean unregister should undo all possible changes that have done
during region_add().  That's patch 1.

Patch 2 fixes a vfio issue when patch 1 is applied.

I'm marking this change as RFC since it touches the core of memory
somehow, on which I am not 100% sure about.  E.g., I haven't tested
all the listener users, so I'm not sure whether it may broke any use
case.

But what I'm sure is that it passes the docker tests on
compiling/qtests, and it fixes the event loss that reported.

Let's see whether I can get some feedback first.  Please review.

Thanks.

Peter Xu (2):
  memory: do explicit cleanup when remove listeners
  vfio: listener unregister before unset container

 hw/vfio/common.c | 16 ++++++++++++----
 memory.c         | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.14.3
