Received: from eggs.gnu.org ([2001:4830:134:3::10]:36078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKk-0004Xe-6b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKg-0007jl-VA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYtKg-0007ga-NO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5TDIl18074707
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:21:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jwn7x15qu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:21:01 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 29 Jun 2018 14:20:59 +0100
From: Greg Kurz <groug@kaod.org>
Date: Fri, 29 Jun 2018 15:20:44 +0200
In-Reply-To: <20180629132045.429006-1-groug@kaod.org>
References: <20180629132045.429006-1-groug@kaod.org>
Message-Id: <20180629132045.429006-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/2] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

strchrnul is a GNU extension and thus unavailable on a number of targets.
In the review for a commit removing strchrnul from 9p, I was asked to
create a qemu_strchrnul helper to factor out this functionality.
Do so, and use it in a number of other places in the code base that inlined
the replacement pattern in a place where strchrnul could be used.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 configure             | 18 ++++++++++++++++++
 hmp.c                 |  8 ++++----
 hw/9pfs/9p-local.c    |  2 +-
 include/qemu/cutils.h |  8 ++++++++
 monitor.c             |  8 ++------
 util/cutils.c         | 15 +++++++++++++++
 util/qemu-option.c    |  6 +-----
 util/uri.c            |  6 ++----
 8 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 4d12cfbe3f6a..26944a74be8c 100755
--- a/configure
+++ b/configure
@@ -4793,6 +4793,21 @@ if compile_prog "" "" ; then
     sem_timedwait=yes
 fi
 
+##########################################
+# check if we have strchrnul
+
+strchrnul=no
+cat > $TMPC << EOF
+#include <string.h>
+int main(void);
+// Use a haystack that the compiler shouldn't be able to constant fold
+char *haystack = (char*)&main;
+int main(void) { return strchrnul(haystack, 'x') != &haystack[6]; }
+EOF
+if compile_prog "" "" ; then
+    strchrnul=yes
+fi
+
 ##########################################
 # check if trace backend exists
 
@@ -6276,6 +6291,9 @@ fi
 if test "$sem_timedwait" = "yes" ; then
   echo "CONFIG_SEM_TIMEDWAIT=y" >> $config_host_mak
 fi
+if test "$strchrnul" = "yes" ; then
+  echo "HAVE_STRCHRNUL=y" >> $config_host_mak
+fi
 if test "$byteswap_h" = "yes" ; then
   echo "CONFIG_BYTESWAP_H=y" >> $config_host_mak
 fi
diff --git a/hmp.c b/hmp.c
index 0da0b0ac33ee..933230d8a701 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2140,12 +2140,12 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
     int has_hold_time = qdict_haskey(qdict, "hold-time");
     int hold_time = qdict_get_try_int(qdict, "hold-time", -1);
     Error *err = NULL;
-    char *separator;
+    const char *separator;
     int keyname_len;
 
     while (1) {
-        separator = strchr(keys, '-');
-        keyname_len = separator ? separator - keys : strlen(keys);
+        separator = qemu_strchrnul(keys, '-');
+        keyname_len = separator - keys;
 
         /* Be compatible with old interface, convert user inputted "<" */
         if (keys[0] == '<' && keyname_len == 1) {
@@ -2182,7 +2182,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
             keylist->value->u.qcode.data = idx;
         }
 
-        if (!separator) {
+        if (!*separator) {
             break;
         }
         keys = separator + 1;
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5721eff1e189..828e8d6e5638 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -65,7 +65,7 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
         assert(*path != '/');
 
         head = g_strdup(path);
-        c = strchrnul(path, '/');
+        c = qemu_strchrnul(path, '/');
         if (*c) {
             /* Intermediate path element */
             head[c - path] = 0;
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index a663340b2386..274d419bb707 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -122,6 +122,14 @@ int qemu_strnlen(const char *s, int max_len);
  * Returns: the pointer originally in @input.
  */
 char *qemu_strsep(char **input, const char *delim);
+#ifdef HAVE_STRCHRNUL
+static inline const char *qemu_strchrnul(const char *s, int c)
+{
+    return strchrnul(s, c);
+}
+#else
+const char *qemu_strchrnul(const char *s, int c);
+#endif
 time_t mktimegm(struct tm *tm);
 int qemu_fdatasync(int fd);
 int fcntl_setfl(int fd, int flag);
diff --git a/monitor.c b/monitor.c
index 0730a271728b..80af6a9390f6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -820,9 +820,7 @@ static int compare_cmd(const char *name, const char *list)
     p = list;
     for(;;) {
         pstart = p;
-        p = strchr(p, '|');
-        if (!p)
-            p = pstart + strlen(pstart);
+        p = qemu_strchrnul(p, '|');
         if ((p - pstart) == len && !memcmp(pstart, name, len))
             return 1;
         if (*p == '\0')
@@ -3489,9 +3487,7 @@ static void cmd_completion(Monitor *mon, const char *name, const char *list)
     p = list;
     for(;;) {
         pstart = p;
-        p = strchr(p, '|');
-        if (!p)
-            p = pstart + strlen(pstart);
+        p = qemu_strchrnul(p, '|');
         len = p - pstart;
         if (len > sizeof(cmd) - 2)
             len = sizeof(cmd) - 2;
diff --git a/util/cutils.c b/util/cutils.c
index 0de69e6db4a2..9205e0903166 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -544,6 +544,21 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
 
+/**
+ * Searches for the first occurrence of 'c' in 's', and returns a pointer
+ * to the trailing null byte if none was found.
+ */
+#ifndef HAVE_STRCHRNUL
+const char *qemu_strchrnul(const char *s, int c)
+{
+    const char *e = strchr(s, c);
+    if (!e) {
+        e = s + strlen(s);
+    }
+    return e;
+}
+#endif
+
 /**
  * parse_uint:
  *
diff --git a/util/qemu-option.c b/util/qemu-option.c
index ba44a0895ca3..19761e3eaff0 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -77,11 +77,7 @@ const char *get_opt_value(const char *p, char **value)
 
     *value = NULL;
     while (1) {
-        offset = strchr(p, ',');
-        if (!offset) {
-            offset = p + strlen(p);
-        }
-
+        offset = qemu_strchrnul(p, ',');
         length = offset - p;
         if (*offset != '\0' && *(offset + 1) == ',') {
             length++;
diff --git a/util/uri.c b/util/uri.c
index 8624a7ac23d9..8bdef841208d 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -52,6 +52,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "qemu/uri.h"
 
@@ -2266,10 +2267,7 @@ struct QueryParams *query_params_parse(const char *query)
         /* Find the next separator, or end of the string. */
         end = strchr(query, '&');
         if (!end) {
-            end = strchr(query, ';');
-        }
-        if (!end) {
-            end = query + strlen(query);
+            end = qemu_strchrnul(query, ';');
         }
 
         /* Find the first '=' character between here and end. */
-- 
2.14.4
