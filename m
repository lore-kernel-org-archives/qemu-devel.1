Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66761C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CA722282
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 02:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrffw7j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CA722282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXazK-0004cm-KT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 22:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXayG-0003me-Cb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 22:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXayC-0001YP-4s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 22:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603851226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YDcNA62nWdW89VOM29XwVuknxsxXCQcBQqV5y9oBawo=;
 b=hrffw7j5HQI8YageUh+qC22xsiY4/OvLS0Zoz0IJBpDBEXDopw0p2lBVXjJm0IcO5Ri0iY
 e75blWkmIAvH2j4lp0D9uyiWtUzdf/tdi+tEbGfBNnU6/dDS2o5dRo3xxMuzc7sNlmCUNd
 PdKbWkg1kk+hjNQ57UxLTDUZ3QU/lHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-9GDhhC0nMYeKj2jcMprT8w-1; Tue, 27 Oct 2020 22:13:39 -0400
X-MC-Unique: 9GDhhC0nMYeKj2jcMprT8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EF3809DE0;
 Wed, 28 Oct 2020 02:13:38 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80B116EF62;
 Wed, 28 Oct 2020 02:13:28 +0000 (UTC)
Subject: [PATCH] Revert series: virtiofsd: Announce submounts to the guest
From: Alex Williamson <alex.williamson@redhat.com>
To: peter.maydell@linaro.org
Date: Tue, 27 Oct 2020 20:13:28 -0600
Message-ID: <160385090886.20017.13382256442750027666.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 22:13:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cjia@nvidia.com, mjrosato@linux.ibm.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kwankhede@nvidia.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts the following commits due to their basis on a bogus
linux kernel header update:

c93a656f7b65 ("tests/acceptance: Add virtiofs_submounts.py")
45ced7ca2f27 ("tests/acceptance/boot_linux: Accept SSH pubkey")
08dce386e77e ("virtiofsd: Announce sub-mount points")
eba8b096c17c ("virtiofsd: Store every lo_inode's parent_dev")
ede24b6be798 ("virtiofsd: Add fuse_reply_attr_with_flags()")
e2577435d343 ("virtiofsd: Add attr_flags to fuse_entry_param")
2f10415abfc5 ("virtiofsd: Announce FUSE_ATTR_FLAGS")
97d741cc96dd ("linux/fuse.h: Pull in from Linux")

Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

The following pull request, based on legitimate v5.10-rc1 kernel
headers, applies cleanly after this revert:

https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg07849.html


 include/standard-headers/linux/fuse.h              |   11 -
 tests/acceptance/boot_linux.py                     |   13 -
 tests/acceptance/virtiofs_submounts.py             |  289 --------------------
 .../virtiofs_submounts.py.data/cleanup.sh          |   46 ---
 .../virtiofs_submounts.py.data/guest-cleanup.sh    |   30 --
 .../acceptance/virtiofs_submounts.py.data/guest.sh |  138 ----------
 .../acceptance/virtiofs_submounts.py.data/host.sh  |  127 ---------
 tools/virtiofsd/fuse_common.h                      |    8 -
 tools/virtiofsd/fuse_lowlevel.c                    |   34 --
 tools/virtiofsd/fuse_lowlevel.h                    |   20 -
 tools/virtiofsd/helper.c                           |    1 
 tools/virtiofsd/passthrough_ll.c                   |   84 +-----
 12 files changed, 21 insertions(+), 780 deletions(-)
 delete mode 100644 tests/acceptance/virtiofs_submounts.py
 delete mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
 delete mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
 delete mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
 delete mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh

diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index 7dd7a3b992c8..f4df0a40f604 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -227,7 +227,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	flags;
+	uint32_t	padding;
 };
 
 struct fuse_kstatfs {
@@ -310,7 +310,6 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
- * FUSE_ATTR_FLAGS: fuse_attr.flags is present and valid
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -339,7 +338,6 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
-#define FUSE_ATTR_FLAGS		(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -415,13 +413,6 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
-/**
- * fuse_attr flags
- *
- * FUSE_ATTR_SUBMOUNT: File/directory is a submount point
- */
-#define FUSE_ATTR_SUBMOUNT      (1 << 0)
-
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index ad997c3f2eed..0055dc7cee77 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -57,7 +57,7 @@ class BootLinuxBase(Test):
             self.cancel('Failed to download/prepare boot image')
         return boot.path
 
-    def download_cloudinit(self, ssh_pubkey=None):
+    def download_cloudinit(self):
         self.log.info('Preparing cloudinit image')
         try:
             cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
@@ -67,8 +67,7 @@ class BootLinuxBase(Test):
                           password='password',
                           # QEMU's hard coded usermode router address
                           phone_home_host='10.0.2.2',
-                          phone_home_port=self.phone_home_port,
-                          authorized_key=ssh_pubkey)
+                          phone_home_port=self.phone_home_port)
         except Exception:
             self.cancel('Failed to prepared cloudinit image')
         return cloudinit_iso
