Received: from eggs.gnu.org ([209.51.188.92]:57895)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3anylXAYKCuMQJUYTSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--lepton.bounces.google.com>)
	id 1hBtE2-0002yi-S9
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3anylXAYKCuMQJUYTSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--lepton.bounces.google.com>)
	id 1hBtDt-0007Et-Ur
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:38 -0400
Received: from mail-oi1-x249.google.com ([2607:f8b0:4864:20::249]:54782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3anylXAYKCuMQJUYTSLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--lepton.bounces.google.com>)
	id 1hBtDq-00070t-0R
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:39:28 -0400
Received: by mail-oi1-x249.google.com with SMTP id w139so494891oiw.21
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 20:39:23 -0700 (PDT)
Date: Wed,  3 Apr 2019 20:39:12 -0700
In-Reply-To: <20190404033912.47006-1-lepton@google.com>
Message-Id: <20190404033912.47006-2-lepton@google.com>
Mime-Version: 1.0
References: <20190404033912.47006-1-lepton@google.com>
From: Tao Wu <lepton@google.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH 1/1] proof of concept for GPU forwarding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

---
 arch/x86/configs/x86_64_defconfig      |    5 +
 drivers/char/Makefile                  |    1 +
 drivers/char/forwarder/Makefile        |    8 +
 drivers/char/forwarder/forwarder.h     |  103 ++
 drivers/char/forwarder/forwarder_drv.c | 2104 ++++++++++++++++++++++++
 fs/open.c                              |   18 +
 include/uapi/linux/virtwl.h            |   64 +
 tools/forward/Makefile                 |    2 +
 tools/forward/README                   |   58 +
 tools/forward/qemu.diff                | 1117 +++++++++++++
 tools/forward/wayland-proxy-main.c     |   58 +
 tools/forward/wayland-proxy.c          |  297 ++++
 12 files changed, 3835 insertions(+)
 create mode 100644 drivers/char/forwarder/Makefile
 create mode 100644 drivers/char/forwarder/forwarder.h
 create mode 100644 drivers/char/forwarder/forwarder_drv.c
 create mode 100644 include/uapi/linux/virtwl.h
 create mode 100644 tools/forward/Makefile
 create mode 100644 tools/forward/README
 create mode 100644 tools/forward/qemu.diff
 create mode 100644 tools/forward/wayland-proxy-main.c
 create mode 100644 tools/forward/wayland-proxy.c

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 1d3badfda09e..6c6e55051d5c 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -310,3 +310,8 @@ CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_MIXED=y
 CONFIG_ACPI_BGRT=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index fbea7dd12932..af406b6e3e91 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -54,3 +54,4 @@ js-rtc-y = rtc.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
 obj-$(CONFIG_ADI)		+= adi.o
