Received: from eggs.gnu.org ([2001:4830:134:3::10]:41275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uz-00085G-LY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-0006RZ-Jc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:30 -0400
Message-Id: <1491959850-30756-11-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 10/10] tb-hash: improve tb_jmp_cache hash
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Optimizations to cross-page chaining and indirect jumps make
performance more sensitive to the hit rate of tb_jmp_cache.
The constraint of reserving some bits for the page number
lowers the achievable quality of the hashing function.

However, user-mode does not have this requirement. Thus,
with this change we use for user-mode a hashing function that
is both faster and of better quality than the previous one.

Measurements:

-    specINT 2006 (test set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
                              Y axis: Speedup over 95b31d70

     1.3x+-+-------------------------------------------------------------+-+
         |        jr             $$                                        |
    1.25x+-+....  jr+xxhash      %%  ....................................+-+
         |        jr+hash+inline @@                 +++                    |
     1.2x+-+.............................................................+-+
         |                                          @@@                    |
         |                    +++@@               ++@:@       +++  @@+     |
    1.15x+-+..................$$$@@...............$$@.@.......@@...@@....+-+
         |                    $ $@@               $$@ @      %%@   @@      |
     1.1x+-+..................$.$@@...............$$@.@......%%@.$$@@....+-+
         |          +++@@+    $ $@@               $$@ @    ++%%@+$$@@   +++|
    1.05x+-+.........$$@@.....$.$@@...@@..........$$@.@..@@@.%%@.$$@@...@@-+
         |           $$@@     $ $@@$$$@@          $$% @$$@+@$$%@ $$@@+$$@@ |
         |+$$++++++++$$@@+++@@$ $@@$+$@@+++@@$$+@@$$% @$$@+@$$%@ $$%@ $$@@ |
       1x+-$$@@A$$%@R$$@@R$$@@$_$%@$_$%@$$s@@$$%%@$$%.@$$%.@$$%@.$$%@.$$%@-+
         | $$@@+$$%@ $$%@ $$@@$+$%@$ $%@$$%%@$$+%@$$% @$$% @$$%@ $$%@ $$%@ |
    0.95x+-$$%@.$$%@.$$%@.$$%@$.$%@$.$%@$$.%@$$.%@$$%.@$$%.@$$%@.$$%@.$$%@-+
         | $$%@ $$%@ $$%@ $$%@$ $%@$ $%@$$ %@$$ %@$$% @$$% @$$%@ $$%@ $$%@ |
     0.9x+-$$%@-$$%@-$$%@-$$%@$$$%@$$$%@$$%%@$$%%@$$%@@$$%@@$$%@-$$%@-$$%@-+
           astabzip2 gcc gobmh264rehmlibquantumcfomneperlbensjexalanchmean
  png: http://imgur.com/RiaBuIi

That is, a 6.45% hmean improvement for this commit. Note that this is the
test set, so some benchmarks take almost no time (and therefore aren't that
sensitive to changes here). See "train" results below.

Note also that hashing quality is not the only requirement: xxhash
gives on average the highest hit rates. However, the time spent computing
the hash negates the performance gains coming from the increase in hit rate.
Given these results, I dropped xxhash from subsequent experiments.

-   specINT 2006 (train set), x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz
                              Y axis: Speedup over 95b31d70

    1.4x+-+--------------------------------------------------------------+-+
        |    jr      $$                                           +++      |
        |    jr+hash %%                                            :       |
    1.3x+-+.......................................................%%%....+-+
        |                                               +++  +++  %:%      |
        |                      +++                      %%%   :   %+%      |
    1.2x+-+.....................%%......................%.%..%%%.$$.%....+-+
        |                     ++%%                 %%% $$+%  %:% $$+%      |
        |            +++      $$$%                $$+% $$ %  %:% $$ %      |
    1.1x+-+...........%%......$.$%................$$.%.$$.%.$$.%.$$.%..%%%-+
        |  +++        %%      $ $%            +++ $$ % $$ % $$ % $$ % +%+% |
        | ++%%  +++ ++%% ++%% $ $% $$$+ +++   %%% $$ % $$ % $$ % $$ % $$+% |
      1x+-$$$%RGR%%R$$$%H$$$%P$j$%h$s$%.$$%%..%.%.$$.%.$$.%.$$.%.$$.%.$$.%-+
        | $+$% $$$% $ $% $+$% $ $% $ $% $$+%  % % $$ % $$ % $$ % $$ % $$ % |
        | $ $% $ $% $ $% $ $% $ $% $ $% $$ %  % % $$ % $$ % $$ % $$ % $$ % |
    0.9x+-$.$%.$.$%.$.$%.$.$%.$.$%.$.$%.$$.%..%.%.$$.%.$$.%.$$.%.$$.%.$$.%-+
        | $ $% $ $% $ $% $ $% $ $% $ $% $$ % $$+% $$ % $$ % $$ % $$ % $$ % |
        | $ $% $ $% $ $% $ $% $ $% $ $% $$ % $$ % $$ % $$ % $$ % $$ % $$ % |
    0.8x+-$$$%-$$$%-$$$%-$$$%-$$$%-$$$%-$$%%-$$%%-$$%%-$$%%-$$%%-$$%%-$$%%-+
          astarbzip2 gcc gobmh264rehlibquantumcfomneperlbensjexalancbhmean
  png: http://imgur.com/55iJJgD

That is, a 10.19% hmean improvement for jr+hash (this commit).

-               NBench, arm-linux-user. Host: Intel i7-4790K @ 4.00GHz
                              Y axis: Speedup over 95b31d70

    1.35x+-+-------------------------------------------------------------+-+
         |               @@@   jr              $$                          |
     1.3x+-+.............@.@.  jr+inline       %%  ...@@@................+-+
         |               @ @   jr+inline+hash  @@     @ @                  |
         |               @ @                          @ @                  |
    1.25x+-+.............@.@..........................@.@................+-+
         |               @ @                    @@@   @ @                  |
     1.2x+-+.............@.@..................$$%.@...@.@................+-+
         |               @ @                  $$% @   @ @                  |
         |               @ @        %%@       $$% @  %% @                  |
    1.15x+-+.............@.@........%%@.......$$%.@$$$%.@................+-+
         |               @ @        %%@       $$% @$ $% @                  |
     1.1x+-+.............@.@......$$$%@.......$$%.@$.$%.@...............@@-+
         |               @ @      $ $%@       $$% @$ $% @               @@ |
         |               @ @      $ $%@ $$%%@ $$% @$ $% @            $$%%@ |
    1.05x+-+...........$$%.@$$$%@@$.$%@.$$.%@.$$%.@$.$%.@.........@@.$$.%@-+
         | $$%%@       $$% @$ $% @$ $%@ $$ %@ $$% @$ $% @       %%%@ $$ %@ |
       1x+-$$.%@AR%%%@R$$%B@$G$%P@$T$%@_$$+%@l$$%+@$s$%.@$$$%@.$$.%@.$$.%@-+
         +-$$%%@-$$%%@-$$%@@$$$%@@$$$%@-$$%%@-$$%@@$$$%@@$$$%@-$$%%@-$$%%@-+
        ASSIGNMBITFIELFOFP_EMULATHUFFMANLU_DECOMPNEURNUMERICSTRING_SOhmean
  png: http://imgur.com/i5e1gdY

That is, a 11% hmean perf gain--it almost doubles the perf gain
from implementing the jr optimization.

-              NBench, x86_64-linux-user. Host: Intel i7-4790K @ 4.00GHz

     1.1x+-+-------------------------------------------------------------+-+
         |         jr             $$                                       |
    1.08x+-+.....  jr+inline      %%  ...................................+-+
         |         jr+inline+hash @@                                       |
         | $$ @@                                                           |
    1.06x+-$$.@@.........................%%%.............................+-+
         | $$%%@                         % %                               |
    1.04x+-$$.%@.........................%.%.............................+-+
         | $$ %@         @@@            $$ %                   $$          |
         | $$ %@         @ @  %%        $$ %                   $$%%@       |
    1.02x+-$$.%@........%%.@$$$%@@......$$.%@..%%@@..%%........$$.%@.$$%%@-+
         | $$ %@    @@  %% @$ $% @$$$   $$ %@ $$% @  %%@@$$$%  $$ %@ $$ %@ |
       1x+-$$.%@A$$R@@RG%%B@$G$%P@$T$%P_$$T%@h$$%+@$$$%e@$.$%@.$$.%@.$$.%@-+
         | $$ %@ $$%%@ $$% @$ $% @$ $%  $$ %@ $$% @$ $% @$ $%@ $$ %@ $$ %@ |
    0.98x+-$$.%@.$$.%@.$$%.@$.$%.@$.$%@.$$.%@.$$%.@$.$%.@$.$%@.$$.%@.$$.%@-+
         | $$ %@ $$ %@ $$% @$ $% @$ $%@ $$ %@ $$% @$ $% @$ $%@ $$ %@ $$ %@ |
         | $$ %@ $$ %@ $$% @$ $% @$ $%@ $$ %@ $$% @$ $% @$ $%@ $$ %@ $$ %@ |
    0.96x+-$$.%@.$$.%@.$$%.@$.$%.@$.$%@.$$.%@.$$%.@$.$%.@$.$%@.$$.%@.$$.%@-+
         +-$$%%@-$$%%@-$$%@@$$$%@@$$$%@-$$%%@-$$%@@$$$%@@$$$%@-$$%%@-$$%%@-+
        ASSIGNMBITFIELFOFP_EMULATHUFFMANLU_DECOMPNEURNUMERICSTRING_SOhmean
  png: http://imgur.com/Xu0Owgu

The fact that NBench is not very sensitive to changes here was mentioned
in the previous commit's log. We get a very slight overall decrease in hmean
performance, although some workloads improve as well. Note that there are
no error bars: NBench re-runs itself until confidence on the stability of
the average is >= 95%, and it doesn't report the resulting stddev.

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
