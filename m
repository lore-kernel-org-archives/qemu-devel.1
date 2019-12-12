Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEAC00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B103F2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkSCDmP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTgn-0007pF-B8
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbu-0002Tl-3j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbr-0008Qe-Uj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbr-0008Pk-Pv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HyBLXvz6+hVapKmEZisjtRTpcsXV2QDQtFv50aNjUU=;
 b=FkSCDmP/grEyuVuP8mUR4W+GRcsk2FH35vlqulnVfm6kZFyjBTV9ewlvOncAAK5/R4HoAN
 WDX0/ZMoWrSx5bX7+Ppj1UUVAQHoi+vBSPbAlGGU8Sxni8jHnjFobbDOwYYYAT8J/kwveV
 HaZendD4hr84Q7lef6+A429/R4vEhxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-x2K6g-ctMsuYknSlYexCPA-1; Thu, 12 Dec 2019 13:54:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC243107ACC4;
 Thu, 12 Dec 2019 18:54:42 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59FFC19C4F;
 Thu, 12 Dec 2019 18:54:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/10] pseries: disable migration-test if /dev/kvm cannot be
 used
Date: Thu, 12 Dec 2019 19:54:20 +0100
Message-Id: <20191212185424.4675-7-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: x2K6g-ctMsuYknSlYexCPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

On ppc64, migration-test only works with kvm_hv, and we already
have a check to verify the module is loaded.

kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
but on some systems (like build systems) /dev/kvm can be missing
(by administrators choice).

And as kvm_hv exists test-migration is started but QEMU falls back to
TCG because it cannot be used:

    Could not access KVM kernel module: No such file or directory
    failed to initialize KVM: No such file or directory
    Back to tcg accelerator

And as the test is done with TCG, it fails.

As for s390x, we must check for the existence and the access rights
of /dev/kvm.

Reported-by: Cole Robinson <crobinso@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20191120170955.242900-1-lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ebd77a581a..a5343fdc66 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -1349,7 +1349,8 @@ int main(int argc, char **argv)
      * some reason)
      */
     if (g_str_equal(qtest_get_arch(), "ppc64") &&
-        access("/sys/module/kvm_hv", F_OK)) {
+        (access("/sys/module/kvm_hv", F_OK) ||
+         access("/dev/kvm", R_OK | W_OK))) {
         g_test_message("Skipping test: kvm_hv not available");
         return g_test_run();
     }
--=20
2.18.1