+obj-y				+= forwarder/
diff --git a/drivers/char/forwarder/Makefile b/drivers/char/forwarder/Makefile
new file mode 100644
index 000000000000..bc452e51494a
--- /dev/null
+++ b/drivers/char/forwarder/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the drm device driver.  This driver provides support for the
+# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
+
+forwarder-y := forwarder_drv.o
+
+obj-y += forwarder.o
diff --git a/drivers/char/forwarder/forwarder.h b/drivers/char/forwarder/forwarder.h
new file mode 100644
index 000000000000..4937cebbf7b2
--- /dev/null
+++ b/drivers/char/forwarder/forwarder.h
@@ -0,0 +1,103 @@
+enum {
+	STREAM_MAGIC = 0xbeefc1ea,
+	EVENT_MAGIC,
+	IPC_MAGIC,
+};
+struct pwrite_stream {
+	unsigned int magic;
+	int fd;
+	unsigned int handle;
+	unsigned int offset;
+	unsigned int size;
+};
+
+#define IPC_PAGE_SIZE 32768
+
+#define IPC_COUNT 4
+
+struct ipc {
+  volatile unsigned int seq;
+  unsigned int cmd;
+  union {
+          struct {
+		  int arg1;
+		  int arg2;
+		  int arg3;
+		  int pad1;
+	  };
+	  struct {
+		  volatile int64_t ret;
+		  int64_t pad2;
+	  };
+	  struct {
+		  int fd;
+	  } ioctl;
+	  struct {
+		  unsigned int pn_count;
+	  } hostfd;
+	  struct {
+		  void* addr;
+	  } dmabuf;
+	  struct {
+		  int fd;
+		  unsigned int pn_off;
+		  unsigned int pn_count;
+	  } mmap;
+	  struct {
+		  unsigned int pn_off;
+		  unsigned int pn_count;
+	  } munmap;
+	  struct {
+		  int fd;
+		  int whence;
+	  } lseek;
+	  struct {
+		  int fd;
+		  unsigned int len;
+	  } fallocate;
+	  struct {
+		  int fd;
+		  unsigned int len;
+	  } ftruncate;
+	  struct {
+		  int fd;
+		  uint32_t fdc;
+		  uint32_t size;
+	  } msg;
+  };
+  char data[0];
+};
+
+#define WL_IOCTL_BASE 'w'
+#define VIRT_WL_MAX 32
+#define WL_IO(nr)		_IO(WL_IOCTL_BASE, nr + VIRT_WL_MAX)
+
+#define WL_CMD_NEW_RENDER_FD WL_IO(0x00)
+#define WL_CMD_NEW_WL_FD WL_IO(0x01)
+#define WL_CMD_NEW_MEM_FD WL_IO(0x02)
+#define WL_CMD_NEW_SYNC_FD WL_IO(0x03)
+#define WL_CMD_RECVMSG WL_IO(0x04)
+#define WL_CMD_SENDMSG WL_IO(0x05)
+#define WL_CMD_MMAP WL_IO(0x06)
+#define WL_CMD_MUNMAP WL_IO(0x07)
+#define WL_CMD_LSEEK WL_IO(0x08)
+#define WL_CMD_CLEAR_COUNTER WL_IO(0x09)
+#define WL_CMD_SHOW_COUNTER WL_IO(0x0A)
+#define WL_CMD_NEW_DMABUF WL_IO(0x0B)
+#define WL_CMD_FALLOCATE WL_IO(0x0C)
+#define WL_CMD_FTRUNCATE WL_IO(0x0D)
+
+#define SW_SYNC_IOC_MAGIC	'W'
+
+struct sw_sync_create_fence_data {
+	unsigned int	value;
+	char	name[32];
+	int	fence; /* fd of new fence */
+};
+
+#define SW_SYNC_IOC_CREATE_FENCE	_IOWR(SW_SYNC_IOC_MAGIC, 0,\
+		struct sw_sync_create_fence_data)
+
+#define SW_SYNC_IOC_INC			_IOW(SW_SYNC_IOC_MAGIC, 1, __u32)
+
+#define KVM_HC_FORWARDING 70
diff --git a/drivers/char/forwarder/forwarder_drv.c b/drivers/char/forwarder/forwarder_drv.c
new file mode 100644
index 000000000000..c7dd0b64b3c9
--- /dev/null
+++ b/drivers/char/forwarder/forwarder_drv.c
@@ -0,0 +1,2104 @@
+#include <drm/drmP.h>
+#include <drm/i915_drm.h>
+#include <linux/atomic.h>
+#include <linux/anon_inodes.h>
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/nsproxy.h>
+#include <linux/socket.h>
+#include <linux/syscalls.h>
+#include <linux/vm_sockets.h>
+#include <uapi/drm/virtgpu_drm.h>
+#include <uapi/linux/dma-buf.h>
+#include <uapi/linux/kvm_para.h>
+#include <uapi/linux/sync_file.h>
+#include <uapi/linux/virtwl.h>
+
+#include "forwarder.h"
+
+static const int vsock_port = 30000;
+
+#define SYS_DATA_SIZE (2 << 20)
+
+#define MAX_IOCTL_DATA_SIZE (SYS_DATA_SIZE - offsetof(struct syscall_data, ioctl.data))
+
+#define MAX_IPC_DATA_SIZE (IPC_PAGE_SIZE - offsetof(struct ipc, data))
+
+
+#define ERROR(k) do { \
+	pr_err("ERR:%d %s:%d\n", (int)k, __func__, __LINE__); \
+	return k; \
+} while(0)
+
+#define ERROR_RELEASE(k) do { \
+	kfree(data); \
+	if (k) pr_err("ERR:%d %s:%d\n", (int)k, __func__, __LINE__); \
+	return k; \
+} while(0)
+
+#define bug(fmt, ...) do { \
+	printk(KERN_ERR "ERR: %s:%d " fmt, __func__, __LINE__ , ##__VA_ARGS__); \
+	BUG(); \
+} while(0)
+
+struct forward {
+	wait_queue_head_t wq;
+	int host_fd;
+	atomic_t in_wait;
+	char signaled;
+};
+
+struct wait_poll {
+	void* data;
+	int fd;
+};
+
+#define POOL_SIZE 4
+
+struct vsock_pool {
+	struct socket* socks[POOL_SIZE];
+	DECLARE_BITMAP(map, POOL_SIZE);
+	struct mutex lock;
+	struct semaphore free;
+};
+
+static struct vsock_pool stream_pool;
+//static struct vsock_pool ipc_pool;
+
+static struct socket* event_sock;
+
+static int enable = 1;
+static int crostini = 1;
+static ushort major = 226;
+static int hyper_ipc = 1;
+static int stream_bar = 65536;
+static int hyper_ipc_working;
+
+//FIXME, we should get these from host.
+static ushort vendor = 0x8086;
+static ushort device = 0x591e;
+static ushort subsystem_vendor;
+static ushort subsystem_device;
+static char config[64];
+
+enum {
+	RENDER_MINOR = (DRM_MINOR_RENDER << 6),
+	SYNC_MINOR,
+	WL_MINOR,
+};
+
+#define MINOR_NUM 3
+
+static int vsock_send(struct socket *vsock, void *buf, size_t size)
+{
+	struct msghdr msg = { };
+	struct kvec iov[1];
+	iov[0].iov_base = buf;
+	iov[0].iov_len = size;
+	return kernel_sendmsg(vsock, &msg, iov, 1, size);
+}
+
+static int vsock_recv(struct socket *vsock, void *buf, size_t size)
+{
+	struct msghdr msg = { };
+	struct kvec iov[1];
+	iov[0].iov_base = buf;
+	iov[0].iov_len = size;
+	return kernel_recvmsg(vsock, &msg, iov, 1, size, 0);
+}
+
+static int forwarder_open(struct inode *, struct file *);
+static long forwarder_ioctl(struct file *, unsigned int, unsigned long);
+static int forwarder_mmap(struct file *, struct vm_area_struct *);
+static int forwarder_release(struct inode *, struct file *);
+
+static int quick_mmap(struct file *, struct vm_area_struct *);
+static int quick_release(struct inode *, struct file *);
+static long wayland_ioctl(struct file *, unsigned int, unsigned long);
+static loff_t forwarder_lseek(struct file *file, loff_t offset, int whence);
+static long sync_ioctl(struct file *, unsigned int, unsigned long);
+static unsigned int sync_poll(struct file *file, poll_table *wait);
+static long sw_sync_ioctl(struct file *, unsigned int, unsigned long);
+
+static long wl_ioctl(struct file *, unsigned int, unsigned long);
+
+ssize_t no_read(struct file * f, char __user * tr, size_t l, loff_t * off)
+{
+	BUG();
+}
+
+ssize_t no_write(struct file *f, const char __user * tr, size_t l, loff_t *off)
+{
+	BUG();
+}
+
+static unsigned int no_poll(struct file *file, poll_table *wait)
+{
+	BUG();
+}
+
+static const struct file_operations entry_fops = {
+	.owner = THIS_MODULE,
+	.open = forwarder_open,
+};
+
+static const struct file_operations mmap_fops = {
+	.owner = THIS_MODULE,
+	.mmap = quick_mmap,
+	.release = quick_release,
+	.read = no_read,
+	.write = no_write,
+	.poll = no_poll,
+};
+
+static const struct file_operations forwarder_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = forwarder_ioctl,
+	.compat_ioctl = forwarder_ioctl,
+	.mmap = forwarder_mmap,
+	.llseek = forwarder_lseek,
+	.release = forwarder_release,
+	.read = no_read,
+	.write = no_write,
+	.poll = no_poll,
+};
+
+static const struct file_operations wl_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = wl_ioctl,
+	.read = no_read,
+	.write = no_write,
+	.poll = no_poll,
+};
+
+static const struct file_operations wayland_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = wayland_ioctl,
+	.release = forwarder_release,
+	.read = no_read,
+	.write = no_write,
+	.poll = sync_poll,
+};
+
+static const struct file_operations sync_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = sync_ioctl,
+	.compat_ioctl = sync_ioctl,
+	.poll = sync_poll,
+	.release = forwarder_release,
+	.read = no_read,
+	.write = no_write,
+};
+
+static const struct file_operations sw_sync_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = sw_sync_ioctl,
+	.compat_ioctl = sw_sync_ioctl,
+	.release = forwarder_release,
+	.read = no_read,
+	.write = no_write,
+	.poll = no_poll,
+};
+
+static const struct file_operations mem_fd_fops = {
+	.owner = THIS_MODULE,
+	.mmap = forwarder_mmap,
+	.release = forwarder_release,
+	.llseek = forwarder_lseek,
+	.read = no_read,
+	.write = no_write,
+	.poll = no_poll,
+};
+
+struct host_mmap {
+	uint32_t pn_off;
+	uint32_t pn_count;
+	uint64_t count;
+};
+
+static struct mutex ipc_mutex;
+static struct mutex ipc_cmd_mutex;
+static struct ipc* ipc;
+static char* ipcq[IPC_COUNT];
+
+static struct mutex stream_mutex;
+static struct semaphore free_stream_socks;
+
+uint64_t host_addr[2];
+
+#define ADDR_4G (1UL << 32)
+#define ADDR_12G (3UL << 32)
+
+static uint64_t phy_host_addr(uint64_t addr)
+{
+	if (addr < ADDR_4G)
+		return addr + host_addr[0];
+	return addr + host_addr[1] - ADDR_4G;
+}
+
+static uint64_t get_host_addr(void * addr)
+{
+	uint64_t guest_phy = virt_to_phys(addr);
+	return phy_host_addr(guest_phy);
+}
+
+static void * get_guest_addr(uint64_t addr)
+{
+	if (addr >= host_addr[0] && addr < host_addr[0] + ADDR_4G)
+		return phys_to_virt(addr - host_addr[0]);
+	if (addr >= host_addr[1] && addr < host_addr[1] + ADDR_12G)
+		return phys_to_virt(addr - host_addr[1] + ADDR_4G);
+	bug("strange host addr %llx\n", addr);
+	return NULL;
+}
+
+static inline int64_t host_cmd(unsigned int cmd, int arg1, int arg2, int arg3,
+			       unsigned long host_arg)
+{
+	static unsigned int ipc_seq;
+	char type = _IOC_TYPE(cmd);
+	int64_t ret;
+
+	if (hyper_ipc && hyper_ipc_working && type != 'w' &&
+	    cmd != DRM_IOCTL_I915_GEM_MMAP)
+		return kvm_hypercall3(KVM_HC_FORWARDING, arg1, cmd, host_arg);
+	mutex_lock(&ipc_cmd_mutex);
+	ipc->cmd = cmd;
+	ipc->arg1 = arg1;
+	ipc->arg2 = arg2;
+	ipc->arg3 = arg3;
+	ipc->seq = (++ipc_seq);
+	++ipc_seq;
+	do {} while(ipc->seq != ipc_seq);
+	ret = ipc->ret;
+	mutex_unlock(&ipc_cmd_mutex);
+	return ret;
+}
+
+static unsigned int sync_poll(struct file *file, poll_table *wait)
+{
+	struct forward* fwd = (struct forward *)file->private_data;
+	int host_fd;
+	int ret;
+	struct wait_poll wp;
+	poll_wait(file, &fwd->wq, wait);
+	host_fd = fwd->host_fd;
+	if (host_fd < 0) {
+		BUG();
+	}
+	if (fwd->signaled)
+		return POLLIN;
+	if (!atomic_cmpxchg(&fwd->in_wait, 0, 1)) {
+		get_file(file);
+		wp.data = file;
+		wp.fd = host_fd;
+		ret = vsock_send(event_sock, &wp, sizeof(wp));
+		if (ret != sizeof(wp))
+			BUG();
+	}
+	return 0;
+}
+
+static int connect_vsock(struct socket** sock) {
+	int err;
+	struct socket *vsock;
+	struct sockaddr_vm address = { };
+	int i;
+
+	err = __sock_create(current->nsproxy->net_ns, PF_VSOCK, SOCK_STREAM, 0,
+			    &vsock, 1);
+	if (err) {
+		printk(KERN_ERR "creat vsock %d\n", err);
+		BUG();
+	}
+	address.svm_family = AF_VSOCK;
+	address.svm_port = vsock_port;
+	address.svm_cid = VMADDR_CID_HOST;
+	for (i = 0; i < 3; ++i) {
+		err = vsock->ops->connect(vsock, (struct sockaddr *)&address,
+				  sizeof(address), 0);
+		if (err == -EINTR) {
+			msleep(10);
+			continue;
+		}
+		break;
+	}
+	if (err < 0) {
+		printk(KERN_WARNING "fail connect\n");
+		printk(KERN_ERR "connect vsock %d\n", err);
+		sock_release(vsock);
+		return err;
+	}
+	*sock = vsock;
+	return 0;
+}
+
+struct task_struct * wait_wake;
+
+static int quick_forwarder_open(struct file *filp)
+{
+	int fd = -1;
+	struct forward * fwd = kzalloc(sizeof(*fwd), GFP_KERNEL);
+
+	if (fwd == NULL)
+		ERROR(-ENOMEM);
+	init_waitqueue_head(&fwd->wq);
+
+	if (event_sock == NULL)bug("why no event sock");
+	fd = *(int *)filp->private_data;
+	if (fd < 0) {
+		bug("new dev fd %d\n", fd);
+	}
+	fwd->host_fd = fd;
+	filp->private_data = fwd;
+	return 0;
+}
+
+static int forwarder_open(struct inode* inode, struct file *filp)
+{
+	unsigned long host_fd_cmd = 0;
+	const struct file_operations *ops, *new_ops;
+	int ret = -1;
+	unsigned short minor = iminor(inode);
+	struct forward * fwd;
+
+	if (event_sock == NULL) {
+		wake_up_process(wait_wake);
+		while(event_sock == NULL) {
+			pr_warn("wait socket\n");
+			msleep(1000);
+		}
+	}
+
+	switch (minor) {
+		case RENDER_MINOR:
+			host_fd_cmd = WL_CMD_NEW_RENDER_FD;
+			ops = &forwarder_fops;
+			break;
+		case SYNC_MINOR:
+			host_fd_cmd = WL_CMD_NEW_SYNC_FD;
+			ops = &sw_sync_fops;
+			break;
+		case WL_MINOR:
+			ops = &wl_fops;
+			break;
+		default:
+			return -ENODEV;
+	}
+
+	new_ops = fops_get(ops);
+	if (new_ops == NULL)
+		return -ENODEV;
+
+	if (host_fd_cmd) {
+		ret = host_cmd(host_fd_cmd, 0, 0, 0, 0);
+		if (ret < 0)
+			goto err;
+	}
+	if (ret >=0) {
+		fwd = kzalloc(sizeof(*fwd), GFP_KERNEL);
+		if (fwd == NULL) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		init_waitqueue_head(&fwd->wq);
+		fwd->host_fd = ret;
+		filp->private_data = fwd;
+	}
+	replace_fops(filp, new_ops);
+	return 0;
+err:
+	fops_put(new_ops);
+	return ret;
+}
+
+#define SYNC_IOC_LEGACY_MERGE 0xc0283e01
+#define SYNC_IOC_LEGACY_FENCE_INFO 0xc0283e02
+
+static void *copy_ptr(uint64_t* usr_ptr, size_t usr_len, int write_only,
+			  uint64_t keep[], uint32_t c, uint32_t maxc,
+			  int need_keep,
+			  char *begin, char **end, int line)
+{
+	void *ret;
+	uint64_t usr = (*usr_ptr);
+	static uint32_t max, ct;
+
+	if (need_keep && c >= maxc) {
+		pr_warn("Too many pointers to keep %d %d\n",c, maxc);
+		return NULL;
+	}
+	ct = * end - begin + usr_len;
+	if (ct > max) {
+		max =  ct;
+		pr_warn("max data size: %d\n", ct);
+	}
+	if (ct > MAX_IPC_DATA_SIZE) {
+		bug("too much data %ld %d\n", usr_len, line);
+		return NULL;
+	}
+	if (usr_len && !write_only && copy_from_user(*end, (void __user *)usr, usr_len)) {
+		bug("can't copy %llx %p %d %ld\n", usr, *end, line, usr_len);
+		return NULL;
+	}
+	ret = *end;
+	if (need_keep) keep[c] = usr;
+	if (usr_len)
+		*usr_ptr = get_host_addr(ret);
+	else
+		*usr_ptr = 0;
+	(*end) += usr_len;
+	return ret;
+}
+
+static int get_host_fd(int fd, const struct file_operations* op, struct file**
+		       fp, int line) {
+	struct file * file = fget(fd);
+	struct forward * fwd;
+	int ret;
+	if (!file)
+		ERROR(-EBADF);
+	if ((op && file->f_op != op) ||
+	    (file->f_op != &forwarder_fops &&
+	    file->f_op != &sync_fops &&
+	    file->f_op != &mem_fd_fops &&
+	    file->f_op != &sw_sync_fops)) {
+		fput(file);
+		pr_warn("from %s %d %d\n", file->f_path.dentry->d_name.name, fd, line);
+		BUG();
+		ERROR(-EINVAL);
+	}
+	fwd = (struct forward *)file->private_data;
+	if (fwd->host_fd < 0) {
+		pr_warn("unexpected");
+		BUG();
+	}
+	ret  = fwd->host_fd;
+	*fp = file;
+	return ret;
+}
+
+static inline void to_keep(uint64_t v, uint64_t keep[], uint32_t c,
+			   uint32_t maxc)
+{
+	if (c >= maxc) {
+		pr_warn("Too much too keep %d\n", c);
+		BUG();
+	}
+	keep[c] = v;
+}
+
+#define DRM_IOCTL_MODE_GETPLANERESOURCES32 0xc00c64b5
+#define DRM_IOCTL_MODE_OBJ_GETPROPERTIES32 0xc01c64b9
+
+static int pre_deep_copy(unsigned int cmd, char *data, int *guest_fd,
+			     struct file** hold_fp, uint64_t keep_ptr[],
+			     uint32_t *count)
+{
+	char *end;
+	struct drm_i915_gem_execbuffer2 *eb;
+	struct drm_i915_gem_exec_object2 *eo;
+	struct drm_i915_gem_relocation_entry *re;
+	struct drm_i915_gem_exec_fence *ef;
+	struct drm_prime_handle *h;
+	struct sync_merge_data* md;
+	struct sync_file_info* fi;
+	struct sync_fence_info* sf;
+	struct drm_mode_get_property *gp;
+	struct drm_mode_get_plane_res *pr;
+	struct drm_mode_get_plane* mgp;
+	struct drm_mode_obj_get_properties * opr;
+	struct drm_i915_getparam *g;
+	struct drm_version *v;
+	int i, fd;
+	uint32_t c = 0;
+
+	switch (cmd) {
+	case SYNC_IOC_FILE_INFO:
+		fi = (struct sync_file_info*) data;
+		if (fi->num_fences && fi->sync_fence_info) {
+			if (fi->num_fences * sizeof(*sf) + sizeof(*fi) >
+			    MAX_IPC_DATA_SIZE) {
+				pr_warn("too many fences %d\n", fi->num_fences);
+				BUG();
+			}
+			to_keep(fi->sync_fence_info, keep_ptr, c++, *count);
+			fi->sync_fence_info = get_host_addr(fi + 1);
+		}
+		break;
+	case SYNC_IOC_MERGE:
+		md = (struct sync_merge_data *)data;
+		*guest_fd = md->fd2;
+		fd = get_host_fd(md->fd2, &sync_fops, hold_fp, __LINE__);
+		if (fd<0) {
+			BUG();
+			ERROR(-EINVAL);
+		}
+		md->fd2 = fd;
+		break;
+	case DRM_IOCTL_PRIME_FD_TO_HANDLE:
+		h = (struct drm_prime_handle *)data;
+		*guest_fd = h->fd;
+		fd = get_host_fd(h->fd, NULL, hold_fp, __LINE__);
+		if (fd < 0)
+			ERROR(fd);
+		h->fd = fd;
+		break;
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2_WR:
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2:
+		eb = (struct drm_i915_gem_execbuffer2 *)data;
+		end = data + sizeof(*eb);
+		if (eb->flags & I915_EXEC_FENCE_ARRAY)BUG();
+		if (eb->flags & I915_EXEC_FENCE_IN) {
+			*guest_fd = lower_32_bits(eb->rsvd2);
+			fd = get_host_fd(*guest_fd, &sync_fops, hold_fp, __LINE__);
+			if (fd < 0) {
+				BUG();
+				ERROR(-EINVAL);
+			}
+			eb->rsvd2 = fd;
+		}
+		if (eb->buffer_count) {
+			eo = copy_ptr(&eb->buffers_ptr,
+					  sizeof(*eo) * eb->buffer_count,
+					  0, keep_ptr, c++, *count, 1,
+					  data, &end, __LINE__);
+			if (eo == NULL)
+				ERROR(-EFAULT);
+			for (i = 0; i < eb->buffer_count; ++i, ++eo) {
+				to_keep(eo->offset, keep_ptr, c++, *count);
+				if (eo->relocation_count==0)
+					continue;
+				if(copy_ptr(&eo->relocs_ptr,
+				     sizeof(*re) * eo->relocation_count,
+				     0, NULL, 0, 0, 0,
+				     data, &end,  __LINE__) == NULL)
+					ERROR(-EFAULT);
+			}
+		}
+		if (eb->num_cliprects) {
+			if (copy_ptr(&eb->cliprects_ptr,
+					 sizeof(*ef) * eb->num_cliprects,
+					 0, NULL, 0, 0, 0,
+					 data, &end, __LINE__) == NULL)
+				ERROR(-EFAULT);
+		}
+		break;
+	case DRM_IOCTL_MODE_GETPROPERTY:
+		gp = (struct drm_mode_get_property *)data;
+		end = data + sizeof(*gp);
+		to_keep(gp->count_values, keep_ptr, c++, *count);
+		to_keep(gp->count_enum_blobs, keep_ptr, c++, *count);
+		if (copy_ptr(&gp->values_ptr, gp->count_values * sizeof(uint64_t),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			ERROR(-EFAULT);
+		if (copy_ptr(&gp->enum_blob_ptr,
+				 gp->count_enum_blobs *
+				   sizeof(struct drm_mode_property_enum),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			ERROR(-EFAULT);
+		break;
+	case DRM_IOCTL_MODE_GETPLANERESOURCES:
+	case DRM_IOCTL_MODE_GETPLANERESOURCES32:
+		pr = (struct drm_mode_get_plane_res *)data;
+		end = data + sizeof(*pr);
+		to_keep(pr->count_planes, keep_ptr, c++, *count);
+		if (copy_ptr(&pr->plane_id_ptr, pr->count_planes * sizeof(int),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			return -EFAULT;
+		break;
+	case DRM_IOCTL_MODE_GETPLANE:
+		mgp = (struct drm_mode_get_plane *)data;
+		end = data + sizeof(*mgp);
+		to_keep(mgp->count_format_types, keep_ptr, c++, *count);
+		if (copy_ptr(&mgp->format_type_ptr,
+				 mgp->count_format_types * sizeof(int),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			return -EFAULT;
+		break;
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES:
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES32:
+		opr = (struct drm_mode_obj_get_properties *)data;
+		end = data + sizeof(*opr);
+		to_keep(opr->count_props, keep_ptr, c++, *count);
+		if (copy_ptr(&opr->props_ptr,
+				 opr->count_props * sizeof(int),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			ERROR(-EFAULT);
+		if (copy_ptr(&opr->prop_values_ptr,
+				 opr->count_props * sizeof(uint64_t),
+				 1, keep_ptr, c++, *count, 1, data, &end,
+				 __LINE__)==NULL)
+			ERROR(-EFAULT);
+		break;
+	case DRM_IOCTL_I915_GETPARAM:
+		g = (struct drm_i915_getparam *)data;
+		end = data + sizeof(*g);
+		if (copy_ptr((uint64_t *)&g->value, sizeof(int),
+			1, keep_ptr, c++, *count, 1, data, &end,
+			__LINE__)==NULL)
+			ERROR(-EFAULT);
+		break;
+	case DRM_IOCTL_VERSION:
+		v = (struct drm_version *)data;
+		end = data + sizeof(*v);
+		to_keep(v->name_len, keep_ptr, c++, *count);
+		to_keep(v->date_len, keep_ptr, c++, *count);
+		to_keep(v->desc_len, keep_ptr, c++, *count);
+		if (copy_ptr((uint64_t *)&v->name, v->name_len,
+			1, keep_ptr, c++, *count, 1, data, &end,
+			__LINE__)==NULL)
+			ERROR(-EFAULT);
+		if (copy_ptr((uint64_t *)&v->date, v->date_len,
+			1, keep_ptr, c++, *count, 1, data, &end,
+			__LINE__)==NULL)
+			ERROR(-EFAULT);
+		if (copy_ptr((uint64_t *)&v->desc, v->desc_len,
+			1, keep_ptr, c++, *count, 1, data, &end,
+			__LINE__)==NULL)
+			ERROR(-EFAULT);
+		break;
+	}
+	*count = c;
+	return 0;
+}
+
+static int setup_fd(int *host_fd, const char* name,
+		    const struct file_operations* fops)
+{
+	struct file *file;
+	int ret;
+	int flags = O_RDWR | O_CLOEXEC;
+ 
+	file = anon_inode_getfile(name, fops, host_fd, flags);
+	//FIXME host fd leaked at host
+	if (IS_ERR(file))
+		ERROR(PTR_ERR(file));
+	if (fops->llseek) {
+		file->f_mode |= FMODE_LSEEK;
+	}
+	ret = quick_forwarder_open(file);
+	if (ret)
+		goto error;
+
+	ret = get_unused_fd_flags(flags);
+	if (ret < 0)
+		goto error;
+
+	fd_install(ret, file);
+	//pr_warn("setup %s fd host %d guest %d\n", name, *host_fd, ret);
+	*host_fd = ret;
+	return 0;
+error:
+	fput(file);
+	return ret;
+}
+
+static void *mmap_phy_addr(uint64_t phy_addr, size_t size, struct file *dev)
+{
+	void *ptr;
+	struct file *filp = anon_inode_getfile("forwarder GEM_MMAP",
+					       &mmap_fops, dev,
+					       O_RDWR);
+	if (IS_ERR(filp))
+		return filp;
+	get_file(dev);
+	ptr = (void *)vm_mmap(filp, 0, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			      phy_addr);
+	fput(filp);
+	return ptr;
+}
+
+static int deep_copy(struct file *filp, unsigned int cmd, char *buf,
+		     int guest_fd, struct file *hold_fp, uint64_t keep[],
+		     uint32_t c, int *fd)
+{
+	char *ptr;
+	struct drm_version *v;
+	struct drm_i915_getparam *g;
+	struct drm_i915_gem_execbuffer2 *eb;
+	struct drm_i915_gem_exec_object2 *eo;
+	struct drm_i915_gem_mmap *mp;
+	struct drm_prime_handle *h;
+	struct drm_mode_get_plane_res* pr;
+	struct drm_mode_get_plane* mgp;
+	struct drm_mode_obj_get_properties* opr;
+	struct drm_mode_get_property* gp;
+	struct sync_merge_data* md;
+	struct sync_file_info* fi;
+	struct sw_sync_create_fence_data* ss;
+	int i, hostfd;
+	int zc;
+
+	if(hold_fp)fput(hold_fp);
+
+	switch (cmd) {
+	case SW_SYNC_IOC_CREATE_FENCE:
+		ss = (struct sw_sync_create_fence_data *) buf;
+		if (setup_fd(&ss->fence, "host sw fence", &sync_fops))
+			ERROR(-ENOMEM);
+		return 0;
+	case SYNC_IOC_FILE_INFO:
+		fi = (struct sync_file_info*) buf;
+		ptr = buf + sizeof(*fi);
+		if (fi->num_fences && fi->sync_fence_info) {
+			if (c!=1) {
+				pr_warn("c is:%d\n", c);
+				BUG();
+			}
+			if(copy_to_user((void __user *)keep[0], fi+1,
+					fi->num_fences * sizeof(struct sync_fence_info)))
+				return -EFAULT;
+			fi->sync_fence_info = keep[0];
+		}
+		return 0;
+	case SYNC_IOC_MERGE:
+		md = (struct sync_merge_data*) buf;
+		md->fd2 = guest_fd;
+		if (setup_fd(&md->fence, "host merge sync", &sync_fops))
+			ERROR(-ENOMEM);
+		return 0;
+	case DRM_IOCTL_MODE_GETPLANE:
+		mgp = (struct drm_mode_get_plane *)buf;
+		if (c!=2)bug("unexpected %d\n", c);
+		if (keep[0] && keep[1] &&
+		    copy_to_user ((void __user *)keep[1],
+				  get_guest_addr(mgp->format_type_ptr),
+				  min_t(uint32_t, keep[0], mgp->count_format_types) * sizeof(int)))
+			return -EFAULT;
+		mgp->format_type_ptr = keep[1];
+		return 0;
+	case DRM_IOCTL_MODE_GETPLANERESOURCES:
+	case DRM_IOCTL_MODE_GETPLANERESOURCES32:
+		pr = (struct drm_mode_get_plane_res *)buf;
+		if (c!=2)bug("unexpected %d\n", c);
+		if (keep[0] && keep[1] &&
+		    copy_to_user ((void __user *)keep[1],
+				  get_guest_addr(pr->plane_id_ptr),
+				  min_t(uint32_t, keep[0], pr->count_planes) * sizeof(int)))
+			return -EFAULT;
+		pr->plane_id_ptr = keep[1];
+		return 0;
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES:
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES32:
+		opr = (struct drm_mode_obj_get_properties *)buf;
+		if (c!=3)bug("unexpected %d\n", c);
+		if (keep[0]  &&
+		    (copy_to_user((void __user *)keep[1],
+				   get_guest_addr(opr->props_ptr),
+				   min_t(uint32_t, keep[0], opr->count_props) * sizeof(int)) ||
+		     copy_to_user((void __user *)keep[2],
+				  get_guest_addr(opr->prop_values_ptr),
+				  min_t(uint32_t, keep[0], opr->count_props) *
+				  sizeof(uint64_t))))
+			ERROR(-EFAULT);
+		opr->props_ptr = keep[1];
+		opr->prop_values_ptr = keep[2];
+		return 0;
+	case DRM_IOCTL_MODE_GETPROPERTY:
+		gp = (struct drm_mode_get_property *)buf;
+		if (c!=4)bug("not expected c %d\n", c);
+		if (keep[0] && keep[2] &&
+		    copy_to_user((void __user *)keep[2],
+				  get_guest_addr(gp->values_ptr),
+				  min_t(uint32_t, keep[0], gp->count_values) * sizeof(uint64_t)))
+			return -EFAULT;
+		gp->values_ptr = keep[2];
+		if (keep[1] && keep[3] &&
+		    copy_to_user((void __user *)keep[3],
+				  get_guest_addr(gp->enum_blob_ptr),
+		                  min_t(uint32_t, keep[1], gp->count_enum_blobs) *
+				  sizeof(struct drm_mode_property_enum)))
+			return -EFAULT;
+		gp->enum_blob_ptr = keep[3];
+		return 0;
+	case DRM_IOCTL_VERSION:
+		v = (struct drm_version *)buf;
+		if (c!=6)bug("not expected c %d\n", c);
+		if (keep[0] && copy_to_user((void __user *)keep[3],
+					    get_guest_addr((uint64_t)v->name),
+					    min_t(uint32_t, keep[0], v->name_len)))
+			return -EFAULT;
+		if (keep[1] && copy_to_user((void __user *)keep[4],
+					    get_guest_addr((uint64_t)v->date),
+					    min_t(uint32_t, keep[1], v->date_len)))
+			return -EFAULT;
+		if (keep[2] && copy_to_user((void __user *)keep[5],
+					    get_guest_addr((uint64_t)v->desc),
+					    min_t(uint32_t, keep[2], v->desc_len)))
+			return -EFAULT;
+		v->name = (char *)keep[3];
+		v->date = (char *)keep[4];
+		v->desc = (char *)keep[5];
+		return 0;
+	case DRM_IOCTL_I915_GETPARAM:
+		g = (struct drm_i915_getparam *)buf;
+		if (c!=1)bug("unexpected %d\n", c);
+		if (copy_to_user ((void __user *)keep[0],
+				  get_guest_addr((uint64_t)g->value),
+				  sizeof(int)))
+			ERROR(-EFAULT);
+		g->value = (int *)keep[0];
+		return 0;
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2:
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2_WR:
+		eb = (struct drm_i915_gem_execbuffer2 *)buf;
+		if (eb->flags & I915_EXEC_FENCE_IN) {
+			eb->rsvd2 = ((u64)upper_32_bits(eb->rsvd2) << 32)
+				| guest_fd;
+		}
+		if (eb->flags & I915_EXEC_FENCE_OUT) {
+			hostfd = upper_32_bits(eb->rsvd2);
+			if (setup_fd(&hostfd, "host out sync", &sync_fops))
+				ERROR(-ENOMEM);
+			eb->rsvd2 &= GENMASK_ULL(0, 31);
+			eb->rsvd2 |= (u64)hostfd << 32;
+		}
+		ptr = buf + sizeof(*eb);
+		if (!eb->buffers_ptr || !eb->buffer_count)
+			return 0;
+		eo = get_guest_addr(eb->buffers_ptr);
+		if (c != eb->buffer_count + 1) {
+			pr_warn("wrong buffer count: %d %d\n",
+				c, eb->buffer_count);
+			BUG();
+		}
+		eb->buffers_ptr = keep[0] & S64_MAX;
+		zc = keep[0] & S64_MIN;
+		for (i = 0; i < eb->buffer_count; ++i, ++eo) {
+			if (zc) {
+			    if (eo->relocation_count)
+			        eo->relocs_ptr = keep[i + 1] & S64_MAX;
+			} else {
+			    if (eo->offset != keep[i +1]) {
+				if(put_user(eo->offset, (u64 __user
+							 *)(eb->buffers_ptr
+					    + i * sizeof(*eo)
+					    + offsetof(struct
+						       drm_i915_gem_exec_object2
+						       , offset))))
+				   ERROR(-EFAULT);
+			}
+			}
+		}
+		return 0;
+	case DRM_IOCTL_I915_GEM_MMAP:
+		mp = (struct drm_i915_gem_mmap *)buf;
+		ptr = mmap_phy_addr(mp->addr_ptr, mp->size, filp);
+		if (IS_ERR(ptr))
+			ERROR(PTR_ERR(ptr));
+		mp->addr_ptr = (uint64_t) ptr;
+		return 0;
+	case DRM_IOCTL_PRIME_FD_TO_HANDLE:
+		h = (struct drm_prime_handle *)buf;
+		h->fd = guest_fd;
+		return 0;
+	case DRM_IOCTL_PRIME_HANDLE_TO_FD:
+		h = (struct drm_prime_handle *)buf;
+		*fd = h->fd;
+		h->fd = -1;
+		return 0;
+	}
+	return 0;
+}
+
+union addr64 {
+	struct {
+		unsigned int low;
+		unsigned int high;
+	};
+	uint64_t addr;
+};
+
+static long wl_ioctl(struct file *filp, unsigned int cmd,
+		     unsigned long arg)
+{
+	struct virtwl_ioctl_new wl, *tmp;
+	unsigned int pc = 0;
+	int ret;
+	const struct file_operations *fop;
+	const char* name;
+	union addr64 addr;
+
+	if (cmd != VIRTWL_IOCTL_NEW) {
+		pr_warn("unsupported ioctl %d\n", cmd);
+		return -ENOTTY;
+	}
+	if (copy_from_user(&wl, (void __user *)arg, sizeof(wl)))
+		return -EFAULT;
+	if (wl.flags) {
+		pr_warn("unsupported flags %d\n", wl.flags);
+		return -EINVAL;
+	}
+
+	switch (wl.type) {
+	case VIRTWL_IOCTL_NEW_CTX:
+		fop = &wayland_fops;
+		name = "host wayland";
+		wl.fd = host_cmd(WL_CMD_NEW_WL_FD, 0, 0, 0, 0);
+		break;
+	case VIRTWL_IOCTL_NEW_ALLOC:
+		fop = &mem_fd_fops;
+		name = "host mem";
+		pc = PAGE_ALIGN(wl.size) >> PAGE_SHIFT;
+		wl.fd = host_cmd(WL_CMD_NEW_MEM_FD, pc, 0, 0, 0);
+		break;
+	case VIRTWL_IOCTL_NEW_DMABUF:
+		fop = &forwarder_fops;
+		name = "host dmabuf";
+		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		if (tmp == NULL)
+			return -ENOMEM;
+		memcpy(&tmp->dmabuf, &wl.dmabuf, sizeof(wl.dmabuf));
+		addr.addr = get_host_addr(tmp);
+		wl.fd = host_cmd(WL_CMD_NEW_DMABUF, addr.low, addr.high, 0, 0);
+		memcpy(&wl.dmabuf, &tmp->dmabuf, sizeof(wl.dmabuf));
+		kfree(tmp);
+		break;
+	default:
+		bug("unsupported type %d\n", wl.type);
+	}
+	if (wl.fd < 0)
+		return wl.fd;
+
+	ret = setup_fd(&wl.fd, name, fop);
+	if (ret < 0)
+		return ret;
+
+	if (copy_to_user((void __user *)arg, &wl, sizeof(wl)))
+		return -EFAULT;
+	return 0;
+}
+
+extern long (*open_hook)(const char __user *, int, umode_t);
+
+static long wayland_open_tmp(const char __user * filename, int flags, umode_t mode)
+{
+
+	long ret = -ENOSYS;
+	int fd;
+	struct filename *tmp;
+	size_t len;
+
+	if ((flags & ~O_CLOEXEC) != (O_RDWR|O_CREAT|O_EXCL) ||
+	    mode != 0600)		
+		return ret;
+
+	tmp = getname(filename);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	if (strncmp(tmp->name, "/run/user/", 10))
+		goto out;
+	len = strlen(tmp->name);
+	if (len <= 14)
+		goto out;
+	if (strncmp(tmp->name + len - 14, "-shared-", 8))
+		goto out;
+	ret = host_cmd(WL_CMD_NEW_MEM_FD, 8192, 0, 0, 0);
+	if (ret < 0)
+		goto out;
+	fd = ret;
+	ret = setup_fd(&fd, "host memfd", &mem_fd_fops);
+	if (ret < 0)
+		goto out;
+	ret = fd;
+out:
+	putname(tmp);
+	return ret;
+}
+
+
+extern long (*fallocate_hook)(int fd, int mode, loff_t offset, loff_t len);
+
+static long wayland_fallocate(int fd, int mode, loff_t offset, loff_t len)
+{
+	struct file* fp = fget(fd);
+	struct forward *fwd;
+	long ret = -ENOSYS;
+	if (IS_ERR(fp))
+		return -EBADF;
+	if (fp->f_op != &mem_fd_fops)
+		goto out;
+	fwd = (struct forward *) fp->private_data;
+	if (mode || offset) {
+		pr_warn("Who will call me with no zero %d %lld?", mode, offset);
+		return -EINVAL;
+	}
+	if (len > UINT_MAX) {
+		pr_warn("too large %lld\n", len);
+		return -ENOSPC;
+	}
+	ret = host_cmd(WL_CMD_FALLOCATE, fwd->host_fd, len, 0, 0);
+out:
+	fput(fp);
+	return ret;
+}
+
+extern long (*ftruncate_hook)(int fd, unsigned long len);
+
+static long wayland_ftruncate(int fd, unsigned long len)
+{
+	struct file* fp = fget(fd);
+	struct forward *fwd;
+	long ret = -ENOSYS;
+	if (IS_ERR(fp))
+		return -EBADF;
+	if (fp->f_op != &mem_fd_fops)
+		goto out;
+	fwd = (struct forward *) fp->private_data;
+	if (len > UINT_MAX) {
+		pr_warn("too large %ld\n", len);
+		return -ENOSPC;
+	}
+	ret = host_cmd(WL_CMD_FTRUNCATE, fwd->host_fd, len, 0, 0);
+out:
+	fput(fp);
+	return ret;
+}
+
+void init_vsock_pool(struct vsock_pool* pool, unsigned int magic)
+{
+	int i;
+	mutex_init(&pool->lock);
+	sema_init(&pool->free, 0);
+	for (i = 0; i < POOL_SIZE; ++i) {
+		if(connect_vsock(&pool->socks[i]))
+			bug("can't connect to host");
+		if (vsock_send(pool->socks[i], &magic, sizeof(magic))
+		    != sizeof(magic))
+			bug("can't send out magic");
+		up(&pool->free);
+	}
+}
+
+static struct socket* get_vsock(struct vsock_pool* pool)
+{
+	int i;
+	if(down_interruptible(&pool->free))
+		return NULL;
+	mutex_lock(&pool->lock);
+	i = find_next_zero_bit(pool->map, POOL_SIZE, 0);
+	if ( i >= POOL_SIZE) bug("why we can't get one");
+	set_bit(i, pool->map);
+	mutex_unlock(&pool->lock);
+	return pool->socks[i];
+}
+
+static void put_vsock(struct vsock_pool* pool, struct socket* sock)
+{
+	int i;
+	int ret;
+	for (i = 0; i < POOL_SIZE; ++i) {
+		if (sock != pool->socks[i])
+			continue;
+		mutex_lock(&pool->lock);
+		ret = __test_and_clear_bit(i, pool->map);
+		mutex_unlock(&pool->lock);
+		if (ret == 0)bug("double free\n");
+		up(&pool->free);
+		return;
+	}
+	bug("it's not a vsock %p\n", sock);
+}
+
+static long stream_pwrite(struct forward* fwd, struct drm_i915_gem_pwrite* pw)
+{
+	struct socket* vsock;
+	struct pwrite_stream stream;
+	struct msghdr msg;
+	struct iovec iov;
+	int ret;
+	unsigned long done = 0;
+	char c;
+
+	ret = import_single_range(WRITE, (void __user *)pw->data_ptr, pw->size, &iov, &msg.msg_iter);
+	if (unlikely(ret)) {
+		bug("can't import range %d\n", ret);
+		return ret;
+	}
+	stream.magic = STREAM_MAGIC;
+	stream.fd = fwd->host_fd;
+	stream.handle = pw->handle;
+	stream.offset = pw->offset;
+	stream.size = pw->size;
+	vsock = get_vsock(&stream_pool);
+	if (vsock == NULL)
+		return -EINTR;
+	ret = vsock_send(vsock, &stream, sizeof(stream));
+	if (ret != sizeof(stream)) {
+		put_vsock(&stream_pool, vsock);
+		ERROR(-EIO);
+	}
+	msg.msg_name = NULL;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_namelen = 0;
+	msg.msg_flags = 0;
+	for(;;) {
+		ret = sock_sendmsg(vsock, &msg);
+		if (ret <= 0)
+			bug("Want to write %lld, got %d\n", pw->size, ret);
+		done += ret;
+		if (done == pw->size)
+			break;
+		iov.iov_base = (void __user *)(pw->data_ptr + done);
+		iov.iov_len = pw->size - done;
+		msg.msg_iter.count = iov.iov_len;
+		msleep(1);
+	}
+	ret = vsock_recv(vsock, &c, 1);
+	if (ret != 1)
+		bug("can't get reply");
+	put_vsock(&stream_pool, vsock);
+	return 0;
+}
+
+static long ipc_pwrite(int host_fd, uint32_t handle,
+		       uint64_t size, uint64_t offset, struct sg_table* sg) {
+	int i;
+	long ret;
+	struct scatterlist *sgl;
+	struct drm_i915_gem_pwrite* pw = (struct drm_i915_gem_pwrite *)ipc + 1;
+	unsigned long host_arg = get_host_addr(pw);
+	if (sg->nents > IPC_PAGE_SIZE/sizeof(*pw) - 1) {
+		pr_warn("too much entries %d %lld", sg->nents, size);
+		return -ENOMEM;
+	}
+	mutex_lock(&ipc_mutex);
+	pw->pad = sg->nents;
+	for_each_sg(sg->sgl, sgl, sg->nents, i) {
+		pw->handle = handle;
+		pw->offset = offset;
+		pw->size = sgl->length;
+		pw->data_ptr = phy_host_addr(sg_phys(sgl));
+		offset += sgl->length;
+		pw++;
+	}
+	ret = host_cmd(DRM_IOCTL_I915_GEM_PWRITE, host_fd, 0, 0, host_arg);
+	mutex_unlock(&ipc_mutex);
+	return ret;
+}
+
+static int host_recvmsg(int host_fd, int fds[], unsigned int fdc,
+		        unsigned long usr_ptr, unsigned int size)
+{
+	unsigned int fd_size = sizeof(int) * fdc;
+	struct cmsghdr* hdr = (struct cmsghdr *)ipc->data;
+	size_t total;
+	int ret;
+
+	total = sizeof(*hdr) + fd_size + size;
+	if (total > MAX_IPC_DATA_SIZE)
+		return -ENOMEM;
+	mutex_lock(&ipc_mutex);
+	ret = host_cmd(WL_CMD_RECVMSG, host_fd, fdc, size, 0);
+	if ( ret < 0) {
+		mutex_unlock(&ipc_mutex);
+		return ret;
+	}
+	memcpy(fds, ipc->data + sizeof(*hdr), fdc * sizeof(int));
+	if (copy_to_user((void __user *)usr_ptr,
+			 ipc->data + sizeof(*hdr) + fdc * sizeof(int),
+			 ret)) {
+		mutex_unlock(&ipc_mutex);
+		return -EFAULT;
+	}
+	mutex_unlock(&ipc_mutex);
+	return ret;
+}
+
+static int host_sendmsg(int host_fd, int fds[], unsigned int fdc,
+		       unsigned long usr_ptr, unsigned int size)
+{
+	unsigned int fd_size = sizeof(int) * fdc;
+	struct cmsghdr* hdr = (struct cmsghdr *)ipc->data;
+	size_t total;
+	char* data = ipc->data;
+	int ret;
+
+	if (fd_size)
+		total = sizeof(*hdr) + fd_size + size;
+	else
+		total = size;
+	if (total > MAX_IPC_DATA_SIZE)
+		ERROR(-ENOMEM);
+	mutex_lock(&ipc_mutex);
+	if (fd_size) {
+		hdr->cmsg_len = CMSG_LEN(fd_size);
+		hdr->cmsg_level = SOL_SOCKET;
+		hdr->cmsg_type =  SCM_RIGHTS;
+		data += sizeof(*hdr);
+		memcpy(data, fds, fd_size);
+		data += fd_size;
+	}
+	if (copy_from_user(data, (void __user *)usr_ptr, size)) {
+		mutex_unlock(&ipc_mutex);
+		return -EFAULT;
+	}
+	ret = host_cmd(WL_CMD_SENDMSG, host_fd, fdc, size, 0);
+	mutex_unlock(&ipc_mutex);
+	return ret;
+}
+
+static int wayland_sendmsg(struct file *filp, unsigned long arg)
+{
+	struct virtwl_ioctl_txn txn;
+	struct forward *fwd = (struct forward *)filp->private_data;
+	int i, ret, fdc = ARRAY_SIZE(txn.fds);
+	struct file *hold_fp[ARRAY_SIZE(txn.fds)];
+
+	if (copy_from_user(&txn, (void __user *)arg, sizeof(txn)))
+		ERROR(-EFAULT);
+	if (txn.len == 0)
+		ERROR(-EINVAL);
+	// Relax, we have another check later.
+	if (txn.len > MAX_IPC_DATA_SIZE)
+		ERROR(-ENOMEM);
+	for (i = 0; i <  fdc; ++i) {
+		if(txn.fds[i] < 0) {
+			fdc = i;
+			break;
+		}
+		ret = get_host_fd(txn.fds[i], NULL, &hold_fp[i], __LINE__);
+		if (ret < 0) {
+			bug("why this ");
+			fdc = i;
+			goto out;
+		}
+		txn.fds[i] = ret;
+	}
+	ret = host_sendmsg(fwd->host_fd, txn.fds, fdc,
+			   arg + sizeof(txn), txn.len);
+out:
+	for (i = 0; i < fdc; ++i) {
+		fput(hold_fp[i]);
+	}
+	if (ret < 0)
+		ERROR(ret);
+	if (ret != txn.len)
+		ERROR(-EIO);
+	return 0;
+}
+
+static int wayland_recvmsg(struct file* filp, unsigned long arg)
+{
+	struct virtwl_ioctl_txn txn;
+	struct forward *fwd = (struct forward *)filp->private_data;
+	int i, ret;
+	size_t size;
+	struct wait_poll wp;
+	unsigned int last_fd = 0;
+	DEFINE_WAIT(wait);
+
+	if (copy_from_user(&txn, (void __user *)arg, sizeof(txn))) {
+		ERROR(-EFAULT);
+	}
+	if (txn.len == 0)
+		return 0;
+	if (!access_ok(arg + sizeof(txn), txn.len))
+		ERROR(-EFAULT);
+	size = MAX_IPC_DATA_SIZE - sizeof(struct cmsghdr) - sizeof(txn.fds);
+	if (size > txn.len)
+		size = txn.len;
+
+	fwd->signaled = 0;
+	// FIXME, direct copy?
+	while((ret = host_recvmsg(fwd->host_fd, txn.fds, ARRAY_SIZE(txn.fds),
+				  arg + sizeof(txn), size)) == -EAGAIN) {
+		// FIXME
+		return -EAGAIN;
+		if (!atomic_cmpxchg(&fwd->in_wait, 0, 1)) {
+			get_file(filp);
+			wp.data = filp;
+			wp.fd = fwd->host_fd;
+			ret = vsock_send(event_sock, &wp, sizeof(wp));
+			if (ret != sizeof(wp))
+				BUG();
+		}
+		prepare_to_wait(&fwd->wq, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&fwd->wq, &wait);
+	}
+	if (ret < 0)
+		ERROR(ret);
+	txn.len = ret;
+	for (i = 0; i < ARRAY_SIZE(txn.fds); ++i) {
+		if (txn.fds[i] < 0) {
+			last_fd = i;
+			break;
+		}
+		// FIXME LEAK
+		if (setup_fd(&txn.fds[i], "host wayland", &mem_fd_fops)) {
+			BUG();
+			return -ENOMEM;
+		}
+	}
+	for(i = last_fd + 1; i < ARRAY_SIZE(txn.fds); ++i) {
+		txn.fds[i] = -1;
+	}
+	if (copy_to_user((void __user *)arg, &txn, sizeof(txn))) {
+		BUG();
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static long wayland_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	switch (cmd) {
+	case VIRTWL_IOCTL_RECV:
+		return wayland_recvmsg(filp, arg);
+	case VIRTWL_IOCTL_SEND:
+		return wayland_sendmsg(filp, arg);
+	default:
+		BUG();
+		return -ENOTTY;
+	}
+}
+
+static long less_copy_pwrite(struct drm_i915_gem_pwrite* pw, int host_fd)
+{
+	long pc, page_nr;
+	int i;
+	struct page **pages;
+	struct sg_table sg = {};
+	long ret = -ENOMEM;
+	uint64_t user_ptr = ALIGN_DOWN(pw->data_ptr, PAGE_SIZE);
+	uint64_t end_ptr = PAGE_ALIGN(pw->data_ptr + pw->size);
+	uint64_t size = end_ptr - user_ptr;
+	uint64_t offset = pw->data_ptr - user_ptr;
+
+	pc = size >> PAGE_SHIFT;
+
+	pages = kmalloc(sizeof(struct page *) * pc, GFP_KERNEL);
+	if (pages == NULL)
+		return -ENOMEM;
+
+	down_read(&current->mm->mmap_sem);
+	page_nr = get_user_pages(user_ptr, pc, 0, pages, NULL);
+	up_read(&current->mm->mmap_sem);
+	if (page_nr != pc) {
+		pr_warn("can't pin all pages %ld %ld\n", page_nr, pc);
+		goto out;
+	}
+	ret = sg_alloc_table_from_pages(&sg, pages, pc, offset,
+					pw->size, GFP_KERNEL);
+	if (ret) {
+		pr_warn("can't get sg table");
+		goto out;
+	}
+	ret = ipc_pwrite(host_fd, pw->handle, pw->size, pw->offset, &sg);
+out:
+	sg_free_table(&sg);
+	for (i = 0; i < page_nr; ++i)
+		put_page(pages[i]);
+	kfree(pages);
+	return ret;
+}
+
+typedef struct drm_version_32 {
+	int version_major;	  /* Major version */
+	int version_minor;	  /* Minor version */
+	int version_patchlevel;	   /* Patch level */
+	u32 name_len;		  /* Length of name buffer */
+	u32 name;		  /* Name of driver */
+	u32 date_len;		  /* Length of date buffer */
+	u32 date;		  /* User-space buffer to hold date */
+	u32 desc_len;		  /* Length of desc buffer */
+	u32 desc;		  /* User-space buffer to hold desc */
+} drm_version32_t;
+
+typedef struct drm_i915_getparam_32 {
+	__s32 param;
+	u32 value;   /* User-space pointr to hold int */
+} drm_i915_getparam32_t;
+
+#define COMPAT_DRM_IOCTL_VERSION DRM_IOWR(0x00, drm_version32_t)
+#define COMPAT_DRM_IOCTL_I915_GETPARAM DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GETPARAM, drm_i915_getparam32_t)
+
+static unsigned int translate_from32(unsigned int cmd, char* data)
+{
+	struct drm_version dv;
+	struct drm_i915_getparam  gv;
+	drm_version32_t* dv32;
+	drm_i915_getparam32_t* gv32;
+	switch (cmd) {
+	case COMPAT_DRM_IOCTL_VERSION:
+		dv32 = (drm_version32_t *)data;
+		cmd = DRM_IOCTL_VERSION;
+		dv.name_len = dv32->name_len;
+		dv.name = compat_ptr(dv32->name);
+		dv.date_len = dv32->date_len;
+		dv.date = compat_ptr(dv32->date);
+		dv.desc_len = dv32->desc_len;
+		dv.desc = compat_ptr(dv32->desc);
+		memcpy(data, &dv, sizeof(dv));
+		break;
+	case COMPAT_DRM_IOCTL_I915_GETPARAM:
+		gv32 = (drm_i915_getparam32_t *)data;
+		cmd = DRM_IOCTL_I915_GETPARAM;
+		gv.param = gv32->param;
+		gv.value = compat_ptr(gv32->value);
+		memcpy(data, &gv, sizeof(gv));
+		break;
+	default:
+		break;
+	}
+	return cmd;
+}
+
+void translate_to32(unsigned int cmd, char *data)
+{
+	struct drm_version* dv;
+	struct drm_i915_getparam*  gv;
+	drm_version32_t dv32;
+	drm_i915_getparam32_t gv32;
+	switch (cmd) {
+	case COMPAT_DRM_IOCTL_VERSION:
+		dv = (struct drm_version *)data;
+		dv32.version_major = dv->version_major;
+		dv32.version_minor = dv->version_minor;
+		dv32.version_patchlevel = dv->version_patchlevel;
+		dv32.name_len = dv->name_len;
+		dv32.name = ptr_to_compat(dv->name);
+		dv32.date_len = dv->date_len;
+		dv32.date = ptr_to_compat(dv->date);
+		dv32.desc_len = dv->desc_len;
+		dv32.desc = ptr_to_compat(dv->desc);
+		memcpy(data, &dv32, sizeof(dv32));
+		break;
+	case COMPAT_DRM_IOCTL_I915_GETPARAM:
+		gv = (drm_i915_getparam_t *)data;
+		gv32.param = gv->param;
+		gv32.value = ptr_to_compat(gv->value);
+		memcpy(data, &gv32, sizeof(gv32));
+		break;
+	default:
+		break;
+	}
+	return;
+}
+
+static long do_fast_ioctl(struct file* filp, unsigned int cmd, unsigned long arg, int *fd)
+{
+	struct forward* fwd = (struct forward *)filp->private_data;
+	long ret = -EFAULT;
+	size_t s = _IOC_SIZE(cmd);
+	int guest_fd = -1;
+	struct file* hold_fp = NULL;
+	uint64_t keep[224];
+	uint32_t count = ARRAY_SIZE(keep);
+	struct drm_i915_gem_pwrite pw;
+	unsigned int orig_cmd = cmd;
+
+	if (cmd == DRM_IOCTL_I915_GEM_MADVISE)
+		return 0;
+
+	if (cmd == DRM_IOCTL_I915_GEM_PWRITE) {
+		if (copy_from_user(&pw, (void __user *)arg, s))
+			return -EFAULT;
+		if (pw.size > stream_bar || (ret = less_copy_pwrite(&pw, fwd->host_fd))
+			== -ENOMEM)
+			return stream_pwrite(fwd, &pw);
+		else
+			return ret;
+	}
+
+	switch(cmd) {
+	case COMPAT_DRM_IOCTL_VERSION:
+	case COMPAT_DRM_IOCTL_I915_GETPARAM:
+	case DRM_IOCTL_GEM_CLOSE:
+	case DRM_IOCTL_GET_CAP:
+	case DRM_IOCTL_I915_GEM_BUSY:
+	case DRM_IOCTL_I915_GEM_CONTEXT_CREATE:
+	case DRM_IOCTL_I915_GEM_CONTEXT_DESTROY:
+	case DRM_IOCTL_I915_GEM_CONTEXT_GETPARAM:
+	case DRM_IOCTL_I915_GEM_CONTEXT_SETPARAM:
+	case DRM_IOCTL_I915_GEM_CREATE:
+	case DRM_IOCTL_I915_GEM_GET_TILING:
+	case DRM_IOCTL_I915_GEM_GET_APERTURE:
+	case DRM_IOCTL_I915_GEM_MADVISE:
+	case DRM_IOCTL_I915_GEM_MMAP:
+	case DRM_IOCTL_I915_GEM_MMAP_GTT:
+	case DRM_IOCTL_I915_GEM_WAIT:
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2:
+	case DRM_IOCTL_I915_GEM_EXECBUFFER2_WR:
+	case DRM_IOCTL_I915_GEM_SW_FINISH:
+	case DRM_IOCTL_I915_GEM_SET_DOMAIN:
+	case DRM_IOCTL_I915_GEM_SET_TILING:
+	case DRM_IOCTL_I915_GEM_THROTTLE:
+	case DRM_IOCTL_I915_REG_READ:
+	case DRM_IOCTL_I915_GETPARAM:
+	case DRM_IOCTL_I915_GET_RESET_STATS:
+	case DRM_IOCTL_MODE_GETPROPERTY:
+	case DRM_IOCTL_MODE_GETPLANE:
+	case DRM_IOCTL_MODE_GETPLANERESOURCES:
+	case DRM_IOCTL_MODE_GETPLANERESOURCES32:
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES:
+	case DRM_IOCTL_MODE_OBJ_GETPROPERTIES32:
+	case DRM_IOCTL_SET_CLIENT_CAP:
+	case DRM_IOCTL_VERSION:
+	case SYNC_IOC_FILE_INFO:
+	case SYNC_IOC_MERGE:
+	case SW_SYNC_IOC_CREATE_FENCE:
+	case SW_SYNC_IOC_INC:
+	case DRM_IOCTL_PRIME_FD_TO_HANDLE:
+	case DRM_IOCTL_PRIME_HANDLE_TO_FD:
+		break;
+	default:
+		return -ENOSYS;
+	}
+	if (s > MAX_IPC_DATA_SIZE) {
+		bug("too big ioctl\n");
+	}
+	mutex_lock(&ipc_mutex);
+	if (cmd & IOC_IN) {
+		if (copy_from_user(ipc->data, (void __user *)arg, s))
+			goto out;
+		cmd = translate_from32(cmd, ipc->data);
+		if (pre_deep_copy(cmd, ipc->data, &guest_fd, &hold_fp, keep, &count))
+			goto out;
+	}
+	ret = host_cmd(cmd, fwd->host_fd, 0, 0,  get_host_addr(ipc->data));
+	if (ret == 0) {
+		if (deep_copy(filp, cmd, ipc->data, guest_fd, hold_fp,
+				  keep, count, fd)) {
+		   ret = -EFAULT;
+		   goto out;
+		}
+		translate_to32(orig_cmd, ipc->data);
+		if ((cmd & IOC_OUT) && copy_to_user((void __user *)arg, (void *)&ipc->data, s))
+			ret = -EFAULT;
+	}
+out:
+	mutex_unlock(&ipc_mutex);
+	return ret;
+}
+
+static long do_ioctl(struct file *filp, unsigned int cmd, unsigned long arg,
+		     int line)
+{
+	int fd = -1;
+	int ret;
+
+	ret = do_fast_ioctl(filp, cmd, arg, &fd);
+
+	if (ret == 0 && cmd == DRM_IOCTL_PRIME_HANDLE_TO_FD) {
+		if (fd < 0)bug("not expected: %d\n", fd);
+		if (setup_fd(&fd, "forwarder", &forwarder_fops))
+			ERROR(-ENOMEM);
+		if(put_user(fd, (int __user *)(
+					       arg +
+					       offsetof(struct drm_prime_handle,
+							fd))))
+			ERROR(-EFAULT);
+	}
+	if (ret == -ENOSYS)bug("Not supported ioctl %x line:%d\n", cmd, line);
+	return ret;
+}
+
+static long virt_wl_dmabuf_sync(struct file *filp, unsigned long arg)
+{
+	struct virtwl_ioctl_dmabuf_sync sync;
+	struct forward* fwd = (struct forward *)filp->private_data;
+	int ret;
+
+	if(copy_from_user(&sync, (void __user *)arg, sizeof(sync)))
+		return -EFAULT;
+
+	if (sync.flags & ~DMA_BUF_SYNC_VALID_FLAGS_MASK)
+		return -EINVAL;
+
+	mutex_lock(&ipc_mutex);
+	memcpy(ipc->data, &sync, sizeof(sync));
+	*(int *)(ipc->data + 4) = 0;
+	ret = host_cmd(DMA_BUF_IOCTL_SYNC, fwd->host_fd, 0, 0,  get_host_addr(ipc->data));
+	mutex_unlock(&ipc_mutex);
+	return ret;
+}
+
+static long forwarder_ioctl(struct file *filp, unsigned int cmd,
+		     unsigned long arg) {
+	if (cmd == VIRTWL_IOCTL_DMABUF_SYNC)
+		return virt_wl_dmabuf_sync(filp, arg);
+	if ((cmd & ~IOCSIZE_MASK) ==
+	    (DRM_IOCTL_VIRTGPU_RESOURCE_INFO & ~IOCSIZE_MASK))
+		return -ENOTTY;
+	return do_ioctl(filp, cmd, arg, __LINE__);
+}
+
+static long sync_ioctl(struct file *filp, unsigned int cmd,
+		       unsigned long arg) {
+	if (cmd == SYNC_IOC_LEGACY_MERGE ||
+	    cmd == SYNC_IOC_LEGACY_FENCE_INFO)
+		return -ENOTTY;
+        return do_ioctl(filp, cmd, arg, __LINE__);
+}
+
+static long sw_sync_ioctl(struct file *filp, unsigned int cmd,
+		          unsigned long arg) {
+        return do_ioctl(filp, cmd, arg, __LINE__);
+}
+
+//FIXME  host need to verify address/size etc.
+void host_mmap_open(struct vm_area_struct *vma)
+{
+	struct host_mmap* m = vma->vm_private_data;
+	m->count++;
+	return;
+}
+
+//FIXME  host need to verify address/size etc.
+void host_mmap_close(struct vm_area_struct *vma)
+{
+	struct host_mmap* m = vma->vm_private_data;
+	int ret;
+
+	m->count--;
+	if (m->count) {
+		return;
+	}
+	ret = host_cmd(WL_CMD_MUNMAP, m->pn_off, m->pn_count, 0, 0);
+	if (ret) {
+		bug("munmap host failed %d\n", ret);
+	}
+	kfree(m);
+	vma->vm_private_data = NULL;
+	return;
+}
+
+static const struct vm_operations_struct dummy_vm_ops;
+
+static const struct vm_operations_struct vm_ops = {
+	.open = host_mmap_open,
+	.close = host_mmap_close,
+};
+
+static int null_vm_ops(const struct vm_operations_struct* vm_ops)
+{
+	return !vm_ops || !memcmp(vm_ops, &dummy_vm_ops, sizeof(*vm_ops));
+}
+
+static int quick_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int ret;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	struct host_mmap* m;
+
+	if (size > UINT_MAX) {
+		// FIXME, release host mmap?
+		pr_warn("Too big map request %ld\n", size);
+		return -ENOMEM;
+	}
+	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				 size, vma->vm_page_prot);
+	//FIXME hook for vm_ops.close
+	if(ret) {
+		bug("quick mmap done %d\n", ret);
+	} else {
+		if (vma->vm_private_data || !null_vm_ops(vma->vm_ops)) {
+			bug("We already have it %p %p\n", vma->vm_private_data,
+			    vma->vm_ops);
+			BUG();
+		}
+		m = kmalloc(sizeof(*m), GFP_KERNEL);
+		m->pn_off = vma->vm_pgoff;
+		m->pn_count = size >> PAGE_SHIFT;
+		m->count = 1;
+		vma->vm_private_data = m;
+		vma->vm_ops = &vm_ops;
+	}
+	return ret;
+}
+
+
+static loff_t forwarder_lseek(struct file *filp, loff_t offset, int whence)
+{
+	struct forward *fwd = (struct forward *) filp->private_data;
+	loff_t ret;
+	if (offset) {
+		bug("Who will call me with no zero off?");
+		return -EINVAL;
+	}
+	ret = host_cmd(WL_CMD_LSEEK, fwd->host_fd, whence, 0, 0);
+	return ret;
+}
+
+static int forwarder_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct forward *fwd = (struct forward *) filp->private_data;
+	int pc;
+	unsigned long size;
+	struct host_mmap* m;
+	int ret;
+	long pfn;
+
+	size = vma->vm_end - vma->vm_start;
+	if (!PAGE_ALIGNED(size)){
+		pr_warn("Not aligned: %ld\n", size);
+		return -ENOMEM;
+	}
+	if (size > UINT_MAX || vma->vm_pgoff > UINT_MAX) {
+		pr_warn("Too big mmap request: %ld %ld\n", size, vma->vm_pgoff);
+		return -ENOMEM;
+	}
+	pc = size >> PAGE_SHIFT;
+
+	pfn = host_cmd(WL_CMD_MMAP, fwd->host_fd, vma->vm_pgoff, pc, 0);
+	if (pfn < 0) {
+		bug("mmap from system failure %ld\n", pfn);
+		ERROR(pfn);
+	}
+	ret = io_remap_pfn_range(vma, vma->vm_start, pfn,
+				 size, vma->vm_page_prot);
+	if(ret) {
+		bug("forwarder mmap done %d\n", ret);
+	} else {
+		if (vma->vm_private_data || !null_vm_ops(vma->vm_ops)) {
+			bug("We already have it %p %p\n", vma->vm_private_data,
+			    vma->vm_ops);
+			BUG();
+		}
+		m = kmalloc(sizeof(*m), GFP_KERNEL);
+		m->pn_off = pfn;
+		m->pn_count = pc;
+		m->count = 1;
+		vma->vm_private_data = m;
+		vma->vm_ops = &vm_ops;
+	}
+	return ret;
+}
+
+static int forwarder_release(struct inode *inode, struct file *filp)
+{
+	struct forward* fwd = (struct forward *)filp->private_data;
+	int ret;
+	struct wait_poll wp;
+	wp.data = NULL;
+	wp.fd = fwd->host_fd;
+	ret = vsock_send(event_sock, &wp, sizeof(wp));
+	if (ret != sizeof(wp)) {
+		BUG();
+	}
+	kfree(fwd);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static int quick_release(struct inode *inode, struct file *filp)
+{
+	fput((struct file *)filp->private_data);
+	filp->private_data = NULL;
+	return 0;
+}
+
+#define DRM_NAME "drm"
+#define DUMMY_NAME "dummy"
+#define DEV_NAME "forwarder"
+
+struct forwarder_dev {
+	struct device *root;
+	struct class *drm;
+	struct class *dummy;
+	struct device *render;
+	struct device *sync;
+	struct device *wl;
+};
+
+#define RENDER_NODE_NAME "renderD%d"
+
+static int replace_devices(void)
+{
+	int ret;
+	if (crostini)
+		return ksys_link("/dev/dri/renderD128", "/dev/dri/card0");
+	ret = ksys_chmod("/sys/kernel/debug/sync/sw_sync", 0);
+	if (ret && ret != -ENOENT)
+		return ret;
+	ret = ksys_chown("/dev/sw_sync", 1000, 1000);
+	if (ret)
+		return ret;
+	ret = ksys_chmod("/dev/fwl", 0666);
+	if (ret)
+		return ret;
+	ksys_unlink("/dev/wl0");
+	return ksys_link("/dev/fwl", "/dev/wl0");
+}
+
+static int wait_wake_thread(void * data)
+{
+	int ret, i;
+	struct wait_poll w;
+	struct file * filp = NULL;
+	struct forward * fwd;
+	unsigned long ipc_phy_addr;
+	struct socket* sock;
+	unsigned int magic;
+
+	ipcq[0]  = kzalloc(IPC_PAGE_SIZE * (IPC_COUNT + 1), GFP_KERNEL);
+	if (ipcq[0] == NULL) {
+		pr_warn("can't allocate ipc ram");
+		BUG();
+	}
+
+	for (i = 1; i <  IPC_COUNT; ++i)
+		ipcq[i] =  ipcq[i - 1] + IPC_PAGE_SIZE;
+	ipc = (struct ipc *)(ipcq[IPC_COUNT - 1]  + IPC_PAGE_SIZE);
+
+	mutex_init(&ipc_mutex);
+	mutex_init(&ipc_cmd_mutex);
+	mutex_init(&stream_mutex);
+	sema_init(&free_stream_socks, 0);
+	ipc_phy_addr = virt_to_phys(ipc);
+
+	ret = kvm_hypercall3(KVM_HC_FORWARDING, -1, 0, 0);
+	hyper_ipc_working = (ret == -EBADF);
+
+	if ((ret = connect_vsock(&sock))) {
+		pr_warn("can't connect to host");
+		BUG();
+	}
+	magic = EVENT_MAGIC;
+	if (vsock_send(sock, &magic, sizeof(magic)) != sizeof(magic))
+		bug("can't send out magic");
+
+	init_vsock_pool(&stream_pool, STREAM_MAGIC);
+
+	ret = vsock_send(sock, &ipc_phy_addr, sizeof(ipc_phy_addr));
+	if (ret != sizeof(ipc_phy_addr)) {
+		pr_warn("can't get ipc phy addr %d\n", ret);
+		BUG();
+	}
+	ret = vsock_recv(sock, host_addr, sizeof(host_addr));
+	if (ret != sizeof(host_addr)) {
+		pr_warn("can't get back host_addr %d\n", ret);
+		BUG();
+	}
+
+	ret = replace_devices();
+	if (ret < 0) {
+		pr_warn("can't replace devices\n");
+		BUG();
+	}
+
+	open_hook = wayland_open_tmp;
+	ftruncate_hook = wayland_ftruncate;
+	fallocate_hook = wayland_fallocate;
+
+	event_sock = sock;
+	for(;;) {
+		ret = vsock_recv(event_sock, &w, sizeof(w));
+		if (ret != sizeof(w)) {
+			pr_warn("wait got %d\n", ret);
+			BUG();
+		}
+		filp = w.data;
+		fwd = (struct forward *)filp->private_data;
+		fwd->signaled = 1;
+		if (!atomic_cmpxchg(&fwd->in_wait, 1, 0))bug("why");
+		wake_up(&fwd->wq);
+		fput(filp);
+	}
+}
+
+static char *render_node_name(struct device *dev, umode_t *mode)
+{
+	*mode |= 0666;
+	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
+}
+
+static char *wl_node_name(struct device *dev, umode_t *mode)
+{
+	*mode |= 0666;
+	return kasprintf(GFP_KERNEL, "%s", dev_name(dev));
+}
+
+static int pci_dummy_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	return add_uevent_var(env, "PCI_SLOT_NAME=0000:00:00.0");
+}
+
+#define pci_config_attr(field, format_string)				   \
+static ssize_t								   \
+field##_show(struct device *dev, struct device_attribute *attr, char *buf) \
+{									    \
+	return sprintf(buf, format_string, field);			\
+}									\
+static DEVICE_ATTR_RO(field)
+
+pci_config_attr(vendor, "0x%04x\n");
+pci_config_attr(device, "0x%04x\n");
+pci_config_attr(subsystem_vendor, "0x%04x\n");
+pci_config_attr(subsystem_device, "0x%04x\n");
+pci_config_attr(config, "%s");
+
+static struct attribute *pci_dev_attrs[] = {
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_subsystem_device.attr,
+	&dev_attr_config.attr,
+	NULL,
+};
+
+static const struct attribute_group pci_dev_group = {
+	.attrs = pci_dev_attrs,
+};
+
+static const struct attribute_group *pci_dev_groups[] = {
+	&pci_dev_group,
+	NULL,
+};
+
+// Make libdrm happy to work around some checks for sysfs files.
+static struct bus_type pci_dummy_bus = {
+	.name = "pci_dummy",
+	.uevent = pci_dummy_uevent,
+	.dev_groups = pci_dev_groups,
+};
+
+static void init_config(void)
+{
+	unsigned short *c =(unsigned short *)config;
+	*(c++) = vendor;
+	*c = device;
+}
+
+static int __init forwarder_init(void)
+{
+	struct forwarder_dev *dev = NULL;
+	int ret;
+	unsigned int dev_num;
+
+	if(!enable)
+		return -ENODEV;
+
+	init_config();
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	ret = bus_register(&pci_dummy_bus);
+	if (ret)
+		goto free_dev;
+	dev->root = kzalloc(sizeof(*dev->root), GFP_KERNEL);
+	if (!dev->root)
+		goto unregister_bus;
+	device_initialize(dev->root);
+	dev->root->bus = &pci_dummy_bus;
+	dev_set_name(dev->root, DEV_NAME);
+	ret = device_add(dev->root);
+	if (ret) {
+		pr_warn("can't create config %d\n", ret);
+		goto destroy_root;
+	}
+	ret = __register_chrdev(major, RENDER_MINOR, MINOR_NUM, DEV_NAME,
+				&entry_fops);
+	if (ret < 0) {
+		pr_warn("can't register chrdev %d\n", ret);
+		goto destroy_root;
+	}
+	if (major == 0) major = ret;
+	dev_num = MKDEV(major, RENDER_MINOR);
+
+	dev->drm = class_create(THIS_MODULE, DRM_NAME);
+	if (IS_ERR(dev->drm)) {
+		ret = PTR_ERR(dev->drm);
+		pr_warn("can't create class %d\n", ret);
+		goto unregister_dev;
+	}
+	dev->drm->devnode = render_node_name;
+
+	dev->dummy = class_create(THIS_MODULE, DUMMY_NAME);
+	if (IS_ERR(dev->dummy)) {
+		ret = PTR_ERR(dev->dummy);
+		pr_warn("can't create class %d\n", ret);
+		goto destroy_drm;
+	}
+
+	dev->render = device_create(dev->drm, dev->root,
+				    dev_num, dev,
+				    RENDER_NODE_NAME, RENDER_MINOR);
+	if (IS_ERR(dev->render)) {
+		ret = PTR_ERR(dev->render);
+		pr_warn(DEV_NAME ": failed to create device: %d\n", ret);
+		goto destroy_dummy;
+	}
+	dev->sync = device_create(dev->dummy, dev->root,
+				  dev_num + 1, dev, "sw_sync");
+
+	if (IS_ERR(dev->sync)) {
+		ret = PTR_ERR(dev->sync);
+		pr_warn(DEV_NAME ": failed to create device: %d\n", ret);
+		goto destroy_render;
+	}
+
+
+	dev->dummy->devnode = wl_node_name;
+	dev->wl = device_create(dev->dummy, dev->root,
+				dev_num + 2, dev, crostini ? "wl0" : "fwl");
+
+	if (IS_ERR(dev->wl)) {
+		ret = PTR_ERR(dev->wl);
+		pr_warn(DEV_NAME ": failed to create device: %d\n", ret);
+		goto destroy_sync;
+	}
+
+	wait_wake = kthread_create(wait_wake_thread, NULL, "forwarder-wait-wake");
+	if (IS_ERR(wait_wake)) {
+		ret = PTR_ERR(wait_wake);
+		pr_warn("can't create kthread %d", ret);
+		goto destroy_wl;
+	}
+	return 0;
+destroy_wl:
+	put_device(dev->wl);
+destroy_sync:
+	put_device(dev->sync);
+destroy_render:
+	put_device(dev->render);
+destroy_dummy:
+	class_destroy(dev->dummy);
+destroy_drm:
+	class_destroy(dev->drm);
+unregister_dev:
+	unregister_chrdev_region(dev_num, MINOR_NUM);
+destroy_root:
+	put_device(dev->root);
+unregister_bus:
+	bus_unregister(&pci_dummy_bus);
+free_dev:
+	kfree(dev);
+err:
+	bug("ret: %d\n", ret);
+	return ret;
+}
+
+static void __exit forwarder_exit(void)
+{
+	// FIXME
+}
+
+module_init(forwarder_init);
+module_exit(forwarder_exit);
+
+module_param(enable, int, 0444);
+module_param(major, ushort, 0444);
+module_param(hyper_ipc, int, 0644);
+module_param(hyper_ipc_working, int, 0444);
+module_param(stream_bar, int, 0644);
+module_param(vendor, ushort, 0444);
+module_param(device, ushort, 0444);
+MODULE_PARM_DESC(enable, "Boolean to enable forwarder");
diff --git a/fs/open.c b/fs/open.c
index f1c2f855fd43..233a4eadf2bd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -199,8 +199,14 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	return error;
 }
 
+long (*ftruncate_hook)(unsigned int, unsigned long);
+EXPORT_SYMBOL(ftruncate_hook);
+
 SYSCALL_DEFINE2(ftruncate, unsigned int, fd, unsigned long, length)
 {
+	long ret;
+	if (ftruncate_hook && (ret = ftruncate_hook(fd, length)) != -ENOSYS)
+		return ret;
 	return do_sys_ftruncate(fd, length, 1);
 }
 
@@ -334,8 +340,14 @@ int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 	return error;
 }
 
+long (*fallocate_hook)(int, int, loff_t, loff_t);
+EXPORT_SYMBOL(fallocate_hook);
+
 SYSCALL_DEFINE4(fallocate, int, fd, int, mode, loff_t, offset, loff_t, len)
 {
+	long ret;
+	if (fallocate_hook && (ret = fallocate_hook(fd, mode, offset, len)) != -ENOSYS)
+		return ret;
 	return ksys_fallocate(fd, mode, offset, len);
 }
 
@@ -1079,8 +1091,14 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 	return fd;
 }
 
+long (*open_hook)(const char __user *, int, umode_t);
+EXPORT_SYMBOL(open_hook);
+
 SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
 {
+	long ret;
+	if (open_hook  && (ret = open_hook(filename, flags, mode)) != -ENOSYS)
+		return ret;
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
diff --git a/include/uapi/linux/virtwl.h b/include/uapi/linux/virtwl.h
new file mode 100644
index 000000000000..939041389b40
--- /dev/null
+++ b/include/uapi/linux/virtwl.h
@@ -0,0 +1,64 @@
+#ifndef _LINUX_VIRTWL_H
+#define _LINUX_VIRTWL_H
+
+#include <asm/ioctl.h>
+#include <linux/types.h>
+
+#define VIRTWL_SEND_MAX_ALLOCS 28
+
+#define VIRTWL_IOCTL_BASE 'w'
+#define VIRTWL_IO(nr)		_IO(VIRTWL_IOCTL_BASE, nr)
+#define VIRTWL_IOR(nr, type)	_IOR(VIRTWL_IOCTL_BASE, nr, type)
+#define VIRTWL_IOW(nr, type)	_IOW(VIRTWL_IOCTL_BASE, nr, type)
+#define VIRTWL_IOWR(nr, type)	_IOWR(VIRTWL_IOCTL_BASE, nr, type)
+
+enum virtwl_ioctl_new_type {
+	VIRTWL_IOCTL_NEW_CTX, /* open a new wayland connection context */
+	VIRTWL_IOCTL_NEW_ALLOC, /* create a new virtwl shm allocation */
+	/* create a new virtwl pipe that is readable via the returned fd */
+	VIRTWL_IOCTL_NEW_PIPE_READ,
+	/* create a new virtwl pipe that is writable via the returned fd */
+	VIRTWL_IOCTL_NEW_PIPE_WRITE,
+	/* create a new virtwl dmabuf that is writable via the returned fd */
+	VIRTWL_IOCTL_NEW_DMABUF,
+};
+
+struct virtwl_ioctl_new {
+	__u32 type; /* VIRTWL_IOCTL_NEW_* */
+	int fd; /* return fd */
+	__u32 flags; /* currently always 0 */
+	union {
+		/* size of allocation if type == VIRTWL_IOCTL_NEW_ALLOC */
+		__u32 size;
+		/* buffer description if type == VIRTWL_IOCTL_NEW_DMABUF */
+		struct {
+			__u32 width; /* width in pixels */
+			__u32 height; /* height in pixels */
+			__u32 format; /* fourcc format */
+			__u32 stride0; /* return stride0 */
+			__u32 stride1; /* return stride1 */
+			__u32 stride2; /* return stride2 */
+			__u32 offset0; /* return offset0 */
+			__u32 offset1; /* return offset1 */
+			__u32 offset2; /* return offset2 */
+		} dmabuf;
+	};
+};
+
+struct virtwl_ioctl_txn {
+	int fds[VIRTWL_SEND_MAX_ALLOCS];
+	__u32 len;
+	__u8 data[0];
+};
+
+struct virtwl_ioctl_dmabuf_sync {
+	__u32 flags; /* synchronization flags (see dma-buf.h) */
+};
+
+#define VIRTWL_IOCTL_NEW VIRTWL_IOWR(0x00, struct virtwl_ioctl_new)
+#define VIRTWL_IOCTL_SEND VIRTWL_IOR(0x01, struct virtwl_ioctl_txn)
+#define VIRTWL_IOCTL_RECV VIRTWL_IOW(0x02, struct virtwl_ioctl_txn)
+#define VIRTWL_IOCTL_DMABUF_SYNC VIRTWL_IOR(0x03, \
+					    struct virtwl_ioctl_dmabuf_sync)
+
+#endif /* _LINUX_VIRTWL_H */
diff --git a/tools/forward/Makefile b/tools/forward/Makefile
new file mode 100644
index 000000000000..bdeba8070c69
--- /dev/null
+++ b/tools/forward/Makefile
@@ -0,0 +1,2 @@
+wayland-proxy: wayland-proxy.c wayland-proxy-main.c
+	gcc -g -Wall -o $@ $^
diff --git a/tools/forward/README b/tools/forward/README
new file mode 100644
index 000000000000..9c53aec4c6b9
--- /dev/null
+++ b/tools/forward/README
@@ -0,0 +1,58 @@
+Under Linux, most applications use GPU acceleration with help of MESA library. And
+MESA library interacts with kernel GPU driver by operating on some special
+character device file exported by kernel GPU driver. MESA library opens some
+special files in system and operations on GPU are done by ioctl/mmap system call
+and regular memory operations.
+
+The idea of render node forwarding sounds simple: we just write a kernel driver
+for guest Linux kernel and let it exports same interface to user space like the
+real Linux GPU kernel driver. So it's an API proxy between host and VM guest. We
+just proxy API at system call level. Or we can say: it's a guest device driver
+backed by another host device driver which provide same user space interface
+instead of real hardware.
+
+The code here was tested on a debian stretch host with a debian stretch guest with
+intel GPU driver. Here is the instructions:
+
+1. Create a debian stretch guest on a debian stretch host first.
+
+2. Build guest kernel and guest tool:
+   make defconfig # On x86_64 host
+   make -j `nproc` bzImage
+   make -C tools/forward
+
+3. Build patched qemu:
+
+   git clone --depth 1 https://git.qemu.org/git/qemu.git
+   cd qemu
+   patch -p1 < qemu.diff
+   ./configure --target-list=x86_64-softmmu --disable-gtk
+   make -j `nproc`
+
+4. On host, launch wayland server:
+   switch to tty1 and login as a regular user and then run
+   weston -i86400
+
+5. Launch guest with command line like this:
+
+   
+   if lsmod|grep vhost_vsock; then
+	echo ok
+   else
+	sudo modprobe vhost_vsock
+	sudo chgrp kvm /dev/vhost-vsock
+	sudo chmod 660 /dev/vhost-vsock
+   fi
+   $HOME/qemu/x86_64-softmmu/qemu-system-x86_64 -nographic \
+	-smp 4 \
+	-enable-kvm \
+	-m 3072 \
+	-device vhost-vsock-pci,guest-cid=3 \
+	-kernel $HOME/linux/arch/x86/boot/bzImage -append "root=/dev/sda1 console=ttyS0" path_to_guest.img
+
+5. Inside guest:
+   
+   ./wayland-proxy &
+   Xwayland :3 -noreset &
+   export DISPLAY=:3 
+   glxinfo
diff --git a/tools/forward/qemu.diff b/tools/forward/qemu.diff
new file mode 100644
index 000000000000..c8f0f282935e
--- /dev/null
+++ b/tools/forward/qemu.diff
@@ -0,0 +1,1117 @@
+diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
+index 241db496c3..d30885a78d 100644
+--- a/accel/kvm/kvm-all.c
++++ b/accel/kvm/kvm-all.c
+@@ -258,6 +258,23 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
+     return 0;
+ }
+ 
++
++extern int add_guest_memory(void* ptr, unsigned long guest_phy_start,  size_t size);
++
++int add_guest_memory(void* ptr, unsigned long guest_phys_addr, size_t size) {
++    KVMState *s = kvm_state;
++    struct kvm_userspace_memory_region mem;
++    int ret;
++    //FIXME 100
++    mem.slot = 100;
++    mem.guest_phys_addr = guest_phys_addr;
++    mem.memory_size = size;
++    mem.userspace_addr = (uint64_t)ptr;
++    mem.flags = 0;
++    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
++    return ret;
++}
++
+ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
+ {
+     KVMState *s = kvm_state;
+diff --git a/forwarder.h b/forwarder.h
+new file mode 100644
+index 0000000000..4937cebbf7
+--- /dev/null
++++ b/forwarder.h
+@@ -0,0 +1,103 @@
++enum {
++	STREAM_MAGIC = 0xbeefc1ea,
++	EVENT_MAGIC,
++	IPC_MAGIC,
++};
++struct pwrite_stream {
++	unsigned int magic;
++	int fd;
++	unsigned int handle;
++	unsigned int offset;
++	unsigned int size;
++};
++
++#define IPC_PAGE_SIZE 32768
++
++#define IPC_COUNT 4
++
++struct ipc {
++  volatile unsigned int seq;
++  unsigned int cmd;
++  union {
++          struct {
++		  int arg1;
++		  int arg2;
++		  int arg3;
++		  int pad1;
++	  };
++	  struct {
++		  volatile int64_t ret;
++		  int64_t pad2;
++	  };
++	  struct {
++		  int fd;
++	  } ioctl;
++	  struct {
++		  unsigned int pn_count;
++	  } hostfd;
++	  struct {
++		  void* addr;
++	  } dmabuf;
++	  struct {
++		  int fd;
++		  unsigned int pn_off;
++		  unsigned int pn_count;
++	  } mmap;
++	  struct {
++		  unsigned int pn_off;
++		  unsigned int pn_count;
++	  } munmap;
++	  struct {
++		  int fd;
++		  int whence;
++	  } lseek;
++	  struct {
++		  int fd;
++		  unsigned int len;
++	  } fallocate;
++	  struct {
++		  int fd;
++		  unsigned int len;
++	  } ftruncate;
++	  struct {
++		  int fd;
++		  uint32_t fdc;
++		  uint32_t size;
++	  } msg;
++  };
++  char data[0];
++};
++
++#define WL_IOCTL_BASE 'w'
++#define VIRT_WL_MAX 32
++#define WL_IO(nr)		_IO(WL_IOCTL_BASE, nr + VIRT_WL_MAX)
++
++#define WL_CMD_NEW_RENDER_FD WL_IO(0x00)
++#define WL_CMD_NEW_WL_FD WL_IO(0x01)
++#define WL_CMD_NEW_MEM_FD WL_IO(0x02)
++#define WL_CMD_NEW_SYNC_FD WL_IO(0x03)
++#define WL_CMD_RECVMSG WL_IO(0x04)
++#define WL_CMD_SENDMSG WL_IO(0x05)
++#define WL_CMD_MMAP WL_IO(0x06)
++#define WL_CMD_MUNMAP WL_IO(0x07)
++#define WL_CMD_LSEEK WL_IO(0x08)
++#define WL_CMD_CLEAR_COUNTER WL_IO(0x09)
++#define WL_CMD_SHOW_COUNTER WL_IO(0x0A)
++#define WL_CMD_NEW_DMABUF WL_IO(0x0B)
++#define WL_CMD_FALLOCATE WL_IO(0x0C)
++#define WL_CMD_FTRUNCATE WL_IO(0x0D)
++
++#define SW_SYNC_IOC_MAGIC	'W'
++
++struct sw_sync_create_fence_data {
++	unsigned int	value;
++	char	name[32];
++	int	fence; /* fd of new fence */
++};
++
++#define SW_SYNC_IOC_CREATE_FENCE	_IOWR(SW_SYNC_IOC_MAGIC, 0,\
++		struct sw_sync_create_fence_data)
++
++#define SW_SYNC_IOC_INC			_IOW(SW_SYNC_IOC_MAGIC, 1, __u32)
++
++#define KVM_HC_FORWARDING 70
+diff --git a/src.c b/src.c
+new file mode 100644
+index 0000000000..7c5a9e3405
+--- /dev/null
++++ b/src.c
+@@ -0,0 +1,915 @@
++// Copyright 2019 The Chromium OS Authors. All rights reserved.
++// Use of this source code is governed by a BSD-style license that can be
++// found in the LICENSE file.
++
++#ifndef _GNU_SOURCE
++#define _GNU_SOURCE
++#endif
++#include <errno.h>
++#include <gbm.h>
++#include <fcntl.h>
++#include <inttypes.h>
++#include <libdrm/drm.h>
++#include <libdrm/i915_drm.h>
++#include <poll.h>
++#include <pthread.h>
++#include <stddef.h>
++#include <stdio.h>
++#include <stdint.h>
++#include <stdlib.h>
++#include <sys/ioctl.h>
++#include <sys/mman.h>
++#include <sys/socket.h>
++#include <sys/stat.h>
++#include <sys/types.h>
++#include <sys/uio.h>
++#include <sys/un.h>
++#include <unistd.h>
++#include <linux/sync_file.h>
++#include <linux/vm_sockets.h>
++#include "forwarder.h"
++
++#define EXPORT __attribute__ ((visibility ("default")))
++
++FILE *efp;
++
++#ifdef DEBUG
++
++#define debug_close(arg) do { \
++	int r = close(arg); \
++	if (r) r = errno; \
++	fprintf(efp, "%s:%d close %d got %d\n", __func__, __LINE__, arg, r); \
++} while(0)
++
++static void debug_select(fd_set * fds, int max) {
++	fprintf(stderr, "Waiting");
++	for(int i= 0; i < max; ++i) {
++		if (FD_ISSET(i, fds))
++		fprintf(stderr, " %d", i);
++	}
++	fprintf(stderr, "\n");
++}
++
++#else
++
++#define debug_close(arg) close(arg)
++
++#endif
++
++#define bug(...) do { \
++   fprintf(efp, "Bug at %s:%d\n", __func__, __LINE__); \
++   fprintf(efp,  __VA_ARGS__); \
++   fflush(efp); \
++   exit(1); \
++} while(0)
++
++#define debug(...) do { \
++   fprintf(efp, "debug at %s:%d\n", __func__, __LINE__); \
++   fprintf(efp, __VA_ARGS__); \
++   fflush(efp); \
++} while(0)
++
++static void *host_start;
++static void *guest_ram_start[2];
++uint64_t guest_phy_start;
++uint64_t guest_phy_size;
++// FIXME (big page?)
++static const int PAGE_SIZE = 4096;
++static const int PAGE_SHIFT = 12;
++
++static void create_thread(pthread_t * tid, void *(*start_routing) (void *),
++			  void *arg)
++{
++	pthread_attr_t attr;
++	int ret = pthread_attr_init(&attr);
++	if (ret)
++		bug("init thread attr");
++	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
++	if (tid == NULL)
++		tid = malloc(sizeof(*tid));
++	if (!tid)
++		bug("malloc");
++	ret = pthread_create(tid, &attr, start_routing, arg);
++	if (ret)
++		bug("create thread %d\n", ret);
++}
++
++struct forwarder {
++	int socket;
++	struct syscall_data *data;
++};
++
++#define PORT 30000
++
++static char* mem_maps;
++static unsigned int mem_maps_chars;
++
++static int all_zero(unsigned long* ptr, unsigned long off, unsigned long ac)
++{
++	unsigned i  = 0;
++	for (i = 0; i < ac; ++i) {
++		if (ptr[i + off])
++			return 0;
++	}
++	return 1;
++}
++
++static void mark_used(unsigned long pn, unsigned long pc, int used)
++{
++	if (pn % 8) bug("why strange pn");
++	unsigned long char_off = pn / 8;
++	unsigned long char_c = pc / 8;
++	unsigned int char_left = pc % 8;
++	unsigned char mask;
++	memset(mem_maps + char_off, used ? 0xff:0, char_c);
++	if (char_left) {
++		mask = (1UL << char_left) - 1;
++		if (used)
++			mem_maps[char_off + char_c] |= mask;
++		else
++			mem_maps[char_off + char_c] &= ~mask;
++	}
++}
++
++#define find_first_zero(type)  \
++static long find_first_zero_ ## type (unsigned long count) \
++{ \
++	type* ptr = (type *)mem_maps; \
++	unsigned long i, c = mem_maps_chars/sizeof(*ptr); \
++	for (i = 0; i < c; ++i) { \
++		if (ptr[i]==0) { \
++			mark_used(i * sizeof(*ptr) * 8, count, 1); \
++			return i * sizeof(*ptr) * 8; \
++		} \
++	} \
++	return -1; \
++}
++
++find_first_zero(char)
++find_first_zero(short)
++find_first_zero(int)
++find_first_zero(long)
++
++static long find_first_zero_more(unsigned long count)
++{
++	unsigned long ac = (count + 63)/64;
++	unsigned long *ptr = (unsigned long *)mem_maps;
++	unsigned long i, c = mem_maps_chars/sizeof(*ptr);
++	for (i = 0; i < c - ac; i += ac) {
++		if (all_zero(ptr, i, ac)) {
++			mark_used(i * sizeof(*ptr) * 8, count, 1);
++			return i * sizeof(*ptr) * 8;
++		}
++	}
++	return -1;
++}
++
++static unsigned long alloc_guest_phy_addr(unsigned long size)
++{
++	if (size % 4096) {
++		bug("not page aligned\n");
++		return 0;
++	}
++	unsigned long pc = size >> PAGE_SHIFT;
++	long pn;
++
++	if (pc <= 8)
++		pn = find_first_zero_char(pc);
++	else if(pc <=16)
++		pn = find_first_zero_short(pc);
++	else if(pc <=32)
++		pn = find_first_zero_int(pc);
++	else if (pc <=64)
++		pn = find_first_zero_long(pc);
++	else
++		pn = find_first_zero_more(pc);
++
++	if (pn < 0) {
++		debug("no enough address space %lx %lx\n", size,
++		      guest_phy_size);
++		return 0;
++	}
++	return (pn << PAGE_SHIFT) + guest_phy_start;
++}
++
++static int fix_mmap(unsigned int cmd, char *data)
++{
++	struct drm_i915_gem_mmap *mp;
++	unsigned long guest_phy_addr;
++	void *target, *ptr;
++	if (cmd != DRM_IOCTL_I915_GEM_MMAP)
++		return 0;
++	mp = (struct drm_i915_gem_mmap *)data;
++	guest_phy_addr = alloc_guest_phy_addr(mp->size);
++	if (!guest_phy_addr) {
++		bug("running out of space?");
++		return -ENOMEM;
++	}
++	target = host_start + guest_phy_addr - guest_phy_start;
++	ptr = mremap((void *)mp->addr_ptr, mp->size, mp->size,
++		      MREMAP_FIXED | MREMAP_MAYMOVE, target);
++	if (ptr != target) {
++		bug("%p %p remap\n", ptr, target);
++		perror("can't remap");
++		return -ENOMEM;
++	}
++	mp->addr_ptr = guest_phy_addr;
++	return 0;
++}
++
++#ifndef MFD_ALLOW_SEALING
++#define MFD_ALLOW_SEALING 0x0002U
++#endif
++
++static int do_mem_new_fd(unsigned int page_count)
++{
++	int fd = memfd_create("forwarder", MFD_ALLOW_SEALING);
++	if (fd<0) {
++		bug("new memfd");
++		return -errno;
++	}
++	if (ftruncate(fd, (off_t)page_count * PAGE_SIZE) < 0) {
++		bug("truncate");
++		return -errno;
++	}
++	return fd;
++}
++
++static struct gbm_device * gbm;
++
++struct virtwl_ioctl_new {
++	__u32 type; /* VIRTWL_IOCTL_NEW_* */
++	int fd; /* return fd */
++	__u32 flags; /* currently always 0 */
++	union {
++		/* size of allocation if type == VIRTWL_IOCTL_NEW_ALLOC */
++		__u32 size;
++		/* buffer description if type == VIRTWL_IOCTL_NEW_DMABUF */
++		struct {
++			__u32 width; /* width in pixels */
++			__u32 height; /* height in pixels */
++			__u32 format; /* fourcc format */
++			__u32 stride[3]; /* return stride0 */
++			__u32 offset[3]; /* return offset0 */
++		} dmabuf;
++	};
++};
++
++static int do_new_dmabuf(struct virtwl_ioctl_new* addr)
++{
++	struct gbm_bo *bo = gbm_bo_create(gbm, addr->dmabuf.width,
++					  addr->dmabuf.height,
++					  addr->dmabuf.format,
++					  GBM_BO_USE_LINEAR);
++	if (bo == NULL) {
++		debug("can't allocate bo %d %d %x\n", addr->dmabuf.width,
++		      addr->dmabuf.height, addr->dmabuf.format);
++		return -EINVAL;
++	}
++#if 0
++	for (int i = 0; i < gbm_bo_get_plane_count(bo); ++i) {
++		addr->dmabuf.stride[i] = gbm_bo_get_stride_for_plane(bo, i);
++		addr->dmabuf.offset[i] = gbm_bo_get_offset(bo, i);
++	}
++#else
++	addr->dmabuf.stride[0] = gbm_bo_get_stride(bo);
++	addr->dmabuf.offset[0] = 0;
++#endif
++	int fd = gbm_bo_get_fd(bo);
++	gbm_bo_destroy(bo);
++	if (fd >= 0)
++		return fd;
++	else
++		return -errno;
++}
++
++static int do_new_fd(const char* path)
++{
++	int fd = open(path, O_RDWR);
++	if (fd<0) {
++		bug("can't open fd %s\n", path);
++		return -errno;
++	}
++	return fd;
++}
++
++static int do_wl_new_fd(void)
++{
++	struct sockaddr_un addr = { };
++	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
++	const char *wd;
++	if (fd < 0) {
++		bug("create socket\n");
++	}
++	addr.sun_family = AF_UNIX;
++	wd = getenv("XDG_RUNTIME_DIR");
++	if (wd == NULL)
++		wd = "/run/chrome";
++	snprintf(addr.sun_path, sizeof(addr.sun_path), "%s/wayland-0", wd);
++	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
++		bug("connect to wayland server\n");
++		debug_close(fd);
++		return -errno;
++	}
++	return fd;
++}
++
++static int do_sendmsg(int fd, unsigned int fdc, unsigned int size,
++		       char* data)
++{
++	struct iovec iov = {0, size};
++	struct msghdr msg = {};
++	size_t fd_len = fdc * sizeof(int);
++	int ret;
++
++	msg.msg_iov = &iov;
++	msg.msg_iovlen = 1;
++	if (fd_len) {
++		msg.msg_control = data;
++		msg.msg_controllen = sizeof(struct cmsghdr) + fd_len;
++		iov.iov_base = data + msg.msg_controllen;
++	} else {
++		iov.iov_base = data;
++	}
++	ret = sendmsg(fd, &msg, 0);
++	if (ret < 0) bug("why ret %d %d\n", fd, errno);
++	return ret;
++}
++
++static int do_recvmsg(int fd, unsigned int fdc, unsigned int size,
++		      char* data)
++{
++	struct iovec iov = {0, size};
++	struct msghdr msg = {};
++	size_t fd_len = fdc * sizeof(int);
++	int ret;
++	struct cmsghdr *cmsg;
++
++	msg.msg_iov = &iov;
++	msg.msg_iovlen = 1;
++	if (fd_len != 112) bug("fd len %ld\n", fd_len);
++	msg.msg_control = data;
++	msg.msg_controllen = sizeof(*cmsg) + fd_len;
++	iov.iov_base = data + msg.msg_controllen;
++	ret = recvmsg(fd, &msg, MSG_DONTWAIT);
++	if (ret < 0 && errno != EAGAIN) bug("why ret %d %d\n", fd, errno);
++	if (ret < 0)
++		return -EAGAIN;
++	if (msg.msg_controllen) {
++		cmsg = CMSG_FIRSTHDR(&msg);
++		if (CMSG_NXTHDR(&msg, cmsg))
++			bug("I really don't expect this, fix me!\n");
++		if (cmsg->cmsg_level != SOL_SOCKET ||
++		    cmsg->cmsg_type != SCM_RIGHTS)
++			bug("I don't know about this\n");
++		fdc = (cmsg->cmsg_len - sizeof(*cmsg))/sizeof(int);
++		if (fdc > 27)bug("why so many fd");
++	} else
++		fdc = 0;
++	int *rfd = (int *)(data + sizeof(*cmsg));
++	rfd[fdc] = -1;
++	return ret;
++}
++
++struct ioctl_counter {
++	unsigned long cmd;
++	const char* name;
++	unsigned long count;
++};
++
++#define CMD(a) {a, #a, 0}
++
++static struct ioctl_counter counters[] = {
++	{0, "TOTAL",  0},
++	{0, "OTHER",  0},
++	CMD(DRM_IOCTL_GEM_CLOSE),
++	CMD(DRM_IOCTL_GET_CAP),
++	CMD(DRM_IOCTL_I915_GEM_BUSY),
++	CMD(DRM_IOCTL_I915_GEM_CONTEXT_CREATE),
++	CMD(DRM_IOCTL_I915_GEM_CONTEXT_DESTROY),
++	CMD(DRM_IOCTL_I915_GEM_CONTEXT_GETPARAM),
++	CMD(DRM_IOCTL_I915_GEM_CONTEXT_SETPARAM),
++	CMD(DRM_IOCTL_I915_GEM_CREATE),
++	CMD(DRM_IOCTL_I915_GEM_GET_APERTURE),
++	CMD(DRM_IOCTL_I915_GEM_GET_TILING),
++	CMD(DRM_IOCTL_I915_GEM_MADVISE),
++	CMD(DRM_IOCTL_I915_GEM_MMAP_GTT),
++	CMD(DRM_IOCTL_I915_GEM_SET_DOMAIN),
++	CMD(DRM_IOCTL_I915_GEM_SET_TILING),
++	CMD(DRM_IOCTL_I915_GEM_SW_FINISH),
++	CMD(DRM_IOCTL_I915_GEM_PWRITE),
++	CMD(DRM_IOCTL_I915_GEM_THROTTLE),
++	CMD(DRM_IOCTL_I915_GEM_WAIT),
++	CMD(DRM_IOCTL_I915_GET_RESET_STATS),
++	CMD(DRM_IOCTL_I915_REG_READ),
++	CMD(DRM_IOCTL_MODE_GETPLANE),
++	CMD(DRM_IOCTL_MODE_GETPLANERESOURCES),
++	CMD(DRM_IOCTL_MODE_GETPROPERTY),
++	CMD(DRM_IOCTL_MODE_OBJ_GETPROPERTIES),
++	CMD(DRM_IOCTL_SET_CLIENT_CAP),
++	CMD(DRM_IOCTL_VERSION),
++	CMD(DRM_IOCTL_I915_GETPARAM),
++	CMD(DRM_IOCTL_I915_GEM_EXECBUFFER2),
++//	CMD(DRM_IOCTL_I915_GEM_EXECBUFFER2_WR),
++	CMD(DRM_IOCTL_PRIME_HANDLE_TO_FD),
++	CMD(DRM_IOCTL_PRIME_FD_TO_HANDLE),
++	CMD(DRM_IOCTL_I915_GEM_MMAP),
++	CMD(WL_CMD_NEW_WL_FD),
++	CMD(WL_CMD_NEW_MEM_FD),
++	CMD(WL_CMD_NEW_SYNC_FD),
++	CMD(SYNC_IOC_MERGE),
++	CMD(SYNC_IOC_FILE_INFO),
++	CMD(SW_SYNC_IOC_CREATE_FENCE),
++	CMD(SW_SYNC_IOC_INC),
++};
++
++#ifndef ARRAY_SIZE
++#define ARRAY_SIZE(array) \
++    (sizeof(array) / sizeof(array[0]))
++#endif
++
++static void count_ioctl(unsigned long cmd)
++{
++	int i;
++	if (cmd == WL_CMD_CLEAR_COUNTER) {
++		for(i = 0; i < ARRAY_SIZE(counters); ++i) {
++			counters[i].count = 0;
++		}
++		return;
++	}
++	if (cmd == WL_CMD_SHOW_COUNTER) {
++		for(i = 0; i < ARRAY_SIZE(counters); ++i) {
++			fprintf(stderr, "%s: %ld\n", counters[i].name,
++				counters[i].count);
++		}
++		return;
++	}
++	counters[0].count++;
++	for (i = 0; i < ARRAY_SIZE(counters); ++i) {
++		if(counters[i].cmd == cmd) {
++			counters[i].count++;
++			return;
++		}
++	}
++	counters[1].count++;
++}
++
++static void debug_fd(int fd) {
++	char ttt[256], name[256];
++	snprintf(ttt, sizeof(ttt), "/proc/self/fd/%d", fd);
++	int rrr = readlink(ttt, name, sizeof(name));
++	if (rrr < 0) {
++		debug("fail to read link %d\n", errno);
++	}
++	name[rrr] = 0;
++	debug("we got %d %s\n", fd, name);
++}
++
++struct call_pattern {
++	unsigned long cmd;
++	int err;
++};
++
++struct call_pattern patterns[] = {
++	{DRM_IOCTL_I915_GETPARAM, EINVAL},
++	{DRM_IOCTL_I915_GEM_CONTEXT_SETPARAM, EINVAL},
++	{DRM_IOCTL_I915_GET_RESET_STATS, EPERM},
++	{DRM_IOCTL_I915_GEM_WAIT, ETIME},
++//	{DRM_IOCTL_I915_GEM_EXECBUFFER2, ENOENT},
++//	{DRM_IOCTL_I915_GEM_BUSY, ENOENT},
++};
++
++static void debug_ioctl(int fd, unsigned long cmd, int err)
++{
++	int i = 0;
++	for (i = 0; i < ARRAY_SIZE(patterns); i++) {
++		if (cmd == patterns[i].cmd &&
++		    err == patterns[i].err)
++			return;
++	}
++	debug_fd(fd);
++	bug("Cmd: %lx err: %d\n", cmd, err);
++}
++
++#define MAX_DATA_SIZE (2 << 20)
++
++static void *vsock_stream(void *arg)
++{
++	struct forwarder *f = arg;
++	int fd;
++	int socket = f->socket;
++	int ret, size;
++	struct pwrite_stream *data = (struct pwrite_stream *)f->data;
++	char c = '.';
++	for (;;) {
++		ret = read(socket, (char *)data, sizeof(*data));
++		if (ret != sizeof(*data) || data->magic != STREAM_MAGIC) {
++			if (ret)
++				debug("why only this data: %d\n", ret);
++			debug_close(socket);
++			free(data);
++			return NULL;
++		}
++		fd = data->fd;
++		int left = data->size;
++		struct drm_i915_gem_pwrite pw;
++		pw.handle = data->handle;
++		pw.offset = data->offset;
++		char *cur = (char *)data;
++		int len;
++		while(left) {
++			size = (MAX_DATA_SIZE > left ? left: MAX_DATA_SIZE);
++			len = read(socket, cur, size);
++			if (len < 0) {
++				bug("can't read %p %d %d %d\n", cur, size, len, errno);
++			}
++			left -= len;
++			pw.data_ptr = (uint64_t)cur;
++			pw.size = len;
++			ioctl(fd, DRM_IOCTL_I915_GEM_PWRITE, &pw);
++			pw.offset +=len;
++		}
++		ret = write(socket, &c, 1);
++		if (ret != 1)bug("can't write");
++	}
++}
++
++#define MAX_FD 2048
++
++void* waits[MAX_FD];
++
++struct wait_poll {
++	void* data;
++	int fd;
++};
++
++static void* get_host_addr(uint64_t guest_phy)
++{
++	if (guest_phy < (1UL << 32))
++		return (char *)guest_ram_start[0] + guest_phy;
++	return (char *)guest_ram_start[1] + guest_phy - (1UL << 32);
++}
++
++static long do_mmap(int fd, unsigned int pg_off, unsigned int pg_count)
++{
++	uint64_t size = (uint64_t)pg_count * PAGE_SIZE;
++	uint64_t off = (uint64_t)pg_off * PAGE_SIZE;
++	if (size > UINT32_MAX) {
++		debug_fd(fd);
++		bug("too big %" PRIu64 " %u %" PRIu64 "\n", size, pg_off, off);
++		return -ENOMEM;
++	}
++	unsigned long guest_phy_addr  = alloc_guest_phy_addr(size);
++	if (!guest_phy_addr) {
++		bug("too big");
++		return -ENOMEM;
++	}
++	void *target = host_start + guest_phy_addr - guest_phy_start;
++	void *ptr = mmap(target, size, PROT_WRITE | PROT_READ,
++			 MAP_SHARED | MAP_FIXED, fd, off);
++	if (ptr != target) {
++		bug("can't mmap to target\n");
++		if (errno == 0) {
++			return -ENOMEM;
++		}
++		return -errno;
++	}
++	return guest_phy_addr >> PAGE_SHIFT;
++}
++
++static int do_munmap(unsigned int pg_off, unsigned int pg_count)
++{
++	uint64_t guest_addr = (uint64_t) pg_off << PAGE_SHIFT;
++	uint64_t size = (uint64_t)pg_count << PAGE_SHIFT;
++
++	if (guest_addr < guest_phy_start ||
++	    guest_addr >= guest_phy_start + guest_phy_size ||
++	    guest_addr + size >= guest_phy_start + guest_phy_size) {
++		bug("strange munmap req %lx\n", guest_addr);
++		return -EINVAL;
++	}
++	void * target = guest_addr - guest_phy_start + host_start;
++	//FIXME Will there be race?
++	void * tptr = mmap(target, size, PROT_NONE, MAP_SHARED|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
++	if (tptr != target)
++		bug("can't unmap %p %p %d", target, tptr, errno);
++	mark_used(pg_off - (guest_phy_start >> PAGE_SHIFT), pg_count, 0);
++	return 0;
++}
++
++static int64_t handle_cmd(unsigned int cmd, struct ipc* ipc)
++{
++	switch (cmd) {
++	case WL_CMD_NEW_RENDER_FD:
++		return do_new_fd("/dev/dri/renderD128");
++	case WL_CMD_NEW_SYNC_FD:
++		return do_new_fd("/sys/kernel/debug/sync/sw_sync");
++	case WL_CMD_NEW_WL_FD:
++		return do_wl_new_fd();
++	case WL_CMD_NEW_MEM_FD:
++		return do_mem_new_fd(ipc->hostfd.pn_count);
++	case WL_CMD_NEW_DMABUF:
++		return do_new_dmabuf(ipc->dmabuf.addr);
++	case WL_CMD_MMAP:
++		return do_mmap(ipc->mmap.fd, ipc->mmap.pn_off,
++			       ipc->mmap.pn_count);
++	case WL_CMD_MUNMAP:
++		return do_munmap(ipc->munmap.pn_off,
++				 ipc->munmap.pn_count);
++	case WL_CMD_LSEEK:
++		return lseek(ipc->lseek.fd, 0, ipc->lseek.whence);
++	case WL_CMD_FALLOCATE:
++		return fallocate(ipc->fallocate.fd, 0, 0, ipc->fallocate.len);
++	case WL_CMD_FTRUNCATE:
++		return ftruncate(ipc->ftruncate.fd, ipc->ftruncate.len);
++	case WL_CMD_SENDMSG:
++		return do_sendmsg(ipc->msg.fd, ipc->msg.fdc,
++				  ipc->msg.size, ipc->data);
++	case WL_CMD_RECVMSG:
++		return do_recvmsg(ipc->msg.fd, ipc->msg.fdc,
++				  ipc->msg.size, ipc->data);
++	default:
++		bug("no supported cmd:%x\n", cmd);
++		return -ENOENT;
++	}
++}
++
++static void *fast_ipc(void *base)
++{
++	struct ipc * ipc;
++	ipc = (struct ipc *) base;
++	unsigned int seq = 0;
++	int i;
++	int ret;
++	unsigned long delay = 0;
++
++	for(;;) {
++		seq++;
++		for(;;) {
++			if (delay) {
++				usleep(delay);
++			}
++			if (ipc->seq == seq) {
++				delay /= 2;
++				break;
++			}
++			delay++;
++			if (delay > 1000)
++				delay = 1000;
++		}
++		count_ioctl(ipc->cmd);
++		if (_IOC_TYPE(ipc->cmd) == 'w') {
++			ret = handle_cmd(ipc->cmd, ipc);
++		} else if (ipc->cmd == DRM_IOCTL_I915_GEM_PWRITE) {
++			struct drm_i915_gem_pwrite* pw =
++				(struct drm_i915_gem_pwrite *)ipc + 1;
++			unsigned int count = pw->pad;
++			if (count > IPC_PAGE_SIZE/sizeof(*pw) - 1)
++				bug("too much pwrite");
++			ret = 0;
++			for (i = 0; i < count; ++i, ++pw) {
++				if(ioctl(ipc->ioctl.fd, ipc->cmd, pw)){
++					ret = -errno;
++					break;
++				}
++			}
++		} else {
++			ret = ioctl(ipc->ioctl.fd, ipc->cmd, (void *)ipc->data);
++			if (ret < 0)
++				ret = -errno;
++			else {
++				if (ipc->cmd == DRM_IOCTL_I915_GEM_MMAP
++				     && fix_mmap(ipc->cmd, ipc->data))
++				     ret = -ENOMEM;
++			}
++			if(ret)debug_ioctl(ipc->ioctl.fd, ipc->cmd, -ret);
++		}
++		ipc->ret = ret;
++		seq++;
++		ipc->seq = seq;
++	}
++	return NULL;
++}
++
++EXPORT void show(void);
++
++EXPORT void show(void)
++{
++	char buf[4096];
++	int ret;
++	int fd = open("/proc/self/maps", O_RDONLY);
++	do {
++		ret = read(fd, buf, sizeof(buf));
++		fwrite(buf, ret, 1, stderr);
++	} while (ret > 0);
++}
++
++static void add_to_poll(struct pollfd **poll_fds, unsigned int *cnt,
++			unsigned int *cap, int fd)
++{
++	if (fd < 0)bug("invalid fd %d\n", fd);
++	if (*cnt == *cap) {
++		*cap = (*cap) << 1;
++		debug("Increase poll cap to %d\n", *cap);
++		*poll_fds = realloc(*poll_fds, sizeof(**poll_fds) * (*cap));
++		if ((*poll_fds) == NULL)bug("can't malloc new memory for poll fds");
++	}
++	struct pollfd* entry = (*poll_fds) + (*cnt);
++	(*cnt)++;
++	entry->fd = fd;
++	entry->events = POLLIN;
++	entry->revents = 0;
++}
++
++static void remove_from_poll(struct pollfd *poll_fds, unsigned int* cnt, int fd)
++{
++	unsigned int i;
++	if (fd < 0)bug("invalid fd %d\n", fd);
++	for (i = 0; i < *cnt; ++i) {
++		if (poll_fds[i].fd != fd)
++			continue;
++		if (i == 0)bug("important");
++		(*cnt)--;
++		if (i == (*cnt))
++			return;
++		poll_fds[i] = poll_fds[*cnt];
++		return;
++	}
++}
++
++static void * vsock_event(void * arg)
++{
++	int * vsock = (int *) arg;
++	int vfd = *vsock;
++	// Quick hack to b
++	unsigned int fd_cnt = 0;
++	unsigned int fd_max = 8;
++	struct pollfd *poll_fds = malloc(sizeof(*poll_fds) * fd_max);
++	int ret;
++	struct wait_poll wt;
++	unsigned long ipc_phy_addr;
++	int i;
++
++	if (poll_fds == NULL)bug("can't malloca poll fds");
++
++	ret = read(vfd, &ipc_phy_addr, sizeof(ipc_phy_addr));
++	if (ret != sizeof(ipc_phy_addr)) {
++		bug("read guest phy ret %d\n", ret);
++	}
++	ret = write(vfd,  guest_ram_start, sizeof(guest_ram_start));
++	if (ret != sizeof(guest_ram_start)) {
++		bug("write host addr ret %d\n", ret);
++	}
++	create_thread(NULL, fast_ipc, get_host_addr(ipc_phy_addr));
++
++	add_to_poll(&poll_fds,  &fd_cnt, &fd_max, vfd);
++	for(;;) {
++		//debug_select(&use_fds, max_fd + 1);
++		ret = poll(poll_fds, fd_cnt, -1);
++		if (ret < 0 && errno == EINTR)
++			continue;
++		if (ret < 0) {
++			bug("poll %d\n", errno);
++		}
++		if (poll_fds[0].revents & POLLIN) {
++			ret = read(vfd,	&wt, sizeof(wt));
++			if (ret != sizeof(wt)) {
++				if (ret)
++					bug("read  %d %d\n", ret, errno);
++				return NULL;
++			}
++			if (wt.fd >= MAX_FD||wt.fd < 0){
++				bug("too much fd %d", wt.fd);
++			}
++			waits[wt.fd]  = wt.data;
++			if (wt.data) {
++				add_to_poll(&poll_fds, &fd_cnt, &fd_max, wt.fd);
++			} else {
++				debug_close(wt.fd);
++				remove_from_poll(poll_fds, &fd_cnt, wt.fd);
++			}
++		}
++		i = 1;
++		while (i < fd_cnt) {
++			struct pollfd *pfd = poll_fds + i;
++			if (!(pfd->revents & POLLIN) || !waits[pfd->fd]) {
++				i++;
++				continue;
++			}
++			wt.fd = pfd->fd;
++			wt.data = waits[pfd->fd];
++			ret = write(vfd, &wt, sizeof(wt));
++			if (ret != sizeof(wt))
++				bug("write %d %d\n", ret, errno);
++			waits[pfd->fd] = NULL;
++			remove_from_poll(poll_fds, &fd_cnt, wt.fd);
++		}
++	}
++}
++
++static void *vsock_server(void *base)
++{
++	int server_fd, new_socket;
++	struct sockaddr_vm address = { };
++	int opt = 1, ret;
++	int addrlen = sizeof(address);
++	unsigned int magic;
++
++	if ((server_fd = socket(AF_VSOCK, SOCK_STREAM, 0)) == 0) {
++		perror("socket failed");
++		exit(EXIT_FAILURE);
++	}
++	if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
++		       &opt, sizeof(opt))) {
++		perror("setsockopt");
++		exit(EXIT_FAILURE);
++	}
++	address.svm_family = AF_VSOCK;
++	address.svm_port = PORT;
++	address.svm_cid = VMADDR_CID_ANY;
++
++	if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
++		perror("bind failed");
++		exit(EXIT_FAILURE);
++	}
++	if (listen(server_fd, 3) < 0) {
++		perror("listen");
++		exit(EXIT_FAILURE);
++	}
++	for (;;) {
++		new_socket = accept(server_fd, (struct sockaddr *)&address,
++				    (socklen_t *) & addrlen);
++		if (new_socket < 0) {
++			perror("accept");
++			exit(EXIT_FAILURE);
++		}
++		ret = read(new_socket, &magic, sizeof(magic));
++		if (ret != sizeof(magic))
++			bug("Can't get sock type: %d %d\n", ret, errno);
++		switch (magic) {
++		case STREAM_MAGIC:
++			{
++				struct forwarder *c = malloc(sizeof(*c));
++				c->socket = new_socket;
++				c->data = malloc(MAX_DATA_SIZE);
++				create_thread(NULL, vsock_stream, c);
++			}
++			break;
++		case EVENT_MAGIC:
++			{
++				int * a = malloc(sizeof(*a));
++				*a = new_socket;
++				create_thread(NULL, vsock_event, a);
++			}
++			break;
++		default:
++			bug("unknown magic %x\n", magic);
++			break;
++		}
++	}
++	return NULL;
++}
++
++static void alloc_mem_maps(unsigned long mem_size)
++{
++	mem_maps_chars = ((mem_size >> PAGE_SHIFT) + 7 ) / 8;
++	mem_maps = mmap(NULL, mem_maps_chars, PROT_READ|PROT_WRITE,
++			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
++	if (mem_maps == MAP_FAILED)
++		bug("can't allocate mem maps");
++}
++
++EXPORT void start_render_node_host(void *host_addr, uint64_t guest_addr,
++				   uint64_t mem_size, void *ram0_start,
++				   void* ram4g_start)
++{
++	efp = stderr; // fopen("/tmp/rflog", "w");
++	debug("Starting render node host service %p %lx %lx\n",
++	      host_addr, guest_addr, mem_size);
++	if ((uint64_t) host_addr % PAGE_SIZE || guest_addr % PAGE_SIZE ||
++	    mem_size % PAGE_SIZE) {
++		debug("Invalid host_addr %p %lx %lx\n", host_addr,
++		      guest_addr, mem_size);
++		return;
++	}
++	host_start = host_addr;
++	guest_phy_start = guest_addr;
++	guest_phy_size = mem_size;
++	guest_ram_start[0] = ram0_start;
++	guest_ram_start[1] = ram4g_start;
++
++	alloc_mem_maps(mem_size);
++
++	int drm_fd = open("/dev/dri/renderD128", O_RDWR);
++	if (drm_fd < 0) {
++		bug("can't open render node\n");
++		return;
++	}
++	gbm = gbm_create_device(drm_fd);
++	if (gbm == NULL) {
++		bug("can't init gbm\n");
++		return;
++	}
++
++	create_thread(NULL, vsock_server, NULL);
++}
+diff --git a/vl.c b/vl.c
+index d61d5604e5..98785bf5f3 100644
+--- a/vl.c
++++ b/vl.c
+@@ -2985,6 +2985,46 @@ static void user_register_global_props(void)
+                       global_init_func, NULL, NULL);
+ }
+ 
++
++// Start form 8G, size 4G. Big enough?
++static void* qemu_host_start;
++static const unsigned long qemu_guest_phy_start = (2UL << 32);
++static const unsigned long qemu_guest_phy_size  = (1UL << 32);
++
++
++
++void start_render_node_host(void *host_addr, uint64_t guest_addr,
++		uint64_t mem_size, void *ram0_start, void* ram4g_start);
++
++static int memfd_create(const char * name, int ignored)
++{
++	char buf[256];
++	static int c;
++	snprintf(buf, sizeof(buf), "/%s%d", name, c++);
++	return shm_open(buf, O_RDWR|O_CREAT, 0600);
++}
++#include "src.c"
++
++extern int add_guest_memory(void* ptr, unsigned long guest_phy_start,  size_t size);
++
++static void add_memory(void)
++{
++	qemu_host_start = mmap(NULL, qemu_guest_phy_size, PROT_NONE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
++	if (qemu_host_start == NULL) {
++		fprintf(stderr, "faint, mmap1");
++		exit(1);
++	}
++	if (add_guest_memory(qemu_host_start, qemu_guest_phy_start, qemu_guest_phy_size)) {
++		fprintf(stderr, "faint, mmap2");
++		exit(1);
++	}
++	hwaddr len = 4096;
++	void* host0 = cpu_physical_memory_map(0, &len, 1);
++	start_render_node_host(qemu_host_start, qemu_guest_phy_start,
++			qemu_guest_phy_size, host0,  0);
++}
++
++
+ int main(int argc, char **argv, char **envp)
+ {
+     int i;
+@@ -4488,6 +4528,7 @@ int main(int argc, char **argv, char **envp)
+     qemu_opts_foreach(qemu_find_opts("device"),
+                       device_init_func, NULL, &error_fatal);
+ 
++    add_memory();
+     cpu_synchronize_all_post_init();
+ 
+     rom_reset_order_override();
diff --git a/tools/forward/wayland-proxy-main.c b/tools/forward/wayland-proxy-main.c
new file mode 100644
index 000000000000..69c34cad1f67
--- /dev/null
+++ b/tools/forward/wayland-proxy-main.c
@@ -0,0 +1,58 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#define debug(...) do { \
+	fprintf(stderr, "%s:%d\n", __func__, __LINE__); \
+	fprintf(stderr, __VA_ARGS__); \
+} while (0)
+
+#define bug(...) do { \
+	fprintf(stderr, "%s:%d\n", __func__, __LINE__); \
+	fprintf(stderr, __VA_ARGS__); \
+	exit(1); \
+} while (0)
+
+static const char wname[] = "wayland-0";
+
+void wayland_proxy(int fd);
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_un listen_addr = { };
+	int listen_fd;
+	int opt = 1;
+
+	char *proxy_dir = getenv("XDG_RUNTIME_DIR");
+	if (proxy_dir == NULL || !proxy_dir[0]) {
+		bug("No a valid XDG_RUNTIME_DIR\n");
+	}
+	if ((listen_fd = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
+		bug("create socket\n");
+	}
+	if (setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
+		       &opt, sizeof(opt))) {
+		bug("setsockopt");
+	}
+	listen_addr.sun_family = AF_UNIX;
+	snprintf(listen_addr.sun_path, sizeof(listen_addr.sun_path), "%s/%s",
+		 proxy_dir, wname);
+	unlink(listen_addr.sun_path);
+	if (bind
+	    (listen_fd, (struct sockaddr *)&listen_addr,
+	     sizeof(listen_addr)) < 0) {
+		bug("bind failed");
+	}
+	if (listen(listen_fd, 3) < 0) {
+		bug("listen");
+	}
+	wayland_proxy(listen_fd);
+}
diff --git a/tools/forward/wayland-proxy.c b/tools/forward/wayland-proxy.c
new file mode 100644
index 000000000000..c82da887a8e9
--- /dev/null
+++ b/tools/forward/wayland-proxy.c
@@ -0,0 +1,297 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include "../../include/uapi/linux/virtwl.h"
+
+#define debug(...) do { \
+	fprintf(stderr, "%s:%d\n", __func__, __LINE__); \
+	fprintf(stderr, __VA_ARGS__); \
+} while (0)
+
+#define bug(...) do { \
+	fprintf(stderr, "%s:%d\n", __func__, __LINE__); \
+	fprintf(stderr, __VA_ARGS__); \
+	exit(1); \
+} while (0)
+
+enum {
+	FD_TYPE_CLOSED = 0,
+	FD_TYPE_UNIX,
+	FD_TYPE_DEV,
+};
+
+static int get_peer(char *type, int *peer, int fd, int fd_max)
+{
+	if (fd >= fd_max || fd < 0)
+		bug("too big fd %d %d\n", fd, fd_max);
+	int pfd = peer[fd];
+	if (pfd >= fd_max || pfd < 0)
+		bug("too big pfd %d %d\n", pfd, fd_max);
+	if (peer[pfd] != fd)
+		bug("not maching peer %d %d\n", fd, pfd);
+	if (type[fd] == type[pfd])
+		bug("Same type fd %d %d\n", fd, pfd);
+	if (type[fd] == FD_TYPE_CLOSED || type[pfd] == FD_TYPE_CLOSED)
+		bug("double close %d %d\n", fd, pfd);
+	return pfd;
+}
+
+#define MAX_MSG_DATA_LEN 4096
+
+void forward_for_vm(int cfd, int wl)
+{
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+	struct msghdr msg = { };
+	char cmsg_buf[CMSG_LEN(sizeof(int) * VIRTWL_SEND_MAX_ALLOCS)];
+	struct virtwl_ioctl_txn *txn = alloca(sizeof(*txn) + MAX_MSG_DATA_LEN);
+
+	iov.iov_base = txn->data;
+	iov.iov_len = MAX_MSG_DATA_LEN;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	ssize_t ret = recvmsg(cfd, &msg, 0);
+	if (ret <= 0)
+		return;
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg && CMSG_NXTHDR(&msg, cmsg))
+		bug("multiple cmsg");
+	if (cmsg && (cmsg->cmsg_level != SOL_SOCKET ||
+		     cmsg->cmsg_type != SCM_RIGHTS))
+		bug("level:%d type:%d\n", cmsg->cmsg_level, cmsg->cmsg_type);
+
+	int fd_count = 0;
+	if (cmsg) {
+		fd_count = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+		memcpy(txn->fds, CMSG_DATA(cmsg), fd_count * sizeof(int));
+	}
+	for (int i = fd_count; i < VIRTWL_SEND_MAX_ALLOCS; ++i) {
+		txn->fds[i] = -1;
+	}
+	txn->len = ret;
+	ret = ioctl(wl, VIRTWL_IOCTL_SEND, txn);
+	if (ret < 0) {
+		bug("send msg fail");
+	}
+	for (int i = 0; i < fd_count; ++i) {
+		close(txn->fds[i]);
+	}
+}
+
+void forward_for_wl(int wl, int cfd)
+{
+	int ret;
+
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+	struct msghdr msg = { };
+	char cmsg_buf[CMSG_LEN(sizeof(int) * VIRTWL_SEND_MAX_ALLOCS)];
+	struct virtwl_ioctl_txn *txn = alloca(sizeof(*txn) + MAX_MSG_DATA_LEN);
+
+	ret = ioctl(wl, VIRTWL_IOCTL_RECV, txn);
+	if (ret < 0)
+		return;
+	size_t fd_count = 0;
+	for (; fd_count < VIRTWL_SEND_MAX_ALLOCS; ++fd_count) {
+		if (txn->fds[fd_count] < 0) {
+			break;
+		}
+	}
+
+	iov.iov_len = txn->len;
+	iov.iov_base = txn->data;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	if (fd_count > 0) {
+		cmsg = (struct cmsghdr *)&cmsg_buf;
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(fd_count * sizeof(int));
+		memcpy(CMSG_DATA(cmsg), txn->fds, fd_count * sizeof(int));
+		msg.msg_control = cmsg_buf;
+		msg.msg_controllen = cmsg->cmsg_len;
+	}
+
+	ret = sendmsg(cfd, &msg, MSG_NOSIGNAL);
+
+	if (ret != txn->len) {
+		debug("sendmsg failed %d %d %d\n", txn->len, ret, errno);
+	}
+
+	for (int i = 0; i < fd_count; ++i) {
+		close(txn->fds[i]);
+	}
+}
+
+void do_forward(char *type, int *peer, int fd, int fd_max)
+{
+	int pfd = get_peer(type, peer, fd, fd_max);
+	switch (type[fd]) {
+	case FD_TYPE_UNIX:
+		forward_for_vm(fd, pfd);
+		break;
+	case FD_TYPE_DEV:
+		forward_for_wl(fd, pfd);
+		break;
+	default:
+		bug("unreached here");
+		break;
+	}
+}
+
+static int open_wl_dev(int fd)
+{
+	struct virtwl_ioctl_new wl = {.type = VIRTWL_IOCTL_NEW_CTX };
+	int ret = ioctl(fd, VIRTWL_IOCTL_NEW, &wl);
+	if (ret < 0) {
+		debug("Can't new ctx %d\n", errno);
+		return -errno;
+	}
+	return wl.fd;
+}
+
+static void insert_peer_table(char **type, int **peer, int cfd, int dev,
+			      int *fd_max)
+{
+	if (cfd >= (*fd_max) || dev >= (*fd_max)) {
+		(*fd_max) = (*fd_max) << 1;
+		debug("Increase fd table to %d\n", *fd_max);
+		*type = realloc(*type, sizeof(**type) * (*fd_max));
+		*peer = realloc(*peer, sizeof(**peer) * (*fd_max));
+		if (!*type || !*peer)
+			bug("can't malloc new memory for poll fds");
+	}
+	(*type)[cfd] = FD_TYPE_UNIX;
+	(*type)[dev] = FD_TYPE_DEV;
+	(*peer)[cfd] = dev;
+	(*peer)[dev] = cfd;
+}
+
+static void add_to_poll(struct pollfd **poll_fds, unsigned int *cnt,
+			unsigned int *cap, int fd)
+{
+	if (fd < 0)
+		bug("invalid fd %d\n", fd);
+	if (*cnt == *cap) {
+		*cap = (*cap) << 1;
+		debug("Increase poll cap to %d\n", *cap);
+		*poll_fds = realloc(*poll_fds, sizeof(**poll_fds) * (*cap));
+		if ((*poll_fds) == NULL)
+			bug("can't malloc new memory for poll fds");
+	}
+	struct pollfd *entry = (*poll_fds) + (*cnt);
+	(*cnt)++;
+	entry->fd = fd;
+	entry->events = POLLIN;
+	entry->revents = 0;
+}
+
+static void remove_from_poll(struct pollfd *poll_fds, unsigned int *cnt, int fd)
+{
+	unsigned int i;
+	if (fd < 0)
+		bug("invalid fd %d\n", fd);
+	for (i = 0; i < *cnt; ++i) {
+		if (poll_fds[i].fd != fd)
+			continue;
+		if (i == 0)
+			bug("important");
+		(*cnt)--;
+		if (i == (*cnt))
+			return;
+		poll_fds[i] = poll_fds[*cnt];
+		return;
+	}
+}
+
+static void close_all(char *type, int *peer, int fd, int fd_max)
+{
+	int pfd = get_peer(type, peer, fd, fd_max);
+	close(fd);
+	close(pfd);
+	type[fd] = type[pfd] = FD_TYPE_CLOSED;
+	peer[fd] = -1;
+	peer[pfd] = -1;
+}
+
+void wayland_proxy(int listen_fd)
+{
+	struct sockaddr_un listen_addr = { };
+	size_t addrlen = sizeof(listen_addr);
+	int wl;
+	int cfd;
+	unsigned int fd_cnt = 0;
+	unsigned int poll_cap = 8;
+	int fd_max = 1024;
+	int ret;
+	struct pollfd *poll_fds = calloc(poll_cap, sizeof(*poll_fds));
+	char *fd_type = calloc(fd_max, sizeof(*fd_type));
+	int *fd_peer = calloc(fd_max, sizeof(*fd_peer));
+	int wl_dev_fd = open("/dev/wl0", O_RDWR);
+	int i;
+
+	if (wl_dev_fd < 0)
+		bug("can't open wl device\n");
+
+	if (!poll_fds || !fd_type || !fd_peer)
+		bug("can't malloc poll fds");
+
+	add_to_poll(&poll_fds, &fd_cnt, &poll_cap, listen_fd);
+
+	for (;;) {
+		ret = poll(poll_fds, fd_cnt, -1);
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0) {
+			bug("poll %d\n", errno);
+		}
+		if (poll_fds[0].revents & POLLIN) {
+			cfd = accept(listen_fd, (struct sockaddr *)&listen_addr,
+				     (socklen_t *) & addrlen);
+			if (cfd < 0) {
+				bug("accept");
+			}
+			if ((wl = open_wl_dev(wl_dev_fd)) < 0) {
+				bug("connect to wl dev\n");
+			}
+			add_to_poll(&poll_fds, &fd_cnt, &poll_cap, cfd);
+			add_to_poll(&poll_fds, &fd_cnt, &poll_cap, wl);
+			insert_peer_table(&fd_type, &fd_peer, cfd, wl, &fd_max);
+		}
+		for (i = 1; i < fd_cnt; ++i) {
+			struct pollfd *pfd = poll_fds + i;
+			if (!(pfd->revents & POLLHUP))
+				continue;
+			close_all(fd_type, fd_peer, pfd->fd, fd_max);
+		}
+		i = 1;
+		while (i < fd_cnt) {
+			struct pollfd *pfd = poll_fds + i;
+			int fd = pfd->fd;
+			if (fd_type[fd] != FD_TYPE_CLOSED) {
+				i++;
+				continue;
+			}
+			remove_from_poll(poll_fds, &fd_cnt, fd);
+		}
+		for (i = 1; i < fd_cnt; ++i) {
+			struct pollfd *pfd = poll_fds + i;
+			if (!pfd->revents & POLLIN)
+				continue;
+			do_forward(fd_type, fd_peer, pfd->fd, fd_max);
+		}
+	}
+}
-- 
2.21.0.392.gf8f6787159e-goog
