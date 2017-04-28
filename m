Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49Fu-0001Gn-W1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49Fr-00013e-Ub
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:00:31 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:33243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d49Fr-00013P-K3
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:00:27 -0400
Received: by mail-wm0-x22e.google.com with SMTP id i137so12584995wmf.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:00:27 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-14-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-14-rth@twiddle.net>
Date: Fri, 28 Apr 2017 18:00:57 +0100
Message-ID: <87o9vg79h2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 13/19] tb-hash: improve tb_jmp_cache
 hash function in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Optimizations to cross-page chaining and indirect branches make
> performance more sensitive to the hit rate of tb_jmp_cache.
> The constraint of reserving some bits for the page number
> lowers the achievable quality of the hashing function.
>
> However, user-mode does not have this requirement. Thus,
> with this change we use for user-mode a hashing function that
> is both faster and of better quality than the previous one.
>
> Measurements:
>
> Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.
>
> -                           SPECint06 (test set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz
>
>  2.2x +-+--------------------------------------------------------------------------------------------------------------+-+
>       |                                                                                                                  |
>       |         jr                                                                                                       |
>    2x +jr+multhash        +....................................................+++++...................................+-+
>       |    jr+hash                                                              |$$$                                     |
>       |                                                                         |$+$                                     |
>       |                                                                        ### $                                     |
>  1.8x +-+......................................................................#|#.$...................................+-+
>       |                                                                      ++#+# $                                     |
>       |                                                                       |# # $                                     |
>  1.6x +-+....................................................................***.#.$....................++$$$..........+-+
>       |                                         $$$                          *+* # $                     |$+$            |
>       |                       ++$$$           ### $                          * * # $                  +++|$ $            |
>       |                     ++###+$           # # $                          * * # $           ###   ****## $            |
>  1.4x +-+...................***+#.$.........***.#.$..........................*.*.#.$...........#+#$$.*++*|#.$..........+-+
>       |                     *+* # $         * * # $                          * * # $           # # $ *  *+# $            |
>       |                     * * # $   +++++ * * # $                          * * # $         *** # $ *  * # $   ###$$    |
>  1.2x +-+...................*.*.#.$.***##$$.*.*.#.$..........................*.*.#.$.........*.*.#.$.*..*.#.$.***+#+$..+-+
>       |                     * * # $ *+* # $ * * # $   +++                    * * # $ ++###$$ * * # $ *  * # $ * * # $    |
>       |    ***##$$          * * # $ * * # $ * * # $ ***##$$          ++###   * * # $ *** #+$ * * # $ *  * # $ * * # $    |
>       |    *+*+#+$ ***##$$$ * * # $ * * # $ * * # $ *+* # $ ++####$$ ***+#   * * # $ * * # $ * * # $ *  * # $ * * # $    |
>    1x +-++-*+*+#+$+*+*+#-+$+*+*-#+$+*+*+#+$+*+*+#+$+*-*+#+$+***++#+$+*+*+#$$+*+*+#+$+*+*+#+$+*+*-#+$+*+-*+#+$+*+*+#+$-++-+
>       |    * * # $ * * #  $ * * # $ * * # $ * * # $ * * # $ * *  # $ * * # $ * * # $ * * # $ * * # $ *  * # $ * * # $    |
>       |    * * # $ * * #  $ * * # $ * * # $ * * # $ * * # $ * *  # $ * * # $ * * # $ * * # $ * * # $ *  * # $ * * # $    |
>  0.8x +-+--***##$$-***##$$$-***##$$-***##$$-***##$$-***##$$-***###$$-***##$$-***##$$-***##$$-***##$$-****##$$-***##$$--+-+
>          astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
>   png: http://imgur.com/4UXTrEc
>
> Here I also tried the hash function suggested by Paolo ("multhash"):
>
>   return ((uint64_t) (pc * 2654435761) >> 32) & (TB_JMP_CACHE_SIZE - 1);
>
> As you can see it is just as good as the other new function ("hash"),
> which is what I ended up going with.
>
> -                          SPECint06 (train set), x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz
>
>  2.6x +-+--------------------------------------------------------------------------------------------------------------+-+
>       |                                                                                                                  |
>       |     jr                                                                                           ###             |
>  2.4x +jr+hash...........................................................................................#.#...........+-+
>       |                                                                                                  # #             |
>       |                                                                                                  # #             |
>  2.2x +-+................................................................................................#.#...........+-+
>       |                                                                                                  # #             |
>       |                                                                                                  # #             |
>    2x +-+................................................................................................#.#...........+-+
>       |                                                                                               **** #             |
>       |                                                                                               *  * #             |
>  1.8x +-+.............................................................................................*..*.#...........+-+
>       |                                                                         +++                   *  * #             |
>       |                                                                         ####    ####          *  * #             |
>  1.6x +-+......................................####.............................#..#.****..#..........*..*.#...........+-+
>       |                        +++             #++#                          ****  # *  *  #    ####  *  * #             |
>       |                        ###             #  #                          *  *  # *  *  #    #  #  *  * #             |
>  1.4x +-+...................****+#..........****..#..........................*..*..#.*..*..#....#..#..*..*.#...........+-+
>       |                     *++* #          *  *  #                          *  *  # *  *  #  ***  #  *  * #     ####    |
>       |                     *  * #     #### *  *  #                          *  *  # *  *  #  * *  #  *  * #  ****  #    |
>  1.2x +-+...................*..*.#..****++#.*..*..#..........................*..*..#.*..*..#..*.*..#..*..*.#..*..*..#..+-+
>       |    ****###          *  * #  *  *  # *  *  #                          *  *  # *  *  #  * *  #  *  * #  *  *  #    |
>       |    *  *  #  ***###  *  * #  *  *  # *  *  #                  ****##  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
>    1x +-+--****###--***###--****##--****###-****###--***###--***###--****##--****###-****###--***###--****##--****###--+-+
>          astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
>   png: http://imgur.com/ArCbHqo
>
> -                                    NBench, x86_64-linux-user. Host: Intel i7-6700K @ 4.00GHz
>
>  1.12x +-+-------------------------------------------------------------------------------------------------------------+-+
>        |                                                                                                                 |
>        |     jr                                                           +++                                            |
>   1.1x +jr+hash...........................................................####.........................................+-+
>        |                                                               +++#| #                                           |
>        |                                                                | #++#                                           |
>  1.08x +-+................................+++................+++.+++..*****..#.........................................+-+
>        |                                   |  +++             |   |   * | *  #                                           |
>        |                                   |   |              |   |   *+++*  #                                           |
>  1.06x +-+................................****###.............|...|...*...*..#.........................+++.............+-+
>        |                                  *| * |#            ****###  *   *  #                          |                |
>        |                                  *| *++#            *| * |#  *   *  #                        ####               |
>  1.04x +-+................................*++*..#............*|.*.|#..*...*..#........................#.|#.............+-+
>        |                                  *  *  #            *++*++#  *   *  #                     +++#++#               |
>        |                                  *  *  #            *  *  #  *   *  #                      | #  #   +++####     |
>  1.02x +-+................................*..*..#......+++...*..*..#..*...*..#.....................****..#..*****++#...+-+
>        |         +++                      *  *  #   +++ |    *  *  #  *   *  #  +++                *| *  #  *+++*  #     |
>        |      +++ |    +++ +++   ++++++   *  *  #  *****###  *  *  #  *   *  #   |  +++   ++++++   *++*  #  *   *  #     |
>     1x +-++-+++++####++****###++++-+####+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-+++####-+*****###++*++*++#++*+-+*++#+-++-+
>        |     *****| #  *++* |#  *****| #  *  *  #  *   *++#  *  *  #  *   *  #  **** |#  *   *  #  *  *  #  *   *  #     |
>        |     * | *| #  *  *++#  * | *++#  *  *  #  *   *  #  *  *  #  *   *  #  *| *++#  *   *  #  *  *  #  *   *  #     |
>  0.98x +-+...*.|.*++#..*..*..#..*+++*..#..*..*..#..*...*..#..*..*..#..*...*..#..*++*..#..*...*..#..*..*..#..*...*..#...+-+
>        |     *+++*  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>        |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>  0.96x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
>        ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
>   png: http://imgur.com/ZXFX0hJ
>
> -                                   NBench, arm-linux-user. Host: Intel i7-4790K @ 4.00GHz
>
>   1.3x +-+-------------------------------------------------------------------------------------------------------------+-+
>        |                            ####                                                                                 |
>        |     jr                     #  #                                            +++                                  |
>  1.25x +jr+hash.....................#..#...........................................####................................+-+
>        |                            #  #                                           #  #                                  |
>        |                            #  #                                           #  #                                  |
>   1.2x +-+..........................#..#...........................................#..#................................+-+
>        |                            #  #                                           #  #                                  |
>        |                            #  #                                           #  #                                  |
>  1.15x +-+..........................#..#...........................................#..#................................+-+
>        |                            #  #                                  ####     #  #                                  |
>        |                            #  #                                  #  #     #  #                                  |
>   1.1x +-+..........................#..#..................................#..#.....#..#................................+-+
>        |                            #  #                                  #  #     #  #                         +++      |
>        |                            #  #               ####               #  #     #  #                         ####     |
>  1.05x +-+..........................#..#...............#..#.....####......#..#.....#..#.........................#..#...+-+
>        |                            #  #               #  #     #  #      #  #     #  #                +++      #  #     |
>        |                   +++  *****  #     ####  *****  #     #  #   +++#  #  ****  #            ****###      #  #     |
>     1x +-++-+*****###++****+++++*+-+*++#+-****++#-+*+++*-+#+++++#++#++*****++#+-*++*++#-+*****-++++*++*++#++*****++#+-++-+
>        |     *   *  #  *  * |   *   *  #  *  *  #  *   *  #  ****  #  *   *  #  *  *  #  *   *###  *  *++#  *   *  #     |
>        |     *   *  #  *  *###  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>  0.95x +-+...*...*..#..*..*.|#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#...+-+
>        |     *   *  #  *  * |#  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>        |     *   *  #  *  * |#  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
>   0.9x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
>        ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
>   png: http://imgur.com/FfD27ey
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-12-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  include/exec/tb-hash.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
> index 2c27490..b1fe2d0 100644
> --- a/include/exec/tb-hash.h
> +++ b/include/exec/tb-hash.h
> @@ -22,6 +22,8 @@
>
>  #include "exec/tb-hash-xx.h"
>
> +#ifdef CONFIG_SOFTMMU
> +
>  /* Only the bottom TB_JMP_PAGE_BITS of the jump cache hash bits vary for
>     addresses on the same page.  The top bits are the same.  This allows
>     TLB invalidation to quickly clear a subset of the hash table.  */
> @@ -45,6 +47,16 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
>             | (tmp & TB_JMP_ADDR_MASK));
>  }
>
> +#else
> +
> +/* In user-mode we can get better hashing because we do not have a TLB */
> +static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
> +{
> +    return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
> +}
> +
> +#endif /* CONFIG_SOFTMMU */
> +
>  static inline
>  uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags)
>  {

I'll note when I've plotted hit-rates against the cache we don't seem to
be making a good even use of the cache over time. But I suspect there is
more that could be done here. That said the numbers are compelling so:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
