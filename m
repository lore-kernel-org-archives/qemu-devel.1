Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA1C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA3A2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEok-00080w-LL
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEnz-0006is-Ml
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEEnw-0000An-1W
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:43:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-9LTyus_2OFqPuv1_T9XX3Q-1; Fri, 04 Sep 2020 12:43:09 -0400
X-MC-Unique: 9LTyus_2OFqPuv1_T9XX3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB361425E1;
 Fri,  4 Sep 2020 16:43:08 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A23AB19D7D;
 Fri,  4 Sep 2020 16:43:07 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/7] scripts/ci/gitlab-pipeline-status: refactor parser
 creation
Date: Fri,  4 Sep 2020 12:42:55 -0400
Message-Id: <20200904164258.240278-5-crosa@redhat.com>
In-Reply-To: <20200904164258.240278-1-crosa@redhat.com>
References: <20200904164258.240278-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Out of the main function.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 18609553be..8355b6a427 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -89,10 +89,7 @@ def wait_on_pipeline_success(timeout, interval,
         return False
 
 
-def main():
-    """
-    Script entry point
-    """
+def create_parser():
     parser = argparse.ArgumentParser(
         prog='pipeline-status',
         description='check or wait on a pipeline status')
@@ -127,7 +124,13 @@ def main():
     parser.add_argument('--verbose', action='store_true', default=False,
                         help=('A minimal verbosity level that prints the '
                               'overall result of the check/wait'))
+    return parser
 
+def main():
+    """
+    Script entry point
+    """
+    parser = create_parser()
     args = parser.parse_args()
 
     try:
-- 
2.25.4


