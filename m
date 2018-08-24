Received: from eggs.gnu.org ([2001:4830:134:3::10]:52891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft7pT-00076G-AL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft7pP-0002iU-SV
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ft7pP-0002iA-KT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:52:23 -0400
Date: Fri, 24 Aug 2018 16:52:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824085220.GF31581@lemon.usersys.redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<20180824082237.GA3430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180824082237.GA3430@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, 08/24 09:22, Daniel P. Berrang=E9 wrote:
> On Fri, Aug 24, 2018 at 09:21:26AM +0800, Fam Zheng wrote:
> > Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
> > include SDL2.
> >=20
> > One limitation of this patch is that we need a temporary HTTP server =
on
> > host 80 port for auto_install, because slirp cannot do guest forward =
on
> > "host addr".
>=20
> That's a pretty big limitation, as port 80 requires root privileges,
> and that's a pretty strict no for automated testing IMHO.
>=20
> Why does it have to be port 80 in particular - is it not possible
> to use 8080 or even better, detect a random free port ?

OpenBSD autoinstall[1] is hardcoded to fetch from port 80. Maybe we can i=
nstead
persuade it into fetching from a different http server than 10.0.2.2. To =
do that
we'd need to implement a new slirp option for either "option tftp-server-=
name"
or "next-server" according to the manpage. I'll have to experiment with i=
t to
see if it will work.

Or, do you think there are better options to configure the VM network to =
serve
the file?

(Another possibility is to inject the install.conf file into bsd.rd (ramd=
isk
embedded in ELF), but the tools seem OpenBSD specific.)

[1] https://man.openbsd.org/autoinstall

>=20
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/basevm.py | 28 ++++++++++++++--
> >  tests/vm/openbsd   | 81 ++++++++++++++++++++++++++++++++++++++++----=
--
> >  2 files changed, 96 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index d7149dea7d..4080039e66 100755
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -65,8 +65,6 @@ class BaseVM(object):
> >              self._stdout =3D self._devnull
> >          self._args =3D [ \
> >              "-nodefaults", "-m", "4G",
> > -            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22",
> > -            "-device", "virtio-net-pci,netdev=3Dvnet",
> >              "-vnc", "127.0.0.1:0,to=3D20",
> >              "-serial", "file:%s" % os.path.join(self._tmpdir, "seria=
l.out")]
> >          if vcpus:
> > @@ -145,8 +143,10 @@ class BaseVM(object):
> >                              "-device",
> >                              "virtio-blk,drive=3D%s,serial=3D%s,booti=
ndex=3D1" % (name, name)]
> > =20
> > -    def boot(self, img, extra_args=3D[]):
> > +    def boot(self, img, extra_args=3D[], extra_usernet_args=3D""):
> >          args =3D self._args + [
> > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22" +=
 extra_usernet_args,
> > +            "-device", "virtio-net-pci,netdev=3Dvnet",
> >              "-device", "VGA",
> >              "-drive", "file=3D%s,if=3Dnone,id=3Ddrive0,cache=3Dwrite=
back" % img,
> >              "-device", "virtio-blk,drive=3Ddrive0,bootindex=3D0"]
> > @@ -196,6 +196,28 @@ class BaseVM(object):
> >      def qmp(self, *args, **kwargs):
> >          return self._guest.qmp(*args, **kwargs)
> > =20
> > +    def start_http_server(self, workdir, ports=3Drange(8010, 8020), =
sudo=3DFalse):
> > +        p =3D None
> > +        token =3D "%d-%d" % (os.getpid(), time.time())
> > +        with open(os.path.join(workdir, token), "w") as f:
> > +            f.write("# QEMU VM testing HTTP server token file #")
> > +            f.flush()
> > +        for port in ports:
> > +            cmd =3D ["python3", "-m", "http.server", str(port)]
> > +            if sudo:
> > +                cmd =3D ["sudo", "-n"] + cmd
> > +            p =3D subprocess.Popen(cmd, cwd=3Dworkdir)
> > +            for retry in range(5):
> > +                if p.poll() !=3D None:
> > +                    break
> > +                if subprocess.call("curl http://127.0.0.1:%d/%s &>/d=
ev/null" % \
> > +                        (port, token),
> > +                                   shell=3DTrue) =3D=3D 0:
> > +                    atexit.register(p.terminate)
> > +                    return port
> > +                time.sleep(0.3)
> > +        raise IOError("Failed to start HTTP server")
> > +
> >  def parse_args(vm_name):
> >      parser =3D optparse.OptionParser(
> >          description=3D"VM test utility.  Exit codes: "
> > diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> > index 52500ee52b..7e118572a9 100755
> > --- a/tests/vm/openbsd
> > +++ b/tests/vm/openbsd
> > @@ -14,6 +14,9 @@
> >  import os
> >  import sys
> >  import subprocess
> > +import time
> > +import atexit
> > +import tempfile
> >  import basevm
> > =20
> >  class OpenBSDVM(basevm.BaseVM):
> > @@ -23,22 +26,80 @@ class OpenBSDVM(basevm.BaseVM):
> >          rm -rf /var/tmp/qemu-test.*
> >          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >          tar -xf /dev/rsd1c;
> > -        ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --pyt=
hon=3Dpython2.7 {configure_opts};
> > +        ./configure {configure_opts};
> >          gmake --output-sync -j{jobs} {verbose};
> >          # XXX: "gmake check" seems to always hang or fail
> >          #gmake --output-sync -j{jobs} check {verbose};
> >      """
> > =20
> > +    def _install_os(self, img):
> > +        tmpdir =3D tempfile.mkdtemp()
> > +        pxeboot =3D self._download_with_cache("https://fastly.cdn.op=
enbsd.org/pub/OpenBSD/6.3/amd64/pxeboot",
> > +                sha256sum=3D"60029919798f48ea40ecb123adfed6217f099d5=
ed9cd1a6c7de5b544d7b7b0f6")
> > +        bsd_rd =3D self._download_with_cache("https://fastly.cdn.ope=
nbsd.org/pub/OpenBSD/6.3/amd64/bsd.rd",
> > +                sha256sum=3D"1c0adb43a02ae3aee512bcf0829dac0ccb2e4d6=
14b161049af7ce530e5da2dfc")
> > +        install =3D self._download_with_cache("https://fastly.cdn.op=
enbsd.org/pub/OpenBSD/6.3/amd64/install63.iso",
> > +                sha256sum=3D'ee775405dd7926975befbc3fef23de8c4b5a726=
c3b5075e4848fcd3a2a712ea8')
> > +        subprocess.check_call(["qemu-img", "create", img, "32G"])
> > +        subprocess.check_call(["cp", pxeboot, os.path.join(tmpdir, "=
auto_install")])
> > +        subprocess.check_call(["cp", bsd_rd, os.path.join(tmpdir, "b=
sd")])
> > +
> > +        self._gen_install_conf(tmpdir)
> > +        try:
> > +            self.start_http_server(tmpdir, ports=3D[80], sudo=3DTrue=
)
> > +        except Exception:
> > +            sys.stdout.write("Cannot open HTTP server on port 80. Ma=
ybe use sudo?\n")
> > +            sys.exit(1)
> > +        # BOOTP filename being auto_install makes sure OpenBSD insta=
ller
> > +        # not prompt for "auto install mode"
> > +        tftp_args =3D ",tftp=3D%s,bootfile=3D/auto_install" % tmpdir
> > +        self.boot(img,
> > +                  extra_args=3D["-boot", "once=3Dn", "-no-reboot",
> > +                              "-cdrom", install],
> > +                  extra_usernet_args=3Dtftp_args)
> > +        self.wait()
> > +
> > +    def _gen_install_conf(self, tmpdir):
> > +        contents =3D """
> > +System hostname =3D qemu-openbsd
> > +Password for root =3D qemupass
> > +Public ssh key for root =3D {pub_key}
> > +Allow root ssh login =3D yes
> > +Network interfaces =3D vio0
> > +IPv4 address for vio0 =3D dhcp
> > +Setup a user =3D qemu
> > +Password for user =3D qemupass
> > +Public ssh key for user =3D {pub_key}
> > +What timezone are you in =3D US/Eastern
> > +Server =3D fastly.cdn.openbsd.org
> > +Use http =3D yes
> > +Default IPv4 route =3D 10.0.2.2
> > +Location of sets =3D cd0
> > +Set name(s) =3D all
> > +Continue without verification =3D yes
> > +""".format(pub_key=3Dbasevm.SSH_PUB_KEY)
> > +        with open(os.path.join(tmpdir, "install.conf"), "w") as f:
> > +            f.write(contents)
> > +
> >      def build_image(self, img):
> > -        cimg =3D self._download_with_cache("http://download.patchew.=
org/openbsd-6.1-amd64.img.xz",
> > -                sha256sum=3D'8c6cedc483e602cfee5e04f0406c64eb9913849=
5e8ca580bc0293bcf0640c1bf')
> > -        img_tmp_xz =3D img + ".tmp.xz"
> > -        img_tmp =3D img + ".tmp"
> > -        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
> > -        subprocess.check_call(["xz", "-df", img_tmp_xz])
> > -        if os.path.exists(img):
> > -            os.remove(img)
> > -        os.rename(img_tmp, img)
> > +
> > +        self._install_os(img + ".tmp")
> > +
> > +        self.boot(img + ".tmp")
> > +        self.wait_ssh()
> > +
> > +        self.ssh_root("usermod -G operator qemu")
> > +        self.ssh_root("echo https://fastly.cdn.openbsd.org/pub/OpenB=
SD > /etc/installurl")
> > +        for pkg in ["git", "gmake", "glib2", "bison", "sdl2"]:
> > +            self.ssh_root("pkg_add " + pkg)
> > +        self.ssh_root("ln -sf /usr/local/bin/python2.7 /usr/local/bi=
n/python")
> > +        self.ssh_root("ln -sf /usr/local/bin/python2.7-2to3 /usr/loc=
al/bin/2to3")
> > +        self.ssh_root("ln -sf /usr/local/bin/python2.7-config /usr/l=
ocal/bin/python-config")
> > +        self.ssh_root("ln -sf /usr/local/bin/pydoc2.7 /usr/local/bin=
/pydoc")
> > +        self.ssh_root("shutdown -p now")
> > +        self.wait()
> > +
> > +        subprocess.check_call(["mv", img + ".tmp", img])
> > =20
> >  if __name__ =3D=3D "__main__":
> >      sys.exit(basevm.main(OpenBSDVM))
> > --=20
> > 2.17.1
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
