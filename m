Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E5CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207052070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNCoImOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207052070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNx0s-0007vO-6b
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNwRC-0002DO-5f
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006J0-SV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006A2-M8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwhXgl2ciXXzy/J77uxFbsgMEqtSSgjQHtAsTomujWc=;
 b=HNCoImOW7ThhzlzYt0NE/S+6M0KU444n1kqcccb0U1gE4OKjiDEBc27eq5WbD3+C2D+BpH
 yuPuYVis/5h01MPhJBr2HgZptJUxerS0nFlHahb+k/7xCN50SpzERYXY8uE4GXlg3kniV6
 m+r2uCFMLSz8BnIlQJwUvtw6D16CtZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-eJvXOwXeMqC3epOlF6APpQ-1; Fri, 25 Oct 2019 06:02:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F9B147B
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:02:14 +0000 (UTC)
Received: from localhost (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 683E65C1D4;
 Fri, 25 Oct 2019 10:02:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 1/3] WIP virtiofsd: import Linux <fuse.h> header file
Date: Fri, 25 Oct 2019 12:01:50 +0200
Message-Id: <20191025100152.6638-2-stefanha@redhat.com>
In-Reply-To: <20191025100152.6638-1-stefanha@redhat.com>
References: <20191025100152.6638-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eJvXOwXeMqC3epOlF6APpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/vhost-user-fs-test.c needs fuse.h.  The private copy that
virtiofsd has can be replaced with a properly imported file using
update-linux-headers.sh.

TODO rerun update-linux-headers.sh with upstream kernel tree!

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.h                              | 2 +-
 .../fuse_kernel.h =3D> include/standard-headers/linux/fuse.h     | 0
 contrib/virtiofsd/fuse_loop_mt.c                               | 2 +-
 contrib/virtiofsd/fuse_lowlevel.c                              | 2 +-
 contrib/virtiofsd/fuse_virtio.c                                | 2 +-
 scripts/update-linux-headers.sh                                | 3 ++-
 6 files changed, 6 insertions(+), 5 deletions(-)
 rename contrib/virtiofsd/fuse_kernel.h =3D> include/standard-headers/linux=
/fuse.h (100%)

diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 79fb30a1c2..a8c92ff7e0 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -23,7 +23,7 @@
 #endif
=20
 #include "fuse_common.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
=20
 #include <utime.h>
 #include <fcntl.h>
diff --git a/contrib/virtiofsd/fuse_kernel.h b/include/standard-headers/lin=
ux/fuse.h
similarity index 100%
rename from contrib/virtiofsd/fuse_kernel.h
rename to include/standard-headers/linux/fuse.h
diff --git a/contrib/virtiofsd/fuse_loop_mt.c b/contrib/virtiofsd/fuse_loop=
_mt.c
index 2000a8902a..af7b501fac 100644
--- a/contrib/virtiofsd/fuse_loop_mt.c
+++ b/contrib/virtiofsd/fuse_loop_mt.c
@@ -11,7 +11,7 @@
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
 #include "fuse_virtio.h"
=20
 #include <stdio.h>
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 78ccfe3a27..c1a901cb4d 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -10,7 +10,7 @@
 */
=20
 #include "fuse_i.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
 #include "fuse_opt.h"
 #include "fuse_misc.h"
 #include "fuse_virtio.h"
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 533ef24bb7..7a0d0b2603 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
=20
 #include "fuse_i.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "fuse_virtio.h"
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers=
.sh
index f76d77363b..1a627ccd73 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -184,7 +184,8 @@ EOF
=20
 rm -rf "$output/include/standard-headers/linux"
 mkdir -p "$output/include/standard-headers/linux"
-for i in "$tmpdir"/include/linux/*virtio*.h \
+for i in "$tmpdir/include/linux/fuse.h" \
+         "$tmpdir"/include/linux/*virtio*.h \
          "$tmpdir/include/linux/qemu_fw_cfg.h" \
          "$tmpdir/include/linux/input.h" \
          "$tmpdir/include/linux/input-event-codes.h" \
--=20
2.21.0


