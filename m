Received: from eggs.gnu.org ([2001:4830:134:3::10]:36917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSis-000535-DO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSio-0001Lt-86
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:30:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqSin-0001Kx-Ve
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:30:02 -0400
Date: Sat, 9 Sep 2017 07:29:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908232950.GD18677@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-5-famz@redhat.com>
	<87tw0dgqpv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tw0dgqpv.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/12] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com

On Fri, 09/08 16:22, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > This is the common code to implement a "VM test" to
> >
> >   1) Download and initialize a pre-defined VM that has necessary
> >   dependencies to build QEMU and SSH access.
> >
> >   2) Archive $SRC_PATH to a .tar file.
> >
> >   3) Boot the VM, and pass the source tar file to the guest.
> >
> >   4) SSH into the VM, untar the source tarball, build from the source=
.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/basevm.py | 276 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 276 insertions(+)
> >  create mode 100755 tests/vm/basevm.py
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > new file mode 100755
> > index 0000000000..9db91d61fa
> > --- /dev/null
> > +++ b/tests/vm/basevm.py
> > @@ -0,0 +1,276 @@
> > +#!/usr/bin/env python
> > +#
> > +# VM testing base class
> > +#
> > +# Copyright (C) 2017 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Fam Zheng <famz@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.  =
See
> > +# the COPYING file in the top-level directory.
> > +#
> > +
> > +import os
> > +import sys
> > +import logging
> > +import time
> > +import datetime
> > +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", =
"scripts"))
> > +from qemu import QEMUMachine
> > +import subprocess
> > +import hashlib
> > +import optparse
> > +import atexit
> > +import tempfile
> > +import shutil
> > +import multiprocessing
> > +import traceback
> > +
> > +SSH_KEY =3D """\
> > +-----BEGIN RSA PRIVATE KEY-----
> > +MIIEowIBAAKCAQEAopAuOlmLV6LVHdFBj8/eeOwI9CqguIJPp7eAQSZvOiB4Ag/R
> > +coEhl/RBbrV5Yc/SmSD4PTpJO/iM10RwliNjDb4a3I8q3sykRJu9c9PI/YsH8WN9
> > ++NH2NjKPtJIcKTu287IM5JYxyB6nDoOzILbTyJ1TDR/xH6qYEfBAyiblggdjcvhA
> > +RTf93QIn39F/xLypXvT1K2O9BJEsnJ8lEUvB2UXhKo/JTfSeZF8wPBeowaP9EONk
> > +7b+nuJOWHGg68Ji6wVi62tjwl2Szch6lxIhZBpnV7QNRKMfYHP6eIyF4pusazzZq
> > +Telsq6xI2ghecWLzb/MF5A+rklsGx2FNuJSAJwIDAQABAoIBAHHi4o/8VZNivz0x
> > +cWXn8erzKV6tUoWQvW85Lj/2RiwJvSlsnYZDkx5af1CpEE2HA/pFT8PNRqsd+MWC
> > +7AEy710cVsM4BYerBFYQaYxwzblaoojo88LSjVPw3h5Z0iLM8+IMVd36nwuc9dpE
> > +R8TecMZ1+U4Tl6BgqkK+9xToZRdPKdjS8L5MoFhGN+xY0vRbbJbGaV9Q0IHxLBkB
> > +rEBV7T1mUynneCHRUQlJQEwJmKpT8MH3IjsUXlG5YvnuuvcQJSNTaW2iDLxuOKp8
> > +cxW8+qL88zpb1D5dppoIu6rlrugN0azSq70ruFJQPc/A8GQrDKoGgRQiagxNY3u+
> > +vHZzXlECgYEA0dKO3gfkSxsDBb94sQwskMScqLhcKhztEa8kPxTx6Yqh+x8/scx3
> > +XhJyOt669P8U1v8a/2Al+s81oZzzfQSzO1Q7gEwSrgBcRMSIoRBUw9uYcy02ngb/
> > +j/ng3DGivfJztjjiSJwb46FHkJ2JR8mF2UisC6UMXk3NgFY/3vWQx78CgYEAxlcG
> > +T3hfSWSmTgKRczMJuHQOX9ULfTBIqwP5VqkkkiavzigGRirzb5lgnmuTSPTpF0LB
> > +XVPjR2M4q+7gzP0Dca3pocrvLEoxjwIKnCbYKnyyvnUoE9qHv4Kr+vDbgWpa2LXG
> > +JbLmE7tgTCIp20jOPPT4xuDvlbzQZBJ5qCQSoZkCgYEAgrotSSihlCnAOFSTXbu4
> > +CHp3IKe8xIBBNENq0eK61kcJpOxTQvOha3sSsJsU4JAM6+cFaxb8kseHIqonCj1j
> > +bhOM/uJmwQJ4el/4wGDsbxriYOBKpyq1D38gGhDS1IW6kk3erl6VAb36WJ/OaGum
> > +eTpN9vNeQWM4Jj2WjdNx4QECgYAwTdd6mU1TmZCrJRL5ZG+0nYc2rbMrnQvFoqUi
> > +BvWiJovggHzur90zy73tNzPaq9Ls2FQxf5G1vCN8NCRJqEEjeYCR59OSDMu/EXc2
> > +CnvQ9SevHOdS1oEDEjcCWZCMFzPi3XpRih1gptzQDe31uuiHjf3cqcGPzTlPdfRt
> > +D8P92QKBgC4UaBvIRwREVJsdZzpIzm224Bpe8LOmA7DeTnjlT0b3lkGiBJ36/Q0p
> > +VhYh/6cjX4/iuIs7gJbGon7B+YPB8scmOi3fj0+nkJAONue1mMfBNkba6qQTc6Y2
> > +5mEKw2/O7/JpND7ucU3OK9plcw/qnrWDgHxl0Iz95+OzUIIagxne
> > +-----END RSA PRIVATE KEY-----
> > +"""
> > +SSH_PUB_KEY =3D """\
> > +ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0KqC4=
gk+nt4BBJm86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm71z0=
8j9iwfxY3340fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2Ny+E=
BFN/3dAiff0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4k5Y=
caDrwmLrBWLra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xYvNv=
8wXkD6uSWwbHYU24lIAn qemu-vm-key
> > +"""
>=20
> I'm not sure we should be embedding the keys in the script. I understan=
d
> we need a common key for downloaded images (although it would be better
> to post-customise the image after download with the local developer
> keys). Perhaps ./tests/testing-keys/id_rsa[.pub]?

