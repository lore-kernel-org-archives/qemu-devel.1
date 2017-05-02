Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOM-0001q3-Rp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOL-0001dw-2B
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:22 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOK-0001dc-TD
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id c45so21742430qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:46 -0700
Message-Id: <20170502192300.2124-12-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 11/25] tb-hash: improve tb_jmp_cache hash
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Optimizations to cross-page chaining and indirect branches make
performance more sensitive to the hit rate of tb_jmp_cache.
The constraint of reserving some bits for the page number
lowers the achievable quality of the hashing function.

However, user-mode does not have this requirement. Thus,
with this change we use for user-mode a hashing function that
is both faster and of better quality than the previous one.

Measurements:

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

-                           SPECint06 (test set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

 2.2x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |         jr                                                                                                       |
   2x +jr+multhash        +....................................................+++++...................................+-+
      |    jr+hash                                                              |$$$                                     |
      |                                                                         |$+$                                     |
      |                                                                        ### $                                     |
 1.8x +-+......................................................................#|#.$...................................+-+
      |                                                                      ++#+# $                                     |
      |                                                                       |# # $                                     |
 1.6x +-+....................................................................***.#.$....................++$$$..........+-+
      |                                         $$$                          *+* # $                     |$+$            |
      |                       ++$$$           ### $                          * * # $                  +++|$ $            |
      |                     ++###+$           # # $                          * * # $           ###   ****## $            |
 1.4x +-+...................***+#.$.........***.#.$..........................*.*.#.$...........#+#$$.*++*|#.$..........+-+
      |                     *+* # $         * * # $                          * * # $           # # $ *  *+# $            |
      |                     * * # $   +++++ * * # $                          * * # $         *** # $ *  * # $   ###$$    |
 1.2x +-+...................*.*.#.$.***##$$.*.*.#.$..........................*.*.#.$.........*.*.#.$.*..*.#.$.***+#+$..+-+
      |                     * * # $ *+* # $ * * # $   +++                    * * # $ ++###$$ * * # $ *  * # $ * * # $    |
      |    ***##$$          * * # $ * * # $ * * # $ ***##$$          ++###   * * # $ *** #+$ * * # $ *  * # $ * * # $    |
      |    *+*+#+$ ***##$$$ * * # $ * * # $ * * # $ *+* # $ ++####$$ ***+#   * * # $ * * # $ * * # $ *  * # $ * * # $    |
   1x +-++-*+*+#+$+*+*+#-+$+*+*-#+$+*+*+#+$+*+*+#+$+*-*+#+$+***++#+$+*+*+#$$+*+*+#+$+*+*+#+$+*+*-#+$+*+-*+#+$+*+*+#+$-++-+
      |    * * # $ * * #  $ * * # $ * * # $ * * # $ * * # $ * *  # $ * * # $ * * # $ * * # $ * * # $ *  * # $ * * # $    |
      |    * * # $ * * #  $ * * # $ * * # $ * * # $ * * # $ * *  # $ * * # $ * * # $ * * # $ * * # $ *  * # $ * * # $    |
 0.8x +-+--***##$$-***##$$$-***##$$-***##$$-***##$$-***##$$-***###$$-***##$$-***##$$-***##$$-***##$$-****##$$-***##$$--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/4UXTrEc

Here I also tried the hash function suggested by Paolo ("multhash"):

  return ((uint64_t) (pc * 2654435761) >> 32) & (TB_JMP_CACHE_SIZE - 1);

As you can see it is just as good as the other new function ("hash"),
which is what I ended up going with.

-                          SPECint06 (train set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

 2.6x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |     jr                                                                                           ###             |
 2.4x +jr+hash...........................................................................................#.#...........+-+
      |                                                                                                  # #             |
      |                                                                                                  # #             |
 2.2x +-+................................................................................................#.#...........+-+
      |                                                                                                  # #             |
      |                                                                                                  # #             |
   2x +-+................................................................................................#.#...........+-+
      |                                                                                               **** #             |
      |                                                                                               *  * #             |
 1.8x +-+.............................................................................................*..*.#...........+-+
      |                                                                         +++                   *  * #             |
      |                                                                         ####    ####          *  * #             |
 1.6x +-+......................................####.............................#..#.****..#..........*..*.#...........+-+
      |                        +++             #++#                          ****  # *  *  #    ####  *  * #             |
      |                        ###             #  #                          *  *  # *  *  #    #  #  *  * #             |
 1.4x +-+...................****+#..........****..#..........................*..*..#.*..*..#....#..#..*..*.#...........+-+
      |                     *++* #          *  *  #                          *  *  # *  *  #  ***  #  *  * #     ####    |
      |                     *  * #     #### *  *  #                          *  *  # *  *  #  * *  #  *  * #  ****  #    |
 1.2x +-+...................*..*.#..****++#.*..*..#..........................*..*..#.*..*..#..*.*..#..*..*.#..*..*..#..+-+
      |    ****###          *  * #  *  *  # *  *  #                          *  *  # *  *  #  * *  #  *  * #  *  *  #    |
      |    *  *  #  ***###  *  * #  *  *  # *  *  #                  ****##  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
   1x +-+--****###--***###--****##--****###-****###--***###--***###--****##--****###-****###--***###--****##--****###--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/ArCbHqo

-                                    NBench, x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz

 1.12x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                                                                                                                 |
       |     jr                                                           +++                                            |
  1.1x +jr+hash...........................................................####.........................................+-+
       |                                                               +++#| #                                           |
       |                                                                | #++#                                           |
 1.08x +-+................................+++................+++.+++..*****..#.........................................+-+
       |                                   |  +++             |   |   * | *  #                                           |
       |                                   |   |              |   |   *+++*  #                                           |
 1.06x +-+................................****###.............|...|...*...*..#.........................+++.............+-+
       |                                  *| * |#            ****###  *   *  #                          |                |
       |                                  *| *++#            *| * |#  *   *  #                        ####               |
 1.04x +-+................................*++*..#............*|.*.|#..*...*..#........................#.|#.............+-+
       |                                  *  *  #            *++*++#  *   *  #                     +++#++#               |
       |                                  *  *  #            *  *  #  *   *  #                      | #  #   +++####     |
 1.02x +-+................................*..*..#......+++...*..*..#..*...*..#.....................****..#..*****++#...+-+
       |         +++                      *  *  #   +++ |    *  *  #  *   *  #  +++                *| *  #  *+++*  #     |
       |      +++ |    +++ +++   ++++++   *  *  #  *****###  *  *  #  *   *  #   |  +++   ++++++   *++*  #  *   *  #     |
    1x +-++-+++++####++****###++++-+####+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-+++####-+*****###++*++*++#++*+-+*++#+-++-+
       |     *****| #  *++* |#  *****| #  *  *  #  *   *++#  *  *  #  *   *  #  **** |#  *   *  #  *  *  #  *   *  #     |
       |     * | *| #  *  *++#  * | *++#  *  *  #  *   *  #  *  *  #  *   *  #  *| *++#  *   *  #  *  *  #  *   *  #     |
 0.98x +-+...*.|.*++#..*..*..#..*+++*..#..*..*..#..*...*..#..*..*..#..*...*..#..*++*..#..*...*..#..*..*..#..*...*..#...+-+
       |     *+++*  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
 0.96x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/ZXFX0hJ

-                                   NBench, arm-linux-user. Host: Intel i7-4790K @ 4.00GHz

  1.3x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                            ####                                                                                 |
       |     jr                     #  #                                            +++                                  |
 1.25x +jr+hash.....................#..#...........................................####................................+-+
       |                            #  #                                           #  #                                  |
       |                            #  #                                           #  #                                  |
  1.2x +-+..........................#..#...........................................#..#................................+-+
       |                            #  #                                           #  #                                  |
       |                            #  #                                           #  #                                  |
 1.15x +-+..........................#..#...........................................#..#................................+-+
       |                            #  #                                  ####     #  #                                  |
       |                            #  #                                  #  #     #  #                                  |
  1.1x +-+..........................#..#..................................#..#.....#..#................................+-+
       |                            #  #                                  #  #     #  #                         +++      |
       |                            #  #               ####               #  #     #  #                         ####     |
 1.05x +-+..........................#..#...............#..#.....####......#..#.....#..#.........................#..#...+-+
       |                            #  #               #  #     #  #      #  #     #  #                +++      #  #     |
       |                   +++  *****  #     ####  *****  #     #  #   +++#  #  ****  #            ****###      #  #     |
    1x +-++-+*****###++****+++++*+-+*++#+-****++#-+*+++*-+#+++++#++#++*****++#+-*++*++#-+*****-++++*++*++#++*****++#+-++-+
       |     *   *  #  *  * |   *   *  #  *  *  #  *   *  #  ****  #  *   *  #  *  *  #  *   *###  *  *++#  *   *  #     |
       |     *   *  #  *  *###  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
 0.95x +-+...*...*..#..*..*.|#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#...+-+
       |     *   *  #  *  * |#  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  * |#  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
  0.9x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/FfD27ey

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-12-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
