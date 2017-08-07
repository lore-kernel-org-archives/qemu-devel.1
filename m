Received: from eggs.gnu.org ([2001:4830:134:3::10]:48975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-0007NN-Jv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIq-0003vG-ET
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:27 +0200
Message-Id: <1502117160-24655-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 23/56] option: Fix type of
 qemu_opt_set_number() parameter @val
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Parameter @val is int64_t.  It's assigned to opt->value.uint, which is
uint64_t, because that's what QemuOpts integers are.  Screwed up when
the function was added in commit b83c18e.  Change @val to uint64_t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/option.h | 2 +-
 util/qemu-option.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index f7338db..d812da4 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -92,7 +92,7 @@ void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp);
 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
                        Error **errp);
-void qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
+void qemu_opt_set_number(QemuOpts *opts, const char *name, uint64_t val,
                          Error **errp);
 typedef int (*qemu_opt_loopfunc)(void *opaque,
                                  const char *name, const char *value,
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9b1dc80..ca4f737 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -579,7 +579,7 @@ void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
     QTAILQ_INSERT_TAIL(&opts->head, opt, next);
 }
 
-void qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
+void qemu_opt_set_number(QemuOpts *opts, const char *name, uint64_t val,
                          Error **errp)
 {
     QemuOpt *opt;
-- 
2.7.5
