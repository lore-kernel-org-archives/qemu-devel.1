Received: from eggs.gnu.org ([2001:4830:134:3::10]:55665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVD5p-00029H-M2
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVD5l-0001AW-MH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:33:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVD5l-0001AQ-FM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:33:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6C8XaPT031660
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:33:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj5030x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:33:52 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 04:33:51 -0400
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 10:33:46 +0200
MIME-Version: 1.0
In-Reply-To: <1499781397-19749-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Message-Id: <2efa5d82-3cb2-ef8a-53b0-54a630637d98@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Implement network booting in the
 s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 07/11/2017 03:56 PM, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image based on a Linux installation, but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
>=20
> This patch series now introduces a s390-netboot.img that can be used
> for network booting via DHCP and TFTP by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.
>=20
> The code can only be built if the roms/SLOF submodule has been checked
> out (there is a sanity check for this in the Makefile). Once it has
> been built, you can download a combined kernel + initrd image via TFTP
> by starting QEMU for example with:
>=20
>  qemu-system-s390x ... -device virtio-net,netdev=3Dn1,bootindex=3D1 \
>        -netdev user,id=3Dn1,tftp=3D/path/to/tftp,bootfile=3Dkernel.img
>=20
> Note that this version does not support downloading via config
> files (i.e. pxelinux config files or .INS config files) yet. This
> will be added later.
>=20
> v4:
>  - Cosmetic clean-ups according to the review feedback from v3
>  - Fixed bug in the find_dev() function (spotted by Cornelia in v3)
>  - Added an additional patch to remove some unused structs from
>    virtio.h
>=20
> v3:
>  - Adressed the review feedback from v2
>  - The last remaining SLOF patch has now been merged (big thanks to
>    Alexey!), so not sending this as RFC anymore - it is ready now for
>    integration, I think.
>=20
> v2:
>  - Put the network boot loader into a separate s390-netboot.img
>    binary instead of linking it directly into the s390-ccw firmware.
>  - Use the SLOF sources from the roms/SLOF/ submodule instead of
>    copying them into the pc-bios/s390-ccw folder
>  - Removed the .INS config file loading code for now - only support
>    combined kernel + initrd images in this initial implementation.
>=20
> Thomas Huth (11):
>   pc-bios/s390-ccw: Move libc functions to separate header
>   pc-bios/s390-ccw: Move ebc2asc to sclp.c
>   pc-bios/s390-ccw: Move virtio-block related functions into a separate
>     file
>   pc-bios/s390-ccw: Add a write() function for stdio
>   pc-bios/s390-ccw: Move byteswap functions to a separate header
>   pc-bios/s390-ccw: Remove unused structs from virtio.h
>   pc-bios/s390-ccw: Add code for virtio feature negotiation
>   roms/SLOF: Update submodule to latest status
>   pc-bios/s390-ccw: Add core files for the network bootloading program
>   pc-bios/s390-ccw: Add virtio-net driver code
>   pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP
>     load
>=20
>  pc-bios/s390-ccw/Makefile        |  13 +-
>  pc-bios/s390-ccw/bootmap.c       |   2 +
>  pc-bios/s390-ccw/bootmap.h       |  26 ---
>  pc-bios/s390-ccw/bswap.h         |  30 ++++
>  pc-bios/s390-ccw/libc.h          |  45 +++++
>  pc-bios/s390-ccw/main.c          |  14 +-
>  pc-bios/s390-ccw/netboot.mak     |  51 ++++++
>  pc-bios/s390-ccw/netmain.c       | 362 +++++++++++++++++++++++++++++++=
++++++++
>  pc-bios/s390-ccw/s390-ccw.h      |  33 +---
>  pc-bios/s390-ccw/sclp.c          |  37 ++--
>  pc-bios/s390-ccw/virtio-blkdev.c | 296 +++++++++++++++++++++++++++++++=
+
>  pc-bios/s390-ccw/virtio-net.c    | 135 +++++++++++++++
>  pc-bios/s390-ccw/virtio-scsi.c   |   1 +
>  pc-bios/s390-ccw/virtio.c        | 306 ++++---------------------------=
--
>  pc-bios/s390-ccw/virtio.h        |  46 ++---
>  roms/SLOF                        |   2 +-
>  16 files changed, 1011 insertions(+), 388 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/bswap.h
>  create mode 100644 pc-bios/s390-ccw/libc.h
>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>  create mode 100644 pc-bios/s390-ccw/netmain.c
>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
>=20

Was going to apply but then I updated the slof thing but building fails. =
Not sure yet why.

In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
isdigit.c:13:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isdigit.c:15:17: error=
: expected =E2=80=98)=E2=80=99 before =E2=80=98ch=E2=80=99
 int isdigit(int ch)
                 ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isdigit.c:15:5: error:=
 expected expression before =E2=80=98)=E2=80=99 token
 int isdigit(int ch)
     ^
