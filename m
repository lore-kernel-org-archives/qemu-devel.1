Received: from eggs.gnu.org ([2001:4830:134:3::10]:58943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVjMc-0002NW-CR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVjMX-0001kh-FQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVjMX-0001kE-9D
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 15:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22DD180F7D
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 19:01:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 13 Jul 2017 20:01:16 +0100
Message-Id: <20170713190116.21608-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's a rare exit seg if the guest is accessing
IO during exit.
It's always hitting the atomic_inc(&bs->in_flight) with a NULL
bs. This was added recently in 99723548  but I don't see it
as the cause.

Flip vl.c around so we pause the cpus before closing the block devices,
that way we shouldn't have anything trying to access them when
they're gone.

This was originally Red Hat bz https://bugzilla.redhat.com/show_bug.cgi?id=1451015

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Cong Li <coli@redhat.com>

--
This is a very rare race, I'll leave it running in a loop to see if
we hit anything else and to check this really fixes it.

I do worry if there are other cases that can trigger this - e.g.
hot-unplug or ejecting a CD.

---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index f7560de622..d53f715e91 100644
--- a/vl.c
+++ b/vl.c
@@ -4787,8 +4787,8 @@ int main(int argc, char **argv, char **envp)
     replay_disable_events();
     iothread_stop_all();
 
-    bdrv_close_all();
     pause_all_vcpus();
+    bdrv_close_all();
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
-- 
2.13.0
