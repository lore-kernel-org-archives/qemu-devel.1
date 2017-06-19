Received: from eggs.gnu.org ([2001:4830:134:3::10]:40746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCV-0007Nx-7R
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCP-0004rX-Pb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:31 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCP-0004qe-A2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:25 -0400
Received: by mail-wr0-x235.google.com with SMTP id y25so30273557wrd.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:45 +0100
Message-Id: <20170619104655.31104-4-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 03/13] all: fix up code consitency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is pretty much a mechanical change where I ran:

  indent -kr

Across all the files and then fixed up all but a few violations of:

  ../../qemu.git/scripts/checkpatch.pl -f *.c *.h > checkpatch.out

Along with heavy use of M-x untabify to make everything consistent.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 comms.c                | 325 +++++++++++++++++++++++--------------------------
 reginfo.c              | 114 ++++++++---------
 risu.c                 | 310 +++++++++++++++++++++++-----------------------
 risu.h                 |   4 +-
 risu_arm.c             |  58 +++++----
 risu_i386.c            | 150 +++++++++++------------
 risu_m68k.c            |   2 +-
 risu_ppc64.c           |   2 +-
 risu_reginfo_aarch64.c |  60 +++++----
 risu_reginfo_aarch64.h |   3 +-
 risu_reginfo_arm.c     | 290 +++++++++++++++++++++----------------------
 risu_reginfo_arm.h     |   3 +-
 risu_reginfo_m68k.c    |  20 +--
 risu_reginfo_m68k.h    |   3 +-
 risu_reginfo_ppc64.c   |  29 ++---
 risu_reginfo_ppc64.h   |   3 +-
 16 files changed, 672 insertions(+), 704 deletions(-)

diff --git a/comms.c b/comms.c
index 31be846..2900c33 100644
--- a/comms.c
+++ b/comms.c
@@ -7,7 +7,7 @@
  *
  * Contributors:
  *     Peter Maydell (Linaro) - initial implementation
- *******************************************************************************/
+ ******************************************************************************/
 
 /* Routines for the socket communication between master and apprentice. */
 
@@ -24,76 +24,70 @@
 
 int apprentice_connect(const char *hostname, int port)
 {
-   /* We are the client end of the TCP connection */
-   int sock;
-   struct sockaddr_in sa;
-   sock = socket(PF_INET, SOCK_STREAM, 0);
-   if (sock < 0)
-   {
-      perror("socket");
-      exit(1);
-   }
-   struct hostent *hostinfo;
-   sa.sin_family = AF_INET;
-   sa.sin_port = htons(port);
-   hostinfo = gethostbyname(hostname);
-   if (!hostinfo)
-   {
-      fprintf(stderr, "Unknown host %s\n", hostname);
-      exit(1);
-   }
-   sa.sin_addr = *(struct in_addr*)hostinfo->h_addr;
-   if (connect(sock, (struct sockaddr*)&sa, sizeof(sa)) < 0)
-   {
-      perror("connect");
-      exit(1);
-   }
-   return sock;
+    /* We are the client end of the TCP connection */
+    int sock;
+    struct sockaddr_in sa;
+    sock = socket(PF_INET, SOCK_STREAM, 0);
+    if (sock < 0) {
+        perror("socket");
+        exit(1);
+    }
+    struct hostent *hostinfo;
+    sa.sin_family = AF_INET;
+    sa.sin_port = htons(port);
+    hostinfo = gethostbyname(hostname);
+    if (!hostinfo) {
+        fprintf(stderr, "Unknown host %s\n", hostname);
+        exit(1);
+    }
+    sa.sin_addr = *(struct in_addr *) hostinfo->h_addr;
+    if (connect(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
+        perror("connect");
+        exit(1);
+    }
+    return sock;
 }
 
 int master_connect(int port)
 {
-   int sock;
-   struct sockaddr_in sa;
-   sock = socket(PF_INET, SOCK_STREAM, 0);
-   if (sock < 0)
-   {
-      perror("socket");
-      exit(1);
-   }
-   int sora = 1;
-   if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &sora, sizeof(sora)) != 0)
-   {
-      perror("setsockopt(SO_REUSEADDR)");
-      exit(1);
-   }
+    int sock;
+    struct sockaddr_in sa;
+    sock = socket(PF_INET, SOCK_STREAM, 0);
+    if (sock < 0) {
+        perror("socket");
+        exit(1);
+    }
+    int sora = 1;
+    if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &sora, sizeof(sora)) !=
+        0) {
+        perror("setsockopt(SO_REUSEADDR)");
+        exit(1);
+    }
 
