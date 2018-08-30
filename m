Received: from eggs.gnu.org ([2001:4830:134:3::10]:40178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvLyI-0003s4-9U
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvLkP-0006FX-Rv
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:08:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fvLkP-0006FD-OT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:08:25 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 30 Aug 2018 14:08:23 +0200
Message-Id: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] qga: ignore non present cpus when handling
 qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mdroth@linux.vnet.ibm.com

If VM has VCPUs plugged sparselly (for example a VM started with
3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
only cpu0 and cpu2 are present), QGA will rise a error
  error: internal error: unable to execute QEMU agent command 'guest-get-vcpus':
  open("/sys/devices/system/cpu/cpu1/"): No such file or directory
when
  virsh vcpucount FOO --guest
is executed.
Fix it by ignoring non present CPUs when fetching CPUs status from sysfs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qga/commands-posix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 37e8a2d..2929872 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2044,7 +2044,9 @@ static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
                               vcpu->logical_id);
     dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
     if (dirfd == -1) {
-        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        if (!(sys2vcpu && errno == ENOENT)) {
+            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        }
     } else {
         static const char fn[] = "online";
         int fd;
-- 
2.7.4
