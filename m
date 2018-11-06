Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HL-00022q-B8
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gK3HK-0006xI-CH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gK3HK-0006vv-40
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:28:30 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 15:13:23 +0000
Message-Id: <20181106151323.16154-5-peter.maydell@linaro.org>
In-Reply-To: <20181106151323.16154-1-peter.maydell@linaro.org>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 4/4] slirp: fork_exec(): create and
 connect child socket before fork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

Currently fork_exec() fork()s, and then creates and connects the
child socket which it uses for communication with the parent in
the child process. This is awkward because the child has no
mechanism to report failure back to the parent, which might end
up blocked forever in accept(). The child code also has an issue
pointed out by Coverity (CID 1005727), where if the qemu_socket()
call fails it will pass -1 as a file descriptor to connect().

Fix these issues by moving the creation of the child's end of
the socket to before the fork(), where we are in a position to
handle a possible failure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 slirp/misc.c | 55 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/slirp/misc.c b/slirp/misc.c
index 260187b6b62..57bdd808e2d 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -85,9 +85,10 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 int
 fork_exec(struct socket *so, const char *ex, int do_pty)
 {
-	int s;
-	struct sockaddr_in addr;
+        int s, cs;
+        struct sockaddr_in addr, csaddr;
 	socklen_t addrlen = sizeof(addr);
+        socklen_t csaddrlen = sizeof(csaddr);
 	int opt;
 	const char *argv[256];
 	/* don't want to clobber the original */
@@ -120,10 +121,35 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 		}
 	}
 
+        if (getsockname(s, (struct sockaddr *)&csaddr, &csaddrlen) < 0) {
+            closesocket(s);
+            return 0;
+        }
+        cs = qemu_socket(AF_INET, SOCK_STREAM, 0);
+        if (cs < 0) {
+            closesocket(s);
+            return 0;
+        }
+        csaddr.sin_addr = loopback_addr;
+        /*
+         * This connect won't block because we've already listen()ed on
+         * the server end (even though we won't accept() the connection
+         * until later on).
+         */
+        do {
+            ret = connect(cs, (struct sockaddr *)&csaddr, csaddrlen);
+        } while (ret < 0 && errno == EINTR);
+        if (ret < 0) {
+            closesocket(s);
+            closesocket(cs);
+            return 0;
+        }
+
 	pid = fork();
 	switch(pid) {
 	 case -1:
 		error_report("Error: fork failed: %s", strerror(errno));
+                closesocket(cs);
 		close(s);
 		return 0;
 
@@ -131,21 +157,10 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
                 setsid();
 
 		/* Set the DISPLAY */
-                getsockname(s, (struct sockaddr *)&addr, &addrlen);
                 close(s);
-                /*
-                 * Connect to the socket
-                 * XXX If any of these fail, we're in trouble!
-                 */
-                s = qemu_socket(AF_INET, SOCK_STREAM, 0);
-                addr.sin_addr = loopback_addr;
-                do {
-                    ret = connect(s, (struct sockaddr *)&addr, addrlen);
-                } while (ret < 0 && errno == EINTR);
-
-		dup2(s, 0);
-		dup2(s, 1);
-		dup2(s, 2);
+                dup2(cs, 0);
+                dup2(cs, 1);
+                dup2(cs, 2);
 		for (s = getdtablesize() - 1; s >= 3; s--)
 		   close(s);
 
@@ -178,12 +193,10 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
 
 	 default:
 		qemu_add_child_watch(pid);
+                closesocket(cs);
                 /*
-                 * XXX this could block us...
-                 * XXX Should set a timer here, and if accept() doesn't
-                 * return after X seconds, declare it a failure
-                 * The only reason this will block forever is if socket()
-                 * of connect() fail in the child process
+                 * This should never block, because we already connect()ed
+                 * on the child end before we forked.
                  */
                 do {
                     so->s = accept(s, (struct sockaddr *)&addr, &addrlen);
-- 
2.19.1
