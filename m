Received: from eggs.gnu.org ([2001:4830:134:3::10]:36247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drMCZ-0004lt-Nd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drMCW-0001kf-GX
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:44:27 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1drMCW-0001k2-5W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:44:24 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v109so13689611wrc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 03:44:24 -0700 (PDT)
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-5-famz@redhat.com>
	<87tw0dgqpv.fsf@linaro.org> <20170908232950.GD18677@lemon.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170908232950.GD18677@lemon.lan>
Date: Mon, 11 Sep 2017 11:44:21 +0100
Message-ID: <874ls9bjlm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com


Fam Zheng <famz@redhat.com> writes:

> On Fri, 09/08 16:22, Alex Bennée wrote:
>>
>> Fam Zheng <famz@redhat.com> writes:
>>
>> > This is the common code to implement a "VM test" to
>> >
>> >   1) Download and initialize a pre-defined VM that has necessary
>> >   dependencies to build QEMU and SSH access.
>> >
>> >   2) Archive $SRC_PATH to a .tar file.
>> >
>> >   3) Boot the VM, and pass the source tar file to the guest.
>> >
>> >   4) SSH into the VM, untar the source tarball, build from the source.
>> >
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > ---
>> >  tests/vm/basevm.py | 276 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 276 insertions(+)
>> >  create mode 100755 tests/vm/basevm.py
>> >
>> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>> > new file mode 100755
>> > index 0000000000..9db91d61fa
>> > --- /dev/null
>> > +++ b/tests/vm/basevm.py
>> > @@ -0,0 +1,276 @@
>> > +#!/usr/bin/env python
>> > +#
>> > +# VM testing base class
>> > +#
>> > +# Copyright (C) 2017 Red Hat Inc.
>> > +#
>> > +# Authors:
>> > +#  Fam Zheng <famz@redhat.com>
>> > +#
>> > +# This work is licensed under the terms of the GNU GPL, version 2.  See
>> > +# the COPYING file in the top-level directory.
>> > +#
>> > +
>> > +import os
>> > +import sys
>> > +import logging
>> > +import time
>> > +import datetime
>> > +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
>> > +from qemu import QEMUMachine
>> > +import subprocess
>> > +import hashlib
>> > +import optparse
>> > +import atexit
>> > +import tempfile
>> > +import shutil
>> > +import multiprocessing
>> > +import traceback
>> > +
>> > +SSH_KEY = """\
>> > +-----BEGIN RSA PRIVATE KEY-----
>> > +MIIEowIBAAKCAQEAopAuOlmLV6LVHdFBj8/eeOwI9CqguIJPp7eAQSZvOiB4Ag/R
>> > +coEhl/RBbrV5Yc/SmSD4PTpJO/iM10RwliNjDb4a3I8q3sykRJu9c9PI/YsH8WN9
>> > ++NH2NjKPtJIcKTu287IM5JYxyB6nDoOzILbTyJ1TDR/xH6qYEfBAyiblggdjcvhA
>> > +RTf93QIn39F/xLypXvT1K2O9BJEsnJ8lEUvB2UXhKo/JTfSeZF8wPBeowaP9EONk
>> > +7b+nuJOWHGg68Ji6wVi62tjwl2Szch6lxIhZBpnV7QNRKMfYHP6eIyF4pusazzZq
>> > +Telsq6xI2ghecWLzb/MF5A+rklsGx2FNuJSAJwIDAQABAoIBAHHi4o/8VZNivz0x
>> > +cWXn8erzKV6tUoWQvW85Lj/2RiwJvSlsnYZDkx5af1CpEE2HA/pFT8PNRqsd+MWC
>> > +7AEy710cVsM4BYerBFYQaYxwzblaoojo88LSjVPw3h5Z0iLM8+IMVd36nwuc9dpE
>> > +R8TecMZ1+U4Tl6BgqkK+9xToZRdPKdjS8L5MoFhGN+xY0vRbbJbGaV9Q0IHxLBkB
>> > +rEBV7T1mUynneCHRUQlJQEwJmKpT8MH3IjsUXlG5YvnuuvcQJSNTaW2iDLxuOKp8
>> > +cxW8+qL88zpb1D5dppoIu6rlrugN0azSq70ruFJQPc/A8GQrDKoGgRQiagxNY3u+
>> > +vHZzXlECgYEA0dKO3gfkSxsDBb94sQwskMScqLhcKhztEa8kPxTx6Yqh+x8/scx3
>> > +XhJyOt669P8U1v8a/2Al+s81oZzzfQSzO1Q7gEwSrgBcRMSIoRBUw9uYcy02ngb/
>> > +j/ng3DGivfJztjjiSJwb46FHkJ2JR8mF2UisC6UMXk3NgFY/3vWQx78CgYEAxlcG
>> > +T3hfSWSmTgKRczMJuHQOX9ULfTBIqwP5VqkkkiavzigGRirzb5lgnmuTSPTpF0LB
>> > +XVPjR2M4q+7gzP0Dca3pocrvLEoxjwIKnCbYKnyyvnUoE9qHv4Kr+vDbgWpa2LXG
>> > +JbLmE7tgTCIp20jOPPT4xuDvlbzQZBJ5qCQSoZkCgYEAgrotSSihlCnAOFSTXbu4
>> > +CHp3IKe8xIBBNENq0eK61kcJpOxTQvOha3sSsJsU4JAM6+cFaxb8kseHIqonCj1j
>> > +bhOM/uJmwQJ4el/4wGDsbxriYOBKpyq1D38gGhDS1IW6kk3erl6VAb36WJ/OaGum
>> > +eTpN9vNeQWM4Jj2WjdNx4QECgYAwTdd6mU1TmZCrJRL5ZG+0nYc2rbMrnQvFoqUi
>> > +BvWiJovggHzur90zy73tNzPaq9Ls2FQxf5G1vCN8NCRJqEEjeYCR59OSDMu/EXc2
>> > +CnvQ9SevHOdS1oEDEjcCWZCMFzPi3XpRih1gptzQDe31uuiHjf3cqcGPzTlPdfRt
>> > +D8P92QKBgC4UaBvIRwREVJsdZzpIzm224Bpe8LOmA7DeTnjlT0b3lkGiBJ36/Q0p
>> > +VhYh/6cjX4/iuIs7gJbGon7B+YPB8scmOi3fj0+nkJAONue1mMfBNkba6qQTc6Y2
>> > +5mEKw2/O7/JpND7ucU3OK9plcw/qnrWDgHxl0Iz95+OzUIIagxne
>> > +-----END RSA PRIVATE KEY-----
>> > +"""
>> > +SSH_PUB_KEY = """\
>> > +ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0KqC4gk+nt4BBJm86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm71z08j9iwfxY3340fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2Ny+EBFN/3dAiff0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4k5YcaDrwmLrBWLra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xYvNv8wXkD6uSWwbHYU24lIAn qemu-vm-key
>> > +"""
>>
>> I'm not sure we should be embedding the keys in the script. I understand
>> we need a common key for downloaded images (although it would be better
>> to post-customise the image after download with the local developer
>> keys). Perhaps ./tests/testing-keys/id_rsa[.pub]?
>
> We cannot generate keys or start from local keys because it's hard to inject it
> into the *BSD images without ssh access (chicken-and-egg problem). Adding the
> local keys might be a good feature, indeed.

