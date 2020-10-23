Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5646CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B60920E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHTeRxYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B60920E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0gX-0002a8-B3
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0On-0001Ks-07
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0Oc-00059j-Pe
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603472310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpypEx6GSXG1iA90tR9+xmS+weK9zNiwaau8KlRzKu0=;
 b=VHTeRxYkG2Oz027srWjBTIGiBFAxMFsOa6fSJJrw0ivW07SwS/gTVuqc8ktJgEDb3ySEMG
 HSY3xzQmloYXltlVrNfmU/WYrQx/hqM44BYZcEeuEeSmO/Tk/Vm6MbKF03vBtEcOMC3oq1
 vtcaNJt0zb5J8/dh1W3aAhwL8OUenhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-jLideVhSMIiuW8ErOfxJ6Q-1; Fri, 23 Oct 2020 12:58:27 -0400
X-MC-Unique: jLideVhSMIiuW8ErOfxJ6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB4A1074642
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:58:26 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 950EB10013D7;
 Fri, 23 Oct 2020 16:58:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v4 1/5] tools/virtiofsd: xattr name mappings: Add option
Date: Fri, 23 Oct 2020 17:58:08 +0100
Message-Id: <20201023165812.36028-2-dgilbert@redhat.com>
In-Reply-To: <20201023165812.36028-1-dgilbert@redhat.com>
References: <20201023165812.36028-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add an option to define mappings of xattr names so that
the client and server filesystems see different views.
This can be used to have different SELinux mappings as
seen by the guest, to run the virtiofsd with less privileges
(e.g. in a case where it can't set trusted/system/security
xattrs but you want the guest to be able to), or to isolate
multiple users of the same name; e.g. trusted attributes
used by stacking overlayfs.

A mapping engine is used with 3 simple rules; the rules can
be combined to allow most useful mapping scenarios.
The ruleset is defined by -o xattrmap='rules...'.

This patch doesn't use the rule maps yet.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         |  92 ++++++++++++++++
 tools/virtiofsd/passthrough_ll.c | 173 +++++++++++++++++++++++++++++++
 2 files changed, 265 insertions(+)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 7ecee49834..868fa0e97b 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -109,6 +109,98 @@ Options
   timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
   The default is ``auto``.
 
+xattr-mapping
+-------------
+
+By default the name of xattr's used by the client are passed through to the server
+file system.  This can be a problem where either those xattr names are used
+by something on the server (e.g. selinux client/server confusion) or if the
+virtiofsd is running in a container with restricted privileges where it cannot
+access some attributes.
+
+A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
+string consists of a series of rules.
+
+The first matching rule terminates the mapping.
+The set of rules must include a terminating rule to match any remaining attributes
+at the end.
+
+Each rule consists of a number of fields separated with a separator that is the
+first non-white space character in the rule.  This separator must then be used
+for the whole rule.
+White space may be added before and after each rule.
+Using ':' as the separator a rule is of the form:
+
+``:type:scope:key:prepend:``
+
+**scope** is:
+
+- 'client' - match 'key' against a xattr name from the client for
+             setxattr/getxattr/removexattr
+- 'server' - match 'prepend' against a xattr name from the server
+             for listxattr
+- 'all' - can be used to make a single rule where both the server
+          and client matches are triggered.
+
+**type** is one of:
+
+- 'prefix' - is designed to prepend and strip a prefix;  the modified
+  attributes then being passed on to the client/server.
+
+- 'ok' - Causes the rule set to be terminated when a match is found
+  while allowing matching xattr's through unchanged.
+  It is intended both as a way of explicitly terminating
+  the list of rules, and to allow some xattr's to skip following rules.
+
+- 'bad' - If a client tries to use a name matching 'key' it's
+  denied using EPERM; when the server passes an attribute
+  name matching 'prepend' it's hidden.  In many ways it's use is very like
+  'ok' as either an explict terminator or for special handling of certain
+  patterns.
+
+**key** is a string tested as a prefix on an attribute name originating
+on the client.  It maybe empty in which case a 'client' rule
+will always match on client names.
+
+**prepend** is a string tested as a prefix on an attribute name originating
+on the server, and used as a new prefix.  It may be empty
+in which case a 'server' rule will always match on all names from
+the server.
+
+e.g.:
+
+  ``:prefix:client:trusted.:user.virtiofs.:``
+
+  will match 'trusted.' attributes in client calls and prefix them before
+  passing them to the server.
+
+  ``:prefix:server::user.virtiofs.:``
+
+  will strip 'user.virtiofs.' from all server replies.
+
+  ``:prefix:all:trusted.:user.virtiofs.:``
+
+  combines the previous two cases into a single rule.
+
+  ``:ok:client:user.::``
+
+  will allow get/set xattr for 'user.' xattr's and ignore
+  following rules.
+
+  ``:ok:server::security.:``
+
+  will pass 'securty.' xattr's in listxattr from the server
+  and ignore following rules.
+
+  ``:ok:all:::``
+
+  will terminate the rule search passing any remaining attributes
+  in both directions.
+
+  ``:bad:server::security.:``
+
+  would hide 'security.' xattr's in listxattr from the server.
+
 Examples
 --------
 
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index ff53df4451..d47fe3db31 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -64,6 +64,7 @@
 #include <syslog.h>
 #include <unistd.h>
 
