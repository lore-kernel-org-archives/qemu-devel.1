Received: from eggs.gnu.org ([2001:4830:134:3::10]:57023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7k-0007hD-I4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPc7h-0005Ns-SA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPc7h-0005NF-MT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:04:45 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 26 Jun 2017 18:04:41 -0400
Message-Id: <1498514681-3059-8-git-send-email-cota@braap.org>
In-Reply-To: <1498514681-3059-1-git-send-email-cota@braap.org>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/7] trace: Statically enable all TCG guest
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

The optimizations of this series makes it feasible to have them
available on all builds.

After this patchset we avoid the ~2X slowdown that enabling
TCG events used to incur, as shown in the bar chart below.
[orig==before; new==after]

                                                        NBench score; higher is better

  180 +-+--------+----------+----------+---------+----------+----------+----------+----------+----------+---------+----------+--------+-+
      |                                                                                                                                 |
      |                                      *** $$$$%%                                                                    orig         |
  160 +-+....................................*.*.$..$.%............................................................orig-enabled       +-+
      |                                      * * $  $ %                                                                     new         |
  140 +-+....................................*.*.$..$.%............................................................new-disabled.......+-+
      |                                      * * $  $ %                                                                                 |
      |                                      * * $  $ %                                                                                 |
  120 +-+....................................*.*.$..$.%...............................................................................+-+
      |                                      * * $  $ %                                                                                 |
      |                                      * * $  $ %                                                                                 |
  100 +-+....................................*.*.$..$.%.....$$$%%%....................................................................+-+
      |                                      * * $  $ % *** $ $  % *** $$$%%                                                            |
   80 +-+....................................*.*.$..$.%.*.*.$.$..%.*.*.$.$.%..........................................................+-+
      |                                      * * $  $ % * * $ $  % * * $ $ %                                                            |
      |                                      * * $  $ % * * $ $  % * * $ $ %                                                            |
   60 +-+.........................***..$$$%%.*.*##..$.%.*.*.$.$..%.*.*.$.$.%..***.$$$%%...............................................+-+
      |                **** $$$%% * *  $ $ % * * #  $ % * *## $  % * * $ $ %  * * $ $ %                                                 |
      |                *  * $ $ % * *  $ $ % * * #  $ % * * # $  % * *## $ %  * * $ $ %                                                 |
   40 +-+..............*..*.$.$.%.*.*..$.$.%.*.*.#..$.%.*.*.#.$..%.*.*.#.$.%..*.*.$.$.%...............................................+-+
      |                *  * $ $ % * *  $ $ % * * #  $ % * * # $  % * * # $ %  * *## $ %                                  *** $$$%%%     |
   20 +-+....***.$$$%%.*..*##.$.%.*.*###.$.%.*.*.#..$.%.*.*.#.$..%.*.*.#.$.%..*.*.#.$.%..................................*.*.$.$..%...+-+
      |      * *## $ % *  * # $ % * *  # $ % * * #  $ % * * # $  % * * # $ %  * * # $ %                                  * *## $  %     |
      |      * * # $ % *  * # $ % * *  # $ % * * #  $ % * * # $  % * * # $ %  * * # $ %            ***###$$%% ***##$$$%% * * # $  %     |
    0 +-+----***##$$%%-****##$$%%-***###$$%%-***##$$$%%-***##$$%%%-***##$$%%--***##$$%%-****##$$%%-***###$$%%-***##$$$%%-***##$$%%%---+-+
     NUMERIC SORTSTRING SORT   BITFIEFP EMULATION ASSIGNMENT       IDEA    HUFFMAN    FOURIER NEURLU DECOMPOSITION      gmean
png: http://imgur.com/a/8XG5S

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[cota: add perf numbers]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/trace-events b/trace-events
index bae63fd..f9dbd7f 100644
--- a/trace-events
+++ b/trace-events
@@ -106,7 +106,7 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
 
 # @num: System call number.
 # @arg*: System call argument value.
@@ -115,7 +115,7 @@ disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
+vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t arg8) "num=0x%016"PRIx64" arg1=0x%016"PRIx64" arg2=0x%016"PRIx64" arg3=0x%016"PRIx64" arg4=0x%016"PRIx64" arg5=0x%016"PRIx64" arg6=0x%016"PRIx64" arg7=0x%016"PRIx64" arg8=0x%016"PRIx64
 
 # @num: System call number.
 # @ret: System call result value.
@@ -124,4 +124,4 @@ disable vcpu guest_user_syscall(uint64_t num, uint64_t arg1, uint64_t arg2, uint
 #
 # Mode: user
 # Targets: TCG(all)
-disable vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
+vcpu guest_user_syscall_ret(uint64_t num, uint64_t ret) "num=0x%016"PRIx64" ret=0x%016"PRIx64
-- 
2.7.4
