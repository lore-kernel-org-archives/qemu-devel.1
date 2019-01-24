Received: from eggs.gnu.org ([209.51.188.92]:47906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9W-0004Hp-1c
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9U-0004mS-7g
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:45 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:38:25 +0100
Message-Id: <20190124143825.25921-5-armbru@redhat.com>
In-Reply-To: <20190124143825.25921-1-armbru@redhat.com>
References: <20190124143825.25921-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org

From: Christophe Fergeau <cfergeau@redhat.com>

Commit 8bca4613 added support for %% in json strings when interpolating,
but in doing so broke handling of % when not interpolating.

When parse_string() is fed a string token containing '%', it skips the
'%' regardless of ctxt->ap, i.e. even it's not interpolating.  If the
'%' is the string's last character, it fails an assertion.  Else, it
"merely" swallows the '%'.

Fix parse_string() to handle '%' specially only when interpolating.

To gauge the bug's impact, let's review non-interpolating users of this
parser, i.e. code passing NULL context to json_message_parser_init():

* tests/check-qjson.c, tests/test-qobject-input-visitor.c,
  tests/test-visitor-serialization.c

  Plenty of tests, but we still failed to cover the buggy case.

* monitor.c: QMP input

* qga/main.c: QGA input

* qobject_from_json():

  - qobject-input-visitor.c: JSON command line option arguments of
    -display and -blockdev

    Reproducer: -blockdev '{"%"}'

  - block.c: JSON pseudo-filenames starting with "json:"

    Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3

  - block/rbd.c: JSON key pairs

    Pseudo-filenames starting with "rbd:".

Command line, QMP and QGA input are trusted.

Filenames are trusted when they come from command line, QMP or HMP.
They are untrusted when they come from from image file headers.
Example: QCOW2 backing file name.  Note that this is *not* the security
boundary between host and guest.  It's the boundary between host and an
image file from an untrusted source.

Neither failing an assertion nor skipping a character in a filename of
your choice looks exploitable.  Note that we don't support compiling
with NDEBUG.

Fixes: 8bca4613e6cddd948895b8db3def05950463495b
Cc: qemu-stable@nongnu.org
Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Message-Id: <20190102140535.11512-1-cfergeau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
[Commit message extended to discuss impact]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7a7ae9e8d1..d8eb210c0c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -208,11 +208,13 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
             }
             break;
         case '%':
-            if (ctxt->ap && ptr[1] != '%') {
-                parse_error(ctxt, token, "can't interpolate into string");
-                goto out;
+            if (ctxt->ap) {
+                if (ptr[1] != '%') {
+                    parse_error(ctxt, token, "can't interpolate into string");
+                    goto out;
+                }
+                ptr++;
             }
-            ptr++;
             /* fall through */
         default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index d876a7a96e..fa2afccb0a 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -175,6 +175,11 @@ static void utf8_string(void)
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\xCE\xBA\xE1\xBD\xB9\xCF\x83\xCE\xBC\xCE\xB5",
             "\\u03BA\\u1F79\\u03C3\\u03BC\\u03B5",
+        },
+            /* '%' character when not interpolating */
+        {
+            "100%",
+            "100%",
         },
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
-- 
2.17.2
