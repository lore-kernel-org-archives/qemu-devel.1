Received: from eggs.gnu.org ([2001:4830:134:3::10]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBp-0006iy-CR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-00005n-OI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008VK-BH
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:19 +0200
Message-Id: <20180808120334.10970-42-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 41/56] json: Nicer recovery from invalid
 leading zero
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

For input 0123, the lexer produces the tokens

    JSON_ERROR    01
    JSON_INTEGER  23

Reporting an error is correct; 0123 is invalid according to RFC 7159.
But the error recovery isn't nice.

Make the finite state machine eat digits before going into the error
state.  The lexer now produces

    JSON_ERROR    0123

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 7a82aab88b..f600cc732e 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -108,6 +108,7 @@ enum json_lexer_state {
     IN_SQ_STRING_ESCAPE,
     IN_SQ_STRING,
     IN_ZERO,
+    IN_BAD_ZERO,
     IN_DIGITS,
     IN_DIGIT,
     IN_EXP_E,
@@ -158,10 +159,14 @@ static const uint8_t json_lexer[][256] =  {
     /* Zero */
     [IN_ZERO] = {
         TERMINAL(JSON_INTEGER),
-        ['0' ... '9'] = IN_ERROR,
+        ['0' ... '9'] = IN_BAD_ZERO,
         ['.'] = IN_MANTISSA,
     },
 
+    [IN_BAD_ZERO] = {
+        ['0' ... '9'] = IN_BAD_ZERO,
+    },
+
     /* Float */
     [IN_DIGITS] = {
         TERMINAL(JSON_FLOAT),
-- 
2.17.1
