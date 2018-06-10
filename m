Received: from eggs.gnu.org ([2001:4830:134:3::10]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeD-0002um-LI
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeB-0003fE-Sx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:05 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeB-0003f3-Kc
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:03 -0400
Received: by mail-pl0-x242.google.com with SMTP id f1-v6so10399794plt.6
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:16 -1000
Message-Id: <20180610030220.3777-45-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 044/108] linux-user: Split out socketcall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

At the same time, merge do_socketcall into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 194 +++++++++++++++++++++----------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6d8d2eb780..d50c84614e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4184,99 +4184,6 @@ fail:
     return ret;
 }
 
-#ifdef TARGET_NR_socketcall
-/* do_socketcall() must return target values and target errnos. */
-static abi_long do_socketcall(int num, abi_ulong vptr)
-{
-    static const unsigned nargs[] = { /* number of arguments per operation */
-        [TARGET_SYS_SOCKET] = 3,      /* domain, type, protocol */
-        [TARGET_SYS_BIND] = 3,        /* fd, addr, addrlen */
-        [TARGET_SYS_CONNECT] = 3,     /* fd, addr, addrlen */
-        [TARGET_SYS_LISTEN] = 2,      /* fd, backlog */
-        [TARGET_SYS_ACCEPT] = 3,      /* fd, addr, addrlen */
-        [TARGET_SYS_GETSOCKNAME] = 3, /* fd, addr, addrlen */
-        [TARGET_SYS_GETPEERNAME] = 3, /* fd, addr, addrlen */
-        [TARGET_SYS_SOCKETPAIR] = 4,  /* domain, type, protocol, tab */
-        [TARGET_SYS_SEND] = 4,        /* fd, msg, len, flags */
-        [TARGET_SYS_RECV] = 4,        /* fd, msg, len, flags */
-        [TARGET_SYS_SENDTO] = 6,      /* fd, msg, len, flags, addr, addrlen */
-        [TARGET_SYS_RECVFROM] = 6,    /* fd, msg, len, flags, addr, addrlen */
-        [TARGET_SYS_SHUTDOWN] = 2,    /* fd, how */
-        [TARGET_SYS_SETSOCKOPT] = 5,  /* fd, level, optname, optval, optlen */
-        [TARGET_SYS_GETSOCKOPT] = 5,  /* fd, level, optname, optval, optlen */
-        [TARGET_SYS_SENDMSG] = 3,     /* fd, msg, flags */
-        [TARGET_SYS_RECVMSG] = 3,     /* fd, msg, flags */
-        [TARGET_SYS_ACCEPT4] = 4,     /* fd, addr, addrlen, flags */
-        [TARGET_SYS_RECVMMSG] = 4,    /* fd, msgvec, vlen, flags */
-        [TARGET_SYS_SENDMMSG] = 4,    /* fd, msgvec, vlen, flags */
-    };
-    abi_long a[6]; /* max 6 args */
-    unsigned i;
-
-    /* check the range of the first argument num */
-    /* (TARGET_SYS_SENDMMSG is the highest among TARGET_SYS_xxx) */
-    if (num < 1 || num > TARGET_SYS_SENDMMSG) {
-        return -TARGET_EINVAL;
-    }
-    /* ensure we have space for args */
-    if (nargs[num] > ARRAY_SIZE(a)) {
-        return -TARGET_EINVAL;
-    }
-    /* collect the arguments in a[] according to nargs[] */
-    for (i = 0; i < nargs[num]; ++i) {
-        if (get_user_ual(a[i], vptr + i * sizeof(abi_long)) != 0) {
-            return -TARGET_EFAULT;
-        }
-    }
-    /* now when we have the args, invoke the appropriate underlying function */
-    switch (num) {
-    case TARGET_SYS_SOCKET: /* domain, type, protocol */
-        return do_socket(a[0], a[1], a[2]);
-    case TARGET_SYS_BIND: /* sockfd, addr, addrlen */
-        return do_bind(a[0], a[1], a[2]);
-    case TARGET_SYS_CONNECT: /* sockfd, addr, addrlen */
-        return do_connect(a[0], a[1], a[2]);
-    case TARGET_SYS_LISTEN: /* sockfd, backlog */
-        return get_errno(listen(a[0], a[1]));
-    case TARGET_SYS_ACCEPT: /* sockfd, addr, addrlen */
-        return do_accept4(a[0], a[1], a[2], 0);
-    case TARGET_SYS_GETSOCKNAME: /* sockfd, addr, addrlen */
-        return do_getsockname(a[0], a[1], a[2]);
-    case TARGET_SYS_GETPEERNAME: /* sockfd, addr, addrlen */
-        return do_getpeername(a[0], a[1], a[2]);
-    case TARGET_SYS_SOCKETPAIR: /* domain, type, protocol, tab */
-        return do_socketpair(a[0], a[1], a[2], a[3]);
-    case TARGET_SYS_SEND: /* sockfd, msg, len, flags */
-        return do_sendto(a[0], a[1], a[2], a[3], 0, 0);
-    case TARGET_SYS_RECV: /* sockfd, msg, len, flags */
-        return do_recvfrom(a[0], a[1], a[2], a[3], 0, 0);
-    case TARGET_SYS_SENDTO: /* sockfd, msg, len, flags, addr, addrlen */
-        return do_sendto(a[0], a[1], a[2], a[3], a[4], a[5]);
-    case TARGET_SYS_RECVFROM: /* sockfd, msg, len, flags, addr, addrlen */
-        return do_recvfrom(a[0], a[1], a[2], a[3], a[4], a[5]);
-    case TARGET_SYS_SHUTDOWN: /* sockfd, how */
-        return get_errno(shutdown(a[0], a[1]));
-    case TARGET_SYS_SETSOCKOPT: /* sockfd, level, optname, optval, optlen */
-        return do_setsockopt(a[0], a[1], a[2], a[3], a[4]);
-    case TARGET_SYS_GETSOCKOPT: /* sockfd, level, optname, optval, optlen */
-        return do_getsockopt(a[0], a[1], a[2], a[3], a[4]);
-    case TARGET_SYS_SENDMSG: /* sockfd, msg, flags */
-        return do_sendrecvmsg(a[0], a[1], a[2], 1);
-    case TARGET_SYS_RECVMSG: /* sockfd, msg, flags */
-        return do_sendrecvmsg(a[0], a[1], a[2], 0);
-    case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
-        return do_accept4(a[0], a[1], a[2], a[3]);
-    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0);
-    case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
-    default:
-        gemu_log("Unsupported socketcall: %d\n", num);
-        return -TARGET_EINVAL;
-    }
-}
-#endif
-
 #define N_SHM_REGIONS	32
 
 static struct shm_region {
@@ -9575,6 +9482,100 @@ IMPL(sigsuspend)
 }
 #endif
 
