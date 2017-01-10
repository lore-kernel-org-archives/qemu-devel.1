Received: from eggs.gnu.org ([2001:4830:134:3::10]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cR1Hl-0001Ne-6E
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cR1Hh-0007IC-32
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cR1Hg-0007Gm-QW
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:36:37 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0F538553F
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:36:36 +0000 (UTC)
Date: Tue, 10 Jan 2017 18:36:30 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170110183630.GA6628@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<20170110165105.GR27720@redhat.com>
	<80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 10, 2017 at 06:45:23PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 10/01/2017 17:51, Daniel P. Berrange wrote:
> > It doesn't work with builddir !=3D srcdir builds, because -I. is resolv=
ed
> > to the srcdir, but the trace.h is in builddir.
>=20
> This is a bug then.  The toplevel builddir (or for that matter srcdir)
> is not meant to be in the search path: only the toplevel include/, the
> subdirectory builddir, and the subdirectory srcdir.

So what's happening is this...

During build of, for example, hw/scsi/esp-pci.o we have this
explicit include search path passed to GCC:

-I/home/berrange/src/virt/qemu/tcg
-I/home/berrange/src/virt/qemu/tcg/i386
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu-build/linux-headers
-I.
-I/home/berrange/src/virt/qemu
-I/home/berrange/src/virt/qemu/include
-I/home/berrange/src/virt/qemu/hw/scsi
-Ihw/scsi

Here -I. refers to the $BUILDDIR, since although the source file is in
hw/scsi/, the compiler is invoked from $BUILDDIR as its working directory.=
=20

The compiler also has an implicit search dir which is the directory where
the source file being compiled lives, and that is searched first AFAICT.

So when doing non-vpath build:

   srcdir=3D/home/berrange/src/virt/qemu
 builddir=3D/home/berrange/src/virt/qemu

we have this effective search order:

-I/home/berrange/src/virt/qemu/hw/scsi
-I/home/berrange/src/virt/qemu/tcg
-I/home/berrange/src/virt/qemu/tcg/i386
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu
-I/home/berrange/src/virt/qemu
-I/home/berrange/src/virt/qemu/include
-I/home/berrange/src/virt/qemu/hw/scsi
-I/home/berrange/src/virt/qemu/hw/scsi


Thus, #include "trace.h" picks up $builddir/hw/scsi/trace.h correctly.

5782  execve("/usr/bin/as", ["as", "-I", "/home/berrange/src/virt/qemu/tcg"=
, "-I", "/home/berrange/src/virt/qemu/tcg/i386", "-I", "/home/berrange/src/=
virt/qemu/linux-headers", "-I", "/home/berrange/src/virt/qemu/linux-headers=
", "-I", ".", "-I", "/home/berrange/src/virt/qemu", "-I", "/home/berrange/s=
rc/virt/qemu/include", "-I", "hw/scsi", "-I", "hw/scsi", "-I", "/usr/includ=
e/pixman-1", "-I", "/usr/include/glib-2.0", "-I", "/usr/lib64/glib-2.0/incl=
ude", "-I", "/usr/include/p11-kit-1", "-I", "/usr/include/libpng16", "-I", =
"/usr/include/spice-server", "-I", "/usr/include/cacard", "-I", "/usr/inclu=
de/nss3", "-I", "/usr/include/nspr4", "-I", "/usr/include/glib-2.0", "-I", =
"/usr/lib64/glib-2.0/include", "-I", "/usr/include/pixman-1", "-I", "/usr/i=
nclude/spice-1", "-I", "/usr/include/cacard", "-I", "/usr/include/nss3", "-=
I", "/usr/include/nspr4", "-I", "/usr/include/glib-2.0", "-I", "/usr/lib64/=
glib-2.0/include", "-I", "/usr/include/libusb-1.0", "-I", "/home/berrange/s=
rc/virt/qemu/tests", "--64", "-o", "hw/scsi/esp-pci.o", "/tmp/cccr6Zf8.s"],=
 [/* 63 vars */] <unfinished ...>

=2E..

5781  open("hw/scsi/trace.h", O_RDONLY|O_NOCTTY) =3D 14


but when doing a vpath build

   srcdir=3D/home/berrange/src/virt/qemu
 builddir=3D/home/berrange/src/virt/qemu-build

we have this effective search order:


-I/home/berrange/src/virt/qemu/hw/scsi
-I/home/berrange/src/virt/qemu/tcg
-I/home/berrange/src/virt/qemu/tcg/i386
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu-build/linux-headers
-I/home/berrange/src/virt/qemu-build
-I/home/berrange/src/virt/qemu
-I/home/berrange/src/virt/qemu/include
-I/home/berrange/src/virt/qemu/hw/scsi
-I/home/berrange/src/virt/qemu-build/hw/scsi

Thus #include "trace.h" picks up $builddir/trace.h incorrectly.

3138  execve("/usr/libexec/gcc/x86_64-redhat-linux/6.2.1/cc1", ["/usr/libex=
ec/gcc/x86_64-redhat-linux/6.2.1/cc1", "-quiet", "-I", "/home/berrange/src/=
virt/qemu/tcg", "-I", "/home/berrange/src/virt/qemu/tcg/i386", "-I", "/home=
/berrange/src/virt/qemu/linux-headers", "-I", "/home/berrange/src/virt/qemu=
-build/linux-headers", "-I", ".", "-I", "/home/berrange/src/virt/qemu", "-I=
", "/home/berrange/src/virt/qemu/include", "-I", "/home/berrange/src/virt/q=
emu/hw/scsi", "-I", "hw/scsi", "-I", "/usr/include/pixman-1", "-I", "/usr/i=
nclude/glib-2.0", "-I", "/usr/lib64/glib-2.0/include", "-I", "/usr/include/=
p11-kit-1", "-I", "/usr/include/libpng16", "-I", "/usr/include/spice-server=
", "-I", "/usr/include/cacard", "-I", "/usr/include/nss3", "-I", "/usr/incl=
ude/nspr4", "-I", "/usr/include/glib-2.0", "-I", "/usr/lib64/glib-2.0/inclu=
de", "-I", "/usr/include/pixman-1", "-I", "/usr/include/spice-1", "-I", "/u=
sr/include/cacard", "-I", "/usr/include/nss3", "-I", "/usr/include/nspr4", =
"-I", "/usr/include/glib-2.0", "-I", "/usr/lib64/glib-2.0/include", "-I", "=
/usr/include/libusb-1.0", "-I", "/home/berrange/src/virt/qemu/tests", "-MMD=
", "hw/scsi/esp-pci.d", "-MF", "hw/scsi/esp-pci.d", "-MP", "-MT", "hw/scsi/=
esp-pci.o", "-D_REENTRANT", "-D", "HAS_LIBSSH2_SFTP_FSYNC", "-D", "_GNU_SOU=
RCE", "-D", "PIE", "-D", "_GNU_SOURCE", "-D", "_FILE_OFFSET_BITS=3D64", "-D=
", "_LARGEFILE_SOURCE", "-U", "_FORTIFY_SOURCE", "-D", "_FORTIFY_SOURCE=3D2=
", "/home/berrange/src/virt/qemu/hw/scsi/esp-pci.c", "-quiet", "-dumpbase",=
 "esp-pci.c", "-m64", "-mcx16", "-mtune=3Dgeneric", "-march=3Dx86-64", "-au=
xbase-strip", "hw/scsi/esp-pci.o", "-g", "-O2", "-Werror", "-Wstrict-protot=
ypes", "-Wredundant-decls", "-Wall", "-Wundef", "-Wwrite-strings", "-Wmissi=
ng-prototypes", "-Wendif-labels", "-Wno-shift-negative-value", "-Wmissing-i=
nclude-dirs", "-Wempty-body", "-Wnested-externs", "-Wformat-security", "-Wf=
ormat-y2k", "-Winit-self", "-Wignored-qualifiers", "-Wold-style-declaration=
", "-Wold-style-definition", "-Wtype-limits", "-fPIE", "-fno-strict-aliasin=
g", "-fno-common", "-fwrapv", "-fstack-protector-strong", "-o", "/tmp/ccH7y=
Xaj.s"], [/* 63 vars */] <unfinished ...>

=2E..

3138  open("/home/berrange/src/virt/qemu/hw/scsi/trace.h", O_RDONLY|O_NOCTT=
Y) =3D -1 ENOENT (No such file or directory)
3138  open("/home/berrange/src/virt/qemu/tcg/trace.h", O_RDONLY|O_NOCTTY) =
=3D -1 ENOENT (No such file or directory)
3138  open("/home/berrange/src/virt/qemu/tcg/i386/trace.h", O_RDONLY|O_NOCT=
TY) =3D -1 ENOENT (No such file or directory)
3138  open("/home/berrange/src/virt/qemu/linux-headers/trace.h", O_RDONLY|O=
_NOCTTY) =3D -1 ENOENT (No such file or directory)
3138  open("/home/berrange/src/virt/qemu-build/linux-headers/trace.h", O_RD=
ONLY|O_NOCTTY) =3D -1 ENOENT (No such file or directory)
3138  open("./trace.h", O_RDONLY|O_NOCTTY) =3D 14
3138  open("./trace.h", O_RDONLY)       =3D 14


For a consistent search order, we would need to have this be the
explicit args:

-I/home/berrange/src/virt/qemu/hw/scsi
-Ihw/scsi
-I/home/berrange/src/virt/qemu/tcg
-I/home/berrange/src/virt/qemu/tcg/i386
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu-build/linux-headers
-I.
-I/home/berrange/src/virt/qemu
-I/home/berrange/src/virt/qemu/include

It seems you're saying we should also trim the top level dirs, so
we in fact get:


-I/home/berrange/src/virt/qemu/hw/scsi
-Ihw/scsi
-I/home/berrange/src/virt/qemu/tcg
-I/home/berrange/src/virt/qemu/tcg/i386
-I/home/berrange/src/virt/qemu/linux-headers
-I/home/berrange/src/virt/qemu-build/linux-headers
-I/home/berrange/src/virt/qemu/include

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ =
:|
|: http://libvirt.org              -o-             http://virt-manager.org =
:|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ =
:|
