Received: from eggs.gnu.org ([2001:4830:134:3::10]:58378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv366-00085m-7f
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dv361-0003MC-4P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dv360-0003Kq-RE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:08:57 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Sep 2017 23:07:47 +0800
Message-Id: <20170921150755.19914-6-famz@redhat.com>
In-Reply-To: <20170921150755.19914-1-famz@redhat.com>
References: <20170921150755.19914-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 05/13] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is the common code to implement a "VM test" to

  1) Download and initialize a pre-defined VM that has necessary
  dependencies to build QEMU and SSH access.

  2) Archive $SRC_PATH to a .tar file.

  3) Boot the VM, and pass the source tar file to the guest.

  4) SSH into the VM, untar the source tarball, build from the source.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 262 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 262 insertions(+)
 create mode 100755 tests/vm/basevm.py

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
new file mode 100755
index 0000000000..3c863bc237
--- /dev/null
+++ b/tests/vm/basevm.py
@@ -0,0 +1,262 @@
+#!/usr/bin/env python
+#
+# VM testing base class
+#
+# Copyright 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import logging
+import time
+import datetime
+sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scr=
ipts"))
+from qemu import QEMUMachine
+import subprocess
+import hashlib
+import optparse
+import atexit
+import tempfile
+import shutil
+import multiprocessing
+import traceback
+
+SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
+               "..", "keys", "id_rsa")).read()
+SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
+                   "..", "keys", "id_rsa.pub")).read()
+
+class BaseVM(object):
+    GUEST_USER =3D "qemu"
+    GUEST_PASS =3D "qemupass"
+    ROOT_PASS =3D "qemupass"
+
+    # The script to run in the guest that builds QEMU
+    BUILD_SCRIPT =3D ""
+    # The guest name, to be overridden by subclasses
+    name =3D "#base"
+    def __init__(self, debug=3DFalse, vcpus=3DNone):
+        self._guest =3D None
+        self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
+                                                         suffix=3D".tmp"=
,
+                                                         dir=3D"."))
+        atexit.register(shutil.rmtree, self._tmpdir)
+
+        self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
+        open(self._ssh_key_file, "w").write(SSH_KEY)
+        subprocess.check_call(["chmod", "600", self._ssh_key_file])
+
+        self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.pu=
b")
+        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
+
+        self.debug =3D debug
+        self._stderr =3D sys.stderr
+        self._devnull =3D open(os.devnull, "w")
+        if self.debug:
+            self._stdout =3D sys.stdout
+        else:
+            self._stdout =3D self._devnull
+        self._args =3D [ \
+            "-nodefaults", "-m", "2G",
+            "-cpu", "host",
+            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22",
+            "-device", "virtio-net-pci,netdev=3Dvnet",
+            "-vnc", "127.0.0.1:0,to=3D20",
+            "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.ou=
t")]
+        if vcpus:
+            self._args +=3D ["-smp", str(vcpus)]
+        if os.access("/dev/kvm", os.R_OK | os.W_OK):
+            self._args +=3D ["-enable-kvm"]
+        else:
+            logging.info("KVM not available, not using -enable-kvm")
+        self._data_args =3D []
+
+    def _download_with_cache(self, url, sha256sum=3DNone):
+        def check_sha256sum(fname):
+            if not sha256sum:
+                return True
+            checksum =3D subprocess.check_output(["sha256sum", fname]).s=
plit()[0]
+            return sha256sum =3D=3D checksum
+
+        cache_dir =3D os.path.expanduser("~/.cache/qemu-vm/download")
+        if not os.path.exists(cache_dir):
+            os.makedirs(cache_dir)
+        fname =3D os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
+        if os.path.exists(fname) and check_sha256sum(fname):
+            return fname
+        logging.debug("Downloading %s to %s...", url, fname)
+        subprocess.check_call(["wget", "-c", url, "-O", fname + ".downlo=
ad"],
+                              stdout=3Dself._stdout, stderr=3Dself._stde=
rr)
+        os.rename(fname + ".download", fname)
+        return fname
+
+    def _ssh_do(self, user, cmd, check, interactive=3DFalse):
+        ssh_cmd =3D ["ssh", "-q",
+                   "-o", "StrictHostKeyChecking=3Dno",
+                   "-o", "UserKnownHostsFile=3D" + os.devnull,
+                   "-o", "ConnectTimeout=3D1",
+                   "-p", self.ssh_port, "-i", self._ssh_key_file]
+        if interactive:
+            ssh_cmd +=3D ['-t']
+        assert not isinstance(cmd, str)
+        ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
+        logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
+        r =3D subprocess.call(ssh_cmd,
+                            stdin=3Dsys.stdin if interactive else self._=
devnull,
+                            stdout=3Dsys.stdout if interactive else self=
._stdout,
+                            stderr=3Dsys.stderr if interactive else self=
._stderr)
+        if check and r !=3D 0:
+            raise Exception("SSH command failed: %s" % cmd)
+        return r
+
+    def ssh(self, *cmd):
+        return self._ssh_do(self.GUEST_USER, cmd, False)
+
+    def ssh_interactive(self, *cmd):
+        return self._ssh_do(self.GUEST_USER, cmd, False, True)
+
+    def ssh_root(self, *cmd):
+        return self._ssh_do("root", cmd, False)
+
+    def ssh_check(self, *cmd):
+        self._ssh_do(self.GUEST_USER, cmd, True)
+
+    def ssh_root_check(self, *cmd):
+        self._ssh_do("root", cmd, True)
+
+    def build_image(self, img):
+        raise NotImplementedError
+
+    def add_source_dir(self, src_dir):
+        name =3D "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
+        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
+        logging.debug("Creating archive %s for src_dir dir: %s", tarfile=
, src_dir)
+        subprocess.check_call(["./scripts/archive-source.sh", tarfile],
+                              cwd=3Dsrc_dir, stdin=3Dself._devnull,
+                              stdout=3Dself._stdout, stderr=3Dself._stde=
rr)
+        self._data_args +=3D ["-drive",
+                            "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwriteba=
ck,format=3Draw" % \
+                                    (tarfile, name),
+                            "-device",
+                            "virtio-blk,drive=3D%s,serial=3D%s,bootindex=
=3D1" % (name, name)]
+
+    def boot(self, img, extra_args=3D[]):
+        args =3D self._args + [
+            "-device", "VGA",
+            "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwriteback=
" % img,
+            "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
+        args +=3D self._data_args + extra_args
+        logging.debug("QEMU args: %s", " ".join(args))
+        qemu_bin =3D os.environ.get("QEMU", "qemu-system-x86_64")
+        guest =3D QEMUMachine(binary=3Dqemu_bin, args=3Dargs)
+        try:
+            guest.launch()
+        except:
+            logging.error("Failed to launch QEMU, command line:")
+            logging.error(" ".join([qemu_bin] + args))
+            logging.error("Log:")
+            logging.error(guest.get_log())
+            logging.error("QEMU version >=3D 2.10 is required")
+            raise
+        atexit.register(self.shutdown)
+        self._guest =3D guest
+        usernet_info =3D guest.qmp("human-monitor-command",
+                                 command_line=3D"info usernet")
+        self.ssh_port =3D None
+        for l in usernet_info["return"].splitlines():
+            fields =3D l.split()
+            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
+                self.ssh_port =3D l.split()[3]
+        if not self.ssh_port:
+            raise Exception("Cannot find ssh port from 'info usernet':\n=
%s" % \
+                            usernet_info)
+
+    def wait_ssh(self, seconds=3D120):
+        starttime =3D datetime.datetime.now()
+        guest_up =3D False
+        while (datetime.datetime.now() - starttime).total_seconds() < se=
conds:
+            if self.ssh("exit 0") =3D=3D 0:
+                guest_up =3D True
+                break
+            time.sleep(1)
+        if not guest_up:
+            raise Exception("Timeout while waiting for guest ssh")
+
+    def shutdown(self):
+        self._guest.shutdown()
+
+    def wait(self):
+        self._guest.wait()
+
+    def qmp(self, *args, **kwargs):
+        return self._guest.qmp(*args, **kwargs)
+
+def parse_args(vm_name):
+    parser =3D optparse.OptionParser(
+        description=3D"VM test utility.  Exit codes: "
+                    "0 =3D success, "
+                    "1 =3D command line error, "
+                    "2 =3D environment initialization failed, "
+                    "3 =3D test command failed")
+    parser.add_option("--debug", "-D", action=3D"store_true",
+                      help=3D"enable debug output")
+    parser.add_option("--image", "-i", default=3D"%s.img" % vm_name,
+                      help=3D"image file name")
+    parser.add_option("--force", "-f", action=3D"store_true",
+                      help=3D"force build image even if image exists")
+    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessing.cp=
u_count() / 2,
+                      help=3D"number of virtual CPUs")
+    parser.add_option("--build-image", "-b", action=3D"store_true",
+                      help=3D"build image")
+    parser.add_option("--build-qemu",
+                      help=3D"build QEMU from source in guest")
+    parser.add_option("--interactive", "-I", action=3D"store_true",
+                      help=3D"Interactively run command")
+    parser.disable_interspersed_args()
+    return parser.parse_args()
+
+def main(vmcls):
+    try:
+        args, argv =3D parse_args(vmcls.name)
+        if not argv and not args.build_qemu and not args.build_image:
+            print "Nothing to do?"
+            return 1
+        if args.debug:
+            logging.getLogger().setLevel(logging.DEBUG)
+        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
+        if args.build_image:
+            if os.path.exists(args.image) and not args.force:
+                sys.stderr.writelines(["Image file exists: %s\n" % args.=
image,
+                                      "Use --force option to overwrite\n=
"])
+                return 1
+            return vm.build_image(args.image)
+        if args.build_qemu:
+            vm.add_source_dir(args.build_qemu)
+            cmd =3D [vm.BUILD_SCRIPT.format(
+                   configure_opts =3D " ".join(argv),
+                   jobs=3Dargs.jobs)]
+        else:
+            cmd =3D argv
+        vm.boot(args.image + ",snapshot=3Don")
+        vm.wait_ssh()
+    except Exception as e:
+        if isinstance(e, SystemExit) and e.code =3D=3D 0:
+            return 0
+        sys.stderr.write("Failed to prepare guest environment\n")
+        traceback.print_exc()
+        return 2
+
+    if args.interactive:
+        if vm.ssh_interactive(*cmd) =3D=3D 0:
+            return 0
+        vm.ssh_interactive()
+        return 3
+    else:
+        if vm.ssh(*cmd) !=3D 0:
+            return 3
--=20
2.13.5
