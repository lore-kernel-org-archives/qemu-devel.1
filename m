Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F34DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE38220650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhLbCnEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE38220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcGv-0003x6-D7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIY-0004W0-S2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIX-0000FQ-Mr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIX-0000FF-Ih
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zmQoqXTuy3AmkJlK9V5BPRo4oz08bz1cJxtEi8udjo=;
 b=IhLbCnEbvHKaUzfoMjPGiUFJeAJdXNjiHyCLk0+iBEdWFsUUaQ7UakLuqUPmFSf/TFblIN
 dOJgHNFsJr5gm6YmO7yU1MCzkpr750u2+3mPVtkscgMPQAM2C4IpBYZ3re7izd34MZCCKa
 7k91G0LhRsEEjc0KfZUqCVApucwFANk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-UYg3KWsvPGWWtg4SU_Ismg-1; Thu, 24 Oct 2019 07:28:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37886476;
 Thu, 24 Oct 2019 11:28:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7321C93D;
 Thu, 24 Oct 2019 11:28:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 22/25] virtiofsd: set maximum RLIMIT_NOFILE limit
Date: Thu, 24 Oct 2019 12:27:15 +0100
Message-Id: <20191024112718.34657-23-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UYg3KWsvPGWWtg4SU_Ismg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtiofsd can exceed the default open file descriptor limit easily on
most systems.  Take advantage of the fact that it runs as root to set up
the maximum open file descriptor limit allowed on the system (the
nr_open sysctl).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index fe46b25fb6..25f7ad854a 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -53,9 +53,11 @@
 #include <sys/xattr.h>
 #include <sys/capability.h>
 #include <sys/mount.h>
+#include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/wait.h>
=20
+#include <glib.h>
 #include "passthrough_helpers.h"
 #include "seccomp.h"
=20
@@ -2110,6 +2112,36 @@ static void setup_sandbox(struct lo_data *lo)
 =09setup_seccomp();
 }
=20
+/* Raise the maximum number of open file descriptors to the system limit *=
/
+static void setup_nofile_rlimit(void)
+{
+=09gchar *nr_open =3D NULL;
+=09struct rlimit rlim;
+=09long long max;
+
+=09if (!g_file_get_contents("/proc/sys/fs/nr_open", &nr_open, NULL, NULL))=
 {
+=09=09fuse_log(FUSE_LOG_ERR, "unable to read /proc/sys/fs/nr_open\n");
+=09=09exit(1);
+=09}
+
+=09errno =3D 0;
+=09max =3D strtoll(nr_open, NULL, 0);
+=09if (errno) {
+=09=09fuse_log(FUSE_LOG_ERR, "strtoll(%s): %m\n", nr_open);
+=09=09exit(1);
+=09}
+
+=09rlim.rlim_cur =3D max;
+=09rlim.rlim_max =3D max;
+
+=09if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "setrlimit(RLIMIT_NOFILE): %m\n");
+=09=09exit(1);
+=09}
+
+=09g_free(nr_open);
+}
+
 int main(int argc, char *argv[])
 {
 =09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2125,6 +2157,8 @@ int main(int argc, char *argv[])
 =09/* Don't mask creation mode, kernel already did that */
 =09umask(0);
=20
+=09setup_nofile_rlimit();
+
 =09pthread_mutex_init(&lo.mutex, NULL);
 =09lo.root.next =3D lo.root.prev =3D &lo.root;
 =09lo.root.fd =3D -1;
--=20
2.23.0


