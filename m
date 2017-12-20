Received: from eggs.gnu.org ([2001:4830:134:3::10]:35825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbB-0001NI-T7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRZbA-0002az-CD
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRZbA-0002Zv-4A
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:19:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4ED9EC119CB4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BAE951DE0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:19:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 09:19:27 +0100
Message-Id: <20171220081927.8761-11-armbru@redhat.com>
In-Reply-To: <20171220081927.8761-1-armbru@redhat.com>
References: <20171220081927.8761-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/10] option: Drop unused get_param_value(),
 get_next_param_value()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Their last user went away in commit f51074cdc6, "pci-hotplug-old: Has
been dead for five major releases, bury", v2.3.0.  Remove them, as new
code should use QemuOpts or maybe keyval_parse() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171006131645.17729-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/option.h |  5 -----
 util/qemu-option.c    | 34 ----------------------------------
 2 files changed, 39 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index f7338dbe80..a88c5f02b1 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -31,11 +31,6 @@
 
 const char *get_opt_name(char *buf, int buf_size, const char *p, char delim);
 const char *get_opt_value(char *buf, int buf_size, const char *p);
-int get_next_param_value(char *buf, int buf_size,
-                         const char *tag, const char **pstr);
-int get_param_value(char *buf, int buf_size,
-                    const char *tag, const char *str);
-
 
 void parse_option_size(const char *name, const char *value,
                        uint64_t *ret, Error **errp);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 877c5b4d67..553d3dc552 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -91,40 +91,6 @@ const char *get_opt_value(char *buf, int buf_size, const char *p)
     return p;
 }
 
-int get_next_param_value(char *buf, int buf_size,
-                         const char *tag, const char **pstr)
-{
-    const char *p;
-    char option[128];
-
-    p = *pstr;
-    for(;;) {
-        p = get_opt_name(option, sizeof(option), p, '=');
-        if (*p != '=')
-            break;
-        p++;
-        if (!strcmp(tag, option)) {
-            *pstr = get_opt_value(buf, buf_size, p);
-            if (**pstr == ',') {
-                (*pstr)++;
-            }
-            return strlen(buf);
-        } else {
-            p = get_opt_value(NULL, 0, p);
-        }
-        if (*p != ',')
-            break;
-        p++;
-    }
-    return 0;
-}
-
-int get_param_value(char *buf, int buf_size,
-                    const char *tag, const char *str)
-{
-    return get_next_param_value(buf, buf_size, tag, &str);
-}
-
 static void parse_option_bool(const char *name, const char *value, bool *ret,
                               Error **errp)
 {
-- 
2.13.6
