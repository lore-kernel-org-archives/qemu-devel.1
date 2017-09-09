Received: from eggs.gnu.org ([2001:4830:134:3::10]:59763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqX6W-0006x5-AW
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 00:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqX6R-0005fv-Cr
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 00:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqX6Q-0005fK-QN
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 00:10:43 -0400
Date: Sat, 9 Sep 2017 12:10:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170909041036.GF18677@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-5-famz@redhat.com>
	<87tw0dgqpv.fsf@linaro.org> <20170908232950.GD18677@lemon.lan>
	<6e624d60-c8ed-54f5-a2ca-9caf9d9c489f@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6e624d60-c8ed-54f5-a2ca-9caf9d9c489f@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com

On Fri, 09/08 22:25, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam, Alex,
>=20
> > >=20
> > > If this fails it's fairly cryptic:
> > >=20
> > > /home/alex/lsrc/qemu/qemu.git/tests/vm/openbsd  --debug   --image "=
tests/vm/openbsd.img" --build-qemu /home/alex/lsrc/qemu/qemu.git
> > > DEBUG:root:Creating archive ./vm-test-fxejnB.tmp/data-2de24.tar for=
 src_dir dir: /home/alex/lsrc/qemu/qemu.git
> > > DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev user,id=3D=
vnet,hostfwd=3D:0.0.0.0:0-:22 -device virtio-net-pci,netdev=3Dvnet -vnc :=
0,to=3D20 -serial file:./vm-test-fxejnB.tmp/serial.out -smp 4 -enable-kvm=
 -device VGA -drive file=3Dtests/vm/openbsd.img,snapshot=3Don,if=3Dnone,i=
d=3Ddrive0,cache=3Dwriteback -device virtio-blk,drive=3Ddrive0,bootindex=3D=
0 -drive file=3D./vm-test-fxejnB.tmp/data-2de24.tar,if=3Dnone,id=3Ddata-2=
de24,cache=3Dwriteback,format=3Draw -device virtio-blk,drive=3Ddata-2de24=
,serial=3Ddata-2de24,bootindex=3D1
> > > Failed to prepare guest environment
> > > Traceback (most recent call last):
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 26=
0, in main
> > >      vm.boot(args.image + ",snapshot=3Don")
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 18=
4, in boot
> > >      guest.launch()
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.=
py", line 151, in launch
> > >      self._post_launch()
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qemu.=
py", line 135, in _post_launch
> > >      self._qmp.accept()
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/q=
mp.py", line 147, in accept
> > >      return self.__negotiate_capabilities()
> > >    File "/home/alex/lsrc/qemu/qemu.git/tests/vm/../../scripts/qmp/q=
mp.py", line 60, in __negotiate_capabilities
> > >      raise QMPConnectError
> > > QMPConnectError
> > >=20
> > > I assume QEMU failed to boot and might have given us a message that
> > > would be useful.
> >=20
> > It's a separate issue of qemu.py, I didn't try to fix it here because=
 currently
> > there are many patches touching that file on the list, there is a hig=
h chance of
> > conflict.
> >=20
> > In your case which qemu version are you using? If not master it proba=
bly is
> > failing because of the hostfwd syntax.
>=20
> very likely.
>=20
> one simple way to handle this could be having this script catching
> QMPConnectError and restart with older command line format,

The error reporting definitely needs improving (like saying which version=
 of
QEMU is needed), but I'm not sure about adding fallbacks here and there a=
re
worth the effort, see below.

>=20
> but I prefer starting QEMU binding a QMP socket, then initialize the op=
tions
> via QMP packets, this should be more portable, this is cleaner.

This is just different, but not necessarily cleaner. When you want to man=
ually
start such a VM, it will be very painful. Nor does "ps | grep | less" etc=
 works.
Command line is simpler and more user friendly in this respect.

>=20
> also I think we don't want to run those images with bleeding edge
> qemu-system, we want a stable QEMU to be able to compile the bleeding e=
dge
> codebase inside a working VM.

You are right we are not testing that bleeding edge qemus can run the VM,=
 but we
need the features of the bleeding edge qemu to write simpler test code. I=
 think
this is reasonable for both CI and developers.  So unless there is an
alternative way to do the hostfwd port allocation, I think we can live wi=
th this
requirement.

>=20
> another note: currently when a VM fails, it closes and what I've left i=
s
> only the last stderr.
> I'd rather see 2 modes:
> - run from some CI when only the final return value is useful, the stde=
rr
> being extra value.
> - in user-dev mode if the build fails I'd like to have access to the
> terminal, eventually some msg like "this build failed, you can connect =
to
> this VM copy/pasting the following ssh command: ... or hit ^C to gracef=
ully
> shutdown the VM"
> But in this mode I'd rather mount my current workdir via a read-writabl=
e
> netshare rather than a one-time temporary read-only tarball, so I could
> modify my repo and just run 'make' inside the VM.

Like the docker tests, this is what DEBUG=3D1 is for.

Fam
