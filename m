Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4735820E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV/xjn/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4735820E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0hd-0003Tc-0J
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0On-0001Le-Fm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW0Oi-0005AE-Ie
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603472312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDwvzkFNIweZmShw1wlRU7uHBoUQJTTBSzbW+CLl6CM=;
 b=TV/xjn/v1APmMflUlLk8f2FaIBkoZX4C+GloCF0ZvPx9u+tty/DBqdNIkCKtPU0hAjpbDT
 VdsfU0qev/3Dy6eOAfQ2McLKscHDesvbyRFsh7Oo+aB9Ax4GwXtmbXocUMOhC8cVR82lb+
 Q1QviIpDrPJnFL5mbGZV4Mo6TqlfR2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-jfg-zVE4PgSounPqtOUYmw-1; Fri, 23 Oct 2020 12:58:31 -0400
X-MC-Unique: jfg-zVE4PgSounPqtOUYmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D45804B7A
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:58:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C628E10013D7;
 Fri, 23 Oct 2020 16:58:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 dinechin@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v4 3/5] tools/virtiofsd: xattr name mappings: Map server xattr
 names
Date: Fri, 23 Oct 2020 17:58:10 +0100
Message-Id: <20201023165812.36028-4-dgilbert@redhat.com>
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

Map xattr names coming from the server, i.e. the host filesystem;
currently this is only from listxattr.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index ec3ef7b50d..57f584ee49 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2217,6 +2217,44 @@ static int xattr_map_client(const struct lo_data *lo, const char *client_name,
     return -EPERM;
 }
 
+/*
+ * For use with listxattr where the server fs gives us a name and we may need
+ * to sanitize this for the client.
+ * Returns a pointer to the result in *out_name
+ *   This is always the original string or the current string with some prefix
+ *   removed; no reallocation is done.
+ * Returns 0 on success
+ * Can return -ENODATA to indicate the name should be dropped from the list.
+ */
+static int xattr_map_server(const struct lo_data *lo, const char *server_name,
+                            const char **out_name)
+{
+    size_t i;
+    const char *end;
+
+    for (i = 0; i < lo->xattr_map_nentries; i++) {
+        const XattrMapEntry *cur_entry = lo->xattr_map_list + i;
+
+        if ((cur_entry->flags & XATTR_MAP_FLAG_SERVER) &&
+            (strstart(server_name, cur_entry->prepend, &end))) {
+            if (cur_entry->flags & XATTR_MAP_FLAG_BAD) {
+                return -ENODATA;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_OK) {
+                *out_name = server_name;
+                return 0;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
+                /* Remove prefix */
+                *out_name = end;
+                return 0;
+            }
+        }
+    }
+
+    return -ENODATA;
+}
+
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
                         size_t size)
 {
@@ -2371,8 +2409,60 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
         if (ret == 0) {
             goto out;
         }
+
+        if (lo->xattr_map_list) {
+            /*
+             * Map the names back, some attributes might be dropped,
+             * some shortened, but not increased, so we shouldn't
+             * run out of room.
+             */
+            size_t out_index, in_index;
+            out_index = 0;
+            in_index = 0;
+            while (in_index < ret) {
+                const char *map_out;
+                char *in_ptr = value + in_index;
+                /* Length of current attribute name */
+                size_t in_len = strlen(value + in_index) + 1;
+
+                int mapret = xattr_map_server(lo, in_ptr, &map_out);
+                if (mapret != -ENODATA && mapret != 0) {
+                    /* Shouldn't happen */
+                    saverr = -mapret;
+                    goto out;
+                }
+                if (mapret == 0) {
+                    /* Either unchanged, or truncated */
+                    size_t out_len;
+                    if (map_out != in_ptr) {
+                        /* +1 copies the NIL */
+                        out_len = strlen(map_out) + 1;
+                    } else {
+                        /* No change */
+                        out_len = in_len;
+                    }
+                    /*
+                     * Move result along, may still be needed for an unchanged
+                     * entry if a previous entry was changed.
+                     */
+                    memmove(value + out_index, map_out, out_len);
+
+                    out_index += out_len;
+                }
+                in_index += in_len;
+            }
+            ret = out_index;
+            if (ret == 0) {
+                goto out;
+            }
+        }
         fuse_reply_buf(req, value, ret);
     } else {
+        /*
+         * xattrmap only ever shortens the result,
+         * so we don't need to do anything clever with the
+         * allocation length here.
+         */
         fuse_reply_xattr(req, ret);
     }
 out_free:
-- 
2.28.0