-   sa.sin_family = AF_INET;
-   sa.sin_port = htons(port);
-   sa.sin_addr.s_addr = htonl(INADDR_ANY);
-   if (bind(sock, (struct sockaddr*)&sa, sizeof(sa)) < 0)
-   {
-      perror("bind");
-      exit(1);
-   }
-   if (listen(sock, 1) < 0)
-   {
-      perror("listen");
-      exit(1);
-   }
-   /* Just block until we get a connection */
-   fprintf(stderr, "master: waiting for connection on port %d...\n", port);
-   struct sockaddr_in csa;
-   socklen_t csasz = sizeof(csa);
-   int nsock = accept(sock, (struct sockaddr*)&csa, &csasz);
-   if (nsock < 0)
-   {
-      perror("accept");
-      exit(1);
-   }
-   /* We're done with the server socket now */
-   close(sock);
-   return nsock;
+    sa.sin_family = AF_INET;
+    sa.sin_port = htons(port);
+    sa.sin_addr.s_addr = htonl(INADDR_ANY);
+    if (bind(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
+        perror("bind");
+        exit(1);
+    }
+    if (listen(sock, 1) < 0) {
+        perror("listen");
+        exit(1);
+    }
+    /* Just block until we get a connection */
+    fprintf(stderr, "master: waiting for connection on port %d...\n",
+            port);
+    struct sockaddr_in csa;
+    socklen_t csasz = sizeof(csa);
+    int nsock = accept(sock, (struct sockaddr *) &csa, &csasz);
+    if (nsock < 0) {
+        perror("accept");
+        exit(1);
+    }
+    /* We're done with the server socket now */
+    close(sock);
+    return nsock;
 }
 
 /* Utility functions which are just wrappers around read and writev
@@ -101,77 +95,68 @@ int master_connect(int port)
  */
 static void recv_bytes(int sock, void *pkt, int pktlen)
 {
-   char *p = pkt;
-   while (pktlen)
-   {
-      int i = read(sock, p, pktlen);
-      if (i <= 0)
-      {
-         if (errno == EINTR)
-         {
-            continue;
-         }
-         perror("read failed");
-         exit(1);
-      }
-      pktlen -= i;
-      p += i;
-   }
+    char *p = pkt;
+    while (pktlen) {
+        int i = read(sock, p, pktlen);
+        if (i <= 0) {
+            if (errno == EINTR) {
+                continue;
+            }
+            perror("read failed");
+            exit(1);
+        }
+        pktlen -= i;
+        p += i;
+    }
 }
 
 static void recv_and_discard_bytes(int sock, int pktlen)
 {
-   /* Read and discard bytes */
-   char dumpbuf[64];
-   while (pktlen)
-   {
-      int i;
-      int len = sizeof(dumpbuf);
-      if (len > pktlen)
-      {
-         len = pktlen;
-      }
-      i = read(sock, dumpbuf, len);
-      if (i <= 0)
-      {
-         if (errno == EINTR)
-         {
-            continue;
-         }
-         perror("read failed");
-         exit(1);
-      }
-      pktlen -= i;
-   }
+    /* Read and discard bytes */
+    char dumpbuf[64];
+    while (pktlen) {
+        int i;
+        int len = sizeof(dumpbuf);
+        if (len > pktlen) {
+            len = pktlen;
+        }
+        i = read(sock, dumpbuf, len);
+        if (i <= 0) {
+            if (errno == EINTR) {
+                continue;
+            }
+            perror("read failed");
+            exit(1);
+        }
+        pktlen -= i;
+    }
 }
 
 ssize_t safe_writev(int fd, struct iovec *iov_in, int iovcnt)
 {
-   /* writev, retrying for EINTR and short writes */
-   int r = 0;
-   struct iovec *iov = iov_in;
-   for (;;)
-   {
-      ssize_t i = writev(fd, iov, iovcnt);
-      if (i == -1)
-      {
-         if (errno == EINTR)
-            continue;
-         return -1;
-      }
-      r += i;
-      /* Move forward through iov to account for data transferred */
-      while (i >= iov->iov_len)
-      {
-         i -= iov->iov_len;
-         iov++;
-         iovcnt--;
-         if (iovcnt == 0) {
-            return r;
-         }
-      }
-      iov->iov_len -= i;
-   }
+    /* writev, retrying for EINTR and short writes */
+    int r = 0;
+    struct iovec *iov = iov_in;
+    for (;;) {
+        ssize_t i = writev(fd, iov, iovcnt);
+        if (i == -1) {
+            if (errno == EINTR) {
+                continue;
+            }
+            return -1;
+        }
+        r += i;
+        /* Move forward through iov to account for data transferred */
+        while (i >= iov->iov_len) {
+            i -= iov->iov_len;
+            iov++;
+            iovcnt--;
+            if (iovcnt == 0) {
+                return r;
+            }
+        }
+        iov->iov_len -= i;
+    }
 }
 
 /* Low level comms routines:
@@ -184,57 +169,53 @@ ssize_t safe_writev(int fd, struct iovec *iov_in, int iovcnt)
  */
 int send_data_pkt(int sock, void *pkt, int pktlen)
 {
-   unsigned char resp;
-   /* First we send the packet length as a network-order 32 bit value.
-    * This avoids silent deadlocks if the two sides disagree over
-    * what size data packet they are transferring. We use writev()
-    * so that both length and packet are sent in one packet; otherwise
-    * we get 300x slowdown because we hit Nagle's algorithm.
-    */
-   uint32_t net_pktlen = htonl(pktlen);
-   struct iovec iov[2];
-   iov[0].iov_base = &net_pktlen;
-   iov[0].iov_len = sizeof(net_pktlen);
-   iov[1].iov_base = pkt;
-   iov[1].iov_len = pktlen;
+    unsigned char resp;
+    /* First we send the packet length as a network-order 32 bit value.
+     * This avoids silent deadlocks if the two sides disagree over
+     * what size data packet they are transferring. We use writev()
+     * so that both length and packet are sent in one packet; otherwise
+     * we get 300x slowdown because we hit Nagle's algorithm.
+     */
+    uint32_t net_pktlen = htonl(pktlen);
+    struct iovec iov[2];
+    iov[0].iov_base = &net_pktlen;
+    iov[0].iov_len = sizeof(net_pktlen);
+    iov[1].iov_base = pkt;
+    iov[1].iov_len = pktlen;
 
-   if (safe_writev(sock, iov, 2) == -1)
-   {
-      perror("writev failed");
-      exit(1);
-   }
+    if (safe_writev(sock, iov, 2) == -1) {
+        perror("writev failed");
+        exit(1);
+    }
 
-   if (read(sock, &resp, 1) != 1)
-   {
-      perror("read failed");
-      exit(1);
-   }
-   return resp;
+    if (read(sock, &resp, 1) != 1) {
+        perror("read failed");
+        exit(1);
+    }
+    return resp;
 }
 
 int recv_data_pkt(int sock, void *pkt, int pktlen)
 {
-   uint32_t net_pktlen;
-   recv_bytes(sock, &net_pktlen, sizeof(net_pktlen));
-   net_pktlen = ntohl(net_pktlen);
-   if (pktlen != net_pktlen)
-   {
-      /* Mismatch. Read the data anyway so we can send
-       * a response back.
-       */
-      recv_and_discard_bytes(sock, net_pktlen);
-      return 1;
-   }
-   recv_bytes(sock, pkt, pktlen);
-   return 0;
+    uint32_t net_pktlen;
+    recv_bytes(sock, &net_pktlen, sizeof(net_pktlen));
+    net_pktlen = ntohl(net_pktlen);
+    if (pktlen != net_pktlen) {
+        /* Mismatch. Read the data anyway so we can send
+         * a response back.
+         */
+        recv_and_discard_bytes(sock, net_pktlen);
+        return 1;
+    }
+    recv_bytes(sock, pkt, pktlen);
+    return 0;
 }
 
 void send_response_byte(int sock, int resp)
 {
-   unsigned char r = resp;
-   if (write(sock, &r, 1) != 1)
-   {
-      perror("write failed");
-      exit(1);
-   }
+    unsigned char r = resp;
+    if (write(sock, &r, 1) != 1) {
+        perror("write failed");
+        exit(1);
+    }
 }
diff --git a/reginfo.c b/reginfo.c
index 96c6342..31bb99f 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -18,8 +18,8 @@ struct reginfo master_ri, apprentice_ri;
 
 uint8_t apprentice_memblock[MEMBLOCKLEN];
 
-static int mem_used = 0;
-static int packet_mismatch = 0;
+static int mem_used;
+static int packet_mismatch;
 
 int send_register_info(int sock, void *uc)
 {
@@ -37,11 +37,12 @@ int send_register_info(int sock, void *uc)
          */
         return send_data_pkt(sock, &ri, sizeof(ri));
     case OP_SETMEMBLOCK:
-        memblock = (void *)(uintptr_t)get_reginfo_paramreg(&ri);
-       break;
+        memblock = (void *) (uintptr_t) get_reginfo_paramreg(&ri);
+        break;
     case OP_GETMEMBLOCK:
         set_ucontext_paramreg(uc,
-                              get_reginfo_paramreg(&ri) + (uintptr_t)memblock);
+                              get_reginfo_paramreg(&ri) +
+                              (uintptr_t) memblock);
         break;
     case OP_COMPAREMEM:
         return send_data_pkt(sock, memblock, MEMBLOCKLEN);
@@ -85,25 +86,25 @@ int recv_and_compare_register_info(int sock, void *uc)
         }
         send_response_byte(sock, resp);
         break;
-      case OP_SETMEMBLOCK:
-          memblock = (void *)(uintptr_t)get_reginfo_paramreg(&master_ri);
-          break;
-      case OP_GETMEMBLOCK:
-          set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
-                                (uintptr_t)memblock);
-          break;
-      case OP_COMPAREMEM:
-         mem_used = 1;
-         if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
-             packet_mismatch = 1;
-             resp = 2;
-         } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
-             /* memory mismatch */
-             resp = 2;
-         }
-         send_response_byte(sock, resp);
-         break;
-   }
+    case OP_SETMEMBLOCK:
+        memblock = (void *) (uintptr_t) get_reginfo_paramreg(&master_ri);
+        break;
+    case OP_GETMEMBLOCK:
+        set_ucontext_paramreg(uc, get_reginfo_paramreg(&master_ri) +
+                              (uintptr_t) memblock);
+        break;
+    case OP_COMPAREMEM:
+        mem_used = 1;
+        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
+            packet_mismatch = 1;
+            resp = 2;
+        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+            /* memory mismatch */
+            resp = 2;
+        }
+        send_response_byte(sock, resp);
+        break;
+    }
 
     return resp;
 }
