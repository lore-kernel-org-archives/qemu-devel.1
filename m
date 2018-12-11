Received: from eggs.gnu.org ([2001:4830:134:3::10]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPF-0008E4-BO
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmPA-0007W3-Qc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:05:17 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:49 +0100
Message-Id: <20181211180352.19644-28-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/30] cutils: Assert in-range base for
 string-to-integer conversions
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

POSIX states that the value of endptr is unspecified if strtol()
fails with EINVAL due to an invalid base argument.  Since none of
the callers to check_strtox_error() initialized endptr, we could
end up propagating uninitialized data back to a caller on error.
However, passing an out-of-range base is already a sign of poor
programming, so let's just assert that base is in range, at which
point check_strtox_error() can be tightened to assert that it is
receiving an initialized ep that points somewhere within the
caller's original string, regardless of whether strto*() succeeded
or failed with ERANGE.

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181206151856.77503-1-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/cutils.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/cutils.c b/util/cutils.c
index 698bd315bd..0621565930 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -280,6 +280,7 @@ int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result)
 static int check_strtox_error(const char *nptr, char *ep,
                               const char **endptr, int libc_errno)
 {
+    assert(ep >= nptr);
     if (endptr) {
         *endptr = ep;
     }
@@ -327,6 +328,7 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,
     char *ep;
     long long lresult;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -379,6 +381,7 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,
     char *ep;
     long long lresult;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -435,6 +438,7 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
 {
     char *ep;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -477,6 +481,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
 {
     char *ep;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -504,6 +509,7 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
 {
     char *ep;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -527,6 +533,7 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
 {
     char *ep;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
@@ -594,6 +601,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
     char *endp = (char *)s;
     unsigned long long val = 0;
 
+    assert((unsigned) base <= 36 && base != 1);
     if (!s) {
         r = -EINVAL;
         goto out;
-- 
2.19.2
