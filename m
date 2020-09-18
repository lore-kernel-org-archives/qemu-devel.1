Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C8CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74521208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZurqGpkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74521208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIWW-0003wr-BS
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJIQ2-0005fJ-1s
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:35:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJIPy-0005Ph-8T
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600443321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=9c3wwv8lX2q7gRj44RfH3GDl/5ZjEa+MwdlsPCdue2Q=;
 b=ZurqGpkE/uINjIf2ijvzkMuv+SjOCPizmc2E4qzcu7WTTvTgYQ371E04AaSTCxORYBF85s
 s0gs10iczyj98DgB6oDS/SUte++k5Bz3qDzgYhAKHAQ9IYckbuxeCZApevRfeO5K2H7+QI
 EENQg81GhVkJrJRPW4aKQKp+vuDwQNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-RqPewQ8aN3OeEM-IaE73iQ-1; Fri, 18 Sep 2020 11:35:19 -0400
X-MC-Unique: RqPewQ8aN3OeEM-IaE73iQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F4101007B02;
 Fri, 18 Sep 2020 15:35:18 +0000 (UTC)
Received: from thuth.com (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0867E60C07;
 Fri, 18 Sep 2020 15:35:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH v2] tests/check-block: Do not run the iotests with old
 versions of bash
Date: Fri, 18 Sep 2020 17:35:14 +0200
Message-Id: <20200918153514.330705-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 08:09:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macOS is shipped with a very old version of the bash (3.2), which
is currently not suitable for running the iotests anymore (e.g.
it is missing support for "readarray" which is used in the file
tests/qemu-iotests/common.filter). Add a check to skip the iotests
in this case - if someone still wants to run the iotests on macOS,
they can install a newer version from homebrew, for example.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use LANG=C and "-q"

 tests/check-block.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/check-block.sh b/tests/check-block.sh
index a5a69060e1..f6b1bda7b9 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -46,6 +46,11 @@ if ! command -v bash >/dev/null 2>&1 ; then
     exit 0
 fi
 
+if LANG=C bash --version | grep -q 'GNU bash, version [123]' ; then
+    echo "bash version too old ==> Not running the qemu-iotests."
+    exit 0
+fi
+
 if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
     if ! command -v gsed >/dev/null 2>&1; then
         echo "GNU sed not available ==> Not running the qemu-iotests."
-- 
2.18.2