@@ -116,36 +117,37 @@ int recv_and_compare_register_info(int sock, void *uc)
  */
 int report_match_status(void)
 {
-   int resp = 0;
-   fprintf(stderr, "match status...\n");
-   if (packet_mismatch) {
-       fprintf(stderr, "packet mismatch (probably disagreement "
-               "about UNDEF on load/store)\n");
-       /* We don't have valid reginfo from the apprentice side
-        * so stop now rather than printing anything about it.
-        */
-       fprintf(stderr, "master reginfo:\n");
-       reginfo_dump(&master_ri, stderr);
-       return 1;
-   }
-   if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
-       fprintf(stderr, "mismatch on regs!\n");
-       resp = 1;
-   }
-   if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
-       fprintf(stderr, "mismatch on memory!\n");
-       resp = 1;
-   }
-   if (!resp) {
-       fprintf(stderr, "match!\n");
-       return 0;
-   }
-
-   fprintf(stderr, "master reginfo:\n");
-   reginfo_dump(&master_ri, stderr);
-   fprintf(stderr, "apprentice reginfo:\n");
-   reginfo_dump(&apprentice_ri, stderr);
-
-   reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
-   return resp;
+    int resp = 0;
+    fprintf(stderr, "match status...\n");
+    if (packet_mismatch) {
+        fprintf(stderr, "packet mismatch (probably disagreement "
+                "about UNDEF on load/store)\n");
+        /* We don't have valid reginfo from the apprentice side
+         * so stop now rather than printing anything about it.
+         */
+        fprintf(stderr, "master reginfo:\n");
+        reginfo_dump(&master_ri, stderr);
+        return 1;
+    }
+    if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
+        fprintf(stderr, "mismatch on regs!\n");
+        resp = 1;
+    }
+    if (mem_used
+        && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
+        fprintf(stderr, "mismatch on memory!\n");
+        resp = 1;
+    }
+    if (!resp) {
+        fprintf(stderr, "match!\n");
+        return 0;
+    }
+
+    fprintf(stderr, "master reginfo:\n");
+    reginfo_dump(&master_ri, stderr);
+    fprintf(stderr, "apprentice reginfo:\n");
+    reginfo_dump(&apprentice_ri, stderr);
+
+    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+    return resp;
 }
diff --git a/risu.c b/risu.c
index 7e42160..2cd6d22 100644
--- a/risu.c
+++ b/risu.c
@@ -28,59 +28,56 @@
 
 #include "risu.h"
 
-void *memblock = 0;
+void *memblock;
 
 int apprentice_socket, master_socket;
 
 sigjmp_buf jmpbuf;
 
 /* Should we test for FP exception status bits? */
-int test_fp_exc = 0;
+int test_fp_exc;
 
 void master_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (recv_and_compare_register_info(master_socket, uc))
-   {
-      case 0:
-         /* match OK */
-         advance_pc(uc);
-         return;
-      default:
-         /* mismatch, or end of test */
-         siglongjmp(jmpbuf, 1);
-   }
+    switch (recv_and_compare_register_info(master_socket, uc)) {
+    case 0:
+        /* match OK */
+        advance_pc(uc);
+        return;
+    default:
+        /* mismatch, or end of test */
+        siglongjmp(jmpbuf, 1);
+    }
 }
 
 void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (send_register_info(apprentice_socket, uc))
-   {
-      case 0:
-         /* match OK */
-         advance_pc(uc);
-         return;
-      case 1:
-         /* end of test */
-         exit(0);
-      default:
-         /* mismatch */
-         exit(1);
-   }
+    switch (send_register_info(apprentice_socket, uc)) {
+    case 0:
+        /* match OK */
+        advance_pc(uc);
+        return;
+    case 1:
+        /* end of test */
+        exit(0);
+    default:
+        /* mismatch */
+        exit(1);
+    }
 }
 
-static void set_sigill_handler(void (*fn)(int, siginfo_t *, void *))
+static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
 {
-   struct sigaction sa;
-   memset(&sa, 0, sizeof(struct sigaction));
-
-   sa.sa_sigaction = fn;
-   sa.sa_flags = SA_SIGINFO;
-   sigemptyset(&sa.sa_mask);
-   if (sigaction(SIGILL, &sa, 0) != 0)
-   {
-      perror("sigaction");
-      exit(1);
-   }
+    struct sigaction sa;
+    memset(&sa, 0, sizeof(struct sigaction));
+
+    sa.sa_sigaction = fn;
+    sa.sa_flags = SA_SIGINFO;
+    sigemptyset(&sa.sa_mask);
+    if (sigaction(SIGILL, &sa, 0) != 0) {
+        perror("sigaction");
+        exit(1);
+    }
 }
 
 typedef void entrypoint_fn(void);
@@ -90,152 +87,147 @@ entrypoint_fn *image_start;
 
 void load_image(const char *imgfile)
 {
-   /* Load image file into memory as executable */
-   struct stat st;
-   fprintf(stderr, "loading test image %s...\n", imgfile);
-   int fd = open(imgfile, O_RDONLY);
-   if (fd < 0)
-   {
-      fprintf(stderr, "failed to open image file %s\n", imgfile);
-      exit(1);
-   }
-   if (fstat(fd, &st) != 0)
-   {
-      perror("fstat");
-      exit(1);
-   }
-   size_t len = st.st_size;
-   void *addr;
-
-   /* Map writable because we include the memory area for store
-    * testing in the image.
-    */
-   addr = mmap(0, len, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, fd, 0);
-   if (!addr)
-   {
-      perror("mmap");
-      exit(1);
-   }
-   close(fd);
-   image_start = addr;
-   image_start_address = (uintptr_t)addr;
+    /* Load image file into memory as executable */
+    struct stat st;
+    fprintf(stderr, "loading test image %s...\n", imgfile);
+    int fd = open(imgfile, O_RDONLY);
+    if (fd < 0) {
+        fprintf(stderr, "failed to open image file %s\n", imgfile);
+        exit(1);
+    }
+    if (fstat(fd, &st) != 0) {
+        perror("fstat");
+        exit(1);
+    }
+    size_t len = st.st_size;
+    void *addr;
+
+    /* Map writable because we include the memory area for store
+     * testing in the image.
+     */
+    addr =
+        mmap(0, len, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd,
+             0);
+    if (!addr) {
+        perror("mmap");
+        exit(1);
+    }
+    close(fd);
+    image_start = addr;
+    image_start_address = (uintptr_t) addr;
 }
 
 int master(int sock)
 {
-   if (sigsetjmp(jmpbuf, 1))
-   {
-      return report_match_status();
-   }
-   master_socket = sock;
-   set_sigill_handler(&master_sigill);
-   fprintf(stderr, "starting image\n");
-   image_start();
-   fprintf(stderr, "image returned unexpectedly\n");
-   exit(1);
+    if (sigsetjmp(jmpbuf, 1)) {
+        return report_match_status();
+    }
+    master_socket = sock;
+    set_sigill_handler(&master_sigill);
+    fprintf(stderr, "starting image\n");
+    image_start();
+    fprintf(stderr, "image returned unexpectedly\n");
+    exit(1);
 }
 
 int apprentice(int sock)
 {
-   apprentice_socket = sock;
-   set_sigill_handler(&apprentice_sigill);
-   fprintf(stderr, "starting image\n");
-   image_start();
-   fprintf(stderr, "image returned unexpectedly\n");
-   exit(1);
+    apprentice_socket = sock;
+    set_sigill_handler(&apprentice_sigill);
+    fprintf(stderr, "starting image\n");
+    image_start();
+    fprintf(stderr, "image returned unexpectedly\n");
+    exit(1);
 }
 
 int ismaster;
 
