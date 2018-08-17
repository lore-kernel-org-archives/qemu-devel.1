Received: from eggs.gnu.org ([2001:4830:134:3::10]:50277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSH-00051U-AL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSF-0008Qc-QW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgSF-0008O5-E1
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:23 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:40 +0200
Message-Id: <20180817150559.16243-42-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 41/60] json: Nicer recovery from invalid
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index ab2453a1e1..4028f39f28 100644
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
@@ -159,10 +160,14 @@ static const uint8_t json_lexer[][256] =  {
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
