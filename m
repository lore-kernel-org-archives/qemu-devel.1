Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70799C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C80B2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TB/n6el7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C80B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudXJ-0002lv-O8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAS-00042X-Sn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAR-0006KU-Ab
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAR-00069H-3c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ToWv4QW9UcDr800cQKGwqIgPn5FyHttr3h3RgHnwWo=;
 b=TB/n6el7SAspWKXV8+KxG5CfNrsONZ4PVkpaFlavSRSR3cMZsV70OLhT/5jsCSJVVk/c+b
 oQJctRyuavpWDmXaOZWC0z1E0Qe4m1rTV0X0EaA1bfVZlyBnTfWRDqzWlfyaucEJtJw5uc
 +wLcLiU8MpIYKn6SugvuzXWCXiz9TVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-mZJ3Cq0vN4K24l9mmxy-0w-1; Thu, 23 Jan 2020 07:00:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A1B8010E2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57AAD1CB;
 Thu, 23 Jan 2020 12:00:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 078/111] virtiofsd: support nanosecond resolution for file
 timestamp
Date: Thu, 23 Jan 2020 11:58:08 +0000
Message-Id: <20200123115841.138849-79-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mZJ3Cq0vN4K24l9mmxy-0w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

Define HAVE_STRUCT_STAT_ST_ATIM to 1 if `st_atim' is member of `struct
stat' which means support nanosecond resolution for the file timestamp
fields.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure                   | 16 ++++++++++++++++
 tools/virtiofsd/fuse_misc.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/configure b/configure
index 557e4382ea..9bc0441509 100755
--- a/configure
+++ b/configure
@@ -5191,6 +5191,19 @@ if compile_prog "" "" ; then
     strchrnul=3Dyes
 fi
=20
+#########################################
+# check if we have st_atim
+
+st_atim=3Dno
+cat > $TMPC << EOF
+#include <sys/stat.h>
+#include <stddef.h>
+int main(void) { return offsetof(struct stat, st_atim); }
+EOF
+if compile_prog "" "" ; then
+    st_atim=3Dyes
+fi
+
 ##########################################
 # check if trace backend exists
=20
@@ -6886,6 +6899,9 @@ fi
 if test "$strchrnul" =3D "yes" ; then
   echo "HAVE_STRCHRNUL=3Dy" >> $config_host_mak
 fi
+if test "$st_atim" =3D "yes" ; then
+  echo "HAVE_STRUCT_STAT_ST_ATIM=3Dy" >> $config_host_mak
+fi
 if test "$byteswap_h" =3D "yes" ; then
   echo "CONFIG_BYTESWAP_H=3Dy" >> $config_host_mak
 fi
diff --git a/tools/virtiofsd/fuse_misc.h b/tools/virtiofsd/fuse_misc.h
index f252baa752..5c618ce21f 100644
--- a/tools/virtiofsd/fuse_misc.h
+++ b/tools/virtiofsd/fuse_misc.h
@@ -7,6 +7,7 @@
  */
=20
 #include <pthread.h>
+#include "config-host.h"
=20
 /*
  * Versioned symbols cannot be used in some cases because it
--=20
2.24.1