-void usage (void)
+void usage(void)
 {
-   fprintf(stderr, "Usage: risu [--master] [--host <ip>] [--port <port>] <image file>\n\n");
-   fprintf(stderr, "Run through the pattern file verifying each instruction\n");
-   fprintf(stderr, "between master and apprentice risu processes.\n\n");
-   fprintf(stderr, "Options:\n");
-   fprintf(stderr, "  --master          Be the master (server)\n");
-   fprintf(stderr, "  -h, --host=HOST   Specify master host machine (apprentice only)\n");
-   fprintf(stderr, "  -p, --port=PORT   Specify the port to connect to/listen on (default 9191)\n");
+    fprintf(stderr,
+            "Usage: risu [--master] [--host <ip>] [--port <port>] <image file>"
+            "\n\n");
+    fprintf(stderr,
+            "Run through the pattern file verifying each instruction\n");
+    fprintf(stderr, "between master and apprentice risu processes.\n\n");
+    fprintf(stderr, "Options:\n");
+    fprintf(stderr, "  --master          Be the master (server)\n");
+    fprintf(stderr,
+            "  -h, --host=HOST   Specify master host machine (apprentice only)"
+            "\n");
+    fprintf(stderr,
+            "  -p, --port=PORT   Specify the port to connect to/listen on "
+            "(default 9191)\n");
 }
 
 int main(int argc, char **argv)
 {
-   // some handy defaults to make testing easier
-   uint16_t port = 9191;
-   char *hostname = "localhost";
-   char *imgfile;
-   int sock;
-
-   // TODO clean this up later
-   
-   for (;;)
-   {
-      static struct option longopts[] = 
-         {
-            { "help", no_argument, 0, '?'},
-            { "master", no_argument, &ismaster, 1 },
-            { "host", required_argument, 0, 'h' },
-            { "port", required_argument, 0, 'p' },
-            { "test-fp-exc", no_argument, &test_fp_exc, 1 },
-            { 0,0,0,0 }
-         };
-      int optidx = 0;
-      int c = getopt_long(argc, argv, "h:p:", longopts, &optidx);
-      if (c == -1)
-      {
-         break;
-      }
-      
-      switch (c)
-      {
-         case 0:
-         {
+    /* some handy defaults to make testing easier */
+    uint16_t port = 9191;
+    char *hostname = "localhost";
+    char *imgfile;
+    int sock;
+
+    /* TODO clean this up later */
+
+    for (;;) {
+        static struct option longopts[] = {
+            {"help", no_argument, 0, '?'},
+            {"master", no_argument, &ismaster, 1},
+            {"host", required_argument, 0, 'h'},
+            {"port", required_argument, 0, 'p'},
+            {"test-fp-exc", no_argument, &test_fp_exc, 1},
+            {0, 0, 0, 0}
+        };
+        int optidx = 0;
+        int c = getopt_long(argc, argv, "h:p:", longopts, &optidx);
+        if (c == -1) {
+            break;
+        }
+
+        switch (c) {
+        case 0:
+        {
             /* flag set by getopt_long, do nothing */
             break;
-         }
-         case 'h':
-         {
+        }
+        case 'h':
+        {
             hostname = optarg;
             break;
-         }
-         case 'p':
-         {
-            // FIXME err handling
+        }
+        case 'p':
+        {
+            /* FIXME err handling */
             port = strtol(optarg, 0, 10);
             break;
-         }
-         case '?':
-         {
+        }
+        case '?':
+        {
             usage();
             exit(1);
-         }
-         default:
+        }
+        default:
             abort();
-      }
-   }
-
-   imgfile = argv[optind];
-   if (!imgfile)
-   {
-      fprintf(stderr, "Error: must specify image file name\n\n");
-      usage();
-      exit(1);
-   }
-
-   load_image(imgfile);
-   
-   if (ismaster)
-   {
-      fprintf(stderr, "master port %d\n", port);
-      sock = master_connect(port);
-      return master(sock);
-   }
-   else
-   {
-      fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-      sock = apprentice_connect(hostname, port);
-      return apprentice(sock);
-   }
+        }
+    }
+
+    imgfile = argv[optind];
+    if (!imgfile) {
+        fprintf(stderr, "Error: must specify image file name\n\n");
+        usage();
+        exit(1);
+    }
+
+    load_image(imgfile);
+
+    if (ismaster) {
+        fprintf(stderr, "master port %d\n", port);
+        sock = master_connect(port);
+        return master(sock);
+    } else {
+        fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
+        sock = apprentice_connect(hostname, port);
+        return apprentice(sock);
+    }
 }
-
-   
diff --git a/risu.h b/risu.h
index 883bcf7..3fbeda8 100644
--- a/risu.h
+++ b/risu.h
@@ -7,7 +7,7 @@
  *
  * Contributors:
  *     Peter Maydell (Linaro) - initial implementation
- *******************************************************************************/
+ ******************************************************************************/
 
 #ifndef RISU_H
 #define RISU_H
@@ -99,7 +99,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
 /* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE *f);
+int reginfo_dump(struct reginfo *ri, FILE * f);
 
 /* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
diff --git a/risu_arm.c b/risu_arm.c
index f570828..a55c6c2 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -7,7 +7,7 @@
  *
  * Contributors:
  *     Peter Maydell (Linaro) - initial implementation
- *******************************************************************************/
+ ******************************************************************************/
 
 #include <stdio.h>
 #include <ucontext.h>
@@ -18,39 +18,37 @@
 
 int insnsize(ucontext_t *uc)
 {
-   /* Return instruction size in bytes of the
-    * instruction at PC
-    */
-   if (uc->uc_mcontext.arm_cpsr & 0x20) 
-   {
-      uint16_t faulting_insn = *((uint16_t*)uc->uc_mcontext.arm_pc);
-      switch (faulting_insn & 0xF800)
-      {
-         case 0xE800:
-         case 0xF000:
-         case 0xF800:
+    /* Return instruction size in bytes of the
+     * instruction at PC
+     */
+    if (uc->uc_mcontext.arm_cpsr & 0x20) {
+        uint16_t faulting_insn = *((uint16_t *) uc->uc_mcontext.arm_pc);
+        switch (faulting_insn & 0xF800) {
+        case 0xE800:
+        case 0xF000:
+        case 0xF800:
             /* 32 bit Thumb2 instruction */
             return 4;
-         default:
+        default:
             /* 16 bit Thumb instruction */
             return 2;
-      }
-   }
-   /* ARM instruction */
-   return 4;
+        }
+    }
+    /* ARM instruction */
+    return 4;
 }
 
 void advance_pc(void *vuc)
 {
-   ucontext_t *uc = vuc;
-   uc->uc_mcontext.arm_pc += insnsize(uc);
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.arm_pc += insnsize(uc);
 }
 
 
 void set_ucontext_paramreg(void *vuc, uint64_t value)
 {
-   ucontext_t *uc = vuc;
-   uc->uc_mcontext.arm_r0 = value;
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.arm_r0 = value;
 }
 
 uint64_t get_reginfo_paramreg(struct reginfo *ri)
@@ -60,13 +58,13 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
 
 int get_risuop(struct reginfo *ri)
 {
-   /* Return the risuop we have been asked to do
-    * (or -1 if this was a SIGILL for a non-risuop insn)
-    */
-   uint32_t insn = ri->faulting_insn;
-   int isz = ri->faulting_insn_size;
-   uint32_t op = insn & 0xf;
-   uint32_t key = insn & ~0xf;
-   uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
-   return (key != risukey) ? -1 : op;
+    /* Return the risuop we have been asked to do
+     * (or -1 if this was a SIGILL for a non-risuop insn)
+     */
+    uint32_t insn = ri->faulting_insn;
+    int isz = ri->faulting_insn_size;
+    uint32_t op = insn & 0xf;
+    uint32_t key = insn & ~0xf;
+    uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
+    return (key != risukey) ? -1 : op;
 }
diff --git a/risu_i386.c b/risu_i386.c
index bfcb4e1..5e7e01d 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -7,7 +7,7 @@
  *
  * Contributors:
  *     Peter Maydell (Linaro) - initial implementation
