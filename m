Received: from eggs.gnu.org ([2001:4830:134:3::10]:33236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002Ic-UK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001gO-LT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHod-0001Zz-Fu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFE84804BAAD
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F33A215670B
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:27 +0200
Message-Id: <20180824193206.25475-20-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 19/58] json: Revamp lexer documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-20-armbru@redhat.com>
---
 qobject/json-lexer.c | 80 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index e85e9a78ff..902fe60846 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -18,21 +18,83 @@
 #define MAX_TOKEN_SIZE (64ULL << 20)
 
 /*
- * Required by JSON (RFC 7159):
+ * From RFC 8259 "The JavaScript Object Notation (JSON) Data
+ * Interchange Format", with [comments in brackets]:
  *
- * \"([^\\\"]|\\[\"'\\/bfnrt]|\\u[0-9a-fA-F]{4})*\"
- * -?(0|[1-9][0-9]*)(.[0-9]+)?([eE][-+]?[0-9]+)?
- * [{}\[\],:]
- * [a-z]+   # covers null, true, false
+ * The set of tokens includes six structural characters, strings,
+ * numbers, and three literal names.
  *
- * Extension of '' strings:
+ * These are the six structural characters:
  *
- * '([^\\']|\\[\"'\\/bfnrt]|\\u[0-9a-fA-F]{4})*'
+ *    begin-array     = ws %x5B ws  ; [ left square bracket
+ *    begin-object    = ws %x7B ws  ; { left curly bracket
+ *    end-array       = ws %x5D ws  ; ] right square bracket
+ *    end-object      = ws %x7D ws  ; } right curly bracket
+ *    name-separator  = ws %x3A ws  ; : colon
+ *    value-separator = ws %x2C ws  ; , comma
  *
- * Extension for vararg handling in JSON construction:
+ * Insignificant whitespace is allowed before or after any of the six
+ * structural characters.
+ * [This lexer accepts it before or after any token, which is actually
+ * the same, as the grammar always has structural characters between
+ * other tokens.]
  *
- * %((l|ll|I64)?d|[ipsf])
+ *    ws = *(
+ *           %x20 /              ; Space
+ *           %x09 /              ; Horizontal tab
+ *           %x0A /              ; Line feed or New line
+ *           %x0D )              ; Carriage return
  *
+ * [...] three literal names:
+ *    false null true
+ *  [This lexer accepts [a-z]+, and leaves rejecting unknown literal
+ *  names to the parser.]
+ *
+ * [Numbers:]
+ *
+ *    number = [ minus ] int [ frac ] [ exp ]
+ *    decimal-point = %x2E       ; .
+ *    digit1-9 = %x31-39         ; 1-9
+ *    e = %x65 / %x45            ; e E
+ *    exp = e [ minus / plus ] 1*DIGIT
+ *    frac = decimal-point 1*DIGIT
+ *    int = zero / ( digit1-9 *DIGIT )
+ *    minus = %x2D               ; -
+ *    plus = %x2B                ; +
+ *    zero = %x30                ; 0
+ *
+ * [Strings:]
+ *    string = quotation-mark *char quotation-mark
+ *
+ *    char = unescaped /
+ *        escape (
+ *            %x22 /          ; "    quotation mark  U+0022
+ *            %x5C /          ; \    reverse solidus U+005C
+ *            %x2F /          ; /    solidus         U+002F
+ *            %x62 /          ; b    backspace       U+0008
+ *            %x66 /          ; f    form feed       U+000C
+ *            %x6E /          ; n    line feed       U+000A
+ *            %x72 /          ; r    carriage return U+000D
+ *            %x74 /          ; t    tab             U+0009
+ *            %x75 4HEXDIG )  ; uXXXX                U+XXXX
+ *    escape = %x5C              ; \
+ *    quotation-mark = %x22      ; "
+ *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
+ *
+ *
+ * Extensions over RFC 8259:
+ * - Extra escape sequence in strings:
+ *   0x27 (apostrophe) is recognized after escape, too
+ * - Single-quoted strings:
+ *   Like double-quoted strings, except they're delimited by %x27
+ *   (apostrophe) instead of %x22 (quotation mark), and can't contain
+ *   unescaped apostrophe, but can contain unescaped quotation mark.
+ * - Interpolation:
+ *   interpolation = %((l|ll|I64)[du]|[ipsf])
+ *
+ * Note:
+ * - Input must be encoded in UTF-8.
+ * - Decoding and validating is left to the parser.
  */
 
 enum json_lexer_state {
-- 
2.17.1
