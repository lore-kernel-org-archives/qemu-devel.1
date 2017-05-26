Received: from eggs.gnu.org ([2001:4830:134:3::10]:40714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbh-0000tg-IV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbf-0008QE-Sq
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:13 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbf-0008Q4-OC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:11 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so2669343qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:17:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:34 -0700
Message-Id: <20170526211638.32301-23-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 22/26] target/aarch64: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Measurements:

[Baseline performance is that before applying this and the previous commit]

-                                    NBench, aarch64-softmmu. Host: Intel i7-4790K @ 4.00GHz

 1.7x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |   cross                                                                                                          |
 1.6x +cross+jr.................................................####...................................................+-+
      |                                                         #++#                                                     |
      |                                                         #  #                                                     |
 1.5x +-+...................................................*****..#...................................................+-+
      |                                                     *+++*  #                                                     |
      |                                                     *   *  #                                                     |
 1.4x +-+...................................................*...*..#...................................................+-+
      |                                                     *   *  #                                                     |
      |                                     #####           *   *  #                                                     |
 1.3x +-+................................****+++#...........*...*..#...................................................+-+
      |                                  *++*   #           *   *  #                                                     |
      |                                  *  *   #           *   *  #                                                     |
 1.2x +-+................................*..*...#...........*...*..#...................................................+-+
      |                                  *  *   #           *   *  #                                                     |
      |                            ####  *  *   #           *   *  #                                                     |
 1.1x +-+.......................+++#..#..*..*...#...........*...*..#...................................................+-+
      |                         ****  #  *  *   #           *   *  #                                        ****####     |
      |                         *  *  #  *  *   #           *   *  #  ****###   +++####            ****###  *  *   #     |
   1x +-++-++++++-++++****###++-*++*++#++*++*+-+#++****+++++*+++*++#++*++*-+#++*****++#++****###-++*++*-+#++*+-*+++#+-++-+
      |     *****###  *  *  #   *  *  #  *  *   #  *++*###  *   *  #  *  *  #  *   *  #  *  *++#   *  *  #  *  *   #     |
      |     *   *++#  *  *  #   *  *  #  *  *   #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #   *  *  #  *  *   #     |
 0.9x +-+---*****###--****###---****###--****####--****###--*****###--****###--*****###--****###---****###--****####---+-+
      ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONNEURAL NUMERIC SORSTRING SORT    hmean
  png: http://imgur.com/qO9ubtk
NB. cross here represents the previous commit.

-                            SPECint06 (test set), aarch64-linux-user. Host: Intel i7-4790K @ 4.00GHz

 1.5x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                       *****                                      |
      |                                                                       *+++*                           jr         |
      |                                                                       *   *                                      |
 1.4x +-+.....................................................................*...*.....................+++............+-+
      |                                                                       *   *                      |               |
      |                                      *****                            *   *                      |               |
      |                                      *   *                            *   *                    *****             |
 1.3x +-+....................................*...*............................*...*....................*.|.*...........+-+
      |                       +++            *   *                            *   *                    * | *             |
      |                      *****           *   *                            *   *                    *+++*             |
      |                      *   *           *   *                            *   *                    *   *             |
 1.2x +-+....................*...*...........*...*............................*...*...........*****....*...*...........+-+
      |     *****            *   *           *   *                            *   *           *   *    *   *    +++      |
      |     *   *            *   *           *   *                            *   *           *   *    *   *   *****     |
      |     *   *            *   *   *****   *   *                            *   *           *   *    *   *   *   *     |
 1.1x +-+...*...*............*...*...*...*...*...*............................*...*....+++....*...*....*...*...*...*...+-+
      |     *   *            *   *   *   *   *   *                            *   *   *****   *   *    *   *   *   *     |
      |     *   *            *   *   *   *   *   *   *****                    *   *   *   *   *   *    *   *   *   *     |
      |     *   *   *****    *   *   *   *   *   *   *   *   ******           *   *   *   *   *   *    *   *   *   *     |
   1x +-++-+*+++*-++*+++*++++*+-+*+++*-++*+++*-++*+++*+++*++-*++++*-++*****+++*++-*+++*++-*+++*+-+*++++*+++*++-*+++*+-++-+
      |     *   *   *   *    *   *   *   *   *   *   *   *   *    *   *+++*   *   *   *   *   *   *    *   *   *   *     |
      |     *   *   *   *    *   *   *   *   *   *   *   *   *    *   *   *   *   *   *   *   *   *    *   *   *   *     |
      |     *   *   *   *    *   *   *   *   *   *   *   *   *    *   *   *   *   *   *   *   *   *    *   *   *   *     |
 0.9x +-+---*****---*****----*****---*****---*****---*****---******---*****---*****---*****---*****----*****---*****---+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/3Dp4vvq

-                           SPECint06 (train set), aarch64-linux-user. Host: Intel i7-4790K @ 4.00GHz

 1.7x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |                                                                                                       jr         |
 1.6x +-+...............................................................................................+++............+-+
      |                                                                                                *****             |
      |                                                                                                *+++*             |
      |                                                                                                *   *             |
 1.5x +-+..............................................................................................*...*...........+-+
      |                                                                        +++                     *   *             |
      |                                                                       *****                    *   *             |
 1.4x +-+.....................................................................*+++*....................*...*...........+-+
      |                                                                       *   *                    *   *             |
      |                                      *****                            *   *                    *   *             |
      |                                      *   *                            *   *   *****            *   *             |
 1.3x +-+....................................*...*............................*...*...*...*............*...*...........+-+
      |                       +++            *   *                            *   *   *   *            *   *             |
      |                      *****           *   *                            *   *   *   *   *****    *   *             |
 1.2x +-+....................*...*...........*...*............................*...*...*...*...*+++*....*...*...*****...+-+
      |                      *   *           *   *                            *   *   *   *   *   *    *   *   *+++*     |
      |     *****            *   *   *****   *   *                            *   *   *   *   *   *    *   *   *   *     |
      |     *   *            *   *   *+++*   *   *                            *   *   *   *   *   *    *   *   *   *     |
 1.1x +-+...*...*............*...*...*...*...*...*............................*...*...*...*...*...*....*...*...*...*...+-+
      |     *   *   *****    *   *   *   *   *   *                    *****   *   *   *   *   *   *    *   *   *   *     |
      |     *   *   *   *    *   *   *   *   *   *    +++    ******   *+++*   *   *   *   *   *   *    *   *   *   *     |
   1x +-+---*****---*****----*****---*****---*****---*****---******---*****---*****---*****---*****----*****---*****---+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/vRrdc9j

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1e28094..e0e8b80 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11361,8 +11361,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
         case DISAS_JUMP:
-            /* indicate that the hash table must be used to find the next TB */
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
         case DISAS_TB_JUMP:
         case DISAS_EXC:
-- 
2.9.4
