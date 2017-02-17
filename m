Received: from eggs.gnu.org ([2001:4830:134:3::10]:41817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cekff-0007XA-HQ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cekfa-0006hk-Kz
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:42:07 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:34899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cekfa-0006hN-H0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:42:02 -0500
Received: by mail-yb0-x242.google.com with SMTP id u130so59316ybb.2
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 07:42:02 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 17 Feb 2017 10:42:00 -0500
Message-Id: <20170217154200.10504-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org

Subject: [PATCH] aarch64: Change ext type to TCGType to fix warnings

To fix the following warnings:

In file included from /users/pranith/qemu/tcg/tcg.c:255:
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:879:24: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
      [-Wenum-conversion]
        tcg_out_cmp(s, ext, a, b, b_const);
        ~~~~~~~~~~~    ^~~
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:893:36: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
      [-Wenum-conversion]
        tcg_out_insn(s, 3201, CBZ, ext, a, offset);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:389:65: note: expanded from macro 'tcg_out_insn'
    glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
                                                                ^
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:895:37: warning: implicit conversion from enumeration type 'TCGMemOp' (aka 'enum TCGMemOp') to different enumeration type 'TCGType' (aka 'enum TCGType')
      [-Wenum-conversion]
        tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:389:65: note: expanded from macro 'tcg_out_insn'
    glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
                                                                ^
/users/pranith/qemu/tcg/aarch64/tcg-target.inc.c:1610:27: warning: implicit conversion from enumeration type 'TCGType' (aka 'enum TCGType') to different enumeration type 'TCGMemOp' (aka 'enum TCGMemOp')
      [-Wenum-conversion]
        tcg_out_brcond(s, ext, a2, a0, a1, const_args[1], arg_label(args[3]));
        ~~~~~~~~~~~~~~    ^~~

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 6d227a5a6a..290de6dae6 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -866,7 +866,7 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
     }
 }
 
-static void tcg_out_brcond(TCGContext *s, TCGMemOp ext, TCGCond c, TCGArg a,
+static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
     intptr_t offset;
@@ -937,7 +937,7 @@ static void tcg_out_addsubi(TCGContext *s, int ext, TCGReg rd,
     }
 }
 
-static inline void tcg_out_addsub2(TCGContext *s, int ext, TCGReg rl,
+static inline void tcg_out_addsub2(TCGContext *s, TCGType ext, TCGReg rl,
                                    TCGReg rh, TCGReg al, TCGReg ah,
                                    tcg_target_long bl, tcg_target_long bh,
                                    bool const_bl, bool const_bh, bool sub)
-- 
2.11.0