Can't libguestfs be used to manipulate the image without booting BSD
itself?

Regardless I still think having the key embedded in the script rather
than in files in the source tree is overly ugly.

>
>>
>> > +
>> > +class BaseVM(object):
>> > +    GUEST_USER = "qemu"
>> > +    GUEST_PASS = "qemupass"
>> > +    ROOT_PASS = "qemupass"
>> > +
>> > +    # The script to run in the guest that builds QEMU
>> > +    BUILD_SCRIPT = ""
>> > +    # The guest name, to be overridden by subclasses
>> > +    name = "#base"
>> > +    def __init__(self, debug=False, vcpus=None):
>> > +        self._guest = None
>> > +        self._tmpdir = tempfile.mkdtemp(prefix="vm-test-", suffix=".tmp", dir=".")
>> > +        atexit.register(shutil.rmtree, self._tmpdir)
>> > +
>> > +        self._ssh_key_file = os.path.join(self._tmpdir, "id_rsa")
>> > +        open(self._ssh_key_file, "w").write(SSH_KEY)
>> > +        subprocess.check_call(["chmod", "600", self._ssh_key_file])
>> > +
>> > +        self._ssh_pub_key_file = os.path.join(self._tmpdir, "id_rsa.pub")
>> > +        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
>>
>> As above, I think it would be better just to keep copies of the keys in
>> the tests directory rather than in the python source.
>>
>> > +
>> > +        self.debug = debug
>> > +        self._stderr = sys.stderr
>> > +        self._devnull = open("/dev/null", "w")
>>
>> You can use os.devnull as a portable reference.
>
> OK.
>
>>
>> > +        if self.debug:
>> > +            self._stdout = sys.stdout
>> > +        else:
>> > +            self._stdout = self._devnull
>> > +        self._args = [ \
>> > +            "-nodefaults", "-m", "2G",
>> > +            "-cpu", "host",
>> > +            "-netdev", "user,id=vnet,hostfwd=:0.0.0.0:0-:22",
>>
>> It doesn't help that howstfwd is poorly documented. Are we trying to map
>> an ephemeral port to the guests 22?
>
> Yes, it is a new feature of usernet, you're right the documentation is missing.
>
>>
>> > +            "-device", "virtio-net-pci,netdev=vnet",
>> > +            "-vnc", ":0,to=20",
>>
>> Do we need a GUI?
>
> I'd like to keep it, it helps when you need to diagnose.

As long it runs or fails cleanly when run on a on terminal.

>
>>
>> > +            "-serial", "file:%s" % os.path.join(self._tmpdir,
>> > "serial.out")]
>> > +        if vcpus:
>> > +            self._args += ["-smp", str(vcpus)]
>> > +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
>> > +            self._args += ["-enable-kvm"]
>> > +        else:
>> > +            logging.info("KVM not available, not using -enable-kvm")
>> > +        self._data_args = []
>> > +
>> > +    def _download_with_cache(self, url, sha256sum=None):
>> > +        def check_sha256sum(fname):
>> > +            if not sha256sum:
>> > +                return True
>> > +            checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
>> > +            return sha256sum == checksum
>> > +
>> > +        cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
>> > +        if not os.path.exists(cache_dir):
>> > +            os.makedirs(cache_dir)
>> > +        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
>> > +        if os.path.exists(fname) and check_sha256sum(fname):
>> > +            return fname
>> > +        logging.debug("Downloading %s to %s...", url, fname)
>> > +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".download"],
>> > +                              stdout=self._stdout,
>> > stderr=self._stderr)
>>
>> Using wget rather than doing it internally adds a utility requirement.
>> Is doing a pure python urllib2 fetch too slow for this?
>
> I think "-c" is a good feature for downloading big files.

