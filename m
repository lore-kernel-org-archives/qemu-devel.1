Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP7-0008Gh-Ru
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP7-0007ab-4C
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP6-0007aN-Tm
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:33 -0400
Received: by mail-wr0-x242.google.com with SMTP id y25so546681wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:39 +0200
Message-Id: <1497523981-38449-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/41] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

qemu proper has done so for 13 years
(8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
Ignoring this signal is especially important in qemu-nbd because
otherwise a client can easily take down the qemu-nbd server by dropping
the connection when the server wants to send something, for example:

$ qemu-nbd -x foo -f raw -t null-co:// &
[1] 12726
$ qemu-io -c quit nbd://localhost/bar
can't open device nbd://localhost/bar: No export with name 'bar' available
[1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://

In this case, the client sends an NBD_OPT_ABORT and closes the
connection (because it is not required to wait for a reply), but the
server replies with an NBD_REP_ACK (because it is required to reply).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20170611123714.31292-1-mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 9464a04..4dd3fd4 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -581,6 +581,10 @@ int main(int argc, char **argv)
     sa_sigterm.sa_handler = termsig_handler;
     sigaction(SIGTERM, &sa_sigterm, NULL);
 
+#ifdef CONFIG_POSIX
+    signal(SIGPIPE, SIG_IGN);
+#endif
+
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
 
-- 
1.8.3.1
