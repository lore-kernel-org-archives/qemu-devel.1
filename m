Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eQxl8-0000NF-Jj
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eQxl7-0007pw-Qp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:55:18 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:26288 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eQxl7-0007i7-6e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:55:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Dec 2017 18:55:03 +0300
Message-Id: <20171218155503.7506-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block: inactivate all if started in paused mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com

Inactivate all if started in paused mode to make it possible to modify
drives through nbd before start (a kind of external reatore).

Invalidation should be done in qmp cont command.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

We need the following option: start vm in stopped mode (-S) and write it's disk before start through NBD.
It should be absolutely safe, but unfortunately it is disallowed by root role of the disk.
Is there any workaround or if not, what is a true way to implement this possibility?

error message:
    unable to execute QEMU command 'nbd-server-add': Conflicts with use by drive0 as 'root', which does not allow 'write' on #block100


I'm not sure about, how to properly make this case possible, but here is a try.

 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 68782814e5..2ebef3953d 100644
--- a/vl.c
+++ b/vl.c
@@ -4727,6 +4727,8 @@ int main(int argc, char **argv, char **envp)
         }
     } else if (autostart) {
         vm_start();
+    } else {
+        bdrv_inactivate_all();
     }
 
     os_setup_post();
-- 
2.11.1
