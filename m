Received: from eggs.gnu.org ([2001:4830:134:3::10]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cqzcD-0002e0-Jw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cqzcA-00045m-Gx
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cqzcA-00044b-9L
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:05:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Mar 2017 14:04:55 +0400
Message-Id: <20170323100455.26821-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: fix buffer-overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Running postcopy-test with ASAN produces the following error:

QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64  tests/postcopy-test
...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D23641=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x7f1556600000 at pc 0x55b8e9d28208 bp 0x7f1555f4d3c0 sp 0x7f1555f4d3b0
READ of size 8 at 0x7f1556600000 thread T6
    #0 0x55b8e9d28207 in htab_save_first_pass /home/elmarco/src/qq/hw/ppc=
/spapr.c:1528
    #1 0x55b8e9d2939c in htab_save_iterate /home/elmarco/src/qq/hw/ppc/sp=
apr.c:1665
    #2 0x55b8e9beae3a in qemu_savevm_state_iterate /home/elmarco/src/qq/m=
igration/savevm.c:1044
    #3 0x55b8ea677733 in migration_thread /home/elmarco/src/qq/migration/=
migration.c:1976
    #4 0x7f15845f46c9 in start_thread (/lib64/libpthread.so.0+0x76c9)
    #5 0x7f157d9d0f7e in clone (/lib64/libc.so.6+0x107f7e)

0x7f1556600000 is located 0 bytes to the right of 2097152-byte region [0x=
7f1556400000,0x7f1556600000)
allocated by thread T0 here:
    #0 0x7f159bb76980 in posix_memalign (/lib64/libasan.so.3+0xc7980)
    #1 0x55b8eab185b2 in qemu_try_memalign /home/elmarco/src/qq/util/osli=
b-posix.c:106
    #2 0x55b8eab186c8 in qemu_memalign /home/elmarco/src/qq/util/oslib-po=
six.c:122
    #3 0x55b8e9d268a8 in spapr_reallocate_hpt /home/elmarco/src/qq/hw/ppc=
/spapr.c:1214
    #4 0x55b8e9d26e04 in ppc_spapr_reset /home/elmarco/src/qq/hw/ppc/spap=
r.c:1261
    #5 0x55b8ea12e913 in qemu_system_reset /home/elmarco/src/qq/vl.c:1697
    #6 0x55b8ea13fa40 in main /home/elmarco/src/qq/vl.c:4679
    #7 0x7f157d8e9400 in __libc_start_main (/lib64/libc.so.6+0x20400)

Thread T6 created by T0 here:
    #0 0x7f159bae0488 in __interceptor_pthread_create (/lib64/libasan.so.=
3+0x31488)
    #1 0x55b8eab1d9cb in qemu_thread_create /home/elmarco/src/qq/util/qem=
u-thread-posix.c:465
    #2 0x55b8ea67874c in migrate_fd_connect /home/elmarco/src/qq/migratio=
n/migration.c:2096
    #3 0x55b8ea66cbb0 in migration_channel_connect /home/elmarco/src/qq/m=
igration/migration.c:500
    #4 0x55b8ea678f38 in socket_outgoing_migration /home/elmarco/src/qq/m=
igration/socket.c:87
    #5 0x55b8eaa5a03a in qio_task_complete /home/elmarco/src/qq/io/task.c=
:142
    #6 0x55b8eaa599cc in gio_task_thread_result /home/elmarco/src/qq/io/t=
ask.c:88
    #7 0x7f15823e38e6  (/lib64/libglib-2.0.so.0+0x468e6)
SUMMARY: AddressSanitizer: heap-buffer-overflow /home/elmarco/src/qq/hw/p=
pc/spapr.c:1528 in htab_save_first_pass

index seems to be wrongly incremented, unless I miss something that
would be worth a comment.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6ee566d658..63439811d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1524,16 +1524,16 @@ static void htab_save_first_pass(QEMUFile *f, sPA=
PRMachineState *spapr,
         /* Consume invalid HPTEs */
         while ((index < htabslots)
                && !HPTE_VALID(HPTE(spapr->htab, index))) {
-            index++;
             CLEAN_HPTE(HPTE(spapr->htab, index));
+            index++;
         }
=20
         /* Consume valid HPTEs */
         chunkstart =3D index;
         while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
                && HPTE_VALID(HPTE(spapr->htab, index))) {
-            index++;
             CLEAN_HPTE(HPTE(spapr->htab, index));
+            index++;
         }
=20
         if (index > chunkstart) {
--=20
2.12.0.191.gc5d8de91d
