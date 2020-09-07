Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75FDC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0472137B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEgEUgdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0472137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG0d-0005bF-CL
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzo-0003o4-VW
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzn-0007tq-Dg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KaDFf/OPyjySwTtQk4PQ59rmIgSVpsfpTTTXXoIQpg=;
 b=FEgEUgduYV2RT+i6NlMC53GIzA2q44hR6mbDe/9elhLFSHUM+89HKud8xbTaIzGuNa1UQu
 JVd14heOW7hxA4roN7P4hcFJu7Xm/Ps0GSHGjn97cdn2xHDggo9JLDoyWlY6u82Bfl3TOy
 ysZIA0reAIuIYxSLSb2wR5Rgal7rB1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-b0efaj3WNx24J9m37LddUQ-1; Mon, 07 Sep 2020 08:11:36 -0400
X-MC-Unique: b0efaj3WNx24J9m37LddUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31BF1007466;
 Mon,  7 Sep 2020 12:11:34 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E893A5C1BB;
 Mon,  7 Sep 2020 12:11:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/14] tests: fixes test-vmstate.c compile error on msys2
Date: Mon,  7 Sep 2020 14:11:16 +0200
Message-Id: <20200907121127.136243-4-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

../tests/test-vmstate.c: In function 'int_cmp':
../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you mean 'uInt'?
  884 |     uint ua = GPOINTER_TO_UINT(a);
      |     ^~~~
      |     uInt
../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you mean 'uInt'?
  885 |     uint ub = GPOINTER_TO_UINT(b);
      |     ^~~~
      |     uInt
make: *** [Makefile.ninja:5461：tests/test-vmstate.exe.p/test-vmstate.c.obj] 错误 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20200905063813.1875-1-luoyonggang@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-vmstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f7b3868881..f8de709a0b 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 /* ID comparison function */
 static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 {
-    uint ua = GPOINTER_TO_UINT(a);
-    uint ub = GPOINTER_TO_UINT(b);
+    guint ua = GPOINTER_TO_UINT(a);
+    guint ub = GPOINTER_TO_UINT(b);
     return (ua > ub) - (ua < ub);
 }
 
-- 
2.18.2


