Received: from eggs.gnu.org ([2001:4830:134:3::10]:44916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu0OG-0004tQ-SN
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cu0OC-0008HB-8L
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cu0OB-0008GE-Ul
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:31:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C006D3DBD7
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 17:31:06 +0000 (UTC)
Date: Fri, 31 Mar 2017 18:31:01 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170331173101.GL30620@redhat.com>
References: <20170331164322.24020-1-stefanha@redhat.com>
	<4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <4de63a1a-e385-e22f-9bc4-f29d90cbdc30@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Frediano Ziglio <fziglio@redhat.com>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 31, 2017 at 06:53:56PM +0200, Paolo Bonzini wrote:
> glib is expecting QEMU to use g_main_context_acquire around accesses to 
> GMainContext.  However QEMU is not doing that, instead it is taking its 
> own mutex.  So we should add g_main_context_acquire and
> g_main_context_release in the two implementations of 
> os_host_main_loop_wait; these should undo the effect of Frediano's 
> glib patch.

Based on this paragraph, I'm testing the attached patch, and it does
also appear to solve the hanging serial port problem.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-main-loop-Acquire-main_context-lock-around-os_host_m.patch"

>From d46afa25dae0f1d057cfac3a0b6ae94771be51f2 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri, 31 Mar 2017 18:29:01 +0100
Subject: [PATCH] main-loop: Acquire main_context lock around
 os_host_main_loop_wait.

---
 util/main-loop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/util/main-loop.c b/util/main-loop.c
index 4534c89..19cad6b 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -218,9 +218,12 @@ static void glib_pollfds_poll(void)
 
 static int os_host_main_loop_wait(int64_t timeout)
 {
+    GMainContext *context = g_main_context_default();
     int ret;
     static int spin_counter;
 
+    g_main_context_acquire(context);
+
     glib_pollfds_fill(&timeout);
 
     /* If the I/O thread is very busy or we are incorrectly busy waiting in
@@ -256,6 +259,9 @@ static int os_host_main_loop_wait(int64_t timeout)
     }
 
     glib_pollfds_poll();
+
+    g_main_context_release(context);
+
     return ret;
 }
 #else
@@ -412,12 +418,15 @@ static int os_host_main_loop_wait(int64_t timeout)
     fd_set rfds, wfds, xfds;
     int nfds;
 
+    g_main_context_acquire(context);
+
     /* XXX: need to suppress polling by better using win32 events */
     ret = 0;
     for (pe = first_polling_entry; pe != NULL; pe = pe->next) {
         ret |= pe->func(pe->opaque);
     }
     if (ret != 0) {
+        g_main_context_release(context);
         return ret;
     }
 
@@ -472,6 +481,8 @@ static int os_host_main_loop_wait(int64_t timeout)
         g_main_context_dispatch(context);
     }
 
+    g_main_context_release(context);
+
     return select_ret || g_poll_ret;
 }
 #endif
-- 
2.9.3


--cNdxnHkX5QqsyA0e--