We cannot generate keys or start from local keys because it's hard to inj=
ect it
into the *BSD images without ssh access (chicken-and-egg problem). Adding=
 the
local keys might be a good feature, indeed.

>=20
> > +
> > +class BaseVM(object):
> > +    GUEST_USER =3D "qemu"
> > +    GUEST_PASS =3D "qemupass"
> > +    ROOT_PASS =3D "qemupass"
> > +
> > +    # The script to run in the guest that builds QEMU
> > +    BUILD_SCRIPT =3D ""
> > +    # The guest name, to be overridden by subclasses
> > +    name =3D "#base"
> > +    def __init__(self, debug=3DFalse, vcpus=3DNone):
> > +        self._guest =3D None
> > +        self._tmpdir =3D tempfile.mkdtemp(prefix=3D"vm-test-", suffi=
x=3D".tmp", dir=3D".")
> > +        atexit.register(shutil.rmtree, self._tmpdir)
> > +
> > +        self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
> > +        open(self._ssh_key_file, "w").write(SSH_KEY)
> > +        subprocess.check_call(["chmod", "600", self._ssh_key_file])
> > +
> > +        self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rs=
a.pub")
> > +        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
>=20
> As above, I think it would be better just to keep copies of the keys in
> the tests directory rather than in the python source.
>=20
> > +
> > +        self.debug =3D debug
> > +        self._stderr =3D sys.stderr
> > +        self._devnull =3D open("/dev/null", "w")
>=20
> You can use os.devnull as a portable reference.

