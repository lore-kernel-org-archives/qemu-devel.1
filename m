Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE06C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A1221655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrZrAv4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A1221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS85-0007ae-Kq
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXS5G-0004sW-CR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXS5E-0003Sc-Ca
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603817067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xchWNSLSOvO+uFguJOcWC+8gOndFHe2Hse3FacZ9bQ=;
 b=BrZrAv4VqpxkvKmJvY3+qJ/XgEsJbss6DV+uJTgb5ECwHMV5T7D24oyQIwj+32P4VS2FeP
 V8ZPY+FvNun0Ctm5zq5hFeSKC33o7jWqIK/lCnAylUsUS0xy4X/tv7b/yfjbEYlnUTrVR2
 b7hL8pkx9aRLkQjZOHVzhxjR9y4El10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-D6KlE1zJNsWeG9HOrYMIxQ-1; Tue, 27 Oct 2020 12:44:26 -0400
X-MC-Unique: D6KlE1zJNsWeG9HOrYMIxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0978835B74;
 Tue, 27 Oct 2020 16:44:24 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73CC05C1BB;
 Tue, 27 Oct 2020 16:44:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests/291: Stop NBD server
Date: Tue, 27 Oct 2020 17:44:16 +0100
Message-Id: <20201027164416.144115-3-mreitz@redhat.com>
In-Reply-To: <20201027164416.144115-1-mreitz@redhat.com>
References: <20201027164416.144115-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nbd_server_start_unix_socket() includes an implicit nbd_server_stop(),
but we still need an explicit one at the end of the test (where there
follows no next nbd_server_start_unix_socket()), or qemu-nbd will linger
until the test exits.

This will become important when enabling this test to run on FUSE
exports, because then the export (which is the image used by qemu-nbd)
will go away before qemu-nbd exits, which will lead to qemu-nbd
complaining that it cannot flush the bitmaps in the image.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/291 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 77fa38f93d..b7320bc7ad 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -128,6 +128,8 @@ nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"
 $QEMU_IMG map --output=json --image-opts \
     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b3" | _filter_qemu_img_map
 
+nbd_server_stop
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
-- 
2.26.2


