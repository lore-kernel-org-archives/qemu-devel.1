Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FEAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8475D2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="1jjxZVGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8475D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7DJ-0005k3-GN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77Q-0004HV-RE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77L-0004jT-G9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:17 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs77B-0004Xl-B7; Mon, 29 Jul 2019 10:59:05 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 10A3F96F67;
 Mon, 29 Jul 2019 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIw9VOnNOvv6i5KDhQD4nJN5V8svLGb1uTTCxjQz4rM=;
 b=1jjxZVGU+7Ozaw6ODz/G0/Dtymc7847a7SEXlr0up1TjHwz5PMFGuNsY8v+4OdwF6eWrkA
 kf1oAzau6OYvz50HU9jrVw3r/b62NoW9nZkcPw4CGQS8O7jgjg1G3ZhFEVuLRwyYgX50Xg
 xKviJU+60D6gFZztOztafbJSCOTxBnI=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:31 +0200
Message-Id: <20190729145654.14644-11-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIw9VOnNOvv6i5KDhQD4nJN5V8svLGb1uTTCxjQz4rM=;
 b=wAZ0WXR22PWrixZWMTlufg5mgCs2YRIK9liXy/YpNo2FyRBHOlhI1M2/oxXOnbuFtbHPEB
 WBTw0KJinWKLcjNeVinkf3RN5GIbPqEgzGKLI+VyieJ0/498tAq40v7TrCAm+RImD/f2Bb
 Y9C3cVeDb3QBgflR59T/oxcqRfcGlBI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412344; a=rsa-sha256; cv=none;
 b=58H2EsS5g1GX2LiVQ1ar3zUzQameEIsMpV+poV7zJ7ItawiKv7RzPiwP0+uBl9bZrHyRXI
 JOTPnXCaLtNETogtjm53EgW0Ng1Hx27BenMRzwJ1w5/9iV/T07N+L4ngSTIxVrhEvhbLEI
 aeRfvsbvVTBO61ojGKhKAYOjESDQsUU=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 10/33] vl.c: remove qbus_reset_all
 registration
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qbus_reset_all by resettable_reset_cold_fn for
the sysbus reset registration.
This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 vl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index b426b32134..5a465c8236 100644
--- a/vl.c
+++ b/vl.c
@@ -4421,7 +4421,11 @@ int main(int argc, char **argv, char **envp)
=20
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
-    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+    /*
+     * TODO: when we have a main reset container/domain object, use
+     * it to fully benefit from multi-phase reset
+     */
+    qemu_register_reset(resettable_reset_cold_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
=20
     if (rom_check_and_register_reset() !=3D 0) {
--=20
2.22.0


