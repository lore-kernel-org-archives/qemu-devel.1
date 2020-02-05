Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8420C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736A220720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIN7QMTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736A220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSM3-0002nS-Hx
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ7-0005Y7-Q9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSJ5-0006Jf-Ra
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:34:01 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:36874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSJ5-0006IS-Iu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:59 -0500
Received: by mail-pf1-x429.google.com with SMTP id p14so1883491pfn.4
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BTo2IbS/Iw9aPjF8JvV5QAW0iHf49XaNmUCUIWa/t68=;
 b=HIN7QMTqZa7eGiwKX3QPSoPxRoepzlORT+gIPul3AiDFR70qjIiW87Dq1EofUPEWKs
 YYQqpEkxtty/3GG8canLgENp2Pq+KZ1mZyAWtjo0Tz8mLla911ibHbDTpYkt9w1WMPK6
 huuWRTOloc9UcqlIcmxlv3MDncZAv2Y/9kPQD0j/kruhT1fkUDc988WgsDX7JGLTmZK8
 qDkzcyJSCPWso1+ymAf11LcWJyzLgqrTd6lhOGq7WVuAAYFk/ILGVopkyYEddBYrPKPi
 1zMX63iRAc5QzleGMLt+BFG93Xw24HdtB8a4ETqkzVBBTqlDZV/4dubLHi184UIQiBDu
 NIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BTo2IbS/Iw9aPjF8JvV5QAW0iHf49XaNmUCUIWa/t68=;
 b=NAik4MP9HO+Pcag5wbDfH7mkgUrY9+PylULKYn2F31VMsgs7ZfA+v+rtPJWUMnNdoz
 zBar8R0sTdwiOT3ZjAt+joVA3EHkHSTHW4qoWmAwZVFzBqL/+J+rMPIBi3hLjBiLoed9
 E2X5XZQyL7KpmYXTm2t3Zv5j2WJ2IMg2pUekJboXzdG3n/o8r7Tap4InQrxpthbXW8oN
 zzigR02iB8FeaYuZNYZBekub6QeobnuRpQngrpkX/QdHoR0UfpprfOMQCsgCYlbNliDx
 n6ud/psKrPPa9yKIVI3KJBaPb9iDbT6l2zVHJ8tSh65Nt8DV0T/o72uFvT83z8bqJCFS
 FhoQ==
X-Gm-Message-State: APjAAAViFB+33hsAtp4n/pK4Don7z/UhUzsVU/pcsxXyvihlxQ5q3FlV
 8+94VuchsXCL8X2bv2KJlyuHkDkKdlM=
X-Google-Smtp-Source: APXvYqxCuoBzfx9OCphWMSwmr9t1QLKXcqpcBRXha984RIFCxRoKq678QlsfisuYTJcGeb0Qfl95xg==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr39708118pfn.245.1580938438017; 
 Wed, 05 Feb 2020 13:33:58 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:57 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/14] tests/vm: Add configuration to basevm.py
Date: Wed,  5 Feb 2020 16:29:13 -0500
Message-Id: <20200205212920.467-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added use of a configuration to tests/vm/basevm.py.
The configuration provides parameters used to configure a VM.
This allows for providing alternate configurations to the VM being
created/launched. cpu, machine, memory, and NUMA configuration are all
examples of configuration which we might want to vary on the VM being created
or launched.
This will for example allow for creating an aarch64 vm.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 141 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 30 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 87a484c55c..33004934af 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -33,19 +33,43 @@ import multiprocessing
 import traceback
 from socket_thread import SocketThread
 
-SSH_KEY = open(os.path.join(os.path.dirname(__file__),
-               "..", "keys", "id_rsa")).read()
-SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
-                   "..", "keys", "id_rsa.pub")).read()
+SSH_KEY_FILE = os.path.join(os.path.dirname(__file__),
+               "..", "keys", "id_rsa")
+SSH_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
+                   "..", "keys", "id_rsa.pub")
 
 class ConsoleTimeoutException(Exception):
     """Raise this exception when read from console times out."""
     pass
 
