Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DCB20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvjcYUbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DCB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcAH-0003uI-41
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIG-0003ro-RR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIF-00007q-G5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60761
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIF-00007Z-BG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDDFSLl6Vav0RkNlE+wabtjmTyQMQM9+El2XueyOjyQ=;
 b=fvjcYUbl5Q2i2h/p1OUGrk7xfzSmUWfemwAsMP91tD427Ra+ZEz6ZYQolq/a6hQm/kUY7q
 Y+vwfhRzB8boy52dRRsV7Kl4zhRhlCmJ0d/3xcb8Ho/NsBkpnxvbNcgEyVyfnApWnXyQMx
 L1vH9DloQpwwotw+cIRdOEcpy/98qjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Qv_B0wuiOUiN551RX96EMQ-1; Thu, 24 Oct 2019 07:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D208D476;
 Thu, 24 Oct 2019 11:28:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 558B752D8;
 Thu, 24 Oct 2019 11:28:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 17/25] virtiofsd: move to an empty network namespace
Date: Thu, 24 Oct 2019 12:27:10 +0100
Message-Id: <20191024112718.34657-18-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Qv_B0wuiOUiN551RX96EMQ-1
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

If the process is compromised there should be no network access.  Use an
empty network namespace to sandbox networking.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 20a34d4d83..58cf82a89f 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1822,6 +1822,19 @@ static void print_capabilities(void)
 =09printf("}\n");
 }
=20
+/*
+ * Called after our UNIX domain sockets have been created, now we can move=
 to
+ * an empty network namespace to prevent TCP/IP and other network activity=
 in
+ * case this process is compromised.
+ */
+static void setup_net_namespace(void)
+{
+=09if (unshare(CLONE_NEWNET) !=3D 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNET): %m\n");
+=09=09exit(1);
+=09}
+}
+
 /* This magic is based on lxc's lxc_pivot_root() */
 static void setup_pivot_root(const char *source)
 {
@@ -1913,6 +1926,7 @@ static void setup_mount_namespace(const char *source)
  */
 static void setup_sandbox(struct lo_data *lo)
 {
+=09setup_net_namespace();
 =09setup_mount_namespace(lo->source);
 }
=20
--=20
2.23.0


