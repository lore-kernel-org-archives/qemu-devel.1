Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11457C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5FB2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5FB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRJF-0001J4-Cr
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxP-0002RS-7G
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxN-0003k8-7o
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:12:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:39508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQxM-0003a8-Tg; Mon, 23 Sep 2019 12:12:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQwy-0001Fp-Od; Mon, 23 Sep 2019 19:12:32 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 2/9] qapi/error: add (Error **errp) cleaning APIs
Date: Mon, 23 Sep 2019 19:12:24 +0300
Message-Id: <20190923161231.22028-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923161231.22028-1-vsementsov@virtuozzo.com>
References: <20190923161231.22028-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
X-Mailman-Approved-At: Mon, 23 Sep 2019 12:26:10 -0400
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
Cc: stefanha@redhat.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, philmd@redhat.com,
 green@moxielogic.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, ronniesahlberg@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 andrew@aj.id.au, crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 david@redhat.com, palmer@sifive.com, thuth@redhat.com, jcmvbkbc@gmail.com,
 den@openvz.org, hare@suse.com, sstabellini@kernel.org, arei.gonglei@huawei.com,
 namei.unix@gmail.com, atar4qemu@gmail.com, farman@linux.ibm.com,
 amit@kernel.org, sw@weilnetz.de, groug@kaod.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 jasowang@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 gxt@mprc.pku.edu.cn, ari@tuxera.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com, borntraeger@de.ibm.com,
 antonynpavlov@gmail.com, dillaman@redhat.com, joel@jms.id.au,
 xen-devel@lists.xenproject.org, integration@gluster.org, rjones@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, v.maffione@gmail.com,
 marex@denx.de, armbru@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me, paul.durrant@citrix.com, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qapi/error.h | 22 ++++++++++++++++++++++
 util/error.c         |  6 +++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index f6f4fa0fac..551385aa91 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -297,6 +297,28 @@ void warn_report_err(Error *err);
  */
 void error_report_err(Error *err);
 
+/*
+ * Functions to clean Error **errp: call corresponding Error *err cleaning
+ * function an set pointer to NULL
+ */
+static inline void error_free_errp(Error **errp)
+{
+    error_free(*errp_in);
+    *errp_in = NULL;
+}
+
+static inline void error_report_errp(Error **errp)
+{
+    error_report_err(*errp_in);
+    *errp_in = NULL;
+}
+
+static inline void warn_report_errp(Error **errp)
+{
+    warn_report_err(*errp_in);
+    *errp_in = NULL;
+}
+
 /*
  * Convenience function to error_prepend(), warn_report() and free @err.
  */
diff --git a/util/error.c b/util/error.c
index d4532ce318..dfba091757 100644
--- a/util/error.c
+++ b/util/error.c
@@ -273,9 +273,9 @@ void error_free(Error *err)
 
 void error_free_or_abort(Error **errp)
 {
-    assert(errp && *errp);
-    error_free(*errp);
-    *errp = NULL;
+    assert(errp_in && *errp_in);
+    error_free(*errp_in);
+    *errp_in = NULL;
 }
 
 void error_propagate(Error **dst_errp, Error *local_err)
-- 
2.21.0