+# This is the standard configuration.
+# Any or all of these can be overridden by
+# passing in a config argument to the VM constructor.
+DEFAULT_CONFIG = {
+    'cpu'             : "max",
+    'machine'         : 'pc',
+    'guest_user'      : "qemu",
+    'guest_pass'      : "qemupass",
+    'root_pass'       : "qemupass",
+    'ssh_key_file'    : SSH_KEY_FILE,
+    'ssh_pub_key_file': SSH_PUB_KEY_FILE,
+    'memory'          : "4G",
+    'extra_args'      : [],
+    'qemu_args'       : "",
+    'dns'             : "",
+    'ssh_port'        : 0,
+    'install_cmds'    : "",
+    'boot_dev_type'   : "block",
+    'ssh_timeout'     : 1,
+}
+BOOT_DEVICE = {
+    'block' :  "-drive file={},if=none,id=drive0,cache=writeback "\
+               "-device virtio-blk,drive=drive0,bootindex=0",
+    'scsi'  :  "-device virtio-scsi-device,id=scsi "\
+               "-drive file={},format=raw,if=none,id=hd0 "\
+               "-device scsi-hd,drive=hd0,bootindex=0",
+}
 class BaseVM(object):
-    GUEST_USER = "qemu"
-    GUEST_PASS = "qemupass"
-    ROOT_PASS = "qemupass"
 
     envvars = [
         "https_proxy",
@@ -71,22 +95,33 @@ class BaseVM(object):
     # since we found we need to wait more than twice as long.
     tcg_ssh_timeout_multiplier = 4
     console_logfile = "console.log"
-    def __init__(self, debug=False, vcpus=None):
+    def __init__(self, debug=False, vcpus=None, config=None):
         self._guest = None
         self._console_fd = None
         self._socket_thread = None
         self._console_timeout_sec = self.socket_timeout
+        # Allow input config to override defaults.
+        self._config = DEFAULT_CONFIG.copy()
+        if config != None:
+            self._config.update(config)
+        self.validate_ssh_keys()
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
                                                          suffix=".tmp",
                                                          dir="."))
         atexit.register(shutil.rmtree, self._tmpdir)
-
-        self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
-        open(self._ssh_key_file, "w").write(SSH_KEY)
-        subprocess.check_call(["chmod", "600", self._ssh_key_file])
-
-        self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
-        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
+        # Copy the key files to a temporary directory.
+        # Also chmod the key file to agree with ssh requirements.
+        self._config['ssh_key'] = \
+            open(self._config['ssh_key_file']).read().rstrip()
+        self._config['ssh_pub_key'] = \
+            open(self._config['ssh_pub_key_file']).read().rstrip()
+        self._ssh_tmp_key_file = os.path.join(self._tmpdir, "id_rsa")
+        open(self._ssh_tmp_key_file, "w").write(self._config['ssh_key'])
+        subprocess.check_call(["chmod", "600", self._ssh_tmp_key_file])
+
+        self._ssh_tmp_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
+        open(self._ssh_tmp_pub_key_file,
+             "w").write(self._config['ssh_pub_key'])
 
         self.debug = debug
         self._stderr = sys.stderr
@@ -95,11 +130,14 @@ class BaseVM(object):
             self._stdout = sys.stdout
         else:
             self._stdout = self._devnull
