Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095ED20746
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFtDU0I9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095ED20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChc8-0001Fi-3S
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChac-0008Jw-Hw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChaa-0005pa-PE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChaa-0005mt-Fj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jealFJWRwXog3m3+gGWZ0kWOZ+sJot2DcLbtmIlySJk=;
 b=PFtDU0I9sL2H9RI6ngoTEVqYZDoEi28CIsGNrSmht40LRdqElQKYEMLYb+KbTYi5Ipgngn
 FBAiJvKYw4DpuANeFzVrynS0KFu6SlNatsNk8FQlk+0jUUBgUmO7eCnf67fl++6eJDZsU2
 cDwMG2l+8GZTMgvggML3/JEfSgh9F8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zw0RP_k5PUeArv9zgMxQow-1; Fri, 13 Mar 2020 06:30:45 -0400
X-MC-Unique: zw0RP_k5PUeArv9zgMxQow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A4A800D4E;
 Fri, 13 Mar 2020 10:30:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4B3A8B773;
 Fri, 13 Mar 2020 10:30:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 1/5] configure: Improve zstd test
Date: Fri, 13 Mar 2020 10:30:35 +0000
Message-Id: <20200313103039.150133-2-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
References: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Juan Quintela <quintela@redhat.com>

There were one error on the test (missing an s for --exists).
But we really need a recent zstd (1.4.0).
Thanks to Michal Privoznik to provide the right vension.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200310111431.173151-1-quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3c7470096f..eb49bb6680 100755
--- a/configure
+++ b/configure
@@ -2475,7 +2475,8 @@ fi
 # zstd check
=20
 if test "$zstd" !=3D "no" ; then
-    if $pkg_config --exist libzstd ; then
+    libzstd_minver=3D"1.4.0"
+    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
         zstd_cflags=3D"$($pkg_config --cflags libzstd)"
         zstd_libs=3D"$($pkg_config --libs libzstd)"
         LIBS=3D"$zstd_libs $LIBS"
--=20
2.24.1


