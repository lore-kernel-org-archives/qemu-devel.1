Received: from eggs.gnu.org ([2001:4830:134:3::10]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipandas1990@gmail.com>) id 1dCjTk-0003O5-O2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipandas1990@gmail.com>) id 1dCjTh-0000MD-JJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:18:16 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sandipandas1990@gmail.com>)
	id 1dCjTh-0000Lj-EE
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:18:13 -0400
Received: by mail-pf0-x241.google.com with SMTP id w69so18738743pfk.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 02:18:13 -0700 (PDT)
From: Sandipan Das <sandipandas1990@gmail.com>
Date: Mon, 22 May 2017 14:47:59 +0530
Message-Id: <1495444679-7736-1-git-send-email-sandipandas1990@gmail.com>
Subject: [Qemu-devel] [PATCH risu v2] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nikunj@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, joserz@linux.vnet.ibm.com

The patterns for the following instructions are fixed:
 * Rotate Left Doubleword then Clear Right (rldcr[.])
 * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
 * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])

The first instruction has a typo. For the other two instructions,
the extended opcodes are incorrect and the shift field 'sha' is
absent. Also, the shift field 'sh' should be used in place of the
register field 'rb'.

Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
---
 ppc64.risu | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ppc64.risu b/ppc64.risu
index 28df9da..dd304e2 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -1451,7 +1451,7 @@ RLDCLd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10001 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 
 # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
-RLCDR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
+RLDCR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
 RLDCRd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10011 \
@@ -1472,17 +1472,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6 000 sha:1 1 \
 !constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
 
 # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
-RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00010 \
+RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
-RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00011 \
+RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 1 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 
 # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
-RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00110 \
+RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
-RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00111 \
+RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1 \
 !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
 
 # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word Immediate then Mask Insert
-- 
2.7.4
