Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98931C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BEA20A8B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePx6u9Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BEA20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fwz-0003Jv-83
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2fvm-0001wG-E9
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:15:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2fvh-0001I4-00
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596482123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iocgnh3uJfB58n5Zv7Q4EdmZ30ZGp79FovmlbWyfeio=;
 b=ePx6u9XlHjOnnT2IT9dPoxleIj9waxADIC7PCWdHi6O7VWHcDmB9QZ50XUoxGKcxXHIO8z
 JGuaoUn47J5t0833pvODldpT49jzy/InvNQLvZ0Cavb2Od61cd0Yg4cV8iZkDLE0VwrVmA
 elQuj8wl4vlIbQqx6BRc3jcFSRTUh/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-7xxODRRvM9myel0uOTMvBQ-1; Mon, 03 Aug 2020 15:15:21 -0400
X-MC-Unique: 7xxODRRvM9myel0uOTMvBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFFAB100CCC2
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 19:15:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-35.ams2.redhat.com
 [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A723C6179D;
 Mon,  3 Aug 2020 19:15:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vgoyal@redhat.com, stefanha@redhat.com,
 virtio-fs@redhat.com
Subject: [PATCH 1/3] tools/virtiofsd: xattr name mappings: Add option
Date: Mon,  3 Aug 2020 20:15:09 +0100
Message-Id: <20200803191511.45261-2-dgilbert@redhat.com>
In-Reply-To: <20200803191511.45261-1-dgilbert@redhat.com>
References: <20200803191511.45261-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
the client and host filesystems see different views.
This can be used to have different SELinux mappings as
seen by the guest, to run the virtiofsd with less privileges
(e.g. in a case where it can't set trusted/system/security
xattrs but you want the guest to be able to), or to isolate
multiple users of the same name; e.g. trusted attributes
used by stacking overlayfs.

A mapping engine is used wit 3 simple rules; the rules can
be combined to allow most useful mapping scenarios.
The ruleset is defined by -o xattrmap='rules...'.

This patch doesn't use the rule maps yet.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         |  46 +++++++++
 tools/virtiofsd/passthrough_ll.c | 156 ++++++++++++++++++++++++++++++-
 2 files changed, 201 insertions(+), 1 deletion(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 824e713491..82b6f6d90a 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -107,6 +107,51 @@ Options
   performance.  ``auto`` acts similar to NFS with a 1 second metadata cache
   timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
 
+xattr-mapping
+-------------
+
+By default the name of xattr's used by the client are passe through to the host
+file system.  This can be a problem where either those xattr names are used
+by something on the host (e.g. selinux guest/host confusion) or if the
+virtiofsd is running in a container with restricted priviliges where it cannot
+access some attributes.
+
+A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
+string consists of a series of rules.
+
+Each rule starts and ends with a ':'.  The mapping stops on a matching
+rule.  White space may be added before and after each rule.
+
+:scope:type:key:prepend:
+
+scope= 'c' - match 'key' against a xattr name from the client
+            for setxattr/getxattr/removexattr
+       'h' - match 'prepend' against a xattr name from the host
+            for listxattr
+       both letters can be included to match both cases.
+
+type is one of:
+       'p' Prefixing: If 'key' matches the client then the 'prepend'
+           is added before the name is passed to the host.
+           For a host case, the prepend is tested and stripped
+           if matching.
+
+       'o' OK: The attribute name is OK and passed through to
+           the host unchanged.
+
+       'b' Bad: If a client tries to use this name it's
+           denied using EPERM; when the host passes an attribute
+           name matching it's hidden.
+
+key is a string tested as a prefix on an attribute name originating
+       on the client.  It maybe empty in which case a 'c' rule
+       will always match on client names.
+
+prepend is a string tested as a prefix on an attribute name originiating
+       on the host, and used as a new prefix by 'p'.  It maybe empty
+       in which case a 'h' rule will always match on host names.
+
+
 Examples
 --------
 
@@ -123,3 +168,4 @@ Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
       -numa node,memdev=mem \
       ...
   guest# mount -t virtiofs myfs /mnt
+
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 94e0de2d2b..5506d84132 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -144,6 +144,7 @@ struct lo_data {
     int flock;
     int posix_lock;
     int xattr;
+    char *xattrmap;
     char *source;
     char *modcaps;
     double timeout;
@@ -171,6 +172,7 @@ static const struct fuse_opt lo_opts[] = {
     { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
     { "xattr", offsetof(struct lo_data, xattr), 1 },
     { "no_xattr", offsetof(struct lo_data, xattr), 0 },
+    { "xattrmap=%s", offsetof(struct lo_data, xattrmap), 0 },
     { "modcaps=%s", offsetof(struct lo_data, modcaps), 0 },
     { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
     { "timeout=", offsetof(struct lo_data, timeout_set), 1 },
@@ -2003,7 +2005,154 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
     fuse_reply_err(req, res == -1 ? errno : 0);
 }
 
-static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+typedef struct xattr_map_entry {
+    const char *key;
+    const char *prepend;
+    unsigned int flags;
+} XattrMapEntry;
+
+/*
+ * Exit; process attribute unmodified if matched.
+ * An empty key applies to all.
+ */
+#define XATTR_MAP_FLAG_END_OK  (1 <<  0)
+/*
+ * The attribute is unwanted;
+ * EPERM on write hidden on read.
+ */
+#define XATTR_MAP_FLAG_END_BAD (1 <<  1)
+/*
+ * For attr that start with 'key' prepend 'prepend'
+ * 'key' maybe empty to prepend for all attrs
+ * key is defined from set/remove point of view.
+ * Automatically reversed on read
+ */
+#define XATTR_MAP_FLAG_PREFIX  (1 <<  2)
+/* Apply rule to get/set/remove */
+#define XATTR_MAP_FLAG_CLIENT  (1 << 16)
+/* Apply rule to list */
+#define XATTR_MAP_FLAG_HOST    (1 << 17)
+/* Apply rule to all */
+#define XATTR_MAP_FLAG_ALL   (XATTR_MAP_FLAG_HOST | XATTR_MAP_FLAG_CLIENT)
+
+static XattrMapEntry *xattr_map_list;
+
+static XattrMapEntry *parse_xattrmap(const char *map)
+{
+    XattrMapEntry *res = NULL;
+    size_t nentries = 0;
+    const char *tmp;
+
+    while (*map) {
+        /* Find the : at the start of a rule */
+        if (isspace(*map)) {
+            map++;
+            continue;
+        }
+        if (*map != ':') {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Expecting : or space, found '%c'"
+                     " at start of rule %zu\n",
+                     __func__, *map, nentries + 1);
+            exit(1);
+        }
+        /* Skip the :, now at the start of the 'scope' */
+        map++;
+
+        /* Allocate some space for the rule */
+        res = g_realloc_n(res, ++nentries, sizeof(XattrMapEntry));
+        res[nentries - 1].flags = 0;
+
+        /* Scope is one or both of 'c' or 'h' */
+        do {
+            switch (*map) {
+            case 'c':
+                res[nentries - 1].flags |= XATTR_MAP_FLAG_CLIENT;
+                map++;
+                break;
+            case 'h':
+                res[nentries - 1].flags |= XATTR_MAP_FLAG_HOST;
+                map++;
+                break;
+            case ':':
+                break;
+            default:
+                fuse_log(FUSE_LOG_ERR,
+                         "%s: Expecting 'c', 'h', or ':', found '%c' in scope"
+                         " section of rule %zu\n",
+                         __func__, *map, nentries);
+                exit(1);
+            }
+        } while (*map != ':');
+
+        /* Start of 'type' */
+        switch (*++map) {
+        case 'p':
+            res[nentries - 1].flags |= XATTR_MAP_FLAG_PREFIX;
+            map++;
+            break;
+        case 'o':
+            res[nentries - 1].flags |= XATTR_MAP_FLAG_END_OK;
+            map++;
+            break;
+        case 'b':
+            res[nentries - 1].flags |= XATTR_MAP_FLAG_END_BAD;
+            map++;
+            break;
+        default:
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Expecting 'p', 'o', or 'b', found '%c' in type"
+                     " section of rule %zu\n",
+                     __func__, *map, nentries);
+            exit(1);
+        }
+
+        if (*map++ != ':') {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing ':' at end of type field of rule %zu\n",
+                     __func__, *map, nentries);
+            exit(1);
+        }
+
+        /* At start of 'key' field */
+        tmp = strchr(map, ':');
+        if (!tmp) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing ':' at end of key field of rule %zu",
+                     __func__, *map, nentries);
+            exit(1);
+        }
+        res[nentries - 1].key = g_strndup(map, tmp - map);
+        map = tmp + 1;
+
+        /* At start of 'prepend' field */
+        tmp = strchr(map, ':');
+        if (!tmp) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Missing ':' at end of prepend field of rule %zu",
+                     __func__, *map, nentries);
+            exit(1);
+        }
+        res[nentries - 1].prepend = g_strndup(map, tmp - map);
+        map = tmp + 1;
+        /* End of rule - go around again for another rule */
+    }
+
+    if (!nentries) {
+        fuse_log(FUSE_LOG_ERR, "Empty xattr map\n");
+        exit(1);
+    }
+
+    /* Add a terminaotr to error in cases the user hasn't specified */
+    res = g_realloc_n(res, ++nentries, sizeof(XattrMapEntry));
+    res[nentries - 1].flags = XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD;
+    res[nentries - 1].key = g_strdup("");
+    res[nentries - 1].prepend = g_strdup("");
+
+    return res;
+}
+
+static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
                         size_t size)
 {
     struct lo_data *lo = lo_data(req);
@@ -2909,6 +3058,11 @@ int main(int argc, char *argv[])
     } else {
         lo.source = strdup("/");
     }
+
+    if (lo.xattrmap) {
+        xattr_map_list = parse_xattrmap(lo.xattrmap);
+    }
+
     if (!lo.timeout_set) {
         switch (lo.cache) {
         case CACHE_NONE:
-- 
2.26.2


