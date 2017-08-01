Received: from eggs.gnu.org ([2001:4830:134:3::10]:59531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrT-0004Iz-Q0
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrR-00079p-Rt
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrR-00078v-LB
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:33 -0400
Received: by mail-wr0-x242.google.com with SMTP id c24so1805028wra.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:09 +0200
Message-Id: <1501604245-33460-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] vl.c/exit: pause cpus before closing
 block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

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

Message-Id: <20170713190116.21608-1-dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index fb6b2ef..dd803fc 100644
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
1.8.3.1