OK.

>=20
> > +        if self.debug:
> > +            self._stdout =3D sys.stdout
> > +        else:
> > +            self._stdout =3D self._devnull
> > +        self._args =3D [ \
> > +            "-nodefaults", "-m", "2G",
> > +            "-cpu", "host",
> > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22",
>=20
> It doesn't help that howstfwd is poorly documented. Are we trying to ma=
p
> an ephemeral port to the guests 22?

Yes, it is a new feature of usernet, you're right the documentation is mi=
ssing.

>=20
> > +            "-device", "virtio-net-pci,netdev=3Dvnet",
> > +            "-vnc", ":0,to=3D20",
>=20
> Do we need a GUI?

I'd like to keep it, it helps when you need to diagnose.

>=20
> > +            "-serial", "file:%s" % os.path.join(self._tmpdir,
> > "serial.out")]
> > +        if vcpus:
> > +            self._args +=3D ["-smp", str(vcpus)]
> > +        if os.access("/dev/kvm", os.R_OK | os.W_OK):
> > +            self._args +=3D ["-enable-kvm"]
> > +        else:
> > +            logging.info("KVM not available, not using -enable-kvm")
> > +        self._data_args =3D []
> > +
> > +    def _download_with_cache(self, url, sha256sum=3DNone):
> > +        def check_sha256sum(fname):
> > +            if not sha256sum:
> > +                return True
> > +            checksum =3D subprocess.check_output(["sha256sum", fname=
]).split()[0]
> > +            return sha256sum =3D=3D checksum
> > +
> > +        cache_dir =3D os.path.expanduser("~/.cache/qemu-vm/download"=
)
> > +        if not os.path.exists(cache_dir):
> > +            os.makedirs(cache_dir)
> > +        fname =3D os.path.join(cache_dir, hashlib.sha1(url).hexdiges=
t())
> > +        if os.path.exists(fname) and check_sha256sum(fname):
> > +            return fname
> > +        logging.debug("Downloading %s to %s...", url, fname)
> > +        subprocess.check_call(["wget", "-c", url, "-O", fname + ".do=
wnload"],
> > +                              stdout=3Dself._stdout,
> > stderr=3Dself._stderr)
>=20
> Using wget rather than doing it internally adds a utility requirement.
> Is doing a pure python urllib2 fetch too slow for this?

I think "-c" is a good feature for downloading big files.

>=20
> > +        os.rename(fname + ".download", fname)
> > +        return fname
> > +
> > +    def _ssh_do(self, user, cmd, check, interactive=3DFalse):
> > +        ssh_cmd =3D ["ssh", "-q",
> > +                   "-o", "StrictHostKeyChecking=3Dno",
> > +                   "-o", "UserKnownHostsFile=3D/dev/null",
> > +                   "-o", "ConnectTimeout=3D1",
> > +                   "-p", self.ssh_port, "-i", self._ssh_key_file]
> > +        if interactive:
> > +            ssh_cmd +=3D ['-t']
> > +        assert not isinstance(cmd, str)
> > +        ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
> > +        logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
> > +        r =3D subprocess.call(ssh_cmd,
> > +                            stdin=3Dsys.stdin if interactive else se=
lf._devnull,
> > +                            stdout=3Dsys.stdout if interactive else =
self._stdout,
> > +                            stderr=3Dsys.stderr if interactive else =
self._stderr)
> > +        if check and r !=3D 0:
> > +            raise Exception("SSH command failed: %s" % cmd)
> > +        return r
> > +
> > +    def ssh(self, *cmd):
> > +        return self._ssh_do(self.GUEST_USER, cmd, False)
> > +
> > +    def ssh_interactive(self, *cmd):
> > +        return self._ssh_do(self.GUEST_USER, cmd, False, True)
> > +
> > +    def ssh_root(self, *cmd):
> > +        return self._ssh_do("root", cmd, False)
> > +
> > +    def ssh_check(self, *cmd):
> > +        self._ssh_do(self.GUEST_USER, cmd, True)
> > +
> > +    def ssh_root_check(self, *cmd):
> > +        self._ssh_do("root", cmd, True)
> > +
> > +    def build_image(self, img):
> > +        raise NotImplementedError
> > +
> > +    def add_source_dir(self, src_dir):
> > +        name =3D "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
> > +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
> > +        logging.debug("Creating archive %s for src_dir dir: %s", tar=
file, src_dir)
> > +        subprocess.check_call(["./scripts/archive-source.sh", tarfil=
e],
> > +                              cwd=3Dsrc_dir, stdin=3Dself._devnull,
> > +                              stdout=3Dself._stdout, stderr=3Dself._=
stderr)
> > +        self._data_args +=3D ["-drive",
> > +                            "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwri=
teback,format=3Draw" % \
> > +                                    (tarfile, name),
> > +                            "-device",
> > +                            "virtio-blk,drive=3D%s,serial=3D%s,booti=
ndex=3D1" % (name, name)]
> > +
> > +    def boot(self, img, extra_args=3D[]):
> > +        args =3D self._args + [
> > +            "-device", "VGA",
>=20
> Is specifying a display device at boot time really needed (say rather
> than further up with the rest of the machine description). Do we even
> want a display given use ssh/serial for everything?

It makes debug easier, and also I find cloud-init or something in ubuntu
requires a virtual console on the display to make progress.

>=20
> > +            "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwrite=
back" % img,
> > +            "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
> > +        args +=3D self._data_args + extra_args
> > +        logging.debug("QEMU args: %s", " ".join(args))
> > +        guest =3D QEMUMachine(binary=3Dos.environ.get("QEMU", "qemu-=
system-x86_64"),
> > +                            args=3Dargs)
> > +        guest.launch()
> > +        atexit.register(self.shutdown)
> > +        self._guest =3D guest
> > +        usernet_info =3D guest.qmp("human-monitor-command",
> > +                                 command_line=3D"info usernet")
> > +        self.ssh_port =3D None
> > +        for l in usernet_info["return"].splitlines():
> > +            fields =3D l.split()
> > +            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
> > +                self.ssh_port =3D l.split()[3]
> > +        if not self.ssh_port:
> > +            raise Exception("Cannot find ssh port from 'info usernet=
':\n%s" % \
> > +                            usernet_info)
> > +
> > +    def wait_ssh(self, seconds=3D120):
> > +        starttime =3D datetime.datetime.now()
> > +        guest_up =3D False
> > +        while (datetime.datetime.now() - starttime).total_seconds() =
< seconds:
> > +            if self.ssh("exit 0") =3D=3D 0:
> > +                guest_up =3D True
> > +                break
> > +            time.sleep(1)
> > +        if not guest_up:
> > +            raise Exception("Timeout while waiting for guest ssh")
> > +
> > +    def shutdown(self):
> > +        self._guest.shutdown()
> > +
> > +    def wait(self):
> > +        self._guest.wait()
> > +
> > +    def qmp(self, *args, **kwargs):
> > +        return self._guest.qmp(*args, **kwargs)
> > +
> > +def parse_args(vm_name):
> > +    parser =3D optparse.OptionParser(description=3D"""
> > +    VM test utility.  Exit codes: 0 =3D success, 1 =3D command line =
error, 2 =3D environment initialization failed, 3 =3D test command failed=
""")
> > +    parser.add_option("--debug", "-D", action=3D"store_true",
> > +                      help=3D"enable debug output")
> > +    parser.add_option("--image", "-i", default=3D"%s.img" % vm_name,
> > +                      help=3D"image file name")
> > +    parser.add_option("--force", "-f", action=3D"store_true",
> > +                      help=3D"force build image even if image exists=
")
> > +    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessin=
g.cpu_count() / 2,
> > +                      help=3D"number of virtual CPUs")
> > +    parser.add_option("--build-image", "-b", action=3D"store_true",
> > +                      help=3D"build image")
> > +    parser.add_option("--build-qemu",
> > +                      help=3D"build QEMU from source in guest")
> > +    parser.add_option("--interactive", "-I", action=3D"store_true",
> > +                      help=3D"Interactively run command")
> > +    parser.disable_interspersed_args()
> > +    return parser.parse_args()
> > +
> > +def main(vmcls):
> > +    try:
> > +        args, argv =3D parse_args(vmcls.name)
> > +        if not argv and not args.build_qemu and not args.build_image=
:
> > +            print "Nothing to do?"
> > +            return 1
> > +        if args.debug:
> > +            logging.getLogger().setLevel(logging.DEBUG)
> > +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> > +        if args.build_image:
> > +            if os.path.exists(args.image) and not args.force:
> > +                sys.stderr.writelines(["Image file exists: %s\n" % a=
rgs.image,
> > +                                      "Use --force option to overwri=
te\n"])
> > +                return 1
> > +            return vm.build_image(args.image)
> > +        if args.build_qemu:
> > +            vm.add_source_dir(args.build_qemu)
> > +            cmd =3D [vm.BUILD_SCRIPT.format(
> > +                   configure_opts =3D " ".join(argv),
> > +                   jobs=3Dargs.jobs)]
> > +        else:
> > +            cmd =3D argv
> > +        vm.boot(args.image + ",snapshot=3Don")
>=20
> If this fails it's fairly cryptic:
>=20
> /home/alex/lsrc/qemu/qemu.git/tests/vm/openbsd  --debug   --image "test=
s/vm/openbsd.img" --build-qemu /home/alex/lsrc/qemu/qemu.git
> DEBUG:root:Creating archive ./vm-test-fxejnB.tmp/data-2de24.tar for src=
_dir dir: /home/alex/lsrc/qemu/qemu.git
> DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev user,id=3Dvne=
t,hostfwd=3D:0.0.0.0:0-:22 -device virtio-net-pci,netdev=3Dvnet -vnc :0,t=
o=3D20 -serial file:./vm-test-fxejnB.tmp/serial.out -smp 4 -enable-kvm -d=
evice VGA -drive file=3Dtests/vm/openbsd.img,snapshot=3Don,if=3Dnone,id=3D=
drive0,cache=3Dwriteback -device virtio-blk,drive=3Ddrive0,bootindex=3D0 =
-drive file=3D./vm-test-fxejnB.tmp/data-2de24.tar,if=3Dnone,id=3Ddata-2de=
24,cache=3Dwriteback,format=3Draw -device virtio-blk,drive=3Ddata-2de24,s=
erial=3Ddata-2de24,bootindex=3D1
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 260, in=
 main
>     vm.boot(args.image + ",snapshot=3Don")
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 184, in=
 boot
>     guest.launch()
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", =
line 151, in launch
>     self._post_launch()
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.py", =
line 135, in _post_launch
>     self._qmp.accept()
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py=
", line 147, in accept
>     return self.__negotiate_capabilities()
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/qmp.py=
", line 60, in __negotiate_capabilities
>     raise QMPConnectError
> QMPConnectError
>=20
> I assume QEMU failed to boot and might have given us a message that
> would be useful.

It's a separate issue of qemu.py, I didn't try to fix it here because cur=
rently
there are many patches touching that file on the list, there is a high ch=
ance of
conflict.

In your case which qemu version are you using? If not master it probably =
is
failing because of the hostfwd syntax.

>=20
>=20
> > +        vm.wait_ssh()
> > +    except Exception as e:
> > +        if isinstance(e, SystemExit) and e.code =3D=3D 0:
> > +            return 0
> > +        sys.stderr.write("Failed to prepare guest environment\n")
> > +        traceback.print_exc()
> > +        return 2
> > +
> > +    if args.interactive:
> > +        if vm.ssh_interactive(*cmd) =3D=3D 0:
> > +            return 0
> > +        vm.ssh_interactive()
> > +        return 3
> > +    else:
> > +        if vm.ssh(*cmd) !=3D 0:
> > +            return 3
>=20
>=20
> --
> Alex Benn=E9e
>=20

Thanks for the review!

Fam
