Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43734C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED3A21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4T05Kk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED3A21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSl9x-0002UY-Hp
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6j-0007JV-UH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kSl6h-0008Gs-ST
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SijZu7DXL8pr3SqLNEV/Mnvf+aeAxCZg1WnVYAKhCWs=;
 b=d4T05Kk1LseQMeKr5rlAqP5Tu0x2LnIjyi0bDgtESOSwH9yMds9VAXnQ8ZiU46ypVP2TBv
 sQcCRTOfodRezcjKhPF2O5YtB4LEGZ4oqgVQyu0oxNG9f4+IrX0IsEBWelrs4iO6OrLdJw
 pzXV3YiQFrkA5a4gcXZiTM/X9NMAubY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-ivKh9la4NWeYlDjou7DiLw-1; Wed, 14 Oct 2020 14:02:33 -0400
X-MC-Unique: ivKh9la4NWeYlDjou7DiLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B654418BE167
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 18:02:31 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-95.ams2.redhat.com
 [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860766EF68;
 Wed, 14 Oct 2020 18:02:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 5/5] tools/virtiofsd: xattr name mappings: Simple 'map'
Date: Wed, 14 Oct 2020 19:02:09 +0100
Message-Id: <20201014180209.49299-6-dgilbert@redhat.com>
In-Reply-To: <20201014180209.49299-1-dgilbert@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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

The mapping rule system implemented in the last few patches is
extremely flexible, but not easy to use.  Add a simple
'map' type as a sprinkling of sugar to make it easy.

e.g.

  -o xattrmap=":map::user.virtiofs.:"

would be sufficient to prefix all xattr's
or

  -o xattrmap=":map:trusted.:user.virtiofs.:"

would just prefix 'trusted.' xattr's and leave
everything else alone.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         |  18 ++++++
 tools/virtiofsd/passthrough_ll.c | 108 ++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 5cb64612ed..e388ef253e 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -127,6 +127,7 @@ Each rule consists of a number of fields separated with a separator that is the
 first non-white space character in the rule.  This separator must then be used
 for the whole rule.
 White space may be added before and after each rule.
+
 Using ':' as the separator a rule is of the form:
 
 ``:type:scope:key:prepend:``
@@ -162,6 +163,13 @@ on the server, and used as a new prefix.  It may be empty
 in which case a 'server' rule will always match on all names from
 the server.
 
+A simpler 'map' type provides a shorter syntax for the common case:
+
+``:map:key:prepend:``
+
+The 'map' type adds a number of separate rules to add **prepend** as a prefix
+to the matched **key** (or all attributes if **key** is empty).
+There may be at most one 'map' rule and it must be the last rule in the set.
 
 xattr-mapping Examples
 ----------------------
@@ -178,6 +186,11 @@ the first rule prefixes and strips 'user.virtiofs.',
 the second rule hides any non-prefixed attributes that
 the host set.
 
+This is equivalent to the 'map' rule:
+
+::
+-o xattrmap=":map::user.virtiofs.:"
+
 2) Prefix 'trusted.' attributes, allow others through
 
 ::
@@ -200,6 +213,11 @@ the 'user.viritofs.' path directly.
 Finally, the fourth rule lets all remaining attributes
 through.
 
+This is equivalent to the 'map' rule:
+
+::
+-o xattrmap="/map/trusted./user.virtiofs./"
+
 3) Hide 'security.' attributes, and allow everything else
 
 ::
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 8406a2ae86..a1b3364ba3 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2074,6 +2074,106 @@ static void free_xattrmap(XattrMapEntry *map)
     g_free(map);
 }
 
