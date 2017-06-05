Received: from eggs.gnu.org ([2001:4830:134:3::10]:42939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHt0Y-0005ap-Eq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHt0U-0007kj-Fp
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:29:26 -0400
References: <20170531120049.14111-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
Date: Mon, 5 Jun 2017 17:29:21 +0300
MIME-Version: 1.0
In-Reply-To: <20170531120049.14111-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, marcandre.lureau@gmail.com, peter.maydell@redhat.com, eblake@redhat.com, f4bug@amsat.org

31.05.2017 15:00, Kamil Rytarowski wrote:
> Currently ivshmem requires eventfd() which is Linux specific.
> Do not and build it unconditionally on every Linux/BSD/Solaris.
>=20
> This patch indirectly fixes build failure on NetBSD, where these tools
> additionally require -lrt for shm_open(3). In future there should be
> added support for NetBSD and the linking addressed appropriately.

Unfortunately this breaks static build.

$ ../configure --disable-system --disable-linux-user --static
$ make V=3D1
...
c++ -I/usr/include/pixman-1  -Werror -pthread -I/usr/include/glib-2.0 -I/=
usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredund=
ant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-negat=
ive-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-sty=
le-declaration -Wold-style-definition -Wtype-limits -fstack-protector-str=
ong
-I/usr/include/libpng16 -I/build/qemu/git/tests -O2 -U_FORTIFY_SOURCE -D_=
FORTIFY_SOURCE=3D2 -g  -Wl,--warn-common -m64 -static -g  -o ivshmem-serv=
er
libqemuutil.a libqemustub.a   -lm -lgthread-2.0 -pthread -lglib-2.0 -pthr=
ead -lpcre -pthread  -lz -lrt -lz -lnettle  -lutil
/usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/crt1.o: In func=
tion `_start':
(.text+0x20): undefined reference to `main'
collect2: error: ld returned 1 exit status
Makefile:475: error building =ABivshmem-server=BB
$ _

I'll take a look at this later. reverting it for now.

Thanks,

/mjt