In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
isprint.c:13:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isprint.c:15:17: error=
: expected =E2=80=98)=E2=80=99 before =E2=80=98ch=E2=80=99
 int isprint(int ch)
                 ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isprint.c:15:5: error:=
 expected expression before =E2=80=98)=E2=80=99 token
 int isprint(int ch)
     ^
In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
isxdigit.c:13:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isxdigit.c:15:18: erro=
r: expected =E2=80=98)=E2=80=99 before =E2=80=98ch=E2=80=99
 int isxdigit(int ch)
                  ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isxdigit.c:15:5: error=
: expected expression before =E2=80=98)=E2=80=99 token
 int isxdigit(int ch)
     ^
In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
tolower.c:13:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/tolower.c:15:5: error:=
 expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98__extension__=
=E2=80=99
 int tolower(int c)
     ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'isdigit.o' failed
make[1]: *** [isdigit.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'isprint.o' failed
make[1]: *** [isprint.o] Error 1
In file included from /usr/include/string.h:630:0,
                 from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string=
/strncmp.c:13:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/strncmp.c:17:1: error=
: expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98__extension_=
_=E2=80=99
 strncmp(const char *s1, const char *s2, size_t n)
 ^
In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
isspace.c:13:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isspace.c:15:17: error=
: expected =E2=80=98)=E2=80=99 before =E2=80=98ch=E2=80=99
 int isspace(int ch)
                 ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isspace.c:15:5: error:=
 expected expression before =E2=80=98)=E2=80=99 token
 int isspace(int ch)
     ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'isxdigit.o' failed
