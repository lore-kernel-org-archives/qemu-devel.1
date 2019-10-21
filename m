Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E5ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531D620679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgWJCCE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531D620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVmb-0003dn-5i
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPa-0003QQ-Mt
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPY-0003pz-Ss
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPY-0003pr-PC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bd/jhwIcPIkHatwm0oH6IJBsTW/paDkJBBrmDdlrvNM=;
 b=bgWJCCE0PBkT2VuL4pEWjbMmzGclmj+np/h6RB/1cX7ht0q0/F+Lh2IAKbNJuya7hVb0rJ
 hPbK1zHQHa2nLH/MbFhky+i8TZUpaq8xkC/jkKE5JuuqogLpezzZUd3N3ToIj7aeXpW5Ly
 i+iP/7n8JyjYCsdRkYFUNn6H2F4LTnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-cjyEumnrNRi4UFPKO6JGNg-1; Mon, 21 Oct 2019 06:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02923107AD31;
 Mon, 21 Oct 2019 10:59:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C775614C1;
 Mon, 21 Oct 2019 10:59:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 09/30] virtiofsd: Fix fuse_daemonize ignored return values
Date: Mon, 21 Oct 2019 11:58:11 +0100
Message-Id: <20191021105832.36574-10-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cjyEumnrNRi4UFPKO6JGNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

QEMU's compiler enables warnings/errors for ignored values
and the (void) trick used in the fuse code isn't enough.
Turn all the return values into a return value on the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/helper.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/contrib/virtiofsd/helper.c b/contrib/virtiofsd/helper.c
index f7b00db258..958a42b6f4 100644
--- a/contrib/virtiofsd/helper.c
+++ b/contrib/virtiofsd/helper.c
@@ -10,12 +10,10 @@
   See the file COPYING.LIB.
 */
=20
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
 #include "fuse_lowlevel.h"
-#include "mount_util.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
@@ -173,6 +171,7 @@ int fuse_parse_cmdline(struct fuse_args *args,
=20
 int fuse_daemonize(int foreground)
 {
+=09int ret =3D 0, rett;
 =09if (!foreground) {
 =09=09int nullfd;
 =09=09int waiter[2];
@@ -194,8 +193,8 @@ int fuse_daemonize(int foreground)
 =09=09case 0:
 =09=09=09break;
 =09=09default:
-=09=09=09(void) read(waiter[0], &completed, sizeof(completed));
-=09=09=09_exit(0);
+=09=09=09_exit( read(waiter[0], &completed, sizeof(completed) !=3D
+                               sizeof(completed)));
 =09=09}
=20
 =09=09if (setsid() =3D=3D -1) {
@@ -203,26 +202,30 @@ int fuse_daemonize(int foreground)
 =09=09=09return -1;
 =09=09}
=20
-=09=09(void) chdir("/");
+=09=09ret =3D chdir("/");
=20
 =09=09nullfd =3D open("/dev/null", O_RDWR, 0);
 =09=09if (nullfd !=3D -1) {
-=09=09=09(void) dup2(nullfd, 0);
-=09=09=09(void) dup2(nullfd, 1);
-=09=09=09(void) dup2(nullfd, 2);
+=09=09=09rett =3D dup2(nullfd, 0);
+=09=09=09if (!ret) ret =3D rett;
+=09=09=09rett =3D dup2(nullfd, 1);
+=09=09=09if (!ret) ret =3D rett;
+=09=09=09rett =3D dup2(nullfd, 2);
+=09=09=09if (!ret) ret =3D rett;
 =09=09=09if (nullfd > 2)
 =09=09=09=09close(nullfd);
 =09=09}
=20
 =09=09/* Propagate completion of daemon initialization */
 =09=09completed =3D 1;
-=09=09(void) write(waiter[1], &completed, sizeof(completed));
+=09=09rett =3D write(waiter[1], &completed, sizeof(completed));
+=09=09if (!ret) ret =3D rett;
 =09=09close(waiter[0]);
 =09=09close(waiter[1]);
 =09} else {
-=09=09(void) chdir("/");
+=09=09ret =3D chdir("/");
 =09}
-=09return 0;
+=09return ret;
 }
=20
 void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
--=20
2.23.0