- *******************************************************************************/
+ ******************************************************************************/
 
 #include <stdio.h>
 #include <ucontext.h>
@@ -19,10 +19,9 @@
  * It is a simplified and reduced subset of what can
  * be obtained with a ucontext_t*
  */
-struct reginfo
-{
-      uint32_t faulting_insn;
-      gregset_t gregs;
+struct reginfo {
+    uint32_t faulting_insn;
+    gregset_t gregs;
 };
 
 #ifndef REG_GS
@@ -42,34 +41,32 @@ struct reginfo master_ri, apprentice_ri;
 
 static int insn_is_ud2(uint32_t insn)
 {
-   return ((insn & 0xffff) == 0x0b0f);
+    return ((insn & 0xffff) == 0x0b0f);
 }
 
 void advance_pc(void *vuc)
 {
-   /* We assume that this is either UD1 or UD2.
-    * This would need tweaking if we want to test
-    * expected undefs on x86.
-    */
-   ucontext_t *uc = vuc;
-   uc->uc_mcontext.gregs[REG_EIP] += 2;
+    /* We assume that this is either UD1 or UD2.
+     * This would need tweaking if we want to test
+     * expected undefs on x86.
+     */
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t *uc)
+static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
 {
-   int i;
-   for (i = 0; i < NGREG; i++)
-   {
-      switch(i)
-      {
-         case REG_ESP:
-         case REG_UESP:
-         case REG_GS:
-         case REG_FS:
-         case REG_ES:
-         case REG_DS:
-         case REG_TRAPNO:
-         case REG_EFL:
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        switch (i) {
+        case REG_ESP:
+        case REG_UESP:
+        case REG_GS:
+        case REG_FS:
+        case REG_ES:
+        case REG_DS:
+        case REG_TRAPNO:
+        case REG_EFL:
             /* Don't store these registers as it results in mismatches.
              * In particular valgrind has different values for some
              * segment registers, and they're boring anyway.
@@ -78,27 +75,27 @@ static void fill_reginfo(struct reginfo *ri, ucontext_t *uc)
              */
             ri->gregs[i] = 0xDEADBEEF;
             break;
-         case REG_EIP:
+        case REG_EIP:
             /* Store the offset from the start of the test image */
             ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
             break;
-         default:
+        default:
             ri->gregs[i] = uc->uc_mcontext.gregs[i];
             break;
-      }
-   }
-   /* x86 insns aren't 32 bit but we're not really testing x86 so
-    * this is just to distinguish 'do compare' from 'stop'
-    */
-   ri->faulting_insn = *((uint32_t*)uc->uc_mcontext.gregs[REG_EIP]);
+        }
+    }
+    /* x86 insns aren't 32 bit but we're not really testing x86 so
+     * this is just to distinguish 'do compare' from 'stop'
+     */
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
 }
 
 
 int send_register_info(int sock, void *uc)
 {
-   struct reginfo ri;
-   fill_reginfo(&ri, uc);
-   return send_data_pkt(sock, &ri, sizeof(ri));
+    struct reginfo ri;
+    fill_reginfo(&ri, uc);
+    return send_data_pkt(sock, &ri, sizeof(ri));
 }
 
 /* Read register info from the socket and compare it with that from the
@@ -107,43 +104,37 @@ int send_register_info(int sock, void *uc)
  */
 int recv_and_compare_register_info(int sock, void *uc)
 {
-   int resp;
-   fill_reginfo(&master_ri, uc);
-   recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
-   if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0)
-   {
-      /* mismatch */
-      resp = 2;
-   }
-   else if (insn_is_ud2(master_ri.faulting_insn))
-   {
-      /* end of test */
-      resp = 1;
-   }
-   else
-   {
-      /* either successful match or expected undef */
-      resp = 0;
-   }
-   send_response_byte(sock, resp);
-   return resp;
+    int resp;
+    fill_reginfo(&master_ri, uc);
+    recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
+    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0) {
+        /* mismatch */
+        resp = 2;
+    } else if (insn_is_ud2(master_ri.faulting_insn)) {
+        /* end of test */
+        resp = 1;
+    } else {
+        /* either successful match or expected undef */
+        resp = 0;
+    }
+    send_response_byte(sock, resp);
+    return resp;
 }
 
-static char *regname[] = 
-{
-   "GS", "FS", "ES" ,"DS", "EDI", "ESI", "EBP", "ESP",
-   "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-   "CS", "EFL", "UESP", "SS", 0
+static char *regname[] = {
+    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
+    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
+    "CS", "EFL", "UESP", "SS", 0
 };
 
 static void dump_reginfo(struct reginfo *ri)
 {
-   int i;
-   fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
-   for (i = 0; i < NGREG; i++)
-   {
-      fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???", ri->gregs[i]);
-   }
+    int i;
+    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    for (i = 0; i < NGREG; i++) {
+        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+                ri->gregs[i]);
+    }
 }
 
 
@@ -155,16 +146,15 @@ static void dump_reginfo(struct reginfo *ri)
  */
 int report_match_status(void)
 {
-   fprintf(stderr, "match status...\n");
-   fprintf(stderr, "master reginfo:\n");
-   dump_reginfo(&master_ri);
-   fprintf(stderr, "apprentice reginfo:\n");
-   dump_reginfo(&apprentice_ri);
-   if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) == 0)
-   {
-      fprintf(stderr, "match!\n");
-      return 0;
-   }
-   fprintf(stderr, "mismatch!\n");
-   return 1;
+    fprintf(stderr, "match status...\n");
+    fprintf(stderr, "master reginfo:\n");
+    dump_reginfo(&master_ri);
+    fprintf(stderr, "apprentice reginfo:\n");
+    dump_reginfo(&apprentice_ri);
+    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) == 0) {
+        fprintf(stderr, "match!\n");
+        return 0;
+    }
+    fprintf(stderr, "mismatch!\n");
+    return 1;
 }
diff --git a/risu_m68k.c b/risu_m68k.c
index f84ac7a..0bf5c14 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -10,7 +10,7 @@
 
 void advance_pc(void *vuc)
 {
-    ucontext_t *uc = (ucontext_t*)vuc;
+    ucontext_t *uc = (ucontext_t *) vuc;
     uc->uc_mcontext.gregs[R_PC] += 4;
 }
 
diff --git a/risu_ppc64.c b/risu_ppc64.c
index b575078..eb60573 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -15,7 +15,7 @@
 
 void advance_pc(void *vuc)
 {
-    ucontext_t *uc = (ucontext_t*)vuc;
+    ucontext_t *uc = (ucontext_t *) vuc;
     uc->uc_mcontext.regs->nip += 4;
 }
 
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index fe567de..e3fadde 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -26,33 +26,36 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     /* necessary to be able to compare with memcmp later */
     memset(ri, 0, sizeof(*ri));
 
-    for (i = 0; i < 31; i++)
+    for (i = 0; i < 31; i++) {
         ri->regs[i] = uc->uc_mcontext.regs[i];
+    }
 
     ri->sp = 0xdeadbeefdeadbeef;
     ri->pc = uc->uc_mcontext.pc - image_start_address;
-    ri->flags = uc->uc_mcontext.pstate & 0xf0000000; /* get only flags */
+    ri->flags = uc->uc_mcontext.pstate & 0xf0000000;    /* get only flags */
 
     ri->fault_address = uc->uc_mcontext.fault_address;
-    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.pc);
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.pc);
 