+        netdev = "user,id=vnet,hostfwd=:127.0.0.1:{}-:22"
         self._args = [ \
-            "-nodefaults", "-m", "4G",
-            "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22" +
-                       (",ipv6=no" if not self.ipv6 else ""),
+            "-nodefaults", "-m", self._config['memory'],
+            "-cpu", self._config['cpu'],
+            "-netdev",
+            netdev.format(self._config['ssh_port']) +
+            (",ipv6=no" if not self.ipv6 else "") +
+            (",dns=" + self._config['dns'] if self._config['dns'] else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
@@ -110,6 +148,45 @@ class BaseVM(object):
             logging.info("KVM not available, not using -enable-kvm")
         self._data_args = []
 
+        if self._config['qemu_args'] != None:
+            qemu_args = self._config['qemu_args']
+            qemu_args = qemu_args.replace('\n',' ').replace('\r','')
+            # Remove any empty strings from list.
+            self._config['extra_args'] = [x for x in qemu_args.split(' ') if x]
+
+    def validate_ssh_keys(self):
+        """Check to see if the ssh key files exist."""
+        if 'ssh_key_file' not in self._config or\
+           not os.path.exists(self._config['ssh_key_file']):
+            raise Exception("ssh key file not found.")
+        if 'ssh_pub_key_file' not in self._config or\
+           not os.path.exists(self._config['ssh_pub_key_file']):
+               raise Exception("ssh pub key file not found.")
+
+    def wait_boot(self, wait_string=None):
+        """Wait for the standard string we expect
+           on completion of a normal boot.
+           The user can also choose to override with an
+           alternate string to wait for."""
+        if wait_string is None:
+            if self.login_prompt is None:
+                raise Exception("self.login_prompt not defined")
+            wait_string = self.login_prompt
+        # Intentionally bump up the default timeout under TCG,
+        # since the console wait below takes longer.
+        timeout = self.socket_timeout
+        if not kvm_available(self.arch):
+            timeout *= 8
+        self.console_init(timeout=timeout)
+        self.console_wait(wait_string)
+
+    def __getattr__(self, name):
+        # Support direct access to config by key.
+        # for example, access self._config['cpu'] by self.cpu
+        if name.lower() in self._config.keys():
+            return self._config[name.lower()]
+        return object.__getattribute__(self, name)
+
     def _download_with_cache(self, url, sha256sum=None, sha512sum=None):
         def check_sha256sum(fname):
             if not sha256sum:
@@ -141,8 +218,9 @@ class BaseVM(object):
                    "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
-                   "-o", "ConnectTimeout=1",
-                   "-p", self.ssh_port, "-i", self._ssh_key_file]
+                   "-o",
+                   "ConnectTimeout={}".format(self._config["ssh_timeout"]),
+                   "-p", self.ssh_port, "-i", self._ssh_tmp_key_file]
         # If not in debug mode, set ssh to quiet mode to
         # avoid printing the results of commands.
         if not self.debug:
@@ -200,15 +278,15 @@ class BaseVM(object):
         print("console logfile is: {}".format(self.console_logfile))
 
     def boot(self, img, extra_args=[]):
-        args = self._args + [
-            "-device", "VGA",
-            "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
-            "-device", "virtio-blk,drive=drive0,bootindex=0"]
-        args += self._data_args + extra_args
+        boot_dev = BOOT_DEVICE[self._config['boot_dev_type']]
+        boot_params = boot_dev.format(img)
+        args = self._args + boot_params.split(' ')
+        args += self._data_args + extra_args + self._config['extra_args']
+        args += ["-device", "VGA"]
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
-        guest.set_machine('pc')
+        guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
             guest.launch()
@@ -332,7 +410,8 @@ class BaseVM(object):
         self.console_send(command)
 
     def console_ssh_init(self, prompt, user, pw):
-        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" % SSH_PUB_KEY.rstrip()
+        sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" \
+                     % self._config['ssh_pub_key'].rstrip()
         self.console_wait_send("login:",    "%s\n" % user)
         self.console_wait_send("Password:", "%s\n" % pw)
         self.console_wait_send(prompt,      "mkdir .ssh\n")
@@ -461,15 +540,17 @@ def parse_args(vmcls):
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-def main(vmcls):
+def main(vmcls, config=None):
     try:
+        if config == None:
+            config = {}
         args, argv = parse_args(vmcls)
         if not argv and not args.build_qemu and not args.build_image:
             print("Nothing to do?")
             return 1
         logging.basicConfig(level=(logging.DEBUG if args.debug
                                    else logging.WARN))
-        vm = vmcls(debug=args.debug, vcpus=args.jobs)
+        vm = vmcls(debug=args.debug, vcpus=args.jobs, config=config)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
-- 
2.17.1


