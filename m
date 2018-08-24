Received: from eggs.gnu.org ([2001:4830:134:3::10]:39111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mi-8G
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxL-00019Z-TT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxL-000195-K8
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B4E1804B9F4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EBFB22026D6D
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:50 +0200
Message-Id: <20180824193206.25475-43-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 42/58] json: Improve names of lexer states
 related to numbers
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
Message-Id: <20180823164025.12553-43-armbru@redhat.com>
---
 qobject/json-lexer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index f1a4b5a430..01417dca9d 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -108,13 +108,13 @@ enum json_lexer_state {
     IN_SQ_STRING_ESCAPE,
     IN_SQ_STRING,
     IN_ZERO,
-    IN_DIGITS,
-    IN_DIGIT,
+    IN_EXP_DIGITS,
+    IN_EXP_SIGN,
     IN_EXP_E,
     IN_MANTISSA,
     IN_MANTISSA_DIGITS,
-    IN_NONZERO_NUMBER,
-    IN_NEG_NONZERO_NUMBER,
+    IN_DIGITS,
+    IN_SIGN,
     IN_KEYWORD,
     IN_INTERP,
     IN_WHITESPACE,
@@ -164,19 +164,19 @@ static const uint8_t json_lexer[][256] =  {
     },
 
     /* Float */
-    [IN_DIGITS] = {
+    [IN_EXP_DIGITS] = {
         TERMINAL(JSON_FLOAT),
-        ['0' ... '9'] = IN_DIGITS,
+        ['0' ... '9'] = IN_EXP_DIGITS,
     },
 
-    [IN_DIGIT] = {
-        ['0' ... '9'] = IN_DIGITS,
+    [IN_EXP_SIGN] = {
+        ['0' ... '9'] = IN_EXP_DIGITS,
     },
 
     [IN_EXP_E] = {
-        ['-'] = IN_DIGIT,
-        ['+'] = IN_DIGIT,
-        ['0' ... '9'] = IN_DIGITS,
+        ['-'] = IN_EXP_SIGN,
+        ['+'] = IN_EXP_SIGN,
+        ['0' ... '9'] = IN_EXP_DIGITS,
     },
 
     [IN_MANTISSA_DIGITS] = {
@@ -191,17 +191,17 @@ static const uint8_t json_lexer[][256] =  {
     },
 
     /* Number */
-    [IN_NONZERO_NUMBER] = {
+    [IN_DIGITS] = {
         TERMINAL(JSON_INTEGER),
-        ['0' ... '9'] = IN_NONZERO_NUMBER,
+        ['0' ... '9'] = IN_DIGITS,
         ['e'] = IN_EXP_E,
         ['E'] = IN_EXP_E,
         ['.'] = IN_MANTISSA,
     },
 
-    [IN_NEG_NONZERO_NUMBER] = {
+    [IN_SIGN] = {
         ['0'] = IN_ZERO,
-        ['1' ... '9'] = IN_NONZERO_NUMBER,
+        ['1' ... '9'] = IN_DIGITS,
     },
 
     /* keywords */
@@ -236,8 +236,8 @@ static const uint8_t json_lexer[][256] =  {
         ['"'] = IN_DQ_STRING,
         ['\''] = IN_SQ_STRING,
         ['0'] = IN_ZERO,
-        ['1' ... '9'] = IN_NONZERO_NUMBER,
-        ['-'] = IN_NEG_NONZERO_NUMBER,
+        ['1' ... '9'] = IN_DIGITS,
+        ['-'] = IN_SIGN,
         ['{'] = JSON_LCURLY,
         ['}'] = JSON_RCURLY,
         ['['] = JSON_LSQUARE,
-- 
2.17.1