-    ctx = (struct _aarch64_ctx *)&uc->uc_mcontext.__reserved[0];
+    ctx = (struct _aarch64_ctx *) &uc->uc_mcontext.__reserved[0];
 
     while (ctx->magic != FPSIMD_MAGIC && ctx->size != 0) {
         ctx += (ctx->size + sizeof(*ctx) - 1) / sizeof(*ctx);
     }
 
     if (ctx->magic != FPSIMD_MAGIC || ctx->size != sizeof(*fp)) {
-        fprintf(stderr, "risu_reginfo_aarch64: failed to get FP/SIMD state\n");
+        fprintf(stderr,
+                "risu_reginfo_aarch64: failed to get FP/SIMD state\n");
         return;
     }
 
-    fp = (struct fpsimd_context *)ctx;
+    fp = (struct fpsimd_context *) ctx;
     ri->fpsr = fp->fpsr;
     ri->fpcr = fp->fpcr;
 
-    for (i = 0; i < 32; i++)
+    for (i = 0; i < 32; i++) {
         ri->vregs[i] = fp->vregs[i];
+    }
 };
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
@@ -62,13 +65,14 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 }
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+int reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
     fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
 
-    for (i = 0; i < 31; i++)
+    for (i = 0; i < 31; i++) {
         fprintf(f, "  X%2d   : %016" PRIx64 "\n", i, ri->regs[i]);
+    }
 
     fprintf(f, "  sp    : %016" PRIx64 "\n", ri->sp);
     fprintf(f, "  pc    : %016" PRIx64 "\n", ri->pc);
@@ -76,16 +80,17 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     fprintf(f, "  fpsr  : %08x\n", ri->fpsr);
     fprintf(f, "  fpcr  : %08x\n", ri->fpcr);
 
