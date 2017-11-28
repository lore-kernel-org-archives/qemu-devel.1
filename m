Received: from eggs.gnu.org ([2001:4830:134:3::10]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfY8-0001D4-Cu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJfY2-0003hx-Hk
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:03:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 28 Nov 2017 07:02:48 -0600
Message-Id: <20171128130248.901-3-eblake@redhat.com>
In-Reply-To: <20171128130248.901-1-eblake@redhat.com>
References: <20171128130248.901-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] nbd/server: CVE-2017-15118 Stack smash on
 large export name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, secalert@redhat.com, ppandit@redhat.com, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Introduced in commit f37708f6b8 (2.10).  The NBD spec says a client
can request export names up to 4096 bytes in length, even though
they should not expect success on names longer than 256.  However,
qemu hard-codes the limit of 256, and fails to filter out a client
that probes for a longer name; the result is a stack smash that can
potentially give an attacker arbitrary control over the qemu
process.

The smash can be easily demonstrated with this client:
$ qemu-io f raw nbd://localhost:10809/$(printf %3000d 1 | tr ' ' a)

If the qemu NBD server binary (whether the standalone qemu-nbd, or
the builtin server of QMP nbd-server-start) was compiled with
-fstack-protector-strong, the ability to exploit the stack smash
into arbitrary execution is a lot more difficult (but still
theoretically possible to a determined attacker, perhaps in
combination with other CVEs).  Still, crashing a running qemu (and
losing the VM) is bad enough, even if the attacker did not obtain
full execution control.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index a81801e3bc..92c0fdd03b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -386,6 +386,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
         msg = "name length is incorrect";
         goto invalid;
     }
+    if (namelen >= sizeof(name)) {
+        msg = "name too long for qemu";
+        goto invalid;
+    }
     if (nbd_read(client->ioc, name, namelen, errp) < 0) {
         return -EIO;
     }
-- 
2.14.3
