Received: from eggs.gnu.org ([2001:4830:134:3::10]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIv-00007L-Ru
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIs-0000rF-K8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:59 -0400
Message-Id: <1493106839-10438-14-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 13/13] tb-hash: improve tb_jmp_cache hash
 function in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Optimizations to cross-page chaining and indirect branches make
performance more sensitive to the hit rate of tb_jmp_cache.
The constraint of reserving some bits for the page number
lowers the achievable quality of the hashing function.

However, user-mode does not have this requirement. Thus,
with this change we use for user-mode a hashing function that
is both faster and of better quality than the previous one.

Measurements:

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

-                            SPECint06 (test set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

   2x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                         +++++                                    |
      |       jr+noinline                                                        | |                                     |
      |         jr+inline                                                      ++%%@                                     |
 1.8x +-+jr+hash+noinline        +..............................................|%%@...................................+-+
      |jr+multhash+inline                                                       |%%@+                                    |
      |    jr+hash+inline                                                     +$$$%@                                     |
      |                                                                     ++##|$%@                      +++            |
 1.6x +-+....................................................................|##|$%@....................+%%%...........+-+
      |                                          @@+                         **#+$%@                    $$+%             |
      |                                       $$$%@+                        +**#+$%@             ++++ ++$$+%@            |
      |                        ++++           $ $%@                          **# $%@           +$$%@@+++$$ %@            |
 1.4x +-+.....................+%%%@..........##+$%@..........................**#.$%@...........+$$%.@***$$.%@..........+-+
      |                     ++$$+%@          ##+$%@                          **# $%@            $$% @* *#$+%@            |
      |                    ***#$ %@        +**# $%@                          **# $%@         +###$% @* *#$ %@            |
      |                    *+*#$ %@    +%%@+**# $%@                          **# $%@         **+#$% @*+*#$ %@   +%%%@+   |
 1.2x +-+..................*.*#$.%@***#$$%@+**#.$%@..........................**#.$%@.........**.#$%.@*.*#$.%@***#$+%@+.+-+
      |     +++            * *#$ %@* *# $%@ **# $%@ +++++++                  **# $%@  +++%%@@** #$% @* *#$ %@*+*#$ %@    |
      |   ++###$%+         * *#$ %@* *# $%@ **# $%@ **##$%@@                 **# $%@+**#$$%+@** #$% @* *#$ %@* *#$ %@    |
      |   +**+#$%@@ ++$$@@@* *#$ %@* *# $%@ **# $%@ ** #$% @+###++@@++++%%%+ **# $%@ **# $% @** #$% @* *#$ %@* *#$ %@    |
   1x +-++-**+#$%-@**##$%+@*+*#$+%@*+*#+$%@+**#+$%@+**+#$%+@**+#$+@@***#$+%@+**#+$%@+**#+$%+@**+#$%+@*+*#$+%@*-*#$+%@-++-+
      |    ** #$% @** #$% @* *#$ %@* *# $%@ **# $%@ ** #$% @** #$%%@* *#$ %@ **# $%@ **# $% @** #$% @* *#$ %@* *#$ %@    |
      |    ** #$% @** #$% @* *#$ %@* *# $%@ **# $%@ ** #$% @** #$+%@* *#$ %@ **# $%@ **# $% @** #$% @* *#$ %@* *#$ %@    |
      |    ** #$% @** #$% @* *#$ %@* *# $%@ **# $%@ ** #$% @** #$ %@* *#$ %@ **# $%@ **# $% @** #$% @* *#$ %@* *#$ %@    |
 0.8x +-+--**##$%@@**##$%@@***#$%%@***#$$%@-**#$$%@-**##$%@@**##$%%@***#$%%@-**#$$%@-**#$$%@@**##$%@@***#$%%@***#$%%@--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/1ZJGjzV

Here I also tried the hash function suggested by Paolo ("multhash"):
  return ((uint64_t) (pc * 2654435761) >> 32) & ();
As you can see it is just as good as the other new function ("hash"),
but I kept "hash" because with it all benchmarks have speedup > 1.

-                          SPECint06 (train set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

 2.6x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |     jr+inline                                                                                                    |
 2.4x +jr+inline+hash....................................................................................###...........+-+
      |                                                                                                  # #             |
      |                                                                                                  # #             |
 2.2x +-+................................................................................................#.#...........+-+
      |                                                                                                  # #             |
      |                                                                                                  # #             |
   2x +-+................................................................................................#.#...........+-+
      |                                                                                                  # #             |
      |                                                                                               **** #             |
 1.8x +-+.............................................................................................*..*.#...........+-+
      |                                                                         +++     ####          *  * #             |
      |                                                                         #### ****++#          *  * #             |
 1.6x +-+......................................+++...........................****..#.*++*..#..........*..*.#...........+-+
      |                                        ####                          *++*  # *  *  #     +++  *  * #             |
      |                        +++           ++#++#                          *  *  # *  *  #    ####  *  * #             |
 1.4x +-+...................+++###..........****..#..........................*..*..#.*..*..#....#..#..*..*.#...........+-+
      |                     ****+#          *  *  #                          *  *  # *  *  #  ***  #  *  * #     ####    |
      |                     *++* #     +++  *  *  #                          *  *  # *  *  #  *+*  #  *  * #  ****++#    |
 1.2x +-+...................*..*.#..****###.*..*..#..........................*..*..#.*..*..#..*.*..#..*..*.#..*..*..#..+-+
      |    ****###     +++  *  * #  *  *  # *  *  #                          *  *  # *  *  #  * *  #  *  * #  *  *  #    |
      |    *  *++#  ***###  *  * #  *  *  # *  *  #                          *  *  # *  *  #  * *  #  *  * #  *  *  #    |
   1x +-+--****###--***###--****##--****###-****###--***###--***###--****##--****###-****###--***###--****##--****###--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/1D2VFze

-                                   NBench, x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

  1.1x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                                                                                                                 |
       |       jr+inline                                                                                                 |
 1.08x +jr+hash+noinline        +..............................+++.....................................................+-+
       |  jr+hash+inline                                        |                                                        |
       |                                                     +++|                                                        |
       |                                                      | |+++                                                     |
 1.06x +-+....................................................|.|.|....................................................+-+
       |                                                      |###|                                  +++++               |
       |                                                      |#|#|                                  ###$$$              |
 1.04x +-+.........................+++....+++.+++.............|#|#$$$..............................++#|#++$............+-+
       |                            |+++   |+++|            ****|#| $           +++                 |#+#  $              |
       |                            | |    | | |            * |*+#| $            |+++             **** #  $              |
       |     +++                +++ | |  ****| |            * |* #++$            | |+++           * |* #  $              |
 1.02x +-+....|..................|####$$.*.|*|$$$$.++++++++.*.|*.#..$..........****|.|............*++*.#..$.++++++++...+-+
       |     ***+++              |# |#|$ * |*##| $  |  | |  * |* #  $          * |*| |      +++   *  * #  $ ***###$$     |
       |     *|* |+++  +++ +++  *** |#|$ * |*|#| $ ***###$$ *++* #  $      +++ * |*##$$$   ####++ *  * #  $ *+*++# $     |
    1x +-++-+*+*###+++****-$$$$+*+*++#+$+*++*+#++$+*+*++#+$+*++*-#++$+++-++$$$+*++*+#++$+***++#$$+*++*-#++$+*+*++#+$+-++-+
       |     * *++#$$ *++*|$++$ *|*++# $ *  *+#++$ *+*++#|$ *  * #  $ *** |$+$ *  *|#| $ *+*  #+$ *  * #  $ * *  # $     |
       |     * *  #+$ *  *##  $ *+*  # $ *  * #  $ * *  #+$ *  * #  $ *+*### $ *  *|#++$ * *  # $ *  * #  $ * *  # $     |
       |     * *  # $ *  *|#  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *++# $ *  *+#  $ * *  # $ *  * #  $ * *  # $     |
 0.98x +-+...*.*..#.$.*..*+#..$.*.*..#.$.*..*.#..$.*.*..#.$.*..*.#..$.*.*..#.$.*..*.#..$.*.*..#.$.*..*.#..$.*.*..#.$...+-+
       |     * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $     |
       |     * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $ *  * #  $ * *  # $     |
 0.96x +-+---***###$$-****##$$$-***###$$-****##$$$-***###$$-****##$$$-***###$$-****##$$$-***###$$-****##$$$-***###$$---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/xK9YfOB

-                                    NBench, arm-linux-user. Host: Intel i7-4790K @ 4.00GHz

  1.3x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                            ####                                            +++                                  |
       |     jr+inline              #++#                                           ####                                  |
 1.25x +jr+hash+inline..............#..#...........................................#++#................................+-+
       |                            #  #                                           #  #                                  |
       |                            #  #                                           #  #                                  |
       |                            #  #                                           #  #                                  |
  1.2x +-+..........................#..#..................................####.....#..#................................+-+
       |                            #  #                               +++#++#     #  #                                  |
       |                            #  #                              *****  #     #  #                                  |
 1.15x +-+..........................#..#..............................*+++*..#.....#..#................................+-+
       |                            #  #                              *   *  #  ****  #                                  |
       |                            #  #                              *   *  #  *++*  #                                  |
       |                            #  #                              *   *  #  *  *  #                                  |
  1.1x +-+..........................#..#...............+++............*...*..#..*..*..#................................+-+
       |                            #  #            +++####           *   *  #  *  *  #                         ####     |
       |                            #  #           *****  #           *   *  #  *  *  #                         #  #     |
 1.05x +-+..........................#..#...........*...*..#...........*...*..#..*..*..#...............####......#..#...+-+
       |                            #  #  +++      *   *  #           *   *  #  *  *  #               #++#  *****  #     |
       |                         +++#  #  ****###  *   *  #  ****###  *   *  #  *  *  #            +++#  #  *   *  #     |
       |      ++++++   ****###  *****  #  *++*++#  *   *  #  *++*++#  *   *  #  *  *  #   ++++++   ****  #  *   *  #     |
    1x +-++-+*****###++*++*++#++*+-+*++#+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-*++*++#-+*****###++*++*++#++*+-+*++#+-++-+
       |     *+++*++#  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
 0.95x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/uhIEOA1

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/tb-hash.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 2c27490..b1fe2d0 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -22,6 +22,8 @@
 
 #include "exec/tb-hash-xx.h"
 
+#ifdef CONFIG_SOFTMMU
+
 /* Only the bottom TB_JMP_PAGE_BITS of the jump cache hash bits vary for
    addresses on the same page.  The top bits are the same.  This allows
    TLB invalidation to quickly clear a subset of the hash table.  */
@@ -45,6 +47,16 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
            | (tmp & TB_JMP_ADDR_MASK));
 }
 
+#else
+
+/* In user-mode we can get better hashing because we do not have a TLB */
+static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
+{
+    return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
+}
+
+#endif /* CONFIG_SOFTMMU */
+
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags)
 {
-- 
2.7.4
