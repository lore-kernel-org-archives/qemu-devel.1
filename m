Received: from eggs.gnu.org ([2001:4830:134:3::10]:35979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNJ-0000yv-Bj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNE-00011e-J6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:33 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 18 Dec 2018 15:28:50 +0100
Message-Id: <20181218142851.9477-4-laurent@vivier.eu>
In-Reply-To: <20181218142851.9477-1-laurent@vivier.eu>
References: <20181218142851.9477-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/4] vl: Use error_fatal to simplify obvious
 fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Patch created mechanically by rerunning:

    $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
             --macro-file scripts/cocci-macro-file.h vl.c

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181213175807.12039-1-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 vl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 2a8b2ee16d..530fad6a71 100644
--- a/vl.c
+++ b/vl.c
@@ -3133,11 +3133,8 @@ int main(int argc, char **argv, char **envp)
                     Visitor *v;
                     BlockdevOptions_queue *bdo;
 
-                    v = qobject_input_visitor_new_str(optarg, "driver", &err);
-                    if (!v) {
-                        error_report_err(err);
-                        exit(1);
-                    }
+                    v = qobject_input_visitor_new_str(optarg, "driver",
+                                                      &error_fatal);
 
                     bdo = g_new(BlockdevOptions_queue, 1);
                     visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
-- 
2.19.2
