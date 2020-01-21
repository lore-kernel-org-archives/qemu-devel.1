Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A8BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0435217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwvlKjZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0435217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittdA-0001ow-9b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgk-0002di-Tb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsgh-0004Sd-1J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsgg-0004SQ-UC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BHAoeMChRyl7bbII5NM5QhM9/YstJI5KgIJy7wDJtU=;
 b=EwvlKjZ9PO4GrGhFM1pnvmXCryNa5FurrUDl6WnEiCYFcjd1SXl9RG60874qii8Gqe8thb
 G4OJzyeVjJwzsBYm8ThPzQpakwNJbbS7RAnsdZubNc9iKw7Ec0quVfxSu7pyfacqwb9B3R
 8kxHT1P2qJDehedCY1blv0X77zdfHa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-gHvm0v3GPRmZB32h3t7SSw-1; Tue, 21 Jan 2020 07:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E11C8017CC;
 Tue, 21 Jan 2020 12:31:13 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A93460CD0;
 Tue, 21 Jan 2020 12:31:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 077/109] virtiofsd: support nanosecond resolution for file
 timestamp
Date: Tue, 21 Jan 2020 12:24:01 +0000
Message-Id: <20200121122433.50803-78-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gHvm0v3GPRmZB32h3t7SSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

Define HAVE_STRUCT_STAT_ST_ATIM to 1 if `st_atim' is member of `struct
stat' which means support nanosecond resolution for the file timestamp
fields.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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