@@ -81,19 +80,19 @@ class BootLinux(BootLinuxBase):
     timeout = 900
     chksum = None
 
-    def setUp(self, ssh_pubkey=None):
+    def setUp(self):
         super(BootLinux, self).setUp()
         self.vm.add_args('-smp', '2')
         self.vm.add_args('-m', '1024')
         self.prepare_boot()
-        self.prepare_cloudinit(ssh_pubkey)
+        self.prepare_cloudinit()
 
     def prepare_boot(self):
         path = self.download_boot()
         self.vm.add_args('-drive', 'file=%s' % path)
 
-    def prepare_cloudinit(self, ssh_pubkey=None):
-        cloudinit_iso = self.download_cloudinit(ssh_pubkey)
+    def prepare_cloudinit(self):
+        cloudinit_iso = self.download_cloudinit()
         self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
 
     def launch_and_wait(self):
diff --git a/tests/acceptance/virtiofs_submounts.py b/tests/acceptance/virtiofs_submounts.py
deleted file mode 100644
index 8b207b3e577f..000000000000
--- a/tests/acceptance/virtiofs_submounts.py
+++ /dev/null
@@ -1,289 +0,0 @@
-import logging
-import re
-import os
-import subprocess
-import time
-
-from avocado import skipUnless
-from avocado_qemu import Test, BUILD_DIR
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import ssh
-
-from qemu.accel import kvm_available
-
-from boot_linux import BootLinux
-
-
-def run_cmd(args):
-    subp = subprocess.Popen(args,
-                            stdout=subprocess.PIPE,
-                            stderr=subprocess.PIPE,
-                            universal_newlines=True)
-    stdout, stderr = subp.communicate()
-    ret = subp.returncode
-
-    return (stdout, stderr, ret)
-
-def has_passwordless_sudo():
-    """
-    This function is for use in a @avocado.skipUnless decorator, e.g.:
-
-        @skipUnless(*has_passwordless_sudo())
-        def test_something_that_needs_sudo(self):
-            ...
-    """
-
-    _, stderr, exitcode = run_cmd(('sudo', '-n', 'true'))
-    if exitcode != 0:
-        return (False, f'Failed to use sudo -n: {stderr.strip()}')
-    else:
-        return (True, '')
-
-
-class VirtiofsSubmountsTest(BootLinux):
-    """
-    :avocado: tags=arch:x86_64
-    """
-
-    def get_portfwd(self):
-        port = None
-
-        res = self.vm.command('human-monitor-command',
-                              command_line='info usernet')
-        for line in res.split('\r\n'):
-            match = \
-                re.search(r'TCP.HOST_FORWARD.*127\.0\.0\.1\s*(\d+)\s+10\.',
-                          line)
-            if match is not None:
-                port = match[1]
-                break
-
-        self.assertIsNotNone(port)
-        self.log.debug('sshd listening on port: ' + port)
-        return port
-
-    def ssh_connect(self, username, keyfile):
-        self.ssh_logger = logging.getLogger('ssh')
-        port = self.get_portfwd()
-        self.ssh_session = ssh.Session('127.0.0.1', port=int(port),
-                                       user=username, key=keyfile)
-        for i in range(10):
-            try:
-                self.ssh_session.connect()
-                return
-            except:
-                time.sleep(4)
-                pass
-        self.fail('sshd timeout')
-
-    def ssh_command(self, command):
-        self.ssh_logger.info(command)
-        result = self.ssh_session.cmd(command)
-        stdout_lines = [line.rstrip() for line
-                        in result.stdout_text.splitlines()]
-        for line in stdout_lines:
-            self.ssh_logger.info(line)
-        stderr_lines = [line.rstrip() for line
-                        in result.stderr_text.splitlines()]
-        for line in stderr_lines:
-            self.ssh_logger.warning(line)
-
-        self.assertEqual(result.exit_status, 0,
-                         f'Guest command failed: {command}')
-        return stdout_lines, stderr_lines
-
-    def run(self, args, ignore_error=False):
-        stdout, stderr, ret = run_cmd(args)
-
-        if ret != 0:
-            cmdline = ' '.join(args)
-            if not ignore_error:
-                self.fail(f'{cmdline}: Returned {ret}: {stderr}')
-            else:
-                self.log.warn(f'{cmdline}: Returned {ret}: {stderr}')
-
-        return (stdout, stderr, ret)
-
-    def set_up_shared_dir(self):
-        atwd = os.getenv('AVOCADO_TEST_WORKDIR')
-        self.shared_dir = os.path.join(atwd, 'virtiofs-shared')
-
-        os.mkdir(self.shared_dir)
-
-        self.run(('cp', self.get_data('guest.sh'),
-                 os.path.join(self.shared_dir, 'check.sh')))
-
-        self.run(('cp', self.get_data('guest-cleanup.sh'),
-                 os.path.join(self.shared_dir, 'cleanup.sh')))
-
-    def set_up_virtiofs(self):
-        attmp = os.getenv('AVOCADO_TESTS_COMMON_TMPDIR')
-        self.vfsdsock = os.path.join(attmp, 'vfsdsock')
-
-        self.run(('sudo', '-n', 'rm', '-f', self.vfsdsock), ignore_error=True)
-
-        self.virtiofsd = \
-            subprocess.Popen(('sudo', '-n',
-                              'tools/virtiofsd/virtiofsd',
-                              f'--socket-path={self.vfsdsock}',
-                              '-o', f'source={self.shared_dir}',
-                              '-o', 'cache=always',
-                              '-o', 'xattr',
-                              '-o', 'announce_submounts',
-                              '-f'),
-                             stdout=subprocess.DEVNULL,
-                             stderr=subprocess.PIPE,
-                             universal_newlines=True)
-
-        while not os.path.exists(self.vfsdsock):
-            if self.virtiofsd.poll() is not None:
-                self.fail('virtiofsd exited prematurely: ' +
-                          self.virtiofsd.communicate()[1])
-            time.sleep(0.1)
-
-        self.run(('sudo', '-n', 'chmod', 'go+rw', self.vfsdsock))
-
-        self.vm.add_args('-chardev',
-                         f'socket,id=vfsdsock,path={self.vfsdsock}',
-                         '-device',
-                         'vhost-user-fs-pci,queue-size=1024,chardev=vfsdsock' \
-                             ',tag=host',
-                         '-object',
-                         'memory-backend-file,id=mem,size=1G,' \
-                             'mem-path=/dev/shm,share=on',
-                         '-numa',
-                         'node,memdev=mem')
-
-    def launch_vm(self):
-        self.launch_and_wait()
-        self.ssh_connect('root', self.ssh_key)
-
-    def set_up_nested_mounts(self):
-        scratch_dir = os.path.join(self.shared_dir, 'scratch')
-        try:
-            os.mkdir(scratch_dir)
-        except FileExistsError:
-            pass
-
-        args = ['bash', self.get_data('host.sh'), scratch_dir]
-        if self.seed:
-            args += [self.seed]
-
-        out, _, _ = self.run(args)
-        seed = re.search(r'^Seed: \d+', out)
-        self.log.info(seed[0])
-
-    def mount_in_guest(self):
-        self.ssh_command('mkdir -p /mnt/host')
-        self.ssh_command('mount -t virtiofs host /mnt/host')
-
-    def check_in_guest(self):
-        self.ssh_command('bash /mnt/host/check.sh /mnt/host/scratch/share')
-
-    def live_cleanup(self):
-        self.ssh_command('bash /mnt/host/cleanup.sh /mnt/host/scratch')
-
-        # It would be nice if the above was sufficient to make virtiofsd clear
-        # all references to the mounted directories (so they can be unmounted
-        # on the host), but unfortunately it is not.  To do so, we have to
-        # resort to a remount.
-        self.ssh_command('mount -o remount /mnt/host')
-
-        scratch_dir = os.path.join(self.shared_dir, 'scratch')
-        self.run(('bash', self.get_data('cleanup.sh'), scratch_dir))
-
-    @skipUnless(*has_passwordless_sudo())
-    def setUp(self):
-        vmlinuz = self.params.get('vmlinuz')
-        if vmlinuz is None:
-            self.cancel('vmlinuz parameter not set; you must point it to a '
-                        'Linux kernel binary to test (to run this test with ' \
-                        'the on-image kernel, set it to an empty string)')
-
-        self.seed = self.params.get('seed')
-
-        atwd = os.getenv('AVOCADO_TEST_WORKDIR')
-        self.ssh_key = os.path.join(atwd, 'id_ed25519')
-
-        self.run(('ssh-keygen', '-t', 'ed25519', '-f', self.ssh_key))
-
-        pubkey = open(self.ssh_key + '.pub').read()
-
-        super(VirtiofsSubmountsTest, self).setUp(pubkey)
-
-        if len(vmlinuz) > 0:
-            self.vm.add_args('-kernel', vmlinuz,
-                             '-append', 'console=ttyS0 root=/dev/sda1')
-
-        # Allow us to connect to SSH
-        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                         '-device', 'e1000,netdev=vnet')
-
-        if not kvm_available(self.arch, self.qemu_bin):
-            self.cancel(KVM_NOT_AVAILABLE)
-        self.vm.add_args('-accel', 'kvm')
-
-    def tearDown(self):
-        try:
-            self.vm.shutdown()
-        except:
-            pass
-
-        scratch_dir = os.path.join(self.shared_dir, 'scratch')
-        self.run(('bash', self.get_data('cleanup.sh'), scratch_dir),
-                 ignore_error=True)
-
-    def test_pre_virtiofsd_set_up(self):
-        self.set_up_shared_dir()
-
-        self.set_up_nested_mounts()
-
-        self.set_up_virtiofs()
-        self.launch_vm()
-        self.mount_in_guest()
-        self.check_in_guest()
-
-    def test_pre_launch_set_up(self):
-        self.set_up_shared_dir()
-        self.set_up_virtiofs()
-
-        self.set_up_nested_mounts()
-
-        self.launch_vm()
-        self.mount_in_guest()
-        self.check_in_guest()
-
-    def test_post_launch_set_up(self):
-        self.set_up_shared_dir()
-        self.set_up_virtiofs()
-        self.launch_vm()
-
-        self.set_up_nested_mounts()
-
-        self.mount_in_guest()
-        self.check_in_guest()
-
-    def test_post_mount_set_up(self):
-        self.set_up_shared_dir()
-        self.set_up_virtiofs()
-        self.launch_vm()
-        self.mount_in_guest()
-
-        self.set_up_nested_mounts()
-
-        self.check_in_guest()
-
-    def test_two_runs(self):
-        self.set_up_shared_dir()
-
-        self.set_up_nested_mounts()
-
-        self.set_up_virtiofs()
-        self.launch_vm()
-        self.mount_in_guest()
-        self.check_in_guest()
-
-        self.live_cleanup()
-        self.set_up_nested_mounts()
-
-        self.check_in_guest()
diff --git a/tests/acceptance/virtiofs_submounts.py.data/cleanup.sh b/tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
deleted file mode 100644
index 2a6579a0fea6..000000000000
--- a/tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir>"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'Scratch dir not given' >&2
-    exit 1
-fi
-
-cd "$scratch_dir/share" || exit 1
-mps=(mnt*)
-mp_i=0
-for mp in "${mps[@]}"; do
-    mp_i=$((mp_i + 1))
-    printf "Unmounting %i/%i...\r" "$mp_i" "${#mps[@]}"
-
-    sudo umount -R "$mp"
-    rm -rf "$mp"
-done
-echo
-
-rm some-file
-cd ..
-rmdir share
-
-imgs=(fs*.img)
-img_i=0
-for img in "${imgs[@]}"; do
-    img_i=$((img_i + 1))
-    printf "Detaching and deleting %i/%i...\r" "$img_i" "${#imgs[@]}"
-
-    dev=$(losetup -j "$img" | sed -e 's/:.*//')
-    sudo losetup -d "$dev"
-    rm -f "$img"
-done
-echo
-
-echo 'Done.'
diff --git a/tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh b/tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
deleted file mode 100644
index 729cb2d1a5ec..000000000000
--- a/tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir>"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'Scratch dir not given' >&2
-    exit 1
-fi
-
-cd "$scratch_dir/share" || exit 1
-
-mps=(mnt*)
-mp_i=0
-for mp in "${mps[@]}"; do
-    mp_i=$((mp_i + 1))
-    printf "Unmounting %i/%i...\r" "$mp_i" "${#mps[@]}"
-
-    sudo umount -R "$mp"
-done
-echo
-
-echo 'Done.'
diff --git a/tests/acceptance/virtiofs_submounts.py.data/guest.sh b/tests/acceptance/virtiofs_submounts.py.data/guest.sh
deleted file mode 100644
index 59ba40fde179..000000000000
--- a/tests/acceptance/virtiofs_submounts.py.data/guest.sh
+++ /dev/null
@@ -1,138 +0,0 @@
-#!/bin/bash
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <shared dir>"
-    echo '(The shared directory is the "share" directory in the scratch' \
-         'directory)'
-}
-
-shared_dir=$1
-if [ -z "$shared_dir" ]; then
-    print_usage "$0" 'Shared dir not given' >&2
-    exit 1
-fi
-
-cd "$shared_dir"
-
-# FIXME: This should not be necessary, but it is.  In order for all
-# submounts to be proper mount points, we need to visit them.
-# (Before we visit them, they will not be auto-mounted, and so just
-# appear as normal directories, with the catch that their st_ino will
-# be the st_ino of the filesystem they host, while the st_dev will
-# still be the st_dev of the parent.)
-# `find` does not work, because it will refuse to touch the mount
-# points as long as they are not mounted; their st_dev being shared
-# with the parent and st_ino just being the root node's inode ID
-# will practically ensure that this node exists elsewhere on the
-# filesystem, and `find` is required to recognize loops and not to
-# follow them.
-# Thus, we have to manually visit all nodes first.
-
-mnt_i=0
-
-function recursively_visit()
-{
-    pushd "$1" >/dev/null
-    for entry in *; do
-        if [[ "$entry" == mnt* ]]; then
-            mnt_i=$((mnt_i + 1))
-            printf "Triggering auto-mount $mnt_i...\r"
-        fi
-
-        if [ -d "$entry" ]; then
-            recursively_visit "$entry"
-        fi
-    done
-    popd >/dev/null
-}
-
-recursively_visit .
-echo
-
-
-if [ -n "$(find -name not-mounted)" ]; then
-    echo "Error: not-mounted files visible on mount points:" >&2
-    find -name not-mounted >&2
-    exit 1
-fi
-
-if [ ! -f some-file -o "$(cat some-file)" != 'root' ]; then
-    echo "Error: Bad file in the share root" >&2
-    exit 1
-fi
-
-shopt -s nullglob
-
-function check_submounts()
-{
-    local base_path=$1
-
-    for mp in mnt*; do
-        printf "Checking submount %i...\r" "$((${#devs[@]} + 1))"
-
-        mp_i=$(echo "$mp" | sed -e 's/mnt//')
-        dev=$(stat -c '%D' "$mp")
-
-        if [ -n "${devs[mp_i]}" ]; then
-            echo "Error: $mp encountered twice" >&2
-            exit 1
-        fi
-        devs[mp_i]=$dev
-
-        pushd "$mp" >/dev/null
-        path="$base_path$mp"
-        while true; do
-            expected_content="$(printf '%s\n%s\n' "$mp_i" "$path")"
-            if [ ! -f some-file ]; then
-                echo "Error: $PWD/some-file does not exist" >&2
-                exit 1
-            fi
-
-            if [ "$(cat some-file)" != "$expected_content" ]; then
-                echo "Error: Bad content in $PWD/some-file:" >&2
-                echo '--- found ---'
-                cat some-file
-                echo '--- expected ---'
-                echo "$expected_content"
-                exit 1
-            fi
-            if [ "$(stat -c '%D' some-file)" != "$dev" ]; then
-                echo "Error: $PWD/some-file has the wrong device ID" >&2
-                exit 1
-            fi
-
-            if [ -d sub ]; then
-                if [ "$(stat -c '%D' sub)" != "$dev" ]; then
-                    echo "Error: $PWD/some-file has the wrong device ID" >&2
-                    exit 1
-                fi
-                cd sub
-                path="$path/sub"
-            else
-                if [ -n "$(echo mnt*)" ]; then
-                    check_submounts "$path/"
-                fi
-                break
-            fi
-        done
-        popd >/dev/null
-    done
-}
-
-root_dev=$(stat -c '%D' some-file)
-devs=()
-check_submounts ''
-echo
-
-reused_devs=$(echo "$root_dev ${devs[@]}" | tr ' ' '\n' | sort | uniq -d)
-if [ -n "$reused_devs" ]; then
-    echo "Error: Reused device IDs: $reused_devs" >&2
-    exit 1
-fi
-
-echo "Test passed for ${#devs[@]} submounts."
diff --git a/tests/acceptance/virtiofs_submounts.py.data/host.sh b/tests/acceptance/virtiofs_submounts.py.data/host.sh
deleted file mode 100644
index d8a9afebdb54..000000000000
--- a/tests/acceptance/virtiofs_submounts.py.data/host.sh
+++ /dev/null
@@ -1,127 +0,0 @@
-#!/bin/bash
-
-mount_count=128
-
-function print_usage()
-{
-    if [ -n "$2" ]; then
-        echo "Error: $2"
-        echo
-    fi
-    echo "Usage: $1 <scratch dir> [seed]"
-    echo "(If no seed is given, it will be randomly generated.)"
-}
-
-scratch_dir=$1
-if [ -z "$scratch_dir" ]; then
-    print_usage "$0" 'No scratch dir given' >&2
-    exit 1
-fi
-
-if [ ! -d "$scratch_dir" ]; then
-    print_usage "$0" "$scratch_dir is not a directory" >&2
-    exit 1
-fi
-
-seed=$2
-if [ -z "$seed" ]; then
-    seed=$RANDOM
-fi
-RANDOM=$seed
-
-echo "Seed: $seed"
-
-set -e
-shopt -s nullglob
-
-cd "$scratch_dir"
-if [ -d share ]; then
-    echo 'Error: This directory seems to be in use already' >&2
-    exit 1
-fi
-
-for ((i = 0; i < $mount_count; i++)); do
-    printf "Setting up fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    rm -f fs$i.img
-    truncate -s 512M fs$i.img
-    mkfs.xfs -q fs$i.img
-    devs[i]=$(sudo losetup -f --show fs$i.img)
-done
-echo
-
-top_level_mounts=$((RANDOM % mount_count + 1))
-
-mkdir -p share
-echo 'root' > share/some-file
-
-for ((i = 0; i < $top_level_mounts; i++)); do
-    printf "Mounting fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    mkdir -p share/mnt$i
-    touch share/mnt$i/not-mounted
-    sudo mount "${devs[i]}" share/mnt$i
-    sudo chown "$(id -u):$(id -g)" share/mnt$i
-
-    pushd share/mnt$i >/dev/null
-    path=mnt$i
-    nesting=$((RANDOM % 4))
-    for ((j = 0; j < $nesting; j++)); do
-        cat > some-file <<EOF
-$i
-$path
-EOF
-        mkdir sub
-        cd sub
-        path="$path/sub"
-    done
-cat > some-file <<EOF
-$i
-$path
-EOF
-    popd >/dev/null
-done
-
-for ((; i < $mount_count; i++)); do
-    printf "Mounting fs %i/%i...\r" "$((i + 1))" "$mount_count"
-
-    mp_i=$((i % top_level_mounts))
-
-    pushd share/mnt$mp_i >/dev/null
-    path=mnt$mp_i
-    while true; do
-        sub_mp="$(echo mnt*)"
-        if cd sub 2>/dev/null; then
-            path="$path/sub"
-        elif [ -n "$sub_mp" ] && cd "$sub_mp" 2>/dev/null; then
-            path="$path/$sub_mp"
-        else
-            break
-        fi
-    done
-    mkdir mnt$i
-    touch mnt$i/not-mounted
-    sudo mount "${devs[i]}" mnt$i
-    sudo chown "$(id -u):$(id -g)" mnt$i
-
-    cd mnt$i
-    path="$path/mnt$i"
-    nesting=$((RANDOM % 4))
-    for ((j = 0; j < $nesting; j++)); do
-        cat > some-file <<EOF
-$i
-$path
-EOF
-        mkdir sub
-        cd sub
-        path="$path/sub"
-    done
-    cat > some-file <<EOF
-$i
-$path
-EOF
-    popd >/dev/null
-done
-echo
-
-echo 'Done.'
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 870544fe132f..686c42c0a528 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -352,14 +352,6 @@ struct fuse_file_info {
  */
 #define FUSE_CAP_NO_OPENDIR_SUPPORT (1 << 24)
 
-/**
- * Indicates that the client will provide fuse_attr.flags, and the kernel will
- * interpret it.
- *
- * This feature is enabled by default when supported by the kernel.
- */
-#define FUSE_CAP_ATTR_FLAGS (1 << 27)
-
 /**
  * Ioctl flags
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 5198f627bcb3..4d1ba2925d1b 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -329,8 +329,7 @@ static unsigned int calc_timeout_nsec(double t)
     }
 }
 
-static void fill_entry(struct fuse_session *se,
-                       struct fuse_entry_out *arg,
+static void fill_entry(struct fuse_entry_out *arg,
                        const struct fuse_entry_param *e)
 {
     *arg = (struct fuse_entry_out){
@@ -342,10 +341,6 @@ static void fill_entry(struct fuse_session *se,
         .attr_valid_nsec = calc_timeout_nsec(e->attr_timeout),
     };
     convert_stat(&e->attr, &arg->attr);
-
-    if (se->conn.capable & FUSE_CAP_ATTR_FLAGS) {
-        arg->attr.flags = e->attr_flags;
-    }
 }
 
 /*
@@ -370,7 +365,7 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 
     struct fuse_direntplus *dp = (struct fuse_direntplus *)buf;
     memset(&dp->entry_out, 0, sizeof(dp->entry_out));
-    fill_entry(req->se, &dp->entry_out, e);
+    fill_entry(&dp->entry_out, e);
 
     struct fuse_dirent *dirent = &dp->dirent;
     *dirent = (struct fuse_dirent){
@@ -408,7 +403,7 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
     size_t size = sizeof(arg);
 
     memset(&arg, 0, sizeof(arg));
-    fill_entry(req->se, &arg, e);
+    fill_entry(&arg, e);
     return send_reply_ok(req, &arg, size);
 }
 
@@ -421,13 +416,13 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
     struct fuse_open_out *oarg = (struct fuse_open_out *)(buf + entrysize);
 
     memset(buf, 0, sizeof(buf));
-    fill_entry(req->se, earg, e);
+    fill_entry(earg, e);
     fill_open(oarg, f);
     return send_reply_ok(req, buf, entrysize + sizeof(struct fuse_open_out));
 }
 
-int fuse_reply_attr_with_flags(fuse_req_t req, const struct stat *attr,
-                               double attr_timeout, uint32_t attr_flags)
+int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
+                    double attr_timeout)
 {
     struct fuse_attr_out arg;
     size_t size = sizeof(arg);
@@ -437,19 +432,9 @@ int fuse_reply_attr_with_flags(fuse_req_t req, const struct stat *attr,
     arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
     convert_stat(attr, &arg.attr);
 
-    if (req->se->conn.capable & FUSE_CAP_ATTR_FLAGS) {
-        arg.attr.flags = attr_flags;
-    }
-
     return send_reply_ok(req, &arg, size);
 }
 
-int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-                    double attr_timeout)
-{
-    return fuse_reply_attr_with_flags(req, attr, attr_timeout, 0);
-}
-
 int fuse_reply_readlink(fuse_req_t req, const char *linkname)
 {
     return send_reply_ok(req, linkname, strlen(linkname));
@@ -2003,9 +1988,6 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
             bufsize = max_bufsize;
         }
     }
-    if (arg->flags & FUSE_ATTR_FLAGS) {
-        se->conn.capable |= FUSE_CAP_ATTR_FLAGS;
-    }
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
     se->conn.capable |= FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
@@ -2032,7 +2014,6 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_DIO);
     LL_SET_DEFAULT(1, FUSE_CAP_IOCTL_DIR);
     LL_SET_DEFAULT(1, FUSE_CAP_ATOMIC_O_TRUNC);
-    LL_SET_DEFAULT(1, FUSE_CAP_ATTR_FLAGS);
     LL_SET_DEFAULT(se->op.write_buf, FUSE_CAP_SPLICE_READ);
     LL_SET_DEFAULT(se->op.getlk && se->op.setlk, FUSE_CAP_POSIX_LOCKS);
     LL_SET_DEFAULT(se->op.flock, FUSE_CAP_FLOCK_LOCKS);
@@ -2122,9 +2103,6 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid,
     if (se->conn.want & FUSE_CAP_POSIX_ACL) {
         outarg.flags |= FUSE_POSIX_ACL;
     }
-    if (se->conn.want & FUSE_CAP_ATTR_FLAGS) {
-        outarg.flags |= FUSE_ATTR_FLAGS;
-    }
     outarg.max_readahead = se->conn.max_readahead;
     outarg.max_write = se->conn.max_write;
     if (se->conn.max_background >= (1 << 16)) {
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 1ff6ba1e4f1e..562fd5241ed4 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -102,11 +102,6 @@ struct fuse_entry_param {
      *  large value.
      */
     double entry_timeout;
-
-    /**
-     * Flags for fuse_attr.flags that do not fit into attr.
-     */
-    uint32_t attr_flags;
 };
 
 /**
@@ -1313,21 +1308,6 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
                     double attr_timeout);
 
-/**
- * Reply with attributes and set fuse_attr.flags
- *
- * Possible requests:
- *   getattr, setattr
- *
- * @param req request handle
- * @param attr the attributes
- * @param attr_timeout validity timeout (in seconds) for the attributes
- * @param attr_flags flags to put into fuse_attr.flags
- * @return zero for success, -errno for failure to send reply
- */
-int fuse_reply_attr_with_flags(fuse_req_t req, const struct stat *attr,
-                               double attr_timeout, uint32_t attr_flags);
-
 /**
  * Reply with the contents of a symbolic link
  *
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index a212f329317b..2e181a49b5ff 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -178,7 +178,6 @@ void fuse_cmdline_help(void)
            "                               default: depends on cache= option.\n"
            "    -o writeback|no_writeback  enable/disable writeback cache\n"
            "                               default: no_writeback\n"
-           "    -o announce_submounts      Announce sub-mount points to the guest\n"
            "    -o xattr|no_xattr          enable/disable xattr\n"
            "                               default: no_xattr\n"
            "    -o modcaps=CAPLIST         Modify the list of capabilities\n"
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 4db50046d49f..a0beb986f36a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -40,7 +40,6 @@
 #include "fuse_virtio.h"
 #include "fuse_log.h"
 #include "fuse_lowlevel.h"
-#include "standard-headers/linux/fuse.h"
 #include <assert.h>
 #include <cap-ng.h>
 #include <dirent.h>
@@ -126,14 +125,6 @@ struct lo_inode {
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
 
     mode_t filetype;
-
-    /*
-     * So we can detect crossmount roots
-     * (As such, this only needs to be valid for directories.  Note
-     * that files can have multiple parents due to hard links, and so
-     * their parent_dev may fluctuate.)
-     */
-    dev_t parent_dev;
 };
 
 struct lo_cred {
@@ -174,7 +165,6 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
-    int announce_submounts;
     int allow_direct_io;
     struct lo_inode root;
     GHashTable *inodes; /* protected by lo->mutex */
@@ -213,7 +203,6 @@ static const struct fuse_opt lo_opts[] = {
     { "cache=always", offsetof(struct lo_data, cache), CACHE_ALWAYS },
     { "readdirplus", offsetof(struct lo_data, readdirplus_set), 1 },
     { "no_readdirplus", offsetof(struct lo_data, readdirplus_clear), 1 },
-    { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
     { "allow_direct_io", offsetof(struct lo_data, allow_direct_io), 1 },
     { "no_allow_direct_io", offsetof(struct lo_data, allow_direct_io), 0 },
     FUSE_OPT_END
@@ -611,52 +600,22 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
     }
 }
 
-/**
- * Call fstatat() and set st_rdev whenever a directory's st_dev
- * differs from the rparent's st_dev (@parent_dev).  This will
- * announce submounts to the FUSE client (unless @announce_submounts
- * is false).
- */
-static int do_fstatat(int dirfd, const char *pathname, struct stat *statbuf,
-                      int flags, dev_t parent_dev, uint32_t *fuse_attr_flags)
-{
-    int res = fstatat(dirfd, pathname, statbuf, flags);
-    if (res == -1) {
-        return res;
-    }
-
-    if (statbuf->st_dev != parent_dev && S_ISDIR(statbuf->st_mode) &&
-        fuse_attr_flags)
-    {
-        *fuse_attr_flags |= FUSE_ATTR_SUBMOUNT;
-    }
-
-    return 0;
-}
-
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
                        struct fuse_file_info *fi)
 {
     int res;
     struct stat buf;
     struct lo_data *lo = lo_data(req);
-    struct lo_inode *inode = lo_inode(req, ino);
-    uint32_t fuse_attr_flags = 0;
 
     (void)fi;
 
-    res = do_fstatat(inode->fd, "", &buf, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
-                     inode->parent_dev, &fuse_attr_flags);
-    lo_inode_put(lo, &inode);
+    res =
+        fstatat(lo_fd(req, ino), "", &buf, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
     if (res == -1) {
         return (void)fuse_reply_err(req, errno);
     }
 
-    if (!lo->announce_submounts) {
-        fuse_attr_flags &= ~FUSE_ATTR_SUBMOUNT;
-    }
-
-    fuse_reply_attr_with_flags(req, &buf, lo->timeout, fuse_attr_flags);
+    fuse_reply_attr(req, &buf, lo->timeout);
 }
 
 static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
@@ -852,16 +811,11 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         goto out_err;
     }
 
