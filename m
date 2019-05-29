Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED70C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D87B2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MEsQJSAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D87B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVstP-0008Hc-A6
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:20:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQU-0000O8-6L
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQS-0002tk-UM
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52135 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQS-0002gf-Ht; Wed, 29 May 2019 02:51:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv643gLz9sPT; Wed, 29 May 2019 16:50:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112626;
	bh=KAhfRGXxmk0mvhBDeynaZTAXX7FnxsaPZJh4L/X8UYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEsQJSAZqJP+HMI+kXGh6g3F9ncPVlEYSpnHOLusRDKX+4prpOFOdCU/6WOsXJX5F
	I6EbTuNUmt+KqNp2PXGg9ZbISsLzT3XE9fs6hWQDISj0J6kpF6zPpYE7WxHaBT12pU
	BoBWgxPYQJzPrOX4x/Kwe0uKdMjCAfzbjCDnEseQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:55 +1000
Message-Id: <20190529065017.15149-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 22/44] spapr: Add forgotten capability to
 migration stream
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr machine capabilities are supposed to be sent in the migration strea=
m
so that we can sanity check the source and destination have compatible
configuration.  Unfortunately, when we added the hpt-max-page-size
capability, we forgot to add it to the migration state.  This means that =
we
can generate spurious warnings when both ends are configured for large
pages, or potentially fail to warn if the source is configured for huge
pages, but the destination is not.

Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 1 +
 hw/ppc/spapr_caps.c    | 1 +
 include/hw/ppc/spapr.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8580a8dc67..bcae30ad26 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
         &vmstate_spapr_cap_ibs,
+        &vmstate_spapr_cap_hpt_maxpagesize,
         &vmstate_spapr_irq_map,
         &vmstate_spapr_cap_nested_kvm_hv,
         &vmstate_spapr_dtb,
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 9b1c10baa6..658eb15a14 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
 SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
+SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7e32f309c2..9fc91c8f5e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap_dfp=
;
 extern const VMStateDescription vmstate_spapr_cap_cfpc;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
+extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
--=20
2.21.0


