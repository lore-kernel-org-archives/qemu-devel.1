Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1551AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42E421973
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="NmLpvV0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42E421973
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUBs-0005aj-Po
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <62777d825ba6a7f9ba749588a9e1e7b273f7e967@lizzy.crudebyte.com>)
 id 1kIU8A-00081W-4o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:53:38 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:45719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <62777d825ba6a7f9ba749588a9e1e7b273f7e967@lizzy.crudebyte.com>)
 id 1kIU88-0000fG-HS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=IOxEdH7P12wqsQCMQXkcjSgsqCj59UF4YaQI8tHT/fE=; b=NmLpv
 V0YG5bbsMlo42pNRSY4xDSK0yF9nWneWlv8XaqZh65pgUE4191Tr+aoXtYhirIVTeZ7hmFilJoIaW
 PP21I5r/5gHvKubQYFR3C240PDorO38sO0dWATiZ2pv0ZQSOrG4ohbls67m7ULwV3s813Zu1cAVv3
 1ORGfwEFxLo5WPJJBJ4s7rzUYQoLVDizL0BQj6kuNjvn38/Gpf2QgWWB6EnV7fv0RpB1pEwdD/SKK
 zB4M2v8ICPlX97AtHzvQYzwPVUy76VoBgdc72TSs894Pg0Fx6Fw6O+YdKOiBjizfxxNv0PAJCaeHN
 ck0lkJc9+va+sJM19h3HV35QRS9SA==;
Message-Id: <62777d825ba6a7f9ba749588a9e1e7b273f7e967.1600166281.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1600166281.git.qemu_oss@crudebyte.com>
References: <cover.1600166281.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 3 Sep 2020 16:20:21 +0200
Subject: [PULL 1/2] 9pfs: log warning if msize <= 8192
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=62777d825ba6a7f9ba749588a9e1e7b273f7e967@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 05:20:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is essential to choose a reasonable high value for 'msize' to avoid
severely degraded file I/O performance. This parameter can only be
chosen on client/guest side, and a Linux client defaults to an 'msize'
of only 8192 if the user did not explicitly specify a value for 'msize',
which results in very poor file I/O performance.

Unfortunately many users are not aware that they should specify an
appropriate value for 'msize' to avoid severe performance issues, so
log a performance warning (with a QEMU wiki link explaining this issue
in detail) on host side in that case to make it more clear.

Currently a client cannot automatically pick a reasonable value for
'msize', because a good value for 'msize' depends on the file I/O
potential of the underlying storage on host side, i.e. a feature
invisible to the client, and even then a user would still need to trade
off between performance profit and additional RAM costs, i.e. with
growing 'msize' (RAM occupation), performance still increases, but
performance delta will shrink continuously.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f.1599144062.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7bb994bbf2..99b6f24fd6 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1353,6 +1353,15 @@ static void coroutine_fn v9fs_version(void *opaque)
         goto out;
     }
 
+    /* 8192 is the default msize of Linux clients */
+    if (s->msize <= 8192) {
+        warn_report_once(
+            "9p: degraded performance: a reasonable high msize should be "
+            "chosen on client/guest side (chosen msize is <= 8192). See "
+            "https://wiki.qemu.org/Documentation/9psetup#msize for details."
+        );
+    }
+
 marshal:
     err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
     if (err < 0) {
-- 
2.20.1


