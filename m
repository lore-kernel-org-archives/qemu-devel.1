Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FCDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E792067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acFOAlR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E792067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSWb-0008BC-GC
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWe-0007IC-C7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWd-00045l-BK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWd-00044a-3i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUswbRayFMHPV/skmfrT9ik6TKHR8nywEJHabUcNX/A=;
 b=acFOAlR8MUeFkZeVOO3g6zyW4gEyj4ji32of/w8B5N6LBhQ1YIdg9gGfQj+Z3DivB4dgXs
 2xqzEl/plGatfA9m3bakx94zSgN35WRh93O9Nu1FdN2XZcMsWlbZLfhdxFefKxQbg0BCjs
 2MfzSpCGqec5Et6BQYx8czE0xoe9qwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-dJD_3pEaPhyWfrdwbq_i5w-1; Thu, 12 Dec 2019 11:41:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB9C6800596
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C66CA60BF3;
 Thu, 12 Dec 2019 16:41:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 077/104] virtiofsd: fix error handling in main()
Date: Thu, 12 Dec 2019 16:38:37 +0000
Message-Id: <20191212163904.159893-78-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dJD_3pEaPhyWfrdwbq_i5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Bo <bo.liu@linux.alibaba.com>

Neither fuse_parse_cmdline() nor fuse_opt_parse() goes to the right place
to do cleanup.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index c526d6f4f6..33092de65a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2475,13 +2475,14 @@ int main(int argc, char *argv[])
     lo_map_init(&lo.fd_map);
=20
     if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
-        return 1;
+        goto err_out1;
     }
     fuse_set_log_func(log_func);
     use_syslog =3D opts.syslog;
     if (use_syslog) {
         openlog("virtiofsd", LOG_PID, LOG_DAEMON);
     }
+
     if (opts.show_help) {
         printf("usage: %s [options]\n\n", argv[0]);
         fuse_cmdline_help();
@@ -2500,7 +2501,7 @@ int main(int argc, char *argv[])
     }
=20
     if (fuse_opt_parse(&args, &lo, lo_opts, NULL) =3D=3D -1) {
-        return 1;
+        goto err_out1;
     }
=20
     /*
--=20
2.23.0


