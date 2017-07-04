Received: from eggs.gnu.org ([2001:4830:134:3::10]:45965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dSJc2-0003GY-Ku
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dSJc1-0004g3-Es
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:55:14 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue,  4 Jul 2017 10:54:52 +0200
Message-Id: <149915849243.6295.4484103824675839071.stgit@frigg.lan>
In-Reply-To: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
References: <149915701334.6295.1724301929524364123.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 6/6] trace: [trivial] Statically enable all
 guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, "open list:Trivial patches" <qemu-trivial@nongnu.org>

The existing optimizations makes it feasible to have them available on al=
l
builds.

Some quick'n'dirty numbers with 400.perlbench (SPECcpu2006) on the train =
input
(medium size - suns.pl) and the guest_mem_before event:

* vanilla, statically disabled
real    0m2,259s
user    0m2,252s
sys     0m0,004s

* vanilla, statically enabled (overhead: 2.18x)
real    0m4,921s
user    0m4,912s
sys     0m0,008s

* multi-tb, statically disabled (overhead: 0.99x) [within noise range]
real    0m2,228s
user    0m2,216s
sys     0m0,008s

* multi-tb, statically enabled (overhead: 0.99x) [within noise range]
real    0m2,229s
user    0m2,224s
sys     0m0,004s


Now enabling all events when booting an ARM system that immediately shuts=
 down
(https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04085.html):

* vanilla, statically disabled
real	0m32,153s
user	0m31,276s
sys	0m0,108s

* vanilla, statically enabled (overhead: 1.35x)
real	0m43,507s
user	0m42,680s
sys	0m0,168s

* multi-tb, statically disabled (overhead: 1.03x)
real	0m32,993s
user	0m32,516s
sys	0m0,104s

* multi-tb, statically enabled (overhead: 1.00x) [within noise range]
real	0m32,110s
user	0m31,176s
sys	0m0,156s


And finally enabling all events using Emilio's dbt-bench
(where orig =3D=3D vanilla, new =3D=3D multi-tb):

                                                        NBench score; hig=
her is better

  180 +-+--------+----------+----------+---------+----------+----------+-=
---------+----------+----------+---------+----------+--------+-+
      |                                                                  =
                                                               |
      |                                      *** $$$$%%                  =
                                                  orig         |
  160 +-+....................................*.*.$..$.%..................=
..........................................orig-enabled       +-+
      |                                      * * $  $ %                  =
                                                   new         |
  140 +-+....................................*.*.$..$.%..................=
..........................................new-disabled.......+-+
      |                                      * * $  $ %                  =
                                                               |
      |                                      * * $  $ %                  =
                                                               |
  120 +-+....................................*.*.$..$.%..................=
.............................................................+-+
      |                                      * * $  $ %                  =
                                                               |
      |                                      * * $  $ %                  =
                                                               |
  100 +-+....................................*.*.$..$.%.....$$$%%%.......=
.............................................................+-+
      |                                      * * $  $ % *** $ $  % *** $$=
$%%                                                            |
   80 +-+....................................*.*.$..$.%.*.*.$.$..%.*.*.$.=
$.%..........................................................+-+
      |                                      * * $  $ % * * $ $  % * * $ =
$ %                                                            |
      |                                      * * $  $ % * * $ $  % * * $ =
$ %                                                            |
   60 +-+.........................***..$$$%%.*.*##..$.%.*.*.$.$..%.*.*.$.=
$.%..***.$$$%%...............................................+-+
      |                **** $$$%% * *  $ $ % * * #  $ % * *## $  % * * $ =
$ %  * * $ $ %                                                 |
      |                *  * $ $ % * *  $ $ % * * #  $ % * * # $  % * *## =
$ %  * * $ $ %                                                 |
   40 +-+..............*..*.$.$.%.*.*..$.$.%.*.*.#..$.%.*.*.#.$..%.*.*.#.=
$.%..*.*.$.$.%...............................................+-+
      |                *  * $ $ % * *  $ $ % * * #  $ % * * # $  % * * # =
$ %  * *## $ %                                  *** $$$%%%     |
   20 +-+....***.$$$%%.*..*##.$.%.*.*###.$.%.*.*.#..$.%.*.*.#.$..%.*.*.#.=
$.%..*.*.#.$.%..................................*.*.$.$..%...+-+
      |      * *## $ % *  * # $ % * *  # $ % * * #  $ % * * # $  % * * # =
$ %  * * # $ %                                  * *## $  %     |
      |      * * # $ % *  * # $ % * *  # $ % * * #  $ % * * # $  % * * # =
$ %  * * # $ %            ***###$$%% ***##$$$%% * * # $  %     |
    0 +-+----***##$$%%-****##$$%%-***###$$%%-***##$$$%%-***##$$%%%-***##$=
$%%--***##$$%%-****##$$%%-***###$$%%-***##$$$%%-***##$$%%%---+-+
     NUMERIC SORTSTRING SORT   BITFIEFP EMULATION ASSIGNMENT       IDEA  =
  HUFFMAN    FOURIER NEURLU DECOMPOSITION      gmean
png: http://imgur.com/a/8XG5S


Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 trace-events |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/trace-events b/trace-events
index bae63fdb1d..f9dbd7f509 100644
--- a/trace-events
+++ b/trace-events
@@ -106,7 +106,7 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d",=
 "vaddr=3D0x%016"PRIx64" info=3D%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d", "vaddr=3D=
0x%016"PRIx64" info=3D%d"
=20
 # @num: System call number.
 # @arg*: System call argument value.
@@ -115,7 +115,7 @@ disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t=
 info) "info=3D%d", "vaddr=3D0x
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t ar=
g2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t =
arg7, uint64_t arg8) "num=3D0x%016"PRIx64" arg1=3D0x%016"PRIx64" arg2=3D0=
x%016"PRIx64" arg3=3D0x%016"PRIx64" arg4=3D0x%016"PRIx64" arg5=3D0x%016"P=
RIx64" arg6=3D0x%016"PRIx64" arg7=3D0x%016"PRIx64" arg8=3D0x%016"PRIx64
+vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint=
64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, ui=
nt64_t arg8) "num=3D0x%016"PRIx64" arg1=3D0x%016"PRIx64" arg2=3D0x%016"PR=
Ix64" arg3=3D0x%016"PRIx64" arg4=3D0x%016"PRIx64" arg5=3D0x%016"PRIx64" a=
rg6=3D0x%016"PRIx64" arg7=3D0x%016"PRIx64" arg8=3D0x%016"PRIx64
=20
 # @num: System call number.
 # @ret: System call result value.
@@ -124,4 +124,4 @@ disable vcpu guest_user_syscall(uint64_t num, uint64_=
t arg1, uint64_t arg2, uint
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=3D0=
x%016"PRIx64" ret=3D0x%016"PRIx64
+vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=3D0x%016"PR=
Ix64" ret=3D0x%016"PRIx64