+#ifdef TARGET_NR_socketcall
+IMPL(socketcall)
+{
+    static const unsigned nargs[] = { /* number of arguments per operation */
+        [TARGET_SYS_SOCKET] = 3,      /* domain, type, protocol */
+        [TARGET_SYS_BIND] = 3,        /* fd, addr, addrlen */
+        [TARGET_SYS_CONNECT] = 3,     /* fd, addr, addrlen */
+        [TARGET_SYS_LISTEN] = 2,      /* fd, backlog */
+        [TARGET_SYS_ACCEPT] = 3,      /* fd, addr, addrlen */
+        [TARGET_SYS_GETSOCKNAME] = 3, /* fd, addr, addrlen */
+        [TARGET_SYS_GETPEERNAME] = 3, /* fd, addr, addrlen */
+        [TARGET_SYS_SOCKETPAIR] = 4,  /* domain, type, protocol, tab */
+        [TARGET_SYS_SEND] = 4,        /* fd, msg, len, flags */
+        [TARGET_SYS_RECV] = 4,        /* fd, msg, len, flags */
+        [TARGET_SYS_SENDTO] = 6,      /* fd, msg, len, flags, addr, addrlen */
+        [TARGET_SYS_RECVFROM] = 6,    /* fd, msg, len, flags, addr, addrlen */
+        [TARGET_SYS_SHUTDOWN] = 2,    /* fd, how */
+        [TARGET_SYS_SETSOCKOPT] = 5,  /* fd, level, optname, optval, optlen */
+        [TARGET_SYS_GETSOCKOPT] = 5,  /* fd, level, optname, optval, optlen */
+        [TARGET_SYS_SENDMSG] = 3,     /* fd, msg, flags */
+        [TARGET_SYS_RECVMSG] = 3,     /* fd, msg, flags */
+        [TARGET_SYS_ACCEPT4] = 4,     /* fd, addr, addrlen, flags */
+        [TARGET_SYS_RECVMMSG] = 4,    /* fd, msgvec, vlen, flags */
+        [TARGET_SYS_SENDMMSG] = 4,    /* fd, msgvec, vlen, flags */
+    };
+    abi_ulong vptr = arg2;
+    abi_long a[6]; /* max 6 args */
+    unsigned i;
+
+    /* check the range of the first argument num */
+    num = arg1;
+    /* (TARGET_SYS_SENDMMSG is the highest among TARGET_SYS_xxx) */
+    if (num < 1 || num > TARGET_SYS_SENDMMSG) {
+        return -TARGET_EINVAL;
+    }
+    /* ensure we have space for args */
+    if (nargs[num] > ARRAY_SIZE(a)) {
+        return -TARGET_EINVAL;
+    }
+    /* collect the arguments in a[] according to nargs[] */
+    for (i = 0; i < nargs[num]; ++i) {
+        if (get_user_ual(a[i], vptr + i * sizeof(abi_long)) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+    /* now when we have the args, invoke the appropriate underlying function */
+    switch (num) {
+    case TARGET_SYS_SOCKET: /* domain, type, protocol */
+        return do_socket(a[0], a[1], a[2]);
+    case TARGET_SYS_BIND: /* sockfd, addr, addrlen */
+        return do_bind(a[0], a[1], a[2]);
+    case TARGET_SYS_CONNECT: /* sockfd, addr, addrlen */
+        return do_connect(a[0], a[1], a[2]);
+    case TARGET_SYS_LISTEN: /* sockfd, backlog */
+        return get_errno(listen(a[0], a[1]));
+    case TARGET_SYS_ACCEPT: /* sockfd, addr, addrlen */
+        return do_accept4(a[0], a[1], a[2], 0);
+    case TARGET_SYS_GETSOCKNAME: /* sockfd, addr, addrlen */
+        return do_getsockname(a[0], a[1], a[2]);
+    case TARGET_SYS_GETPEERNAME: /* sockfd, addr, addrlen */
+        return do_getpeername(a[0], a[1], a[2]);
+    case TARGET_SYS_SOCKETPAIR: /* domain, type, protocol, tab */
+        return do_socketpair(a[0], a[1], a[2], a[3]);
+    case TARGET_SYS_SEND: /* sockfd, msg, len, flags */
+        return do_sendto(a[0], a[1], a[2], a[3], 0, 0);
+    case TARGET_SYS_RECV: /* sockfd, msg, len, flags */
+        return do_recvfrom(a[0], a[1], a[2], a[3], 0, 0);
+    case TARGET_SYS_SENDTO: /* sockfd, msg, len, flags, addr, addrlen */
+        return do_sendto(a[0], a[1], a[2], a[3], a[4], a[5]);
+    case TARGET_SYS_RECVFROM: /* sockfd, msg, len, flags, addr, addrlen */
+        return do_recvfrom(a[0], a[1], a[2], a[3], a[4], a[5]);
+    case TARGET_SYS_SHUTDOWN: /* sockfd, how */
+        return get_errno(shutdown(a[0], a[1]));
+    case TARGET_SYS_SETSOCKOPT: /* sockfd, level, optname, optval, optlen */
+        return do_setsockopt(a[0], a[1], a[2], a[3], a[4]);
+    case TARGET_SYS_GETSOCKOPT: /* sockfd, level, optname, optval, optlen */
+        return do_getsockopt(a[0], a[1], a[2], a[3], a[4]);
+    case TARGET_SYS_SENDMSG: /* sockfd, msg, flags */
+        return do_sendrecvmsg(a[0], a[1], a[2], 1);
+    case TARGET_SYS_RECVMSG: /* sockfd, msg, flags */
+        return do_sendrecvmsg(a[0], a[1], a[2], 0);
+    case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
+        return do_accept4(a[0], a[1], a[2], a[3]);
+    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags */
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0);
+    case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
+    default:
+        gemu_log("Unsupported socketcall: %d\n", num);
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 #ifdef TARGET_NR_ssetmask
 IMPL(ssetmask)
 {
@@ -9924,10 +9925,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_socketcall
-    case TARGET_NR_socketcall:
-        return do_socketcall(arg1, arg2);
-#endif
 #ifdef TARGET_NR_accept
     case TARGET_NR_accept:
         return do_accept4(arg1, arg2, arg3, 0);
@@ -12935,6 +12932,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sigsuspend
         SYSCALL(sigsuspend);
 #endif
+#ifdef TARGET_NR_socketcall
+        SYSCALL(socketcall);
+#endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
 #endif
-- 
2.17.1
