Received: from eggs.gnu.org ([2001:4830:134:3::10]:39820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOU-0001kZ-Oo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOS-0005o8-6K
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d4BOR-0005nn-VZ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 28 Apr 2017 15:17:25 -0400
Message-Id: <1493407045-24172-3-git-send-email-cota@braap.org>
In-Reply-To: <1493407045-24172-1-git-send-email-cota@braap.org>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 + 2/2] target/aarch64: optimize indirect
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
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org

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

-                            SPECint06 (test set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz

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
  png: http://imgur.com/R0FXKxP

-                           SPECint06 (train set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz

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
  png: http://imgur.com/DXzwyLP

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5b691fc..46cb6c5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11360,8 +11360,7 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
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
2.7.4
