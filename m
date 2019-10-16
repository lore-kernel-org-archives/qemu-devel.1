Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA99FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17982067D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17982067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlp4-0007AB-H9
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iKlkm-0003wq-Nn
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iKlkh-0008DE-HF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iKlkh-0008Co-Ab
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D5BB7FDF5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 16:02:18 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 686C360C80;
 Wed, 16 Oct 2019 16:02:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtiofsd: move to an empty network namespace
Date: Wed, 16 Oct 2019 17:01:56 +0100
Message-Id: <20191016160157.12414-2-stefanha@redhat.com>
In-Reply-To: <20191016160157.12414-1-stefanha@redhat.com>
References: <20191016160157.12414-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 16 Oct 2019 16:02:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the process is compromised there should be no network access.  Use an
empty network namespace to sandbox networking.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index 84b60d85bd..c27ff7d800 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -2736,6 +2736,19 @@ static void setup_shared_versions(struct lo_data *=
lo)
 	lo->version_table =3D addr;
 }
=20
+/*
+ * Called after our UNIX domain sockets have been created, now we can mo=
ve to
+ * an empty network namespace to prevent TCP/IP and other network activi=
ty in
+ * case this process is compromised.
+ */
+static void setup_net_namespace(void)
+{
+	if (unshare(CLONE_NEWNET) !=3D 0) {
+		fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNET): %m\n");
+		exit(1);
+	}
+}
+
 /* This magic is based on lxc's lxc_pivot_root() */
 static void setup_pivot_root(const char *source)
 {
@@ -2818,6 +2831,7 @@ static void setup_mount_namespace(const char *sourc=
e)
  */
 static void setup_sandbox(struct lo_data *lo, bool enable_syslog)
 {
+	setup_net_namespace();
 	setup_mount_namespace(lo->source);
 	setup_seccomp(enable_syslog);
 }
--=20
2.21.0


