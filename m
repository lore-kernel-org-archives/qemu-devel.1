Received: from eggs.gnu.org ([2001:4830:134:3::10]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fW171-0004uO-0t
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fW16v-0008TP-5c
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:03:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fW16u-0008TD-Vx
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:02:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 21 Jun 2018 16:02:54 +0100
Message-Id: <20180621150254.4922-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: forbid floating point types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Only one existing trace event uses a floating point type.  Unfortunately
float and double cannot be supported since SystemTap does not have
floating point types.

Remove float and double from the whitelist and document this limitation.
Update the migrate_transferred trace event to use uint64_t instead of
double.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.txt        | 5 +++++
 migration/trace-events        | 2 +-
 qapi/trace-events             | 2 +-
 scripts/tracetool/__init__.py | 2 --
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 07abbb345c..6f815ecbd7 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -104,6 +104,11 @@ Trace events should use types as follows:
  * For everything else, use primitive scalar types (char, int, long) wit=
h the
    appropriate signedness.
=20
+ * Avoid floating point types (float and double) because SystemTap does =
not
+   support them.  In most cases it is possible to round to an integer ty=
pe
+   instead.  This may require scaling the value first by multiplying it =
by 1000
+   or the like when digits after the decimal point need to be preserved.
+
 Format strings should reflect the types defined in the trace event.  Tak=
e
 special care to use PRId64 and PRIu64 for int64_t and uint64_t types,
 respectively.  This ensures portability between 32- and 64-bit platforms=
.
diff --git a/migration/trace-events b/migration/trace-events
index 3f67758893..7ea522e453 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -133,7 +133,7 @@ migrate_global_state_post_load(const char *state) "lo=
aded state: %s"
 migrate_global_state_pre_save(const char *state) "saved state: %s"
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_state_too_big(void) ""
-migrate_transferred(uint64_t tranferred, uint64_t time_spent, double ban=
dwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " ba=
ndwidth %g max_size %" PRId64
+migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t b=
andwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " =
bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=3D%d postcopy-st=
ate=3D%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=3D%p=
 ioctype=3D%s"
diff --git a/qapi/trace-events b/qapi/trace-events
index 9e9008a1dc..70e049ea80 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -29,6 +29,6 @@ visit_type_int64(void *v, const char *name, int64_t *ob=
j) "v=3D%p name=3D%s obj=3D%p"
 visit_type_size(void *v, const char *name, uint64_t *obj) "v=3D%p name=3D=
%s obj=3D%p"
 visit_type_bool(void *v, const char *name, bool *obj) "v=3D%p name=3D%s =
obj=3D%p"
 visit_type_str(void *v, const char *name, char **obj) "v=3D%p name=3D%s =
obj=3D%p"
-visit_type_number(void *v, const char *name, double *obj) "v=3D%p name=3D=
%s obj=3D%p"
+visit_type_number(void *v, const char *name, void *obj) "v=3D%p name=3D%=
s obj=3D%p"
 visit_type_any(void *v, const char *name, void *obj) "v=3D%p name=3D%s o=
bj=3D%p"
 visit_type_null(void *v, const char *name, void *obj) "v=3D%p name=3D%s =
obj=3D%p"
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
index b20fac34a3..0e3c9e146c 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -53,8 +53,6 @@ ALLOWED_TYPES =3D [
     "bool",
     "unsigned",
     "signed",
-    "float",
-    "double",
     "int8_t",
     "uint8_t",
     "int16_t",
--=20
2.17.1