-    res = do_fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
-                     dir->key.dev, &e->attr_flags);
+    res = fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
     if (res == -1) {
         goto out_err;
     }
 
-    if (!lo->announce_submounts) {
-        e->attr_flags &= ~FUSE_ATTR_SUBMOUNT;
-    }
-
     inode = lo_find(lo, &e->attr);
     if (inode) {
         close(newfd);
@@ -893,7 +847,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
         g_hash_table_insert(lo->inodes, &inode->key, inode);
         pthread_mutex_unlock(&lo->mutex);
     }
-    inode->parent_dev = dir->key.dev;
     e->ino = inode->fuse_ino;
     lo_inode_put(lo, &inode);
     lo_inode_put(lo, &dir);
@@ -1107,17 +1060,11 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
         goto out_err;
     }
 
-    res = do_fstatat(inode->fd, "", &e.attr,
-                     AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW,
-                     parent_inode->key.dev, &e.attr_flags);
+    res = fstatat(inode->fd, "", &e.attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
     if (res == -1) {
         goto out_err;
     }
 
-    if (!lo->announce_submounts) {
-        e.attr_flags &= ~FUSE_ATTR_SUBMOUNT;
-    }
-
     pthread_mutex_lock(&lo->mutex);
     inode->nlookup++;
     pthread_mutex_unlock(&lo->mutex);
@@ -1126,14 +1073,6 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
     fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)parent,
              name, (unsigned long long)e.ino);
 
-    /*
-     * No need to update inode->parent_dev, because
-     * (1) We cannot, the inode now has more than one parent,
-     * (2) Directories cannot have more than one parent, so link()
-     *     does not work for them; but parent_dev only needs to be
-     *     valid for directories.
-     */
-
     fuse_reply_entry(req, &e);
     lo_inode_put(lo, &parent_inode);
     lo_inode_put(lo, &inode);
@@ -1152,21 +1091,14 @@ static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
 {
     int res;
     struct stat attr;
-    struct lo_data *lo = lo_data(req);
-    struct lo_inode *dir = lo_inode(req, parent);
 
-    if (!dir) {
-        return NULL;
-    }
-
-    res = do_fstatat(dir->fd, name, &attr,
-                     AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW, dir->key.dev, NULL);
-    lo_inode_put(lo, &dir);
+    res = fstatat(lo_fd(req, parent), name, &attr,
+                  AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
     if (res == -1) {
         return NULL;
     }
 
-    return lo_find(lo, &attr);
+    return lo_find(lo_data(req), &attr);
 }
 
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)


