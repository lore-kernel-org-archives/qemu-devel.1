Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOJ-0007RN-Gs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOI-0006xy-Jd
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:19 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:28 +0100
Message-Id: <20181211180352.19644-7-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/30] misc: Avoid UTF-8 in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

While most developers are now using UTF-8 environments, it's
harder to guarantee that error messages will be output to
a multibyte locale. Rather than risking error messages that
get corrupted into mojibake when the user runs qemu in a
non-multibyte locale, let's stick to straight ASCII error
messages, rather than assuming that our use of UTF-8 in source
code string constants will work unchanged in other locales.

Found with:
$ LC_ALL=C git grep -l $'".*[\x80-\xff].*"' origin -- '**/*.[ch]' | cat
origin:hw/misc/tmp105.c
origin:hw/misc/tmp421.c

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181120203628.2367003-1-eblake@redhat.com>
[lv: added command line to find non ASCII characters]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/tmp105.c | 2 +-
 hw/misc/tmp421.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 0918f3a6ea..f6d7163273 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -79,7 +79,7 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
         return;
     }
     if (temp >= 128000 || temp < -128000) {
-        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " °C is out of range",
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
                    temp / 1000, temp % 1000);
         return;
     }
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index c234044305..eeb11000f0 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -153,7 +153,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
     }
 
     if (temp >= maxs[ext_range] || temp < mins[ext_range]) {
-        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " °C is out of range",
+        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " C is out of range",
                    temp / 1000, temp % 1000);
         return;
     }
-- 
2.19.2
