Received: from eggs.gnu.org ([2001:4830:134:3::10]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpTb-0005Y9-Ue
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cjpTb-0002t1-7F
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cjpTb-0002rd-0q
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:50:39 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Mar 2017 15:50:30 +0000
Message-Id: <1488556233-31246-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 3/6] disas/m68k: Avoid unintended sign
 extension in get_field()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

In get_field(), we take an 'unsigned char' value and shift it left,
which implicitly promotes it to 'signed int', before ORing it into an
'unsigned long' type.  If 'unsigned long' is 64 bits then this will
result in a sign extension and the top 32 bits of the result will be
1s.  Add explicit casts to unsigned long before shifting to prevent
this.

(Spotted by Coverity, CID 715697.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 disas/m68k.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 073abb9..61b689e 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -4685,10 +4685,11 @@ get_field (const unsigned char *data, enum floatformat_byteorders order,
 	/* This is the last byte; zero out the bits which are not part of
 	   this field.  */
 	result |=
-	  (*(data + cur_byte) & ((1 << (len - cur_bitshift)) - 1))
+	  (unsigned long)(*(data + cur_byte)
+			  & ((1 << (len - cur_bitshift)) - 1))
 	    << cur_bitshift;
       else
-	result |= *(data + cur_byte) << cur_bitshift;
+	result |= (unsigned long)*(data + cur_byte) << cur_bitshift;
       cur_bitshift += FLOATFORMAT_CHAR_BIT;
       if (order == floatformat_little)
 	++cur_byte;
-- 
2.7.4