+#include "qemu/cutils.h"
 #include "passthrough_helpers.h"
 #include "passthrough_seccomp.h"
 
@@ -137,6 +138,12 @@ enum {
     CACHE_ALWAYS,
 };
 
+typedef struct xattr_map_entry {
+    char *key;
+    char *prepend;
+    unsigned int flags;
+} XattrMapEntry;
+
 struct lo_data {
     pthread_mutex_t mutex;
     int debug;
@@ -144,6 +151,7 @@ struct lo_data {
     int flock;
     int posix_lock;
     int xattr;
+    char *xattrmap;
     char *source;
     char *modcaps;
     double timeout;
@@ -157,6 +165,8 @@ struct lo_data {
     struct lo_map ino_map; /* protected by lo->mutex */
     struct lo_map dirp_map; /* protected by lo->mutex */
     struct lo_map fd_map; /* protected by lo->mutex */
+    XattrMapEntry *xattr_map_list;
+    size_t xattr_map_nentries;
 
     /* An O_PATH file descriptor to /proc/self/fd/ */
     int proc_self_fd;
@@ -172,6 +182,7 @@ static const struct fuse_opt lo_opts[] = {
     { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
     { "xattr", offsetof(struct lo_data, xattr), 1 },
     { "no_xattr", offsetof(struct lo_data, xattr), 0 },
+    { "xattrmap=%s", offsetof(struct lo_data, xattrmap), 0 },
     { "modcaps=%s", offsetof(struct lo_data, modcaps), 0 },
     { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
     { "timeout=", offsetof(struct lo_data, timeout_set), 1 },
@@ -2010,6 +2021,161 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
     fuse_reply_err(req, res == -1 ? errno : 0);
 }
 
+/* types */
+/*
+ * Exit; process attribute unmodified if matched.
+ * An empty key applies to all.
+ */
+#define XATTR_MAP_FLAG_OK      (1 <<  0)
+/*
+ * The attribute is unwanted;
+ * EPERM on write, hidden on read.
+ */
+#define XATTR_MAP_FLAG_BAD     (1 <<  1)
+/*
+ * For attr that start with 'key' prepend 'prepend'
+ * 'key' may be empty to prepend for all attrs
+ * key is defined from set/remove point of view.
+ * Automatically reversed on read
+ */
+#define XATTR_MAP_FLAG_PREFIX  (1 <<  2)
+
+/* scopes */
+/* Apply rule to get/set/remove */
+#define XATTR_MAP_FLAG_CLIENT  (1 << 16)
+/* Apply rule to list */
+#define XATTR_MAP_FLAG_SERVER  (1 << 17)
+/* Apply rule to all */
+#define XATTR_MAP_FLAG_ALL   (XATTR_MAP_FLAG_SERVER | XATTR_MAP_FLAG_CLIENT)
+
+static void add_xattrmap_entry(struct lo_data *lo,
+                               const XattrMapEntry *new_entry)
+{
+    XattrMapEntry *res = g_realloc_n(lo->xattr_map_list,
+                                     lo->xattr_map_nentries + 1,
+                                     sizeof(XattrMapEntry));
+    res[lo->xattr_map_nentries++] = *new_entry;
+
+    lo->xattr_map_list = res;
+}
+
+static void free_xattrmap(struct lo_data *lo)
+{
+    XattrMapEntry *map = lo->xattr_map_list;
+    size_t i;
+
+    if (!map) {
+        return;
+    }
+
+    for (i = 0; i < lo->xattr_map_nentries; i++) {
+        g_free(map[i].key);
+        g_free(map[i].prepend);
+    };
+
+    g_free(map);
+    lo->xattr_map_list = NULL;
+    lo->xattr_map_nentries = -1;
+}
+
+static void parse_xattrmap(struct lo_data *lo)
+{
+    const char *map = lo->xattrmap;
+    const char *tmp;
+
+    lo->xattr_map_nentries = 0;
+    while (*map) {
+        XattrMapEntry tmp_entry;
+        char sep;
+
+        if (isspace(*map)) {
+            map++;
+            continue;
+        }
+        /* The separator is the first non-space of the rule */
+        sep = *map++;
+        if (!sep) {
+            break;
+        }
+
+        tmp_entry.flags = 0;
+        /* Start of 'type' */
+        if (strstart(map, "prefix", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_PREFIX;
+        } else if (strstart(map, "ok", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_OK;
+        } else if (strstart(map, "bad", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_BAD;
+        } else {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Unexpected type;"
+                     "Expecting 'prefix', 'ok', or 'bad' in rule %zu\n",
+                     __func__, lo->xattr_map_nentries);
+            exit(1);
+        }
+
+        if (*map++ != sep) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing '%c' at end of type field of rule %zu\n",
+                     __func__, sep, lo->xattr_map_nentries);
+            exit(1);
+        }
+
+        /* Start of 'scope' */
+        if (strstart(map, "client", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_CLIENT;
+        } else if (strstart(map, "server", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_SERVER;
+        } else if (strstart(map, "all", &map)) {
+            tmp_entry.flags |= XATTR_MAP_FLAG_ALL;
+        } else {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Unexpected scope;"
+                     " Expecting 'client', 'server', or 'all', in rule %zu\n",
+                     __func__, lo->xattr_map_nentries);
+            exit(1);
+        }
+
+        if (*map++ != sep) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Expecting '%c' found '%c'"
+                     " after scope in rule %zu\n",
+                     __func__, sep, *map, lo->xattr_map_nentries);
+            exit(1);
+        }
+
+        /* At start of 'key' field */
+        tmp = strchr(map, sep);
+        if (!tmp) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing '%c' at end of key field of rule %zu",
+                     __func__, sep, lo->xattr_map_nentries);
+            exit(1);
+        }
+        tmp_entry.key = g_strndup(map, tmp - map);
+        map = tmp + 1;
+
+        /* At start of 'prepend' field */
+        tmp = strchr(map, sep);
+        if (!tmp) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing '%c' at end of prepend field of rule %zu",
+                     __func__, sep, lo->xattr_map_nentries);
+            exit(1);
+        }
+        tmp_entry.prepend = g_strndup(map, tmp - map);
+        map = tmp + 1;
+
+        add_xattrmap_entry(lo, &tmp_entry);
+        /* End of rule - go around again for another rule */
+    }
+
+    if (!lo->xattr_map_nentries) {
+        fuse_log(FUSE_LOG_ERR, "Empty xattr map\n");
+        exit(1);
+    }
+}
+
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
                         size_t size)
 {
@@ -2806,6 +2972,8 @@ static void fuse_lo_data_cleanup(struct lo_data *lo)
         close(lo->root.fd);
     }
 
+    free(lo->xattrmap);
+    free_xattrmap(lo);
     free(lo->source);
 }
 
@@ -2906,6 +3074,11 @@ int main(int argc, char *argv[])
     } else {
         lo.source = strdup("/");
     }
+
+    if (lo.xattrmap) {
+        parse_xattrmap(&lo);
+    }
+
     if (!lo.timeout_set) {
         switch (lo.cache) {
         case CACHE_NONE:
-- 
2.28.0


