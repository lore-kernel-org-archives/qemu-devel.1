Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D022C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC2B205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DrDPkuLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC2B205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE971-0002h1-Ua
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95X-0000kA-DI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95V-0001E2-P3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:42 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35049 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95U-0000RB-Vi; Tue, 17 Mar 2020 06:04:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKv5cQJz9sSG; Tue, 17 Mar 2020 21:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439475;
 bh=pEA9lcDWk0y3tVrpwso9nTEbD4w1S4UtinfkCQ45i5U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DrDPkuLewANYCEG0/CxivTchXwTVFlaWBnmtGerF5rDKONDEW1MKHYpyDQgVSch75
 ED6woSnELS81jYmT6049f008ysHHMUF7ewu54QDO1dY3JPme9mSzFhWVoSHrDhOr+1
 99xg/0re9158uvRPcvSXK9ZmnCQK6gfocv0STqXE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/45] spapr: Fix Coverity warning while validating nvdimm
 options
Date: Tue, 17 Mar 2020 21:03:42 +1100
Message-Id: <20200317100423.622643-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Fixes Coverity issue,
      CID 1419883:  Error handling issues  (CHECKED_RETURN)
           Calling "qemu_uuid_parse" without checking return value

nvdimm_set_uuid() already verifies if the user provided uuid is valid or
not. So, need to check for the validity during pre-plug validation again.

As this a false positive in this case, assert if not valid to be safe.
Also, error_abort if QOM accessor encounters error while fetching the uui=
d
property.

Reported-by: Coverity (CID 1419883)
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-Id: <158281096564.89540.4507375445765515529.stgit@lep8c.aus.stgla=
bs.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 74eeb8bb74..25be8082d7 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -35,6 +35,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, u=
int64_t size,
 {
     char *uuidstr =3D NULL;
     QemuUUID uuid;
+    int ret;
=20
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
         error_setg(errp, "NVDIMM memory size excluding the label area"
@@ -43,8 +44,10 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, =
uint64_t size,
         return;
     }
=20
-    uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP=
, NULL);
-    qemu_uuid_parse(uuidstr, &uuid);
+    uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP=
,
+                                      &error_abort);
+    ret =3D qemu_uuid_parse(uuidstr, &uuid);
+    g_assert(!ret);
     g_free(uuidstr);
=20
     if (qemu_uuid_is_null(&uuid)) {
--=20
2.24.1


