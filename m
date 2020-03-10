Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF3C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB26524655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF9gpixL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB26524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdIG-0001Yz-TW
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDp-0003On-DP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDo-0000Cj-Bb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDo-0000AB-57
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WB34KXnpmzHkyneXT68BbNbGHRLxvi5KS3TZ5lDINys=;
 b=aF9gpixL4VUoLrfdJPO929LFH7nCY/58TxUwj75MaS+f3xVpu3dY9B6yceoLtptjgON+k2
 Ma8RGNyw18+yQVgGs9Qj2DX6nEvW0dUfXw+mOrUEDw+s6xK4jEK5YEn1CkpT37Eic7/ooF
 et+o2QMZTm2Kyaev3Ka025zpcfbz3WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-uJjfNKt8Nri_1ZiBsqmPPQ-1; Tue, 10 Mar 2020 07:38:49 -0400
X-MC-Unique: uJjfNKt8Nri_1ZiBsqmPPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDF8184C801;
 Tue, 10 Mar 2020 11:38:48 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABF818CCE2;
 Tue, 10 Mar 2020 11:38:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 7/7] qapi: Add '@allow-write-only-overlay' feature for
 'blockdev-snapshot'
Date: Tue, 10 Mar 2020 12:38:31 +0100
Message-Id: <20200310113831.27293-8-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Krempa <pkrempa@redhat.com>

Anounce that 'blockdev-snapshot' command's permissions allow changing
of the backing file if the 'consistent_read' permission is not required.

This is useful for libvirt to allow late opening of the backing chain
during a blockdev-mirror.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9758fc48d2..91586fb1fb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1472,6 +1472,12 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshot.
 #
+# Features:
+# @allow-write-only-overlay: If present, the check whether this operation =
is safe
+#                            was relaxed so that it can be used to change
+#                            backing file of a destination of a blockdev-m=
irror.
+#                            (since 5.0)
+#
 # Since: 2.5
 #
 # Example:
@@ -1492,7 +1498,8 @@
 #
 ##
 { 'command': 'blockdev-snapshot',
-  'data': 'BlockdevSnapshot' }
+  'data': 'BlockdevSnapshot',
+  'features': [ 'allow-write-only-overlay' ] }
=20
 ##
 # @change-backing-file:
--=20
2.20.1