-    for (i = 0; i < 32; i++)
+    for (i = 0; i < 32; i++) {
         fprintf(f, "  V%2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
-                (uint64_t)(ri->vregs[i] >> 64),
-                (uint64_t)(ri->vregs[i] & 0xffffffffffffffff));
+                (uint64_t) (ri->vregs[i] >> 64),
+                (uint64_t) (ri->vregs[i] & 0xffffffffffffffff));
+    }
 
     return !ferror(f);
 }
 
 /* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
     fprintf(f, "mismatch detail (master : apprentice):\n");
@@ -94,37 +99,44 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
                 m->faulting_insn, a->faulting_insn);
     }
     for (i = 0; i < 31; i++) {
-        if (m->regs[i] != a->regs[i])
+        if (m->regs[i] != a->regs[i]) {
             fprintf(f, "  X%2d   : %016" PRIx64 " vs %016" PRIx64 "\n",
                     i, m->regs[i], a->regs[i]);
+        }
     }
 
-    if (m->sp != a->sp)
+    if (m->sp != a->sp) {
         fprintf(f, "  sp    : %016" PRIx64 " vs %016" PRIx64 "\n",
                 m->sp, a->sp);
+    }
 
-    if (m->pc != a->pc)
+    if (m->pc != a->pc) {
         fprintf(f, "  pc    : %016" PRIx64 " vs %016" PRIx64 "\n",
                 m->pc, a->pc);
+    }
 
-    if (m->flags != a->flags)
+    if (m->flags != a->flags) {
         fprintf(f, "  flags : %08x vs %08x\n", m->flags, a->flags);
+    }
 
-    if (m->fpsr != a->fpsr)
+    if (m->fpsr != a->fpsr) {
         fprintf(f, "  fpsr  : %08x vs %08x\n", m->fpsr, a->fpsr);
+    }
 
-    if (m->fpcr != a->fpcr)
+    if (m->fpcr != a->fpcr) {
         fprintf(f, "  fpcr  : %08x vs %08x\n", m->fpcr, a->fpcr);
+    }
 
     for (i = 0; i < 32; i++) {
-        if (m->vregs[i] != a->vregs[i])
+        if (m->vregs[i] != a->vregs[i]) {
             fprintf(f, "  V%2d   : "
                     "%016" PRIx64 "%016" PRIx64 " vs "
                     "%016" PRIx64 "%016" PRIx64 "\n", i,
-                    (uint64_t)(m->vregs[i] >> 64),
-                    (uint64_t)(m->vregs[i] & 0xffffffffffffffff),
-                    (uint64_t)(a->vregs[i] >> 64),
-                    (uint64_t)(a->vregs[i] & 0xffffffffffffffff));
+                    (uint64_t) (m->vregs[i] >> 64),
+                    (uint64_t) (m->vregs[i] & 0xffffffffffffffff),
+                    (uint64_t) (a->vregs[i] >> 64),
+                    (uint64_t) (a->vregs[i] & 0xffffffffffffffff));
+        }
     }
 
     return !ferror(f);
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index 3d1b2fd..a05fb4e 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -13,8 +13,7 @@
 #ifndef RISU_REGINFO_AARCH64_H
 #define RISU_REGINFO_AARCH64_H
 
-struct reginfo
-{
+struct reginfo {
     uint64_t fault_address;
     uint64_t regs[31];
     uint64_t sp;
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 5309f3a..8e6736b 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -26,173 +26,173 @@ extern int insnsize(ucontext_t *uc);
 
 static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
 {
-   // Read VFP registers. These live in uc->uc_regspace, which is
-   // a sequence of
-   //   u32 magic
-   //   u32 size
-   //   data....
-   // blocks. We have to skip through to find the one for VFP.
-   unsigned long *rs = uc->uc_regspace;
-
-   for (;;)
-   {
-      switch (*rs++)
-      {
-         case 0:
-         {
-            /* We didn't find any VFP at all (probably a no-VFP
-             * kernel). Zero out all the state to avoid mismatches.
-             */
-            int j;
-            for (j = 0; j < 32; j++)
-               ri->fpregs[j] = 0;
-            ri->fpscr = 0;
-            return;
-         }
-         case 0x56465001: /* VFP_MAGIC */
-         {
-            /* This is the one we care about. The format (after the size word)
-             * is 32 * 64 bit registers, then the 32 bit fpscr, then some stuff
-             * we don't care about.
-             */
-            int i;
-            /* Skip if it's smaller than we expected (should never happen!) */
-            if (*rs < ((32*2)+1))
+    /* Read VFP registers. These live in uc->uc_regspace, which is
+     * a sequence of
+     *   u32 magic
+     *   u32 size
+     *   data....
+     * blocks. We have to skip through to find the one for VFP.
+     */
+    unsigned long *rs = uc->uc_regspace;
+
+    for (;;) {
+        switch (*rs++) {
+        case 0:
             {
-               rs += (*rs / 4);
-               break;
+                /* We didn't find any VFP at all (probably a no-VFP
+                 * kernel). Zero out all the state to avoid mismatches.
+                 */
+                int j;
+                for (j = 0; j < 32; j++) {
+                    ri->fpregs[j] = 0;
+                }
+                ri->fpscr = 0;
+                return;
             }
-            rs++;
-            for (i = 0; i < 32; i++)
+        case 0x56465001:        /* VFP_MAGIC */
             {
-               ri->fpregs[i] = *rs++;
-               ri->fpregs[i] |= (uint64_t)(*rs++) << 32;
+                /* This is the one we care about. The format (after
+                 *  the size word is 32 * 64 bit registers, then the
+                 *  32 bit fpscr, then some stuff we don't care about.
+                 */
+                int i;
+                /* Skip if it's smaller than we expected (should never happen!) */
+                if (*rs < ((32 * 2) + 1)) {
+                    rs += (*rs / 4);
+                    break;
+                }
+                rs++;
+                for (i = 0; i < 32; i++) {
+                    ri->fpregs[i] = *rs++;
+                    ri->fpregs[i] |= (uint64_t) (*rs++) << 32;
+                }
+                /* Ignore the UNK/SBZP bits. We also ignore the cumulative
+                 * exception bits unless we were specifically asked to test
+                 * them on the risu command line -- too much of qemu gets
+                 * them wrong and they aren't actually very important.
+                 */
+                ri->fpscr = (*rs) & 0xffff9f9f;
+                if (!test_fp_exc) {
+                    ri->fpscr &= ~0x9f;
+                }
+                /* Clear the cumulative exception flags. This is a bit
+                 * unclean, but makes sense because otherwise we'd have to
+                 * insert explicit bit-clearing code in the generated code
+                 * to avoid the test becoming useless once all the bits
+                 * get set.
+                 */
+                (*rs) &= ~0x9f;
+                return;
             }
-            /* Ignore the UNK/SBZP bits. We also ignore the cumulative
-             * exception bits unless we were specifically asked to test
-             * them on the risu command line -- too much of qemu gets
-             * them wrong and they aren't actually very important.
-             */
-            ri->fpscr = (*rs) & 0xffff9f9f;
-            if (!test_fp_exc) {
-               ri->fpscr &= ~0x9f;
-            }
-            /* Clear the cumulative exception flags. This is a bit
-             * unclean, but makes sense because otherwise we'd have to
-             * insert explicit bit-clearing code in the generated code
-             * to avoid the test becoming useless once all the bits
-             * get set.
-             */
-            (*rs) &= ~0x9f;
-            return;
-         }
-         default:
+        default:
             /* Some other kind of block, ignore it */
             rs += (*rs / 4);
             break;
-      }
-   }
+        }
+    }
 }
 
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
-   memset(ri, 0, sizeof(*ri)); /* necessary for memcmp later */
-
-   ri->gpreg[0] = uc->uc_mcontext.arm_r0;
-   ri->gpreg[1] = uc->uc_mcontext.arm_r1;
-   ri->gpreg[2] = uc->uc_mcontext.arm_r2;
-   ri->gpreg[3] = uc->uc_mcontext.arm_r3;
-   ri->gpreg[4] = uc->uc_mcontext.arm_r4;
-   ri->gpreg[5] = uc->uc_mcontext.arm_r5;
-   ri->gpreg[6] = uc->uc_mcontext.arm_r6;
-   ri->gpreg[7] = uc->uc_mcontext.arm_r7;
-   ri->gpreg[8] = uc->uc_mcontext.arm_r8;
-   ri->gpreg[9] = uc->uc_mcontext.arm_r9;
-   ri->gpreg[10] = uc->uc_mcontext.arm_r10;
-   ri->gpreg[11] = uc->uc_mcontext.arm_fp;
-   ri->gpreg[12] = uc->uc_mcontext.arm_ip;
-   ri->gpreg[14] = uc->uc_mcontext.arm_lr;
-   ri->gpreg[13] = 0xdeadbeef;
-   ri->gpreg[15] = uc->uc_mcontext.arm_pc - image_start_address;
-   // Mask out everything except NZCVQ GE
-   // In theory we should be OK to compare everything
-   // except the reserved bits, but valgrind for one
-   // doesn't fill in enough fields yet.
-   ri->cpsr = uc->uc_mcontext.arm_cpsr & 0xF80F0000;
-
-   ri->faulting_insn = *((uint16_t*)uc->uc_mcontext.arm_pc);
-   ri->faulting_insn_size = insnsize(uc);
-   if (ri->faulting_insn_size != 2)
-   {
-      ri->faulting_insn |= (*((uint16_t*)uc->uc_mcontext.arm_pc+1)) << 16;
-   }
-
-   reginfo_init_vfp(ri, uc);
+    memset(ri, 0, sizeof(*ri));         /* necessary for memcmp later */
+
+    ri->gpreg[0] = uc->uc_mcontext.arm_r0;
+    ri->gpreg[1] = uc->uc_mcontext.arm_r1;
+    ri->gpreg[2] = uc->uc_mcontext.arm_r2;
+    ri->gpreg[3] = uc->uc_mcontext.arm_r3;
+    ri->gpreg[4] = uc->uc_mcontext.arm_r4;
+    ri->gpreg[5] = uc->uc_mcontext.arm_r5;
+    ri->gpreg[6] = uc->uc_mcontext.arm_r6;
+    ri->gpreg[7] = uc->uc_mcontext.arm_r7;
+    ri->gpreg[8] = uc->uc_mcontext.arm_r8;
+    ri->gpreg[9] = uc->uc_mcontext.arm_r9;
+    ri->gpreg[10] = uc->uc_mcontext.arm_r10;
+    ri->gpreg[11] = uc->uc_mcontext.arm_fp;
+    ri->gpreg[12] = uc->uc_mcontext.arm_ip;
+    ri->gpreg[14] = uc->uc_mcontext.arm_lr;
+    ri->gpreg[13] = 0xdeadbeef;
+    ri->gpreg[15] = uc->uc_mcontext.arm_pc - image_start_address;
+    /* Mask out everything except NZCVQ GE
+     * In theory we should be OK to compare everything
+     * except the reserved bits, but valgrind for one
+     * doesn't fill in enough fields yet.
+     */
+    ri->cpsr = uc->uc_mcontext.arm_cpsr & 0xF80F0000;
+
+    ri->faulting_insn = *((uint16_t *) uc->uc_mcontext.arm_pc);
+    ri->faulting_insn_size = insnsize(uc);
+    if (ri->faulting_insn_size != 2) {
+        ri->faulting_insn |=
+            (*((uint16_t *) uc->uc_mcontext.arm_pc + 1)) << 16;
+    }
+
+    reginfo_init_vfp(ri, uc);
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
-    return memcmp(r1, r2, sizeof(*r1)) == 0; /* ok since we memset 0 */
+    return memcmp(r1, r2, sizeof(*r1)) == 0;    /* ok since we memset 0 */
 }
 
 /* reginfo_dump: print the state to a stream, returns nonzero on success */
 int reginfo_dump(struct reginfo *ri, FILE *f)
 {
-   int i;
-   if (ri->faulting_insn_size == 2)
-      fprintf(f, "  faulting insn %04x\n", ri->faulting_insn);
-   else
-      fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
-   for (i = 0; i < 16; i++)
-   {
-      fprintf(f, "  r%d: %08x\n", i, ri->gpreg[i]);
-   }
-   fprintf(f, "  cpsr: %08x\n", ri->cpsr);
-   for (i = 0; i < 32; i++)
-   {
-      fprintf(f, "  d%d: %016llx\n",
-              i, (unsigned long long)ri->fpregs[i]);
-   }
-   fprintf(f, "  fpscr: %08x\n", ri->fpscr);
-
-   return !ferror(f);
+    int i;
+    if (ri->faulting_insn_size == 2) {
+        fprintf(f, "  faulting insn %04x\n", ri->faulting_insn);
+    } else {
+        fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
+    }
+    for (i = 0; i < 16; i++) {
+        fprintf(f, "  r%d: %08x\n", i, ri->gpreg[i]);
+    }
+    fprintf(f, "  cpsr: %08x\n", ri->cpsr);
+    for (i = 0; i < 32; i++) {
+        fprintf(f, "  d%d: %016llx\n",
+                i, (unsigned long long) ri->fpregs[i]);
+    }
+    fprintf(f, "  fpscr: %08x\n", ri->fpscr);
+
+    return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a,
-                          FILE *f)
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
-   int i;
-   fprintf(f, "mismatch detail (master : apprentice):\n");
-
-   if (m->faulting_insn_size != a->faulting_insn_size)
-      fprintf(f, "  faulting insn size mismatch %d vs %d\n",
-              m->faulting_insn_size, a->faulting_insn_size);
-   else if (m->faulting_insn != a->faulting_insn)
-   {
-      if (m->faulting_insn_size == 2)
-         fprintf(f, "  faulting insn mismatch %04x vs %04x\n",
-                 m->faulting_insn, a->faulting_insn);
-      else
-         fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
-                 m->faulting_insn, a->faulting_insn);
-   }
-   for (i = 0; i < 16; i++)
-   {
-      if (m->gpreg[i] != a->gpreg[i])
-         fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i], a->gpreg[i]);
-   }
-   if (m->cpsr != a->cpsr)
-      fprintf(f, "  cpsr: %08x vs %08x\n", m->cpsr, a->cpsr);
-   for (i = 0; i < 32; i++)
-   {
-      if (m->fpregs[i] != a->fpregs[i])
-         fprintf(f, "  d%d: %016llx vs %016llx\n", i,
-                 (unsigned long long)m->fpregs[i],
-                 (unsigned long long)a->fpregs[i]);
-   }
-   if (m->fpscr != a->fpscr)
-      fprintf(f, "  fpscr: %08x vs %08x\n", m->fpscr, a->fpscr);
-
-   return !ferror(f);
+    int i;
+    fprintf(f, "mismatch detail (master : apprentice):\n");
+
+    if (m->faulting_insn_size != a->faulting_insn_size) {
+        fprintf(f, "  faulting insn size mismatch %d vs %d\n",
+                m->faulting_insn_size, a->faulting_insn_size);
+    } else if (m->faulting_insn != a->faulting_insn) {
+        if (m->faulting_insn_size == 2) {
+            fprintf(f, "  faulting insn mismatch %04x vs %04x\n",
+                    m->faulting_insn, a->faulting_insn);
+        } else {
+            fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+                    m->faulting_insn, a->faulting_insn);
+        }
+    }
+    for (i = 0; i < 16; i++) {
+        if (m->gpreg[i] != a->gpreg[i]) {
+            fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i],
+                    a->gpreg[i]);
+        }
+    }
+    if (m->cpsr != a->cpsr) {
+        fprintf(f, "  cpsr: %08x vs %08x\n", m->cpsr, a->cpsr);
+    }
+    for (i = 0; i < 32; i++) {
+        if (m->fpregs[i] != a->fpregs[i]) {
+            fprintf(f, "  d%d: %016llx vs %016llx\n", i,
+                    (unsigned long long) m->fpregs[i],
+                    (unsigned long long) a->fpregs[i]);
+        }
+    }
+    if (m->fpscr != a->fpscr) {
+        fprintf(f, "  fpscr: %08x vs %08x\n", m->fpscr, a->fpscr);
+    }
+
+    return !ferror(f);
 }
