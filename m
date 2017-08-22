Received: from eggs.gnu.org ([2001:4830:134:3::10]:41459)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dk8Wp-00084G-3f
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dk8Wl-0007zp-RD
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:43:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:62167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dk8Wl-0007y0-C9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:43:27 -0400
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-4-famz@redhat.com>
	<51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8f1a5811-57bb-2471-8651-2c1260b525ed@gmx.com>
Date: Tue, 22 Aug 2017 14:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I6osnaTar9R25vDCj4HDjb9ww2RWimjaX"
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I6osnaTar9R25vDCj4HDjb9ww2RWimjaX
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <8f1a5811-57bb-2471-8651-2c1260b525ed@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tests: Add vm test lib
References: <20170822044155.2451-1-famz@redhat.com>
 <20170822044155.2451-4-famz@redhat.com>
 <51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
In-Reply-To: <51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.08.2017 13:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fam,
>=20
> On 08/22/2017 01:41 AM, Fam Zheng wrote:
>> This is the common code to implement a "VM test" to
>>
>>    1) Download and initialize a pre-defined VM that has necessary
>>    dependencies to build QEMU and SSH access.
>>
>>    2) Archive $SRC_PATH to a .tar file.
>>
>>    3) Boot the VM, and pass the source tar file to the guest.
>>
>>    4) SSH into the VM, untar the source tarball, build from the source=
=2E
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>   tests/vm/basevm.py | 278
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 278 insertions(+)
>>   create mode 100755 tests/vm/basevm.py
>>
>> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
>> new file mode 100755
>> index 0000000000..7eab737aa8
>> --- /dev/null
>> +++ b/tests/vm/basevm.py
>> @@ -0,0 +1,278 @@
>> +#!/usr/bin/env python
>> +#
>> +# VM testing base class
>> +#
>> +# Copyright (C) 2017 Red Hat Inc.
>> +#
>> +# Authors:
>> +#  Fam Zheng <famz@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
>> +# the COPYING file in the top-level directory.
>> +#
>> +
>> +import os
>> +import sys
>> +import logging
>> +import time
>> +import datetime
>> +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..",
>> "scripts"))
>> +from qemu import QEMUMachine
>> +import subprocess
>> +import hashlib
>> +import optparse
>> +import atexit
>> +import tempfile
>> +import shutil
>> +import multiprocessing
>> +import traceback
>> +
>> +SSH_KEY =3D """\
>> +-----BEGIN RSA PRIVATE KEY-----
>> +MIIEowIBAAKCAQEAopAuOlmLV6LVHdFBj8/eeOwI9CqguIJPp7eAQSZvOiB4Ag/R
>> +coEhl/RBbrV5Yc/SmSD4PTpJO/iM10RwliNjDb4a3I8q3sykRJu9c9PI/YsH8WN9
>> ++NH2NjKPtJIcKTu287IM5JYxyB6nDoOzILbTyJ1TDR/xH6qYEfBAyiblggdjcvhA
>> +RTf93QIn39F/xLypXvT1K2O9BJEsnJ8lEUvB2UXhKo/JTfSeZF8wPBeowaP9EONk
>> +7b+nuJOWHGg68Ji6wVi62tjwl2Szch6lxIhZBpnV7QNRKMfYHP6eIyF4pusazzZq
>> +Telsq6xI2ghecWLzb/MF5A+rklsGx2FNuJSAJwIDAQABAoIBAHHi4o/8VZNivz0x
>> +cWXn8erzKV6tUoWQvW85Lj/2RiwJvSlsnYZDkx5af1CpEE2HA/pFT8PNRqsd+MWC
>> +7AEy710cVsM4BYerBFYQaYxwzblaoojo88LSjVPw3h5Z0iLM8+IMVd36nwuc9dpE
>> +R8TecMZ1+U4Tl6BgqkK+9xToZRdPKdjS8L5MoFhGN+xY0vRbbJbGaV9Q0IHxLBkB
>> +rEBV7T1mUynneCHRUQlJQEwJmKpT8MH3IjsUXlG5YvnuuvcQJSNTaW2iDLxuOKp8
>> +cxW8+qL88zpb1D5dppoIu6rlrugN0azSq70ruFJQPc/A8GQrDKoGgRQiagxNY3u+
>> +vHZzXlECgYEA0dKO3gfkSxsDBb94sQwskMScqLhcKhztEa8kPxTx6Yqh+x8/scx3
>> +XhJyOt669P8U1v8a/2Al+s81oZzzfQSzO1Q7gEwSrgBcRMSIoRBUw9uYcy02ngb/
>> +j/ng3DGivfJztjjiSJwb46FHkJ2JR8mF2UisC6UMXk3NgFY/3vWQx78CgYEAxlcG
>> +T3hfSWSmTgKRczMJuHQOX9ULfTBIqwP5VqkkkiavzigGRirzb5lgnmuTSPTpF0LB
>> +XVPjR2M4q+7gzP0Dca3pocrvLEoxjwIKnCbYKnyyvnUoE9qHv4Kr+vDbgWpa2LXG
>> +JbLmE7tgTCIp20jOPPT4xuDvlbzQZBJ5qCQSoZkCgYEAgrotSSihlCnAOFSTXbu4
>> +CHp3IKe8xIBBNENq0eK61kcJpOxTQvOha3sSsJsU4JAM6+cFaxb8kseHIqonCj1j
>> +bhOM/uJmwQJ4el/4wGDsbxriYOBKpyq1D38gGhDS1IW6kk3erl6VAb36WJ/OaGum
>> +eTpN9vNeQWM4Jj2WjdNx4QECgYAwTdd6mU1TmZCrJRL5ZG+0nYc2rbMrnQvFoqUi
>> +BvWiJovggHzur90zy73tNzPaq9Ls2FQxf5G1vCN8NCRJqEEjeYCR59OSDMu/EXc2
>> +CnvQ9SevHOdS1oEDEjcCWZCMFzPi3XpRih1gptzQDe31uuiHjf3cqcGPzTlPdfRt
>> +D8P92QKBgC4UaBvIRwREVJsdZzpIzm224Bpe8LOmA7DeTnjlT0b3lkGiBJ36/Q0p
>> +VhYh/6cjX4/iuIs7gJbGon7B+YPB8scmOi3fj0+nkJAONue1mMfBNkba6qQTc6Y2
>> +5mEKw2/O7/JpND7ucU3OK9plcw/qnrWDgHxl0Iz95+OzUIIagxne
>> +-----END RSA PRIVATE KEY-----
>> +"""
>> +SSH_PUB_KEY =3D """\
>> +ssh-rsa
>> AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0KqC4gk+nt4BBJm=
86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm71z08j9iwfxY33=
40fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2Ny+EBFN/3dAiff=
0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4k5YcaDrwmLrBW=
Lra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xYvNv8wXkD6uSWw=
bHYU24lIAn
>> qemu-vm-key
>> +"""
>> +
>> +class BaseVM(object):
>> +    GUEST_USER =3D "qemu"
>> +    GUEST_PASS =3D "qemupass"
>> +    ROOT_PASS =3D "qemupass"
>> +
>> +    # The script to run in the guest that builds QEMU
>> +    BUILD_SCRIPT =3D ""
>> +    # The guest name, to be overridden by subclasses
>> +    name =3D "#base"
>> +    def __init__(self, debug=3DFalse, vcpus=3DNone):
>> +        self._guest =3D None
>> +        self._tmpdir =3D tempfile.mkdtemp(prefix=3D"qemu-vm-")
>> +        atexit.register(shutil.rmtree, self._tmpdir)
>> +
>> +        self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
>> +        open(self._ssh_key_file, "w").write(SSH_KEY)
>> +        subprocess.check_call(["chmod", "600", self._ssh_key_file])
>> +
>> +        self._ssh_pub_key_file =3D os.path.join(self._tmpdir,
>> "id_rsa.pub")
>> +        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
>> +
>> +        self.debug =3D debug
>> +        self._stderr =3D sys.stderr
>> +        self._devnull =3D open("/dev/null", "w")
>> +        if self.debug:
>> +            self._stdout =3D sys.stdout
>> +        else:
>> +            self._stdout =3D self._devnull
>> +        self._args =3D [ \
>> +            "-nodefaults", "-enable-kvm", "-m", "2G",

Can we make -enable-kvm optional? This is currently Linux specific.

>> +            "-cpu", "host",
>> +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22",
>> +            "-device", "virtio-net-pci,netdev=3Dvnet",
>> +            "-vnc", ":0,to=3D20",
>> +            "-serial", "file:%s" % os.path.join(self._tmpdir,
>> "serial.out")]
>> +        if vcpus:
>> +            self._args +=3D ["-smp", str(vcpus)]
>> +
>> +        self._data_args =3D []
>> +
>> +    def _download_with_cache(self, url, sha256sum=3DNone):
>> +        def check_sha256sum(fname):
>> +            if not sha256sum:
>> +                return True
>> +            checksum =3D subprocess.check_output(["sha256sum",
>> fname]).split()[0]
>> +            return sha256sum =3D=3D checksum
>> +
>> +        cache_dir =3D os.path.expanduser("~/.cache/qemu-vm/download")=

