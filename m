Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4DDC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED64C2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED64C2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEFH-0001Rp-Qf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBf-0005Cy-OZ; Tue, 13 Oct 2020 02:53:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBe-0000GZ-2H; Tue, 13 Oct 2020 02:53:31 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N49Yn-1kJFyP2dkn-0103Pm; Tue, 13 Oct 2020 08:53:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] block/blkdebug: fix memory leak
Date: Tue, 13 Oct 2020 08:53:08 +0200
Message-Id: <20201013065313.7349-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QDmY58ZSYUGWGfjqvfuDyoZ0M9E/tkHa0s4WqXNzo+/znmCUr5c
 rUMPhz8QU1d1CshRVAfBU1E3+mhZ+Yyms5TfNviYv46t60dNQWqM7x5RuVzyrTzDeYJbEW5
 Uc7KMVVnEGrvKMQwTqRDzHlv/R1wXIw5WDv9Eg3wQEJRM8J7esls38A67sSiZFDAw262Y8Z
 gGtxSpEOsI7nekoftoC2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PczvMuKHoo8=:wsOv39YVXFYY1j1YyL9blB
 Y5wDXS3etdNI1qbtJV59zkUNc5um2CjvAArTyfXgRY9Y7333HPivrvhD6tT3g7Po5Tj61MGUZ
 yGEpZqUXBvVIsi6bNNNoTd9xkISqIdM1UycCAvY4mqe4Ya2DmguCWDX+TO+cgEhMc1LRBq5Pd
 deyPlmf3aH7dWddZ/c02ZxIc8lMuOLHy/bO01ZBOuVrSX1LSgih7Xe6JM9pu3fGVsE3rq9lal
 rt4c9HGvW9pjxxhggKKkOuBRvWfA5XsGdQScMjhjMfRqZ19RuRp9Sf35SHieKUz9rm1/hTei6
 kHoMckw21g3/UYWDO1NN50zqnEdJOk9QTZGC2vmyiUcpEyI1QhWIlK6jOgAchpTeRguNtZ2Jn
 uqEaSugMXkAjphQQBuBLwCxnlHm8EKPL3sR0rnsFGxdLQnUotN1PuaeYCZpUcr/TCBE264N1h
 ZHa0t+zMtIUMjlDo1ux/GPLkacYX+cMDwpetdfQFat1qCLzNMJF2KGftHbagyIC6ytVz8XwQb
 qKU2S9BYIIowZtGjLd9utpWBJILL9RSRaON+hj8txcxUCS2wYpaultx819v2bH87yuXM5cTa4
 FzVmgRFPnYerRmw/qNlWDHQcBGiW516TTifK7bjoINxRXuSkTfsbYSY9lTILOYd0MYp2HtLob
 A6x6z88viVyDiNDGm9m/vyqZtk3M+cb5jPnpXNFTShXnpXoKmtnSQ/EJQ/18hh+xP2svxa7Ww
 W7hRY+WZt7AmafvLITwcCpUa+Ou6w6x8GYwAeqivm4C8BqsvnbL9dxczqNqX05rsedOcSUL5S
 LP8vXhrVs/kTIwYEtSN/YuyJPq6oMkKIXu7QwWAcn56T1bnuMmg0UOREFtl8VneSP2718YO
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Elena Afanasova <eafanasova@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Afanasova <eafanasova@gmail.com>

Spotted by PVS-Studio

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1e903f928eb3da332cc95e2a6f87243bd9fe66e4.camel@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/blkdebug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index eecbf3e5c479..54da719dd151 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -215,6 +215,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
                                  BLKDEBUG_IO_TYPE__MAX, &local_error);
         if (local_error) {
             error_propagate(errp, local_error);
+            g_free(rule);
             return -1;
         }
         if (iotype != BLKDEBUG_IO_TYPE__MAX) {
-- 
2.26.2


