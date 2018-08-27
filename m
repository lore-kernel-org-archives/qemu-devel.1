Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVv-0005ti-5c
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVs-00067q-Fb
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuBVs-00067e-7f
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 09:00:16 +0200
Message-Id: <20180827070021.11931-2-armbru@redhat.com>
In-Reply-To: <20180827070021.11931-1-armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] json: Fix lexer for lookahead character
 beyond '\x7F'
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

The lexer fails to end a valid token when the lookahead character is
beyond '\x7F'.  For instance, input

    true\xC2\xA2

produces the tokens

    JSON_ERROR     true\xC2
    JSON_ERROR     \xA2

The first token should be

    JSON_KEYWORD   true

instead.

The culprit is

    #define TERMINAL(state) [0 ... 0x7F] = (state)

It leaves [0x80..0xFF] zero, i.e. IN_ERROR.  Has always been broken.
Fix it to initialize the complete array.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index e1745a3d95..4867839f66 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -123,7 +123,7 @@ enum json_lexer_state {
 QEMU_BUILD_BUG_ON((int)JSON_MIN <= (int)IN_START_INTERP);
 QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
 
-#define TERMINAL(state) [0 ... 0x7F] = (state)
+#define TERMINAL(state) [0 ... 0xFF] = (state)
 
 /* Return whether TERMINAL is a terminal state and the transition to it
    from OLD_STATE required lookahead.  This happens whenever the table
-- 
2.17.1