I guess so.

>
>>
>> > +        os.rename(fname + ".download", fname)
>> > +        return fname
>> > +
>> > +    def _ssh_do(self, user, cmd, check, interactive=False):
>> > +        ssh_cmd = ["ssh", "-q",
>> > +                   "-o", "StrictHostKeyChecking=no",
>> > +                   "-o", "UserKnownHostsFile=/dev/null",
>> > +                   "-o", "ConnectTimeout=1",
>> > +                   "-p", self.ssh_port, "-i", self._ssh_key_file]
>> > +        if interactive:
>> > +            ssh_cmd += ['-t']
>> > +        assert not isinstance(cmd, str)
>> > +        ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
>> > +        logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
>> > +        r = subprocess.call(ssh_cmd,
>> > +                            stdin=sys.stdin if interactive else self._devnull,
>> > +                            stdout=sys.stdout if interactive else self._stdout,
>> > +                            stderr=sys.stderr if interactive else self._stderr)
>> > +        if check and r != 0:
>> > +            raise Exception("SSH command failed: %s" % cmd)
>> > +        return r
>> > +
>> > +    def ssh(self, *cmd):
>> > +        return self._ssh_do(self.GUEST_USER, cmd, False)
>> > +
>> > +    def ssh_interactive(self, *cmd):
>> > +        return self._ssh_do(self.GUEST_USER, cmd, False, True)
>> > +
>> > +    def ssh_root(self, *cmd):
>> > +        return self._ssh_do("root", cmd, False)
>> > +
>> > +    def ssh_check(self, *cmd):
>> > +        self._ssh_do(self.GUEST_USER, cmd, True)
>> > +
>> > +    def ssh_root_check(self, *cmd):
>> > +        self._ssh_do("root", cmd, True)
>> > +
>> > +    def build_image(self, img):
>> > +        raise NotImplementedError
>> > +
>> > +    def add_source_dir(self, src_dir):
>> > +        name = "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
>> > +        tarfile = os.path.join(self._tmpdir, name + ".tar")
>> > +        logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
>> > +        subprocess.check_call(["./scripts/archive-source.sh", tarfile],
>> > +                              cwd=src_dir, stdin=self._devnull,
>> > +                              stdout=self._stdout, stderr=self._stderr)
>> > +        self._data_args += ["-drive",
>> > +                            "file=%s,if=none,id=%s,cache=writeback,format=raw" % \
>> > +                                    (tarfile, name),
>> > +                            "-device",
>> > +                            "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
>> > +
>> > +    def boot(self, img, extra_args=[]):
>> > +        args = self._args + [
>> > +            "-device", "VGA",
>>
>> Is specifying a display device at boot time really needed (say rather
>> than further up with the rest of the machine description). Do we even
>> want a display given use ssh/serial for everything?
>
> It makes debug easier, and also I find cloud-init or something in ubuntu
> requires a virtual console on the display to make progress.
>
>>
>> > +            "-drive", "file=%s,if=none,id=drive0,cache=writeback" % img,
>> > +            "-device", "virtio-blk,drive=drive0,bootindex=0"]
>> > +        args += self._data_args + extra_args
>> > +        logging.debug("QEMU args: %s", " ".join(args))
>> > +        guest = QEMUMachine(binary=os.environ.get("QEMU", "qemu-system-x86_64"),
>> > +                            args=args)
>> > +        guest.launch()
>> > +        atexit.register(self.shutdown)
>> > +        self._guest = guest
>> > +        usernet_info = guest.qmp("human-monitor-command",
>> > +                                 command_line="info usernet")
>> > +        self.ssh_port = None
>> > +        for l in usernet_info["return"].splitlines():
>> > +            fields = l.split()
>> > +            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
>> > +                self.ssh_port = l.split()[3]
>> > +        if not self.ssh_port:
>> > +            raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
>> > +                            usernet_info)
>> > +
>> > +    def wait_ssh(self, seconds=120):
>> > +        starttime = datetime.datetime.now()
>> > +        guest_up = False
>> > +        while (datetime.datetime.now() - starttime).total_seconds() < seconds:
>> > +            if self.ssh("exit 0") == 0:
>> > +                guest_up = True
>> > +                break
>> > +            time.sleep(1)
>> > +        if not guest_up:
>> > +            raise Exception("Timeout while waiting for guest ssh")
>> > +
>> > +    def shutdown(self):
>> > +        self._guest.shutdown()
>> > +
>> > +    def wait(self):
>> > +        self._guest.wait()
>> > +
>> > +    def qmp(self, *args, **kwargs):
>> > +        return self._guest.qmp(*args, **kwargs)
>> > +
>> > +def parse_args(vm_name):
>> > +    parser = optparse.OptionParser(description="""
>> > +    VM test utility.  Exit codes: 0 = success, 1 = command line error, 2 = environment initialization failed, 3 = test command failed""")
>> > +    parser.add_option("--debug", "-D", action="store_true",
>> > +                      help="enable debug output")
>> > +    parser.add_option("--image", "-i", default="%s.img" % vm_name,
>> > +                      help="image file name")
>> > +    parser.add_option("--force", "-f", action="store_true",
>> > +                      help="force build image even if image exists")
>> > +    parser.add_option("--jobs", type=int, default=multiprocessing.cpu_count() / 2,
>> > +                      help="number of virtual CPUs")
>> > +    parser.add_option("--build-image", "-b", action="store_true",
>> > +                      help="build image")
>> > +    parser.add_option("--build-qemu",
>> > +                      help="build QEMU from source in guest")
>> > +    parser.add_option("--interactive", "-I", action="store_true",
>> > +                      help="Interactively run command")
>> > +    parser.disable_interspersed_args()
>> > +    return parser.parse_args()
>> > +
>> > +def main(vmcls):
>> > +    try:
>> > +        args, argv = parse_args(vmcls.name)
>> > +        if not argv and not args.build_qemu and not args.build_image:
>> > +            print "Nothing to do?"
>> > +            return 1
>> > +        if args.debug:
>> > +            logging.getLogger().setLevel(logging.DEBUG)
>> > +        vm = vmcls(debug=args.debug, vcpus=args.jobs)
>> > +        if args.build_image:
>> > +            if os.path.exists(args.image) and not args.force:
>> > +                sys.stderr.writelines(["Image file exists: %s\n" % args.image,
>> > +                                      "Use --force option to overwrite\n"])
>> > +                return 1
>> > +            return vm.build_image(args.image)
>> > +        if args.build_qemu:
>> > +            vm.add_source_dir(args.build_qemu)
>> > +            cmd = [vm.BUILD_SCRIPT.format(
>> > +                   configure_opts = " ".join(argv),
>> > +                   jobs=args.jobs)]
>> > +        else:
>> > +            cmd = argv
>> > +        vm.boot(args.image + ",snapshot=on")
>>
>> If this fails it's fairly cryptic:
>>
>> /home/alex/lsrc/qemu/qemu.git/tests/vm/openbsd  --debug   --image "tests/vm/openbsd.img" --build-qemu /home/alex/lsrc/qemu/qemu.git
>> DEBUG:root:Creating archive ./vm-test-fxejnB.tmp/data-2de24.tar for src_dir dir: /home/alex/lsrc/qemu/qemu.git
>> DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev user,id=vnet,hostfwd=:0.0.0.0:0-:22 -device virtio-net-pci,netdev=vnet -vnc :0,to=20 -serial file:./vm-test-fxejnB.tmp/serial.out -smp 4 -enable-kvm -device VGA -drive file=tests/vm/openbsd.img,snapshot=on,if=none,id=drive0,cache=writeback -device virtio-blk,drive=drive0,bootindex=0 -drive file=./vm-test-fxejnB.tmp/data-2de24.tar,if=none,id=data-2de24,cache=writeback,format=raw -device virtio-blk,drive=data-2de24,serial=data-2de24,bootindex=1
>> Failed to prepare guest environment
>> Traceback (most recent call last):
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 260, in main
>>     vm.boot(args.image + ",snapshot=on")
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 184, in boot
>>     guest.launch()
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", line 151, in launch
>>     self._post_launch()
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", line 135, in _post_launch
>>     self._qmp.accept()
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py", line 147, in accept
>>     return self.__negotiate_capabilities()
>>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py", line 60, in __negotiate_capabilities
>>     raise QMPConnectError
>> QMPConnectError
>>
>> I assume QEMU failed to boot and might have given us a message that
>> would be useful.
>
> It's a separate issue of qemu.py, I didn't try to fix it here because currently
> there are many patches touching that file on the list, there is a high chance of
> conflict.
>
> In your case which qemu version are you using? If not master it probably is
> failing because of the hostfwd syntax.

Nope, built on master (fcea73709b966a7ded9efa7b106ea50c7fe9025c). As I
say I need a cleaner error message to diagnose why it failed.

>
>>
>>
>> > +        vm.wait_ssh()
>> > +    except Exception as e:
>> > +        if isinstance(e, SystemExit) and e.code == 0:
>> > +            return 0
>> > +        sys.stderr.write("Failed to prepare guest environment\n")
>> > +        traceback.print_exc()
>> > +        return 2
>> > +
>> > +    if args.interactive:
>> > +        if vm.ssh_interactive(*cmd) == 0:
>> > +            return 0
>> > +        vm.ssh_interactive()
>> > +        return 3
>> > +    else:
>> > +        if vm.ssh(*cmd) != 0:
>> > +            return 3
>>
>>
>> --
>> Alex Bennée
>>
>
> Thanks for the review!
>
> Fam


--
Alex Bennée
