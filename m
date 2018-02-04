Received: from eggs.gnu.org ([2001:4830:134:3::10]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBes-0004kd-KX
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBer-0004zB-Og
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:02 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBer-0004yy-If
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:01 -0500
Received: by mail-pf0-x242.google.com with SMTP id p1so19466574pfh.4
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:26 -0800
Message-Id: <20180204041136.17525-15-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/24] fpu/soft-fp: Adjust _FP_CMP_CHECK_NAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

The fourth argument to _FP_CMP is a 4-state integer operand that
controls the operation wrt raising exceptions.  However, the usage
that we need within QEMU produces a -Werror=int-in-bool-context:

  error: ?: using integer constants in boolean context, \
  the expression will always evaluate to ‘true’
     glue(FP_CMP_, FS)(r, A, B, float_relation_unordered, (quiet ? 1 : 2));
  note: in definition of macro ‘_FP_CMP_CHECK_NAN’
       if (ex)        \
           ^~

Adding an explicit comparison avoids this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/op-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/op-common.h b/fpu/op-common.h
index c5f33c0148..c4d8b58a03 100644
--- a/fpu/op-common.h
+++ b/fpu/op-common.h
@@ -1242,7 +1242,7 @@
     {									\
       /* The arguments are unordered, which may or may not result in	\
 	 an exception.  */						\
-      if (ex)								\
+      if ((ex) != 0)                                                    \
 	{								\
 	  /* At least some cases of unordered arguments result in	\
 	     exceptions; check whether this is one.  */			\
-- 
2.14.3
