Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ECEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D128C2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIH5PfaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D128C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7bt-0002LM-16
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TT-0002Im-Fw
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TR-0003bB-G3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ7mWsGG/0PrOwAr1AQV3dwPGBuhCxjZLsYw6HYN+Z4=;
 b=RIH5PfaBuEk26UQzcojIAsA+BonD+nyDEY5plcpstUCm44nmmfMMLOMoD10ze8aBnasohU
 7MGBK1c0yB/tyzlyFz7Lm10ahYYUJRLSeD0BX4NJWyT0yvhYWV87ZB1eGe8O/tj/8QyTT3
 PiULZqkrMW7CaAmJwJODaT/jjEm8Fb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-jdyA_6YXM9K2rQk5CvMLCg-1; Mon, 26 Oct 2020 14:44:02 -0400
X-MC-Unique: jdyA_6YXM9K2rQk5CvMLCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4DD803F50;
 Mon, 26 Oct 2020 18:44:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C60F45D9CA;
 Mon, 26 Oct 2020 18:43:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 08/16] tools/virtiofsd: xattr name mappings: Simple 'map'
Date: Mon, 26 Oct 2020 18:43:23 +0000
Message-Id: <20201026184331.272953-9-dgilbert@redhat.com>
In-Reply-To: <20201026184331.272953-1-dgilbert@redhat.com>
References: <20201026184331.272953-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
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
Message-Id: <20201023165812.36028-6-dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/tools/virtiofsd.rst         |  19 ++++++
 tools/virtiofsd/passthrough_ll.c | 112 ++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index d80c078d80..34a9e40146 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -147,6 +147,7 @@ Each rule consists of a number of fields separated with a separator that is the
 first non-white space character in the rule.  This separator must then be used
 for the whole rule.
 White space may be added before and after each rule.
+
 Using ':' as the separator a rule is of the form:
 
 ``:type:scope:key:prepend:``
@@ -219,6 +220,14 @@ e.g.:
 
   would hide 'security.' xattr's in listxattr from the server.
 
+A simpler 'map' type provides a shorter syntax for the common case:
+
+``:map:key:prepend:``
+
+The 'map' type adds a number of separate rules to add **prepend** as a prefix
+to the matched **key** (or all attributes if **key** is empty).
+There may be at most one 'map' rule and it must be the last rule in the set.
+
 xattr-mapping Examples
 ----------------------
 
@@ -234,6 +243,11 @@ the first rule prefixes and strips 'user.virtiofs.',
 the second rule hides any non-prefixed attributes that
 the host set.
 
+This is equivalent to the 'map' rule:
+
+::
+-o xattrmap=":map::user.virtiofs.:"
+
 2) Prefix 'trusted.' attributes, allow others through
 
 ::
@@ -256,6 +270,11 @@ the 'user.virtiofs.' path directly.
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
index 8c0187498a..a0beb986f3 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2090,6 +2090,109 @@ static void free_xattrmap(struct lo_data *lo)
     lo->xattr_map_nentries = -1;
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
+static void parse_xattrmap_map(struct lo_data *lo,
+                               const char *rule, char sep)
+{
+    const char *tmp;
+    char *key;
+    char *prefix;
+    XattrMapEntry tmp_entry;
+
+    if (*rule != sep) {
+        fuse_log(FUSE_LOG_ERR,
+                 "%s: Expecting '%c' after 'map' keyword, found '%c'\n",
+                 __func__, sep, *rule);
+        exit(1);
+    }
+
+    rule++;
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
+    add_xattrmap_entry(lo, &tmp_entry);
+
+    if (!*key) {
+        /* Prefix all case */
+
+        /* 2nd: Hide any non-prefixed entries on the host */
+        tmp_entry.flags = XATTR_MAP_FLAG_BAD | XATTR_MAP_FLAG_ALL;
+        tmp_entry.key = g_strdup("");
+        tmp_entry.prepend = g_strdup("");
+        add_xattrmap_entry(lo, &tmp_entry);
+    } else {
+        /* Prefix matching case */
+
+        /* 2nd: Hide non-prefixed but matching entries on the host */
+        tmp_entry.flags = XATTR_MAP_FLAG_BAD | XATTR_MAP_FLAG_SERVER;
+        tmp_entry.key = g_strdup(""); /* Not used */
+        tmp_entry.prepend = g_strdup(key);
+        add_xattrmap_entry(lo, &tmp_entry);
+
+        /* 3rd: Stop the client accessing prefixed attributes directly */
+        tmp_entry.flags = XATTR_MAP_FLAG_BAD | XATTR_MAP_FLAG_CLIENT;
+        tmp_entry.key = g_strdup(prefix);
+        tmp_entry.prepend = g_strdup(""); /* Not used */
+        add_xattrmap_entry(lo, &tmp_entry);
+
+        /* 4th: Everything else is OK */
+        tmp_entry.flags = XATTR_MAP_FLAG_OK | XATTR_MAP_FLAG_ALL;
+        tmp_entry.key = g_strdup("");
+        tmp_entry.prepend = g_strdup("");
+        add_xattrmap_entry(lo, &tmp_entry);
+    }
+
+    g_free(key);
+    g_free(prefix);
+}
+
 static void parse_xattrmap(struct lo_data *lo)
 {
     const char *map = lo->xattrmap;
@@ -2118,10 +2221,17 @@ static void parse_xattrmap(struct lo_data *lo)
             tmp_entry.flags |= XATTR_MAP_FLAG_OK;
         } else if (strstart(map, "bad", &map)) {
             tmp_entry.flags |= XATTR_MAP_FLAG_BAD;
+        } else if (strstart(map, "map", &map)) {
+            /*
+             * map is sugar that adds a number of rules, and must be
+             * the last entry.
+             */
+            parse_xattrmap_map(lo, map, sep);
+            return;
         } else {
             fuse_log(FUSE_LOG_ERR,
                      "%s: Unexpected type;"
-                     "Expecting 'prefix', 'ok', or 'bad' in rule %zu\n",
+                     "Expecting 'prefix', 'ok', 'bad' or 'map' in rule %zu\n",
                      __func__, lo->xattr_map_nentries);
             exit(1);
         }
-- 
2.28.0


