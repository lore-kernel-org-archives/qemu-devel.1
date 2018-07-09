Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fcVhB-0003xw-Bm
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fcVh6-00021b-GG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:55:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephane.duverger@gmail.com>)
	id 1fcVh6-00021J-9F
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:55:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id c13-v6so10839659wrt.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 05:55:07 -0700 (PDT)
Received: from vm.localdomain (71.208.159.77.rev.sfr.net. [77.159.208.71])
	by smtp.gmail.com with ESMTPSA id
	x6-v6sm17986569wrd.57.2018.07.09.05.55.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 09 Jul 2018 05:55:06 -0700 (PDT)
Date: Mon, 9 Jul 2018 14:54:59 +0200
From: stephane duverger <stephane.duverger@gmail.com>
Message-ID: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

This is a small patch to gdbstub rather insignificant at first sight:
fix null pointer dereference. It actually allows to take benefit of
gdb features (breakpoints/sstep) internally (ie. special purpose
board) without connecting a gdb client to the Qemu instance gdbserver
stub.

Regards,

Signed-off-by: Stephane Duverger <stephane.duverger@gmail.com>
---
 gdbstub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index d6ab95006c..788fd625ab 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1412,6 +1412,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
 
 void gdb_set_stop_cpu(CPUState *cpu)
 {
+    if (!gdbserver_state) {
+        return;
+    }
     gdbserver_state->c_cpu = cpu;
     gdbserver_state->g_cpu = cpu;
 }
-- 
2.14.1
