Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863FDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC962065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYP5EDky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC962065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMLM-0005XD-6n
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMI4-0001A2-Hw
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMHz-0004VX-8Q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojSCmLxFNIo7TbCKM30bGglwGjRSfaORvBkMlNbVgfs=;
 b=hYP5EDkydoob1Dcx3srmKGrXHe+YhU77XiAlhtjDkBhOtiIKmNMZednqq7FnqFeP8bqhE3
 KKlYoKaAS4ElWBtOVlAwHGtJOsXpCTFzHpmA+2d1QwwdetZ4XSrAcVhE3UrQ8rIiP4+Mg7
 iouBpziVXF7S0NYMEsaxO6l17r6B+Z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-uvmmwm_eMzu7LVwDFzfSww-1; Fri, 02 Oct 2020 10:43:57 -0400
X-MC-Unique: uvmmwm_eMzu7LVwDFzfSww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 553A31084CAB;
 Fri,  2 Oct 2020 14:43:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 434C95D9D5;
 Fri,  2 Oct 2020 14:43:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/37] qemu-io-cmds: Simplify help_oneline
Date: Fri,  2 Oct 2020 16:43:12 +0200
Message-Id: <20201002144345.253865-5-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

help_oneline is declared and starts as:

  static void help_oneline(const char *cmd, const cmdinfo_t *ct)
  {
      if (cmd) {
          printf("%s ", cmd);
      } else {
          printf("%s ", ct->name);
          if (ct->altname) {
              printf("(or %s) ", ct->altname);
          }
      }

However, there are only two routes to help_oneline being called:

   help_f -> help_all -> help_oneline(ct->name, ct)

   help_f -> help_onecmd(argv[1], ct)

In the first case, 'cmd' and 'ct->name' are the same thing,
so it's impossible for the if (cmd) to be false and then validly
print ct->name - this is upsetting gcc
( https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96739 )

In the second case, cmd is argv[1] and we know we've got argv[1]
so again (cmd) is non-NULL.

Simplify help_oneline by just printing cmd.
(Also strengthen argc check just to be pedantic)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200824102914.105619-1-dgilbert@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index baeae86d8c..4153f1c0b0 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2383,14 +2383,7 @@ static const cmdinfo_t sleep_cmd = {
 
 static void help_oneline(const char *cmd, const cmdinfo_t *ct)
 {
-    if (cmd) {
-        printf("%s ", cmd);
-    } else {
-        printf("%s ", ct->name);
-        if (ct->altname) {
-            printf("(or %s) ", ct->altname);
-        }
-    }
+    printf("%s ", cmd);
 
     if (ct->args) {
         printf("%s ", ct->args);
@@ -2420,7 +2413,7 @@ static int help_f(BlockBackend *blk, int argc, char **argv)
 {
     const cmdinfo_t *ct;
 
-    if (argc == 1) {
+    if (argc < 2) {
         help_all();
         return 0;
     }
-- 
2.25.4


