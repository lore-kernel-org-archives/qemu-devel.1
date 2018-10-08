Received: from eggs.gnu.org ([2001:4830:134:3::10]:43961)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9N-0006aQ-HI
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9J-0002Vo-Tl
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:09 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:45007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9I-0002SO-Uh
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:05 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
From: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>
Date: Sun,  7 Oct 2018 21:27:47 -0700
Message-Id: <20181008042747.10130-3-cst@tolva.net>
In-Reply-To: <20181008042747.10130-1-cst@tolva.net>
References: <20181008042747.10130-1-cst@tolva.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] linux-user: Implement usbfs submit and
 reap ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Userspace submits a USB Request Buffer to the kernel, optionally
discards it, and finally reaps the URB.  Thunk buffers from target
to host and back.

Tested by running an i386 scanner driver on ARMv7, by running
the PowerPC lsusb utility on x86_64, and MIPS lsusb on ARMv7.  
The discard urb ioctl is implemented but has not been tested.

Signed-off-by: Cortland Tölva <cst@tolva.net>
---
lsusb was run with -vv so as to exercise the submit and reap ioctls.

 linux-user/ioctls.h        |   8 ++
 linux-user/syscall.c       | 177 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |   4 +
 linux-user/syscall_types.h |  20 +++++
 4 files changed, 209 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 92f6177f1d..ae8951625f 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -143,6 +143,14 @@
   IOCTL(USBDEVFS_SETCONFIGURATION, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(USBDEVFS_GETDRIVER, IOC_R,
         MK_PTR(MK_STRUCT(STRUCT_usbdevfs_getdriver)))
+  IOCTL_SPECIAL(USBDEVFS_SUBMITURB, IOC_W, do_ioctl_usbdevfs_submiturb,
+      MK_PTR(MK_STRUCT(STRUCT_usbdevfs_urb)))
+  IOCTL_SPECIAL(USBDEVFS_DISCARDURB, IOC_RW, do_ioctl_usbdevfs_discardurb,
+      MK_PTR(MK_STRUCT(STRUCT_usbdevfs_urb)))
+  IOCTL_SPECIAL(USBDEVFS_REAPURB, IOC_R, do_ioctl_usbdevfs_reapurb,
+      MK_PTR(TYPE_PTRVOID))
+  IOCTL_SPECIAL(USBDEVFS_REAPURBNDELAY, IOC_R, do_ioctl_usbdevfs_reapurb,
+      MK_PTR(TYPE_PTRVOID))
   IOCTL(USBDEVFS_DISCSIGNAL, IOC_W,
         MK_PTR(MK_STRUCT(STRUCT_usbdevfs_disconnectsignal)))
   IOCTL(USBDEVFS_CLAIMINTERFACE, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2641260186..9b7ea96cfb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -96,6 +96,7 @@
 #include <linux/fb.h>
 #if defined(CONFIG_USBFS)
 #include <linux/usbdevice_fs.h>
+#include <linux/usb/ch9.h>
 #endif
 #include <linux/vt.h>
 #include <linux/dm-ioctl.h>
@@ -4199,6 +4200,182 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
     return ret;
 }
 
+#if defined(CONFIG_USBFS)
+#if HOST_LONG_BITS > 64
+#error USBDEVFS thunks do not support >64 bit hosts yet.
+#endif
+struct live_urb {
+    uint64_t target_urb_adr;
+    uint64_t target_buf_adr;
+    char *target_buf_ptr;
+    struct usbdevfs_urb host_urb;
+};
+
+static GHashTable *usbdevfs_urb_hashtable(void)
+{
+    static GHashTable *urb_hashtable;
+
+    if (!urb_hashtable) {
+        urb_hashtable = g_hash_table_new(g_int64_hash, g_int64_equal);
+    }
+    return urb_hashtable;
+}
+
+static void urb_hashtable_insert(struct live_urb *urb)
+{
+    GHashTable *urb_hashtable = usbdevfs_urb_hashtable();
+    g_hash_table_insert(urb_hashtable, urb, urb);
+}
+
+static struct live_urb *urb_hashtable_lookup(uint64_t target_urb_adr)
+{
+    GHashTable *urb_hashtable = usbdevfs_urb_hashtable();
+    return g_hash_table_lookup(urb_hashtable, &target_urb_adr);
+}
+
+static void urb_hashtable_remove(struct live_urb *urb)
+{
+    GHashTable *urb_hashtable = usbdevfs_urb_hashtable();
+    g_hash_table_remove(urb_hashtable, urb);
+}
+
+static abi_long
+do_ioctl_usbdevfs_reapurb(const IOCTLEntry *ie, uint8_t *buf_temp,
+                          int fd, int cmd, abi_long arg)
+{
+    const argtype usbfsurb_arg_type[] = { MK_STRUCT(STRUCT_usbdevfs_urb) };
+    const argtype ptrvoid_arg_type[] = { TYPE_PTRVOID, 0, 0 };
+    struct live_urb *lurb;
+    void *argptr;
+    uint64_t hurb;
+    int target_size;
+    uintptr_t target_urb_adr;
+    abi_long ret;
+
+    target_size = thunk_type_size(usbfsurb_arg_type, THUNK_TARGET);
+
+    memset(buf_temp, 0, sizeof(uint64_t));
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    memcpy(&hurb, buf_temp, sizeof(uint64_t));
+    lurb = (void *)((uintptr_t)hurb - offsetof(struct live_urb, host_urb));
+    if (!lurb->target_urb_adr) {
+        return -TARGET_EFAULT;
+    }
+    urb_hashtable_remove(lurb);
+    unlock_user(lurb->target_buf_ptr, lurb->target_buf_adr,
+        lurb->host_urb.buffer_length);
+    lurb->target_buf_ptr = NULL;
+
+    /* restore the guest buffer pointer */
+    lurb->host_urb.buffer = (void *)(uintptr_t)lurb->target_buf_adr;
+
+    /* update the guest urb struct */
+    argptr = lock_user(VERIFY_WRITE, lurb->target_urb_adr, target_size, 0);
+    if (!argptr) {
+        g_free(lurb);
+        return -TARGET_EFAULT;
+    }
+    thunk_convert(argptr, &lurb->host_urb, usbfsurb_arg_type, THUNK_TARGET);
+    unlock_user(argptr, lurb->target_urb_adr, target_size);
+
+    target_size = thunk_type_size(ptrvoid_arg_type, THUNK_TARGET);
+    /* write back the urb handle */
+    argptr = lock_user(VERIFY_WRITE, arg, target_size, 0);
+    if (!argptr) {
+        g_free(lurb);
+        return -TARGET_EFAULT;
+    }
+
+    /* GHashTable uses 64-bit keys but thunk_convert expects uintptr_t */
+    target_urb_adr = lurb->target_urb_adr;
+    thunk_convert(argptr, &target_urb_adr, ptrvoid_arg_type, THUNK_TARGET);
+    unlock_user(argptr, arg, target_size);
+
+    g_free(lurb);
+    return ret;
+}
+
+static abi_long
+do_ioctl_usbdevfs_discardurb(const IOCTLEntry *ie,
+                             uint8_t *buf_temp __attribute__((unused)),
+                             int fd, int cmd, abi_long arg)
+{
+    struct live_urb *lurb;
+
+    /* map target address back to host URB with metadata. */
+    lurb = urb_hashtable_lookup(arg);
+    if (!lurb) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(safe_ioctl(fd, ie->host_cmd, &lurb->host_urb));
+}
+
+static abi_long
+do_ioctl_usbdevfs_submiturb(const IOCTLEntry *ie, uint8_t *buf_temp,
+                            int fd, int cmd, abi_long arg)
+{
+    const argtype *arg_type = ie->arg_type;
+    int target_size;
+    abi_long ret;
+    void *argptr;
+    int rw_dir;
+    struct live_urb *lurb;
+
+    /*
+     * each submitted URB needs to map to a unique ID for the
+     * kernel, and that unique ID needs to be a pointer to
+     * host memory.  hence, we need to malloc for each URB.
+     * isochronous transfers have a variable length struct.
+     */
+    arg_type++;
+    target_size = thunk_type_size(arg_type, THUNK_TARGET);
+
+    /* construct host copy of urb and metadata */
+    lurb = g_try_malloc0(sizeof(struct live_urb));
+    if (!lurb) {
+        return -TARGET_ENOMEM;
+    }
+
+    argptr = lock_user(VERIFY_READ, arg, target_size, 1);
+    if (!argptr) {
+        g_free(lurb);
+        return -TARGET_EFAULT;
+    }
+    thunk_convert(&lurb->host_urb, argptr, arg_type, THUNK_HOST);
+    unlock_user(argptr, arg, 0);
+
+    lurb->target_urb_adr = arg;
+    lurb->target_buf_adr = (uintptr_t)lurb->host_urb.buffer;
+
+    /* buffer space used depends on endpoint type so lock the entire buffer */
+    /* control type urbs should check the buffer contents for true direction */
+    rw_dir = lurb->host_urb.endpoint & USB_DIR_IN ? VERIFY_WRITE : VERIFY_READ;
+    lurb->target_buf_ptr = lock_user(rw_dir, lurb->target_buf_adr,
+        lurb->host_urb.buffer_length, 1);
+    if (lurb->target_buf_ptr == NULL) {
+        g_free(lurb);
+        return -TARGET_EFAULT;
+    }
+
+    /* update buffer pointer in host copy */
+    lurb->host_urb.buffer = lurb->target_buf_ptr;
+
+    ret = get_errno(safe_ioctl(fd, ie->host_cmd, &lurb->host_urb));
+    if (is_error(ret)) {
+        unlock_user(lurb->target_buf_ptr, lurb->target_buf_adr, 0);
+        g_free(lurb);
+    } else {
+        urb_hashtable_insert(lurb);
+    }
+
+    return ret;
+}
+#endif /* CONFIG_USBFS */
+
 static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                             int cmd, abi_long arg)
 {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 2daa5ebdcc..99bbce083c 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -870,6 +870,10 @@ struct target_pollfd {
 #define TARGET_USBDEVFS_SETINTERFACE TARGET_IORU('U', 4)
 #define TARGET_USBDEVFS_SETCONFIGURATION TARGET_IORU('U',  5)
 #define TARGET_USBDEVFS_GETDRIVER TARGET_IOWU('U', 8)
+#define TARGET_USBDEVFS_SUBMITURB TARGET_IORU('U', 10)
+#define TARGET_USBDEVFS_DISCARDURB TARGET_IO('U', 11)
+#define TARGET_USBDEVFS_REAPURB TARGET_IOWU('U', 12)
+#define TARGET_USBDEVFS_REAPURBNDELAY TARGET_IOWU('U', 13)
 #define TARGET_USBDEVFS_DISCSIGNAL TARGET_IORU('U', 14)
 #define TARGET_USBDEVFS_CLAIMINTERFACE TARGET_IORU('U', 15)
 #define TARGET_USBDEVFS_RELEASEINTERFACE TARGET_IORU('U', 16)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 6f64a8bdf7..b98a23b0f1 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -300,6 +300,26 @@ STRUCT(usbdevfs_connectinfo,
         TYPE_INT, /* devnum */
         TYPE_CHAR) /* slow */
 
+STRUCT(usbdevfs_iso_packet_desc,
+        TYPE_INT, /* length */
+        TYPE_INT, /* actual_length */
+        TYPE_INT) /* status */
+
+STRUCT(usbdevfs_urb,
+        TYPE_CHAR, /* type */
+        TYPE_CHAR, /* endpoint */
+        TYPE_INT, /* status */
+        TYPE_INT, /* flags */
+        TYPE_PTRVOID, /* buffer */
+        TYPE_INT, /* buffer_length */
+        TYPE_INT, /* actual_length */
+        TYPE_INT, /* start_frame */
+        TYPE_INT, /* union number_of_packets stream_id */
+        TYPE_INT, /* error_count */
+        TYPE_INT, /* signr */
+        TYPE_PTRVOID, /* usercontext */
+        MK_ARRAY(MK_STRUCT(STRUCT_usbdevfs_iso_packet_desc), 0)) /* desc */
+
 STRUCT(usbdevfs_ioctl,
         TYPE_INT, /* ifno */
         TYPE_INT, /* ioctl_code */
-- 
2.17.1
