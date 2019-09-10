Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3AFC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD8221479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuBKYNJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD8221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hVw-0004uX-E3
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNp-0005VA-Lx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNj-0004zE-RP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNj-0004yn-Ko
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id k6so8680231wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KUZg/wLKZ46VG6GAy4EjR/UMqLr/ow3tF/QTUuuGP6s=;
 b=LuBKYNJ2o5yuSO/JadJO497TvA6PWxuyGKpPqe4eEc2yMcDuqW4SEbEwTqyEC6nN23
 wGxD0GFSQdHUixcTYy1RJ6epcEouLrlp6FiKKjBLy8wuNvWGTpuQANZ7bhHsZaVy2dUl
 PcK2tX5KGhAHwj0NJqFTpR6XgTdMQPKqstPxa2E0qRHw1lIe7qQI4S5HhqVhe9RzuSXn
 0PdEBZAHs5uKAwwn5XBi38fL0Xo7XEy9nOFuQoM8ms+elJ6Jfzvs6fnBOXOOpfV5PfTs
 jj6OAfnZ8A1tKwcBV/222DiVGULl0oY2uJEVzadV3YgNHXIVwgo+9UpmpIRgO8INSAw2
 mLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KUZg/wLKZ46VG6GAy4EjR/UMqLr/ow3tF/QTUuuGP6s=;
 b=TApzCVbL45P3VNRlCWk7jrAY+8DSNespkrRicy1RPfgXLA6h7tQNRZmpu4+ki1vnN5
 t5djhIxubjLFB91GfIBmULRdbScxSWoGzKqRBp5jnhlyJtfXSDMfwuGLdjC1HNuuPPVO
 9OaUVU/QqZvtdma1gMuDg1dEIvO6bC/YeK/T5OSK8qSsDY9/B0V6iP9irp4rqzPzSX9t
 2Z9Pm75njYaC54I2KBuXKbSIWcIRmnyVR+3A+0/WNXLrVK/cUa2AyYWsH1So1of7+OoY
 QlgNs3ZZjDDn34n9vqkeQfUPXvca+8GnTd56lP2LN48RebCvjwuf8a9ebig1qFBMFJD0
 mXRw==
X-Gm-Message-State: APjAAAVL9yybpDQ1sM1mDkbrwlvQYXBXS4sgwSsXjPwm48SEd+ty6QgS
 Mv6HnwdZ8h4Z1PYra+azB+am1PaOaSy2nQ==
X-Google-Smtp-Source: APXvYqz6fj6i7q1gnuVUGw61bloat/7qqEawTK4ouVolIaV3M2ppksvMMat/Sx8B2xr2qLl8jPu3Zw==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr27816658wrq.72.1568126674549; 
 Tue, 10 Sep 2019 07:44:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:18 +0100
Message-Id: <20190910144428.32597-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PATCH 03/13] target/arm/arm-semi: Make semihosting
 code hand out its own file descriptors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the Arm semihosting code returns the guest file descriptors
(handles) which are simply the fd values from the host OS or the
remote gdbstub. Part of the semihosting 2.0 specification requires
that we implement special handling of opening a ":semihosting-features"
filename. Guest fds which result from opening the special file
won't correspond to host fds, so to ensure that we don't end up
with duplicate fds we need to have QEMU code control the allocation
of the fd values we give the guest.

Add in an abstraction layer which lets us allocate new guest FD
values, and translate from a guest FD value back to the host one.
This also fixes an odd hole where a semihosting guest could
use the semihosting API to read, write or close file descriptors
that it had never allocated but which were being used by QEMU itself.
(This isn't a security hole, because enabling semihosting permits
the guest to do arbitrary file access to the whole host filesystem,
and so should only be done if the guest is completely trusted.)

Currently the only kind of guest fd is one which maps to a
host fd, but in a following commit we will add one which maps
to the :semihosting-features magic data.

If the guest is migrated with an open semihosting file descriptor
then subsequent attempts to use the fd will all fail; this is
not a change from the previous situation (where the host fd
being used on the source end would not be re-opened on the
destination end).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 201 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 186 insertions(+), 15 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 51b55816faf..05491bf5248 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -106,6 +106,113 @@ static int open_modeflags[12] = {
     O_RDWR | O_CREAT | O_APPEND | O_BINARY
 };
 
