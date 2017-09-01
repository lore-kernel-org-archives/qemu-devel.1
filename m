Received: from eggs.gnu.org ([2001:4830:134:3::10]:38879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkXp-0005jx-Bc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dnkXk-0007uy-Bv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dnkXk-0007un-3r
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EFA361481
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 11:55:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Sep 2017 13:54:58 +0200
Message-Id: <20170901115500.12654-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/2] Fix tests on recent gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

v4: really sent the patches for v3, not for v2.  Sorry folks

[v3]
- change assert from position

Please review.

[v2]

- move all uses of -1 for memtest.
- remove docs about the feature.
- use size_t for the second patch (cedric)

Please, review.


[v1]

On Fedora 26 (gcc-7.1.1 and glib2 2.52.3) tests don't compile.

In file included from /usr/include/string.h:639:0,
                 from /mnt/kvm/qemu/cleanup/include/qemu/osdep.h:69,
                 from /mnt/kvm/qemu/cleanup/tests/test-iov.c:1:
In function =E2=80=98memcpy=E2=80=99,
    inlined from =E2=80=98iov_from_buf=E2=80=99 at /mnt/kvm/qemu/cleanup/=
include/qemu/iov.h:51:9,
    inlined from =E2=80=98test_to_from_buf_1=E2=80=99 at /mnt/kvm/qemu/cl=
eanup/tests/test-iov.c:88:14,
    inlined from =E2=80=98test_to_from_buf=E2=80=99 at /mnt/kvm/qemu/clea=
nup/tests/test-iov.c:144:9:
/usr/include/bits/string3.h:53:10: error: =E2=80=98__builtin_memcpy=E2=80=
=99: specified size 18446744073709551615 exceeds maximum object size 9223=
372036854775807 [-Werror=3Dstringop-overflow=3D]
   return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98memcpy=E2=80=99,
    inlined from =E2=80=98iov_to_buf=E2=80=99 at /mnt/kvm/qemu/cleanup/in=
clude/qemu/iov.h:64:9,
    inlined from =E2=80=98test_to_from_buf_1=E2=80=99 at /mnt/kvm/qemu/cl=
eanup/tests/test-iov.c:94:14,
    inlined from =E2=80=98test_to_from_buf=E2=80=99 at /mnt/kvm/qemu/clea=
nup/tests/test-iov.c:144:9:
/usr/include/bits/string3.h:53:10: error: =E2=80=98__builtin_memcpy=E2=80=
=99: specified size 18446744073709551615 exceeds maximum object size 9223=
372036854775807 [-Werror=3Dstringop-overflow=3D]
   return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

In this case, we are abusing the functions and call a size_t argument
with -1, which gives us a very big number.  gcc gets overzealous and
gets confused about it.  Notice that this was introduced in 2015 by Paolo=
:

commit ad523bca56a7202d2498c550a41be5c986c4d33c
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Dec 22 12:03:33 2015 +0100

    iov: avoid memcpy for "simple" iov_from_buf/iov_to_buf

I fixed it by using the real sizes in the tests insntead of -1.  It is al=
ready calculated.




In file included from /usr/include/glib-2.0/glib/glist.h:32:0,
                 from /usr/include/glib-2.0/glib/ghash.h:33,
                 from /usr/include/glib-2.0/glib.h:50,
                 from /mnt/kvm/qemu/cleanup/tests/vmgenid-test.c:11:
In function =E2=80=98acpi_find_vgia=E2=80=99,
    inlined from =E2=80=98read_guid_from_memory=E2=80=99 at /mnt/kvm/qemu=
/cleanup/tests/vmgenid-test.c:103:18:
/usr/include/glib-2.0/glib/gmem.h:216:10: error: argument 1 range [184467=
44071562067968, 18446744073709551615] exceeds maximum object size 9223372=
036854775807 [-Werror=3Dalloc-size-larger-than=3D]
      __p =3D g_##func##_n (__n, __s);   \
      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/glib-2.0/glib/gmem.h:278:42: note: in expansion of macro =E2=
=80=98_G_NEW=E2=80=99
 #define g_new0(struct_type, n_structs)   _G_NEW (struct_type, n_structs,=
 malloc0)
                                          ^~~~~~
/mnt/kvm/qemu/cleanup/tests/vmgenid-test.c:70:14: note: in expansion of m=
acro =E2=80=98g_new0=E2=80=99
     tables =3D g_new0(uint32_t, tables_nr);
              ^~~~~~
/mnt/kvm/qemu/cleanup/tests/vmgenid-test.c: In function =E2=80=98read_gui=
d_from_memory=E2=80=99:
/usr/include/glib-2.0/glib/gmem.h:96:10: note: in a call to allocation fu=
nction =E2=80=98g_malloc0_n=E2=80=99 declared here
 gpointer g_malloc0_n      (gsize  n_blocks,
          ^~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/mnt/kvm/qemu/cleanup/rules.mak:66: tests/vmgenid-test.o] Erro=
r 1


this cames form line:

    tables =3D g_new0(uint32_t, tables_nr);

glib/gcc gets completely confused about this and think that 1st
argument can be 2^64-1.  Documentation says that you should use g_new
for struct types, so ...  I moved to g_malloc0() and call it a day.


--=20
2.13.5



Juan Quintela (2):
  tests: Use real size for iov tests
  tests: Make vmgenid test compile

 include/qemu/iov.h   |  6 ------
 tests/test-iov.c     | 10 +++++-----
 tests/vmgenid-test.c |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

--=20
2.13.5