>> +        if not os.path.exists(cache_dir):
>> +            os.makedirs(cache_dir)
>> +        fname =3D os.path.join(cache_dir, hashlib.sha1(url).hexdigest=
())
>> +        if os.path.exists(fname) and check_sha256sum(fname):
>> +            return fname
>> +        logging.debug("Downloading %s to %s...", url, fname)
>> +        subprocess.check_call(["wget", "-c", url, "-O", fname +
>> ".download"],
>> +                              stdout=3Dself._stdout, stderr=3Dself._s=
tderr)
>> +        os.rename(fname + ".download", fname)
>> +        return fname
>> +
>> +    def _ssh_do(self, user, cmd, check, interactive=3DFalse):
>> +        ssh_cmd =3D ["ssh", "-q",
>> +                   "-o", "StrictHostKeyChecking=3Dno",
>> +                   "-o", "UserKnownHostsFile=3D/dev/null",
>> +                   "-o", "ConnectTimeout=3D1",
>> +                   "-p", self.ssh_port, "-i", self._ssh_key_file]
>> +        if interactive:
>> +            ssh_cmd +=3D ['-t']
>> +        assert not isinstance(cmd, str)
>> +        ssh_cmd +=3D ["%s@127.0.0.1" % user] + list(cmd)
>> +        logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
>> +        r =3D subprocess.call(ssh_cmd,
>> +                            stdin=3Dsys.stdin if interactive else
>> self._devnull,
>> +                            stdout=3Dsys.stdout if interactive else
>> self._stdout,
>> +                            stderr=3Dsys.stderr if interactive else
>> self._stderr)
>> +        if check and r !=3D 0:
>> +            raise Exception("SSH command failed: %s" % cmd)
>> +        return r
>> +
>> +    def ssh(self, *cmd):
>> +        return self._ssh_do(self.GUEST_USER, cmd, False)
>> +
>> +    def ssh_interactive(self, *cmd):
>> +        return self._ssh_do(self.GUEST_USER, cmd, False, True)
>> +
>> +    def ssh_root(self, *cmd):
>> +        return self._ssh_do("root", cmd, False)
>> +
>> +    def ssh_check(self, *cmd):
>> +        self._ssh_do(self.GUEST_USER, cmd, True)
>> +
>> +    def ssh_root_check(self, *cmd):
>> +        self._ssh_do("root", cmd, True)
>> +
>> +    def build_image(self, img):
>> +        raise NotImplementedError
>> +
>> +    def add_source_dir(self, data_dir):
>> +        name =3D "data-" + hashlib.sha1(data_dir).hexdigest()[:5]
>> +        tarfile =3D os.path.join(self._tmpdir, name + ".tar")
>> +        logging.debug("Creating archive %s for data dir: %s",
>> tarfile, data_dir)
>> +        subprocess.check_call(["tar", "--exclude-vcs",
>=20
> --exclude-vcs-ignores will process .gitignore,
> you can also list with 'git ls-files',
> or generate tarball with scripts/make-release
>=20

It might not be a problem here, but --exclude-vcs isn't portable. My
basesystem (NetBSD 8.99.1) version from bsdtar (libarchive) 3.3.2dev
does not support it. The solution to this is to have a fallback to gtar
or make the tar call portable.

>> +                               "--exclude=3Dtests/vm/*.img",
>> +                               "--exclude=3Dtests/vm/*.img.*",
>> +                               "--exclude=3D*.d",
>> +                               "--exclude=3D*.o",
>> +                               "--exclude=3Ddocker-src.*",
>> +                               "-cf", tarfile, '.'], cwd=3Ddata_dir,
>> +                              stdin=3Dself._devnull, stdout=3Dself._s=
tdout)
>> +        self._data_args +=3D ["-drive",
>> +                          =20
>> "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwriteback,format=3Draw" % \
>> +                                    (tarfile, name),
>> +                            "-device",
>> +                          =20
>> "virtio-blk,drive=3D%s,serial=3D%s,bootindex=3D1" % (name, name)]
>=20
> what about mounting readonly via '-device virtio-9p-pci' (not using
> tarball)?
>=20
>> +
>> +    def boot(self, img, extra_args=3D[]):
>> +        args =3D self._args + [
>> +            "-device", "VGA",
>> +            "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwriteb=
ack" % img,
>> +            "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
>> +        args +=3D self._data_args + extra_args
>> +        logging.debug("QEMU args: %s", " ".join(args))
>> +        guest =3D QEMUMachine(binary=3Dos.environ.get("QEMU",
>> "qemu-system-x86_64"),
>> +                            args=3Dargs)
>> +        guest.launch()
>> +        atexit.register(self.shutdown)
>> +        self._guest =3D guest
>> +        usernet_info =3D guest.qmp("human-monitor-command",
>> +                                 command_line=3D"info usernet")
>> +        self.ssh_port =3D None
>> +        for l in usernet_info["return"].splitlines():
>> +            fields =3D l.split()
>> +            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
>> +                self.ssh_port =3D l.split()[3]
>> +        if not self.ssh_port:
>> +            raise Exception("Cannot find ssh port from 'info
>> usernet':\n%s" % \
>> +                            usernet_info)
>> +
>> +    def wait_ssh(self, seconds=3D120):
>> +        starttime =3D datetime.datetime.now()
>> +        guest_up =3D False
>> +        while (datetime.datetime.now() - starttime).total_seconds() <=

>> seconds:
>> +            if self.ssh("exit 0") =3D=3D 0:
>> +                guest_up =3D True
>> +                break
>> +            time.sleep(1)
>> +        if not guest_up:
>> +            raise TimeoutError("Timeout while waiting for guest ssh")=

>> +
>> +    def shutdown(self):
>> +        self._guest.shutdown()
>> +
>> +    def wait(self):
>> +        self._guest.wait()
>> +
>> +    def qmp(self, *args, **kwargs):
>> +        return self._guest.qmp(*args, **kwargs)
>> +
>> +def parse_args(vm_name):
>> +    parser =3D optparse.OptionParser(description=3D"""
>> +    VM test utility.  Exit codes: 0 =3D success, 1 =3D command line
>> error, 2 =3D environment initialization failed, 3 =3D test command fai=
led""")
>> +    parser.add_option("--debug", "-D", action=3D"store_true",
>> +                      help=3D"enable debug output")
>> +    parser.add_option("--image", "-i", default=3D"%s.img" % vm_name,
>> +                      help=3D"image file name")
>> +    parser.add_option("--force", "-f", action=3D"store_true",
>> +                      help=3D"force build image even if image exists"=
)
>> +    parser.add_option("--jobs", type=3Dint,
>> default=3Dmultiprocessing.cpu_count(),
>> +                      help=3D"number of virtual CPUs")
>> +    parser.add_option("--build-image", "-b", action=3D"store_true",
>> +                      help=3D"build image")
>> +    parser.add_option("--build-qemu",
>> +                      help=3D"build QEMU from source in guest")
>> +    parser.add_option("--interactive", "-I", action=3D"store_true",
>> +                      help=3D"Interactively run command")
>> +    parser.disable_interspersed_args()
>> +    return parser.parse_args()
>> +
>> +def main(vmcls):
>> +    try:
>> +        args, argv =3D parse_args(vmcls.name)
>> +        if not argv and not args.build_qemu and not args.build_image:=

>> +            print "Nothing to do?"
>> +            return 1
>> +        if args.debug:
>> +            logging.getLogger().setLevel(logging.DEBUG)
>> +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
>> +        if args.build_image:
>> +            if os.path.exists(args.image) and not args.force:
>> +                sys.stderr.writelines(["Image file exists: %s\n" %
>> args.image,
>> +                                      "Use --force option to
>> overwrite\n"])
>> +                return 1
>> +            return vm.build_image(args.image)
>> +        if args.build_qemu:
>> +            vm.add_source_dir(args.build_qemu)
>> +            cmd =3D [vm.BUILD_SCRIPT.format(
>> +                   configure_opts =3D " ".join(argv),
>> +                   jobs=3Dargs.jobs)]
>> +        else:
>> +            cmd =3D argv
>> +        vm.boot(args.image + ",snapshot=3Don")
>> +        vm.wait_ssh()
>> +    except Exception as e:
>> +        if isinstance(e, SystemExit) and e.code =3D=3D 0:
>> +            return 0
>> +        sys.stderr.write("Failed to prepare guest environment\n")
>> +        traceback.print_exc()
>> +        return 2
>> +
>> +    if args.interactive:
>> +        if vm.ssh_interactive(*cmd) =3D=3D 0:
>> +            return 0
>> +        vm.ssh_interactive()
>> +        return 3
>> +    else:
>> +        if vm.ssh(*cmd) !=3D 0:
>> +            return 3
>>
>=20



--I6osnaTar9R25vDCj4HDjb9ww2RWimjaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnCSeAAoJEEuzCOmwLnZsbuIP/RnWrcf3gyPHfaitYn9D6VTo
qTML0XzxUukVf/gguzHhfFvcsBJUyaBDBwkXIFHVpPVvM1hhzR28ImSHzYRJ624z
DJqCVMf8t+bVGqcadE/v/ur3tWSmypbWcg2OkC2RTGJjIFl+q3izzqs4rAI7Qn/7
s+TEgzGYQHOb5nI9KXe22jVaT5wWRarYeo30ZyM3BE7UHDDWdDHrCxlLXVC5c6Wy
S0dfW0rTbOD5wFHyHPq5Yuz8t/drDv/fcfY4qcN3QUw8IBNYfrvqfQ8VGWtRbiDB
MwHMhruDHg0yERTuPn1PZSjdpA2LJdq3XWvcAAKVM3uGlkrJF2wor35b7HJ68WDO
zAHsT5+4zISvJS/NX72ckp8Al5mgNohpFKej61Cn+Lc4c/KDDj1QyxCdA/5mrzbR
zA0J5mFjJ/rYq109ffdOCpdTxzgCOQVf+Pb6TyUCEdPP83wFBBYFFSHT15h68ZJ+
V/pFC2z3XD6zfcbevAC4hG8fYiVm+h00hTUlrX32dLEBFaYl0lyKb9P/IvBcG5rm
Qt+/GQ4w151FfYHUKH4P54fV4I7D/w7pfLLnlN7t8ovvLfbbVFlWjFeHdzoHaQ9Z
yyYPPcHVj5waq4Tbsw3gTRMlM7yLX2QBjq18aYMgmqth2180FQQFqTtE+ov4/9J+
ft7hGGjyDHwfAEO+lZXJ
=+RMR
-----END PGP SIGNATURE-----

--I6osnaTar9R25vDCj4HDjb9ww2RWimjaX--