+typedef enum GuestFDType {
+    GuestFDUnused = 0,
+    GuestFDHost = 1,
+} GuestFDType;
+
+/*
+ * Guest file descriptors are integer indexes into an array of
+ * these structures (we will dynamically resize as necessary).
+ */
+typedef struct GuestFD {
+    GuestFDType type;
+    int hostfd;
+} GuestFD;
+
+static GArray *guestfd_array;
+
+/*
+ * Allocate a new guest file descriptor and return it; if we
+ * couldn't allocate a new fd then return -1.
+ * This is a fairly simplistic implementation because we don't
+ * expect that most semihosting guest programs will make very
+ * heavy use of opening and closing fds.
+ */
+static int alloc_guestfd(void)
+{
+    guint i;
+
+    if (!guestfd_array) {
+        /* New entries zero-initialized, i.e. type GuestFDUnused */
+        guestfd_array = g_array_new(FALSE, TRUE, sizeof(GuestFD));
+    }
+
+    for (i = 0; i < guestfd_array->len; i++) {
+        GuestFD *gf = &g_array_index(guestfd_array, GuestFD, i);
+
+        if (gf->type == GuestFDUnused) {
+            return i;
+        }
+    }
+
+    /* All elements already in use: expand the array */
+    g_array_set_size(guestfd_array, i + 1);
+    return i;
+}
+
+/*
+ * Look up the guestfd in the data structure; return NULL
+ * for out of bounds, but don't check whether the slot is unused.
+ * This is used internally by the other guestfd functions.
+ */
+static GuestFD *do_get_guestfd(int guestfd)
+{
+    if (!guestfd_array) {
+        return NULL;
+    }
+
+    if (guestfd < 0 || guestfd >= guestfd_array->len) {
+        return NULL;
+    }
+
+    return &g_array_index(guestfd_array, GuestFD, guestfd);
+}
+
+/*
+ * Associate the specified guest fd (which must have been
+ * allocated via alloc_fd() and not previously used) with
+ * the specified host fd.
+ */
+static void associate_guestfd(int guestfd, int hostfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    assert(gf);
+    gf->type = GuestFDHost;
+    gf->hostfd = hostfd;
+}
+
+/*
+ * Deallocate the specified guest file descriptor. This doesn't
+ * close the host fd, it merely undoes the work of alloc_fd().
+ */
+static void dealloc_guestfd(int guestfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    assert(gf);
+    gf->type = GuestFDUnused;
+}
+
+/*
+ * Given a guest file descriptor, get the associated struct.
+ * If the fd is not valid, return NULL. This is the function
+ * used by the various semihosting calls to validate a handle
+ * from the guest.
+ * Note: calling alloc_guestfd() or dealloc_guestfd() will
+ * invalidate any GuestFD* obtained by calling this function.
+ */
+static GuestFD *get_guestfd(int guestfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    if (!gf || gf->type == GuestFDUnused) {
+        return NULL;
+    }
+    return gf;
+}
+
 #ifdef CONFIG_USER_ONLY
 static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
 {
@@ -272,6 +379,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 #else
     CPUARMState *ts = env;
 #endif
+    GuestFD *gf;
 
     if (is_a64(env)) {
         /* Note that the syscall number is in W0, not X0 */
@@ -284,6 +392,9 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
     switch (nr) {
     case TARGET_SYS_OPEN:
+    {
+        int guestfd;
+
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
@@ -297,10 +408,19 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             errno = EINVAL;
             return set_swi_errno(ts, -1);
         }
+
+        guestfd = alloc_guestfd();
+        if (guestfd < 0) {
+            unlock_user(s, arg0, 0);
+            errno = EMFILE;
+            return set_swi_errno(ts, -1);
+        }
+
         if (strcmp(s, ":tt") == 0) {
             int result_fileno = arg1 < 4 ? STDIN_FILENO : STDOUT_FILENO;
+            associate_guestfd(guestfd, result_fileno);
             unlock_user(s, arg0, 0);
-            return result_fileno;
+            return guestfd;
         }
         if (use_gdb_syscalls()) {
             ret = arm_gdb_syscall(cpu, arm_semi_cb, "open,%s,%x,1a4", arg0,
@@ -308,15 +428,31 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             ret = set_swi_errno(ts, open(s, open_modeflags[arg1], 0644));
         }
+        if (ret == (uint32_t)-1) {
+            dealloc_guestfd(guestfd);
+        } else {
+            associate_guestfd(guestfd, ret);
+            ret = guestfd;
+        }
         unlock_user(s, arg0, 0);
         return ret;
+    }
     case TARGET_SYS_CLOSE:
         GET_ARG(0);
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", arg0);
-        } else {
-            return set_swi_errno(ts, close(arg0));
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
         }
+
+        if (use_gdb_syscalls()) {
+            ret = arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
+        } else {
+            ret = set_swi_errno(ts, close(gf->hostfd));
+        }
+        dealloc_guestfd(arg0);
+        return ret;
     case TARGET_SYS_WRITEC:
         qemu_semihosting_console_outc(env, args);
         return 0xdeadbeef;
@@ -327,17 +463,24 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(1);
         GET_ARG(2);
         len = arg2;
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
+        }
+
         if (use_gdb_syscalls()) {
             arm_semi_syscall_len = len;
             return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
-                                   arg0, arg1, len);
+                                   gf->hostfd, arg1, len);
         } else {
             s = lock_user(VERIFY_READ, arg1, len, 1);
             if (!s) {
                 /* Return bytes not written on error */
                 return len;
             }
-            ret = set_swi_errno(ts, write(arg0, s, len));
+            ret = set_swi_errno(ts, write(gf->hostfd, s, len));
             unlock_user(s, arg1, 0);
             if (ret == (uint32_t)-1) {
                 ret = 0;
@@ -350,10 +493,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(1);
         GET_ARG(2);
         len = arg2;
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
+        }
+
         if (use_gdb_syscalls()) {
             arm_semi_syscall_len = len;
             return arm_gdb_syscall(cpu, arm_semi_cb, "read,%x,%x,%x",
-                                   arg0, arg1, len);
+                                   gf->hostfd, arg1, len);
         } else {
             s = lock_user(VERIFY_WRITE, arg1, len, 0);
             if (!s) {
@@ -361,7 +511,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 return len;
             }
             do {
-                ret = set_swi_errno(ts, read(arg0, s, len));
+                ret = set_swi_errno(ts, read(gf->hostfd, s, len));
             } while (ret == -1 && errno == EINTR);
             unlock_user(s, arg1, len);
             if (ret == (uint32_t)-1) {
@@ -375,31 +525,52 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         return 0;
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
+        }
+
         if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", arg0);
+            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
         } else {
-            return isatty(arg0);
+            return isatty(gf->hostfd);
         }
     case TARGET_SYS_SEEK:
         GET_ARG(0);
         GET_ARG(1);
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
+        }
+
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
-                                   arg0, arg1);
+                                   gf->hostfd, arg1);
         } else {
-            ret = set_swi_errno(ts, lseek(arg0, arg1, SEEK_SET));
+            ret = set_swi_errno(ts, lseek(gf->hostfd, arg1, SEEK_SET));
             if (ret == (uint32_t)-1)
               return -1;
             return 0;
         }
     case TARGET_SYS_FLEN:
         GET_ARG(0);
+
+        gf = get_guestfd(arg0);
+        if (!gf) {
+            errno = EBADF;
+            return set_swi_errno(ts, -1);
+        }
+
         if (use_gdb_syscalls()) {
             return arm_gdb_syscall(cpu, arm_semi_flen_cb, "fstat,%x,%x",
-                                   arg0, arm_flen_buf(cpu));
+                                   gf->hostfd, arm_flen_buf(cpu));
         } else {
             struct stat buf;
-            ret = set_swi_errno(ts, fstat(arg0, &buf));
+            ret = set_swi_errno(ts, fstat(gf->hostfd, &buf));
             if (ret == (uint32_t)-1)
                 return -1;
             return buf.st_size;
-- 
2.20.1


