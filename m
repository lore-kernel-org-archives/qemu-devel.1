Received: from eggs.gnu.org ([2001:4830:134:3::10]:37670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D8-0007KH-LY
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D7-00077f-L2
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D7-00077F-FT
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:13 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA33FC0586AA
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:12 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xJ027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:41 +0100
Message-Id: <20161222152300.32395-7-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/25] rules.mak: speedup save-vars load-vars
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unnesting variables spends a lot of time parsing and executing foreach
and if functions.  Because actually very few variables have to be
saved and restored, a good strategy is to remember what has to be done
in load-vars, and only iterate the right variables in load-vars.
For save-vars, unroll the foreach loop to provide another small
improvement.

This speeds up a "noop" build from around 15.5 seconds on my laptop
to 11.7 (25% roughly).

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rules.mak | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/rules.mak b/rules.mak
index f4839d2..c69863f 100644
--- a/rules.mak
+++ b/rules.mak
@@ -192,15 +192,15 @@ clean: clean-timestamp
 # save-vars
 # Usage: $(call save-vars, vars)
 # Save each variable $v in $vars as save-vars-$v, save their object's
-# variables, then clear $v.
+# variables, then clear $v.  saved-vars-$v contains the variables that
+# where saved for the objects, in order to speedup load-vars.
 define save-vars
     $(foreach v,$1,
         $(eval save-vars-$v := $(value $v))
-        $(foreach o,$($v),
-            $(foreach k,cflags libs objs,
-                $(if $($o-$k),
-                    $(eval save-vars-$o-$k := $($o-$k))
-                    $(eval $o-$k := ))))
+        $(eval saved-vars-$v := $(foreach o,$($v), \
+            $(if $($o-cflags), $o-cflags $(eval save-vars-$o-cflags := $($o-cflags))$(eval $o-cflags := )) \
+            $(if $($o-libs), $o-libs $(eval save-vars-$o-libs := $($o-libs))$(eval $o-libs := )) \
+            $(if $($o-objs), $o-objs $(eval save-vars-$o-objs := $($o-objs))$(eval $o-objs := ))))
         $(eval $v := ))
 endef
 
@@ -213,12 +213,10 @@ define load-vars
     $(eval $2-new-value := $(value $2))
     $(foreach v,$1,
         $(eval $v := $(value save-vars-$v))
-        $(foreach o,$($v),
-            $(foreach k,cflags libs objs,
-                $(if $(save-vars-$o-$k),
-                    $(eval $o-$k := $(save-vars-$o-$k))
-                    $(eval save-vars-$o-$k := ))))
-        $(eval save-vars-$v := ))
+        $(foreach o,$(saved-vars-$v),
+            $(eval $o := $(save-vars-$o)) $(eval save-vars-$o := ))
+        $(eval save-vars-$v := )
+        $(eval saved-vars-$v := ))
     $(eval $2 := $(value $2) $($2-new-value))
 endef
 
-- 
2.9.3
