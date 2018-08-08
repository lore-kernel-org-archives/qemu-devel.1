Received: from eggs.gnu.org ([2001:4830:134:3::10]:52464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBn-0006gn-Ad
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBj-0008Tp-Ci
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008S9-2i
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:01 +0200
Message-Id: <20180808120334.10970-24-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 23/56] json: Leave rejecting invalid UTF-8 to
 parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Both the lexer and the parser (attempt to) validate UTF-8 in JSON
strings.

The lexer rejects bytes that can't occur in valid UTF-8: \xC0..\xC1,
\xF5..\xFF.  This rejects some, but not all invalid UTF-8.  It also
rejects ASCII control characters \x00..\x1F, in accordance with RFC
7159 (see recent commit "json: Reject unescaped control characters").

When the lexer rejects, it ends the token right after the first bad
byte.  Good when the bad byte is a newline.  Not so good when it's
something like an overlong sequence in the middle of a string.  For
instance, input

    {"abc\xC0\xAFijk": 1}\n

produces the tokens

    JSON_LCURLY   {
    JSON_ERROR    "abc\xC0
    JSON_ERROR    \xAF
    JSON_KEYWORD  ijk
    JSON_ERROR   ": 1}\n

The parser then reports four errors

    Invalid JSON syntax
    Invalid JSON syntax
    JSON parse error, invalid keyword 'ijk'
    Invalid JSON syntax

before it recovers at the newline.

The commit before previous made the parser reject invalid UTF-8
sequences.  Since then, anything the lexer rejects, the parser would
reject as well.  Thus, the lexer's rejecting is unnecessary for
correctness, and harmful for error reporting.

However, we want to keep rejecting ASCII control characters in the
lexer, because that produces the behavior we want for unclosed
strings.

We also need to keep rejecting \xFF in the lexer, because we
documented that as a way to reset the JSON parser
(docs/interop/qmp-spec.txt section 2.6 QGA Synchronization), which
means we can't change how we recover from this error now.  I wish we
hadn't done that.

I think we should treat \xFE the same as \xFF.

Change the lexer to accept \xC0..\xC1 and \xF5..\xFD.  It now rejects
only \x00..\x1F and \xFE..\xFF.  Error reporting for invalid UTF-8 in
strings is much improved, except for \xFE and \xFF.  For the example
above, the lexer now produces

    JSON_LCURLY   {
    JSON_STRING   "abc\xC0\xAFijk"
    JSON_COLON    :
    JSON_INTEGER  1
    JSON_RCURLY

and the parser reports just

    JSON parse error, invalid UTF-8 sequence in string

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 109a7d8bb8..ca1e0e2c03 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -177,8 +177,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = IN_DQ_UCODE0,
     },
     [IN_DQ_STRING] = {
-        [0x20 ... 0xBF] = IN_DQ_STRING,
-        [0xC2 ... 0xF4] = IN_DQ_STRING,
+        [0x20 ... 0xFD] = IN_DQ_STRING,
         ['\\'] = IN_DQ_STRING_ESCAPE,
         ['"'] = JSON_STRING,
     },
@@ -217,8 +216,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = IN_SQ_UCODE0,
     },
     [IN_SQ_STRING] = {
-        [0x20 ... 0xBF] = IN_SQ_STRING,
-        [0xC2 ... 0xF4] = IN_SQ_STRING,
+        [0x20 ... 0xFD] = IN_SQ_STRING,
         ['\\'] = IN_SQ_STRING_ESCAPE,
         ['\''] = JSON_STRING,
     },
-- 
2.17.1