+/*
+ * Handle the 'map' type, which is sugar for a set of commands
+ * for the common case of prefixing a subset or everything,
+ * and allowing anything not prefixed through.
+ * It must be the last entry in the stream, although there
+ * can be other entries before it.
+ * The form is:
+ *    :map:key:prefix:
+ *
+ * key maybe empty in which case all entries are prefixed.
+ */
+static XattrMapEntry *parse_xattrmap_map(const char *rule,
+                                         XattrMapEntry *map,
+                                         size_t *nentries)
+{
+    char sep = *rule++;
+    const char *tmp;
+    char *key;
+    char *prefix;
+    XattrMapEntry tmp_entry;
+
+    /* At start of 'key' field */
+    tmp = strchr(rule, sep);
+    if (!tmp) {
+        fuse_log(FUSE_LOG_ERR,
+                 "%s: Missing '%c' at end of key field in map rule\n",
+                 __func__, sep);
+        exit(1);
+    }
+
+    key = g_strndup(rule, tmp - rule);
+    rule = tmp + 1;
+
+    /* At start of prefix field */
+    tmp = strchr(rule, sep);
+    if (!tmp) {
+        fuse_log(FUSE_LOG_ERR,
+                 "%s: Missing '%c' at end of prefix field in map rule\n",
+                 __func__, sep);
+        exit(1);
+    }
+
+    prefix = g_strndup(rule, tmp - rule);
+    rule = tmp + 1;
+
+    /*
+     * This should be the end of the string, we don't allow
+     * any more commands after 'map'.
+     */
+    if (*rule) {
+        fuse_log(FUSE_LOG_ERR,
+                 "%s: Expecting end of command after map, found '%c'\n",
+                 __func__, *rule);
+        exit(1);
+    }
+
+    /* 1st: Prefix matches/everything */
+    tmp_entry.flags = XATTR_MAP_FLAG_PREFIX | XATTR_MAP_FLAG_ALL;
+    tmp_entry.key = g_strdup(key);
+    tmp_entry.prepend = g_strdup(prefix);
+    map = add_xattrmap_entry(map, nentries, &tmp_entry);
+
+    if (!*key) {
+        /* Prefix all case */
+
+        /* 2nd: Hide any non-prefixed entries on the host */
+        tmp_entry.flags = XATTR_MAP_FLAG_END_BAD | XATTR_MAP_FLAG_ALL |
+                          XATTR_MAP_FLAG_LAST;
+        tmp_entry.key = g_strdup("");
+        tmp_entry.prepend = g_strdup("");
+        map = add_xattrmap_entry(map, nentries, &tmp_entry);
+    } else {
+        /* Prefix matching case */
+
+        /* 2nd: Hide non-prefixed but matching entries on the host */
+        tmp_entry.flags = XATTR_MAP_FLAG_END_BAD | XATTR_MAP_FLAG_SERVER;
+        tmp_entry.key = g_strdup(""); /* Not used */
+        tmp_entry.prepend = g_strdup(key);
+        map = add_xattrmap_entry(map, nentries, &tmp_entry);
+
+        /* 3rd: Stop the client accessing prefixed attributes directly */
+        tmp_entry.flags = XATTR_MAP_FLAG_END_BAD | XATTR_MAP_FLAG_CLIENT;
+        tmp_entry.key = g_strdup(prefix);
+        tmp_entry.prepend = g_strdup(""); /* Not used */
+        map = add_xattrmap_entry(map, nentries, &tmp_entry);
+
+        /* 4th: Everything else is OK */
+        tmp_entry.flags = XATTR_MAP_FLAG_END_OK | XATTR_MAP_FLAG_ALL |
+                          XATTR_MAP_FLAG_LAST;
+        tmp_entry.key = g_strdup("");
+        tmp_entry.prepend = g_strdup("");
+        map = add_xattrmap_entry(map, nentries, &tmp_entry);
+    }
+
+    g_free(key);
+    g_free(prefix);
+
+    return map;
+}
+
 static XattrMapEntry *parse_xattrmap(struct lo_data *lo)
 {
     XattrMapEntry *res = NULL;
@@ -2102,10 +2202,16 @@ static XattrMapEntry *parse_xattrmap(struct lo_data *lo)
             tmp_entry.flags |= XATTR_MAP_FLAG_END_OK;
         } else if (strstart(map, "bad", &map)) {
             tmp_entry.flags |= XATTR_MAP_FLAG_END_BAD;
+        } else if (strstart(map, "map", &map)) {
+            /*
+             * map is sugar that adds a number of rules, and must be
+             * the last entry.
+             */
+            return parse_xattrmap_map(map, res, &nentries);
         } else {
             fuse_log(FUSE_LOG_ERR,
                      "%s: Unexpected type;"
-                     "Expecting 'prefix', 'ok', or 'bad' in rule %zu\n",
+                     "Expecting 'prefix', 'ok', 'bad' or 'map' in rule %zu\n",
                      __func__, nentries);
             exit(1);
         }
-- 
2.28.0


