Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E16C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120A620675
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120A620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGo7H-0000NO-B6
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:12:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5U-0007YI-90
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5T-0007TE-Di
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGo5R-0007QZ-AQ; Wed, 17 Apr 2019 13:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75CD23086220;
	Wed, 17 Apr 2019 17:11:04 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D936719C58;
	Wed, 17 Apr 2019 17:11:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 12:11:00 -0500
Message-Id: <20190417171101.1254-2-eblake@redhat.com>
In-Reply-To: <20190417171101.1254-1-eblake@redhat.com>
References: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 17 Apr 2019 17:11:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] cutils: Fix size_to_str() on 32-bit
 platforms
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417171100.daahL7Vr8_1qQkU4aulhhapDDoHVhf_TVpgwqPZJ4rg@z>

When extracting a human-readable size formatter, we changed 'uint64_t
div' pre-patch to 'unsigned long div' post-patch. Which breaks on
32-bit platforms, resulting in 'inf' instead of intended values larger
than 999GB.

Fixes: 22951aaa
CC: qemu-stable@nongnu.org
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/cutils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index e098debdc0c..d682c909015 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -825,7 +825,7 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
 char *size_to_str(uint64_t val)
 {
     static const char *suffixes[] =3D { "", "Ki", "Mi", "Gi", "Ti", "Pi"=
, "Ei" };
-    unsigned long div;
+    uint64_t div;
     int i;

     /*
--=20
2.20.1