make[1]: *** [isxdigit.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'tolower.o' failed
make[1]: *** [tolower.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/Makefile.inc:22: reci=
pe for target 'strncmp.o' failed
make[1]: *** [strncmp.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'isspace.o' failed
make[1]: *** [isspace.o] Error 1
In file included from /usr/include/string.h:630:0,
                 from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string=
/strcmp.c:13:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/strcmp.c:17:1: error:=
 expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98__extension__=
=E2=80=99
 strcmp(const char *s1, const char *s2)
 ^
In file included from /usr/include/string.h:630:0,
                 from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string=
/strchr.c:13:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/strchr.c:16:1: error:=
 expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98__extension__=
=E2=80=99
 strchr(const char *s, int c)
 ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/strcmp.c:17:1: error:=
 expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98)=E2=80=99 to=
ken
 strcmp(const char *s1, const char *s2)
 ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/Makefile.inc:22: reci=
pe for target 'strchr.o' failed
make[1]: *** [strchr.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/string/Makefile.inc:22: reci=
pe for target 'strcmp.o' failed
make[1]: *** [strcmp.o] Error 1
In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/=
toupper.c:14:0:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/toupper.c:16:5: error:=
 expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98__extension__=
=E2=80=99
 int toupper (int cha)
     ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/Makefile.inc:20: recip=
e for target 'toupper.o' failed
make[1]: *** [toupper.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/fileno.c: In function =
=E2=80=98fileno=E2=80=99:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/fileno.c:18:15: error:=
 =E2=80=98FILE {aka struct _IO_FILE}=E2=80=99 has no member named =E2=80=98=
fd=E2=80=99
  return stream->fd;
               ^~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/Makefile.inc:23: recip=
e for target 'fileno.o' failed
make[1]: *** [fileno.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/putc.c: In function =E2=
=80=98_IO_putc=E2=80=99:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/putc.c:21:18: error: =E2=
=80=98FILE {aka struct _IO_FILE}=E2=80=99 has no member named =E2=80=98fd=
=E2=80=99
  if (write(stream->fd, &outchar, 1) =3D=3D 1)
                  ^~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/vfprintf.c: In functio=
n =E2=80=98vfprintf=E2=80=99:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/vfprintf.c:23:14: erro=
r: =E2=80=98FILE {aka struct _IO_FILE}=E2=80=99 has no member named =E2=80=
=98fd=E2=80=99
  write(stream->fd, buffer, count);
              ^~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/Makefile.inc:23: recip=
e for target 'putc.o' failed
make[1]: *** [putc.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/Makefile.inc:23: recip=
e for target 'vfprintf.o' failed
make[1]: *** [vfprintf.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/puts.c: In function =E2=
=80=98puts=E2=80=99:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/puts.c:24:20: error: =E2=
=80=98struct _IO_FILE=E2=80=99 has no member named =E2=80=98fd=E2=80=99
  ret =3D write(stdout->fd, str, strlen(str));
                    ^~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/puts.c:25:14: error: =E2=
=80=98struct _IO_FILE=E2=80=99 has no member named =E2=80=98fd=E2=80=99
  write(stdout->fd, "\r\n", 2);
              ^~
/home/cborntra/REPOS/qemu/pc-bios/s390-ccw/netmain.c:25:18: fatal error: =
tftp.h: No such file or directory
 #include <tftp.h>
                  ^
compilation terminated.
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/vsnprintf.c: In functi=
on =E2=80=98vsnprintf=E2=80=99:
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/vsnprintf.c:283:15: wa=
rning: implicit declaration of function =E2=80=98va_arg=E2=80=99 [-Wimpli=
cit-function-declaration]
      formstr, va_arg(arg, void *));
               ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/vsnprintf.c:283:27: er=
ror: expected expression before =E2=80=98void=E2=80=99
      formstr, va_arg(arg, void *));
                           ^~~~
/home/cborntra/REPOS/qemu/rules.mak:66: recipe for target 'netmain.o' fai=
led
make[1]: *** [netmain.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/Makefile.inc:23: recip=
e for target 'puts.o' failed
make[1]: *** [puts.o] Error 1
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/Makefile.inc:23: recip=
e for target 'vsnprintf.o' failed
make[1]: *** [vsnprintf.o] Error 1
/home/cborntra/REPOS/qemu/pc-bios/s390-ccw/virtio-net.c:19:22: fatal erro=
r: ethernet.h: No such file or directory
 #include <ethernet.h>
                      ^
compilation terminated.
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:18:21: erro=
r: unknown field =E2=80=98fd=E2=80=99 specified in initializer
 FILE stdin_data =3D { .fd =3D 0, .mode =3D _IOLBF, .pos =3D 0,
                     ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:18:30: erro=
r: unknown field =E2=80=98mode=E2=80=99 specified in initializer
 FILE stdin_data =3D { .fd =3D 0, .mode =3D _IOLBF, .pos =3D 0,
                              ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:18:38: warn=
ing: initialization makes pointer from integer without a cast [-Wint-conv=
ersion]
 FILE stdin_data =3D { .fd =3D 0, .mode =3D _IOLBF, .pos =3D 0,
                                      ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:18:38: note=
: (near initialization for =E2=80=98stdin_data._IO_read_ptr=E2=80=99)
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:18:46: erro=
r: unknown field =E2=80=98pos=E2=80=99 specified in initializer
 FILE stdin_data =3D { .fd =3D 0, .mode =3D _IOLBF, .pos =3D 0,
                                              ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:19:7: error=
: unknown field =E2=80=98buf=E2=80=99 specified in initializer
       .buf =3D stdin_buffer, .bufsiz =3D BUFSIZ };
       ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:19:28: erro=
r: unknown field =E2=80=98bufsiz=E2=80=99 specified in initializer
       .buf =3D stdin_buffer, .bufsiz =3D BUFSIZ };
                            ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:19:38: warn=
ing: initialization makes pointer from integer without a cast [-Wint-conv=
ersion]
       .buf =3D stdin_buffer, .bufsiz =3D BUFSIZ };
                                      ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:19:38: note=
: (near initialization for =E2=80=98stdin_data._IO_write_base=E2=80=99)
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:20:22: erro=
r: unknown field =E2=80=98fd=E2=80=99 specified in initializer
 FILE stdout_data =3D { .fd =3D 1, .mode =3D _IOLBF, .pos =3D 0,
                      ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:20:31: erro=
r: unknown field =E2=80=98mode=E2=80=99 specified in initializer
 FILE stdout_data =3D { .fd =3D 1, .mode =3D _IOLBF, .pos =3D 0,
                               ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:20:39: warn=
ing: initialization makes pointer from integer without a cast [-Wint-conv=
ersion]
 FILE stdout_data =3D { .fd =3D 1, .mode =3D _IOLBF, .pos =3D 0,
                                       ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:20:39: note=
: (near initialization for =E2=80=98stdout_data._IO_read_ptr=E2=80=99)
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:20:47: erro=
r: unknown field =E2=80=98pos=E2=80=99 specified in initializer
 FILE stdout_data =3D { .fd =3D 1, .mode =3D _IOLBF, .pos =3D 0,
                                               ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:21:8: error=
: unknown field =E2=80=98buf=E2=80=99 specified in initializer
        .buf =3D stdout_buffer, .bufsiz =3D BUFSIZ };
        ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:21:30: erro=
r: unknown field =E2=80=98bufsiz=E2=80=99 specified in initializer
        .buf =3D stdout_buffer, .bufsiz =3D BUFSIZ };
                              ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:21:40: warn=
ing: initialization makes pointer from integer without a cast [-Wint-conv=
ersion]
        .buf =3D stdout_buffer, .bufsiz =3D BUFSIZ };
                                        ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:21:40: note=
: (near initialization for =E2=80=98stdout_data._IO_write_base=E2=80=99)
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:22:22: erro=
r: unknown field =E2=80=98fd=E2=80=99 specified in initializer
 FILE stderr_data =3D { .fd =3D 2, .mode =3D _IONBF, .pos =3D 0,
                      ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:22:31: erro=
r: unknown field =E2=80=98mode=E2=80=99 specified in initializer
 FILE stderr_data =3D { .fd =3D 2, .mode =3D _IONBF, .pos =3D 0,
                               ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:22:39: warn=
ing: initialization makes pointer from integer without a cast [-Wint-conv=
ersion]
 FILE stderr_data =3D { .fd =3D 2, .mode =3D _IONBF, .pos =3D 0,
                                       ^~~~~~
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:22:39: note=
: (near initialization for =E2=80=98stderr_data._IO_read_ptr=E2=80=99)
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:22:47: erro=
r: unknown field =E2=80=98pos=E2=80=99 specified in initializer
 FILE stderr_data =3D { .fd =3D 2, .mode =3D _IONBF, .pos =3D 0,
                                               ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:23:8: error=
: unknown field =E2=80=98buf=E2=80=99 specified in initializer
        .buf =3D NULL, .bufsiz =3D 0 };
        ^
/home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/stdio/stdchnls.c:23:21: erro=
r: unknown field =E2=80=98bufsiz=E2=80=99 specified in initializer
        .buf =3D NULL, .bufsiz =3D 0 };
                     ^
/home/cborntra/REPOS/qemu/rules.mak:66: recipe for target 'virtio-net.o' =
failed