diff --git a/risu_reginfo_arm.h b/risu_reginfo_arm.h
index 96e5791..60754a9 100644
--- a/risu_reginfo_arm.h
+++ b/risu_reginfo_arm.h
@@ -13,8 +13,7 @@
 #ifndef RISU_REGINFO_ARM_H
 #define RISU_REGINFO_ARM_H
 
-struct reginfo
-{
+struct reginfo {
     uint64_t fpregs[32];
     uint32_t faulting_insn;
     uint32_t faulting_insn_size;
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 45950b1..4ff0aa8 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -20,7 +20,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     int i;
     memset(ri, 0, sizeof(*ri));
 
-    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.gregs[R_PC]);
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[R_PC]);
     ri->pc = uc->uc_mcontext.gregs[R_PC] - image_start_address;
 
     for (i = 0; i < NGREG; i++) {
@@ -78,8 +78,7 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    fprintf(f, "  pc            \e[1;101;37m0x%08x\e[0m\n",
-            ri->pc);
+    fprintf(f, "  pc            \e[1;101;37m0x%08x\e[0m\n", ri->pc);
 
     fprintf(f, "\tPC: %08x\n", ri->gregs[R_PC]);
     fprintf(f, "\tPS: %04x\n", ri->gregs[R_PS]);
@@ -101,14 +100,14 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
 
     if (m->gregs[R_PS] != a->gregs[R_PS]) {
-            fprintf(f, "Mismatch: Register PS\n");
-            fprintf(f, "master: [%x] - apprentice: [%x]\n",
-                    m->gregs[R_PS], a->gregs[R_PS]);
+        fprintf(f, "Mismatch: Register PS\n");
+        fprintf(f, "master: [%x] - apprentice: [%x]\n",
+                m->gregs[R_PS], a->gregs[R_PS]);
     }
 
     for (i = 0; i < 16; i++) {
@@ -116,9 +115,10 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
             continue;
         }
         if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register %c%d\n", i < 8 ? 'D' : 'A', i % 8);
-            fprintf(f, "master: [%x] - apprentice: [%x]\n",
-                    m->gregs[i], a->gregs[i]);
+            fprintf(f, "Mismatch: Register %c%d\n", i < 8 ? 'D' : 'A',
+                    i % 8);
+            fprintf(f, "master: [%x] - apprentice: [%x]\n", m->gregs[i],
+                    a->gregs[i]);
         }
     }
 
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
index 06ea61d..c1c9fe6 100644
--- a/risu_reginfo_m68k.h
+++ b/risu_reginfo_m68k.h
@@ -9,8 +9,7 @@
 #ifndef RISU_REGINFO_M68K_H
 #define RISU_REGINFO_M68K_H
 
-struct reginfo
-{
+struct reginfo {
     uint32_t faulting_insn;
     uint32_t pc;
     gregset_t gregs;
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index ae86263..eb9c12b 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -28,7 +28,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     int i;
     memset(ri, 0, sizeof(*ri));
 
-    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.regs->nip);
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.regs->nip);
     ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
 
     for (i = 0; i < NGREG; i++) {
@@ -76,16 +76,16 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
             continue;
         }
 
-        if  (m->fpregs[i] != a->fpregs[i]) {
+        if (m->fpregs[i] != a->fpregs[i]) {
             return 0;
         }
     }
 
     for (i = 0; i < 32; i++) {
         if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
+            m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
+            m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
+            m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
             return 0;
         }
     }
@@ -93,7 +93,7 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 }
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+int reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
 
@@ -153,14 +153,12 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 
     if (m->gregs[XER] != a->gregs[XER]) {
         fprintf(f, "Mismatch: XER\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n",
-                m->gregs[XER], a->gregs[XER]);
+        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[XER], a->gregs[XER]);
     }
 
     if (m->gregs[CCR] != a->gregs[CCR]) {
         fprintf(f, "Mismatch: Cond. Register\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n",
-                m->gregs[CCR], a->gregs[CCR]);
+        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[CCR], a->gregs[CCR]);
     }
 
     for (i = 0; i < 32; i++) {
@@ -168,18 +166,17 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
             continue;
         }
 
-        if  (m->fpregs[i] != a->fpregs[i]) {
+        if (m->fpregs[i] != a->fpregs[i]) {
             fprintf(f, "Mismatch: Register r%d\n", i);
-            fprintf(f, "m: [%f] != a: [%f]\n",
-                    m->fpregs[i], a->fpregs[i]);
+            fprintf(f, "m: [%f] != a: [%f]\n", m->fpregs[i], a->fpregs[i]);
         }
     }
 
     for (i = 0; i < 32; i++) {
         if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
+            m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
+            m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
+            m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
 
             fprintf(f, "Mismatch: Register vr%d\n", i);
             fprintf(f, "m: [%x, %x, %x, %x] != a: [%x, %x, %x, %x]\n",
diff --git a/risu_reginfo_ppc64.h b/risu_reginfo_ppc64.h
index 826143e..7f2c962 100644
--- a/risu_reginfo_ppc64.h
+++ b/risu_reginfo_ppc64.h
@@ -14,8 +14,7 @@
 #ifndef RISU_REGINFO_PPC64LE_H
 #define RISU_REGINFO_PPC64LE_H
 
-struct reginfo
-{
+struct reginfo {
     uint32_t faulting_insn;
     uint32_t prev_insn;
     uint64_t nip;
-- 
2.13.0
