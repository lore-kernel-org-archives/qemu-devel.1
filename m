Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A83C76195
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADF1206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADF1206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpGNH-0004bN-PJ
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 14:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hpGMk-00032Z-2l
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 14:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hpGMi-0001VR-Vu
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 14:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hpGMg-0001Si-K3; Sun, 21 Jul 2019 14:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC779307D88C;
 Sun, 21 Jul 2019 18:15:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAF8A1017E3F;
 Sun, 21 Jul 2019 18:15:15 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 21:15:08 +0300
Message-Id: <20190721181508.28608-3-mlevitsk@redhat.com>
In-Reply-To: <20190721181508.28608-1-mlevitsk@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sun, 21 Jul 2019 18:15:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] qemu-img: better error message when
 opening a backing file fails
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we print message like that:

"
new_file.qcow2 : error message
"

However the error could have come from opening the backing file (e.g when it missing encryption keys),
thus try to clarify this by using this format:

"
qemu-img: error creating new_file.qcow2: base_file.qcow2: error message
Could not open backing image to determine size.
"


Test used:

qemu-img create -f qcow2 \
        --object secret,id=sec0,data=hunter9 \
        --object secret,id=sec1,data=my_new_secret_password \
        -b 'json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "file": { "driver": "file", "filename": "base.qcow2" }}' \
        -o encrypt.format=luks,encrypt.key-secret=sec1 \
        sn.qcow2


Error message before:

qemu-img: sn.qcow2: Invalid password, cannot unlock any keyslot
Could not open backing image to determine size.


Error message after:

qemu-img: error creating sn.qcow2: \
	json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "file": { "driver": "file", "filename": "base.qcow2" }}: \
	Invalid password, cannot unlock any keyslot
Could not open backing image to determine size.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block.c    | 1 +
 qemu-img.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 29e931e217..5eb47b2199 100644
--- a/block.c
+++ b/block.c
@@ -5790,6 +5790,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
                             "This may become an error in future versions.\n");
             local_err = NULL;
         } else if (!bs) {
+            error_prepend(&local_err, "%s: ", backing_file);
             /* Couldn't open bs, do not have size */
             error_append_hint(&local_err,
                               "Could not open backing image to determine size.\n");
diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..134bf2fbe0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -545,7 +545,7 @@ static int img_create(int argc, char **argv)
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
                     options, img_size, flags, quiet, &local_err);
     if (local_err) {
-        error_reportf_err(local_err, "%s: ", filename);
+        error_reportf_err(local_err, "error creating %s: ", filename);
         goto fail;
     }
 
-- 
2.17.2


