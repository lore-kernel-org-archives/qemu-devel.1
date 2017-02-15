Received: from eggs.gnu.org ([2001:4830:134:3::10]:41141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce5Zn-0006Hy-3J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ce5Zj-0001ob-8O
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ce5Zi-0001oE-Vo
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:49:15 -0500
Date: Wed, 15 Feb 2017 19:49:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170215194909.GI2731@work-vm>
References: <20170215181922.11624-1-dgilbert@redhat.com>
	<148718387291.42.9941333783244702770@59c2c5518a5a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <148718387291.42.9941333783244702770@59c2c5518a5a>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] SLIRP VMStatification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: famz@redhat.com, lvivier@redhat.com, quintela@redhat.com

Ewww, it looks like I have a mingw disagreement I need to fix;

<snip>

> QEMU_CFLAGS       -I/usr/x86_64-w64-mingw32/sys-root/mingw/include/pixman=
-1  -I$(SRC_PATH)/dtc/libfdt -Werror -mms-bitfields -I/usr/x86_64-w64-mingw=
32/sys-root/mingw/include/glib-2.0 -I/usr/x86_64-w64-mingw32/sys-root/mingw=
/lib/glib-2.0/include -I/usr/x86_64-w64-mingw32/sys-root/mingw/include  -m6=
4 -mcx16 -mthreads -D__USE_MINGW_ANSI_STDIO=3D1 -DWIN32_LEAN_AND_MEAN -DWIN=
VER=3D0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wst=
rict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-p=
rototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shi=
ft-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -=
Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-=
declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong -=
I/usr/x86_64-w64-mingw32/sys-root/mingw/include -I/usr/x86_64-w64-mingw32/s=
ys-root/mingw/include/p11-kit-1 -I/usr/x86_64-w64-mingw32/sys-root/mingw/in=
clude  -I/usr/x86_64-w64-mingw32/sys-root/mingw/include   -I/usr/x86_64-w64=
-mingw32/sys-root/mingw/include/libpng16=20

<snip>

    error: invalid operands to binary - (have 'uint16_t * {aka short unsign=
ed int *}' and 'short int *')
> /tmp/qemu-test/src/slirp/slirp.c:1280:9: note: in expansion of macro 'VMS=
TATE_UINT16'
>          VMSTATE_UINT16(ss.ss_family, union slirp_sockaddr),
>          ^

<snip>

  error: invalid operands to binary - (have 'uint32_t * {aka unsigned int *=
}' and 'u_long * {aka long unsigned int *}')
> /tmp/qemu-test/src/slirp/slirp.c:1281:9: note: in expansion of macro 'VMS=
TATE_UINT32_TEST'
>          VMSTATE_UINT32_TEST(sin.sin_addr.s_addr, union slirp_sockaddr,
>          ^

> /tmp/qemu-test/src/slirp/slirp.c:1309:9: note: in expansion of macro 'VMS=
TATE_UINT32_TEST'
>          VMSTATE_UINT32_TEST(so_faddr.s_addr, struct socket,
>          ^


> /tmp/qemu-test/src/slirp/slirp.c:1311:9: note: in expansion of macro 'VMS=
TATE_UINT32_TEST'
>          VMSTATE_UINT32_TEST(so_laddr.s_addr, struct socket,
>          ^


My mingw headers has:

  struct sockaddr_storage {
    short ss_family;
    char __ss_pad1[_SS_PAD1SIZE];

    __MINGW_EXTENSION __int64 __ss_align;
    char __ss_pad2[_SS_PAD2SIZE];
  };

so the ss_family problem is a signedness problem.

and:

typedef struct in_addr {
  union {
    struct { u_char  s_b1, s_b2, s_b3, s_b4; } S_un_b;
    struct { u_short s_w1, s_w2; } S_un_w;
    u_long S_addr;
  } S_un;
} IN_ADDR, *PIN_ADDR, *LPIN_ADDR;

Hmm, as far as I can tell it's long's are still 32bit; so I'll need
to dig to figure that out.

I'll go and figure it out.


Dave

> /tmp/qemu-test/src/rules.mak:69: recipe for target 'slirp/slirp.o' failed
> make: *** [slirp/slirp.o] Error 1
> make: *** Waiting for unfinished jobs....
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-t49wmu6l/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
